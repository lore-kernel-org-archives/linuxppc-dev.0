Return-Path: <John.Youn@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay4.synopsys.com [198.182.47.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r6B6R5sHRzDq8b
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 May 2016 12:50:22 +1000 (AEST)
Subject: Re: [PATCH v4] usb: dwc2: fix regression on big-endian PowerPC/ARM
 systems
To: Arnd Bergmann <arnd@arndb.de>, Christian Lamparter
 <chunkeey@googlemail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>
References: <1463147559-544140-1-git-send-email-arnd@arndb.de>
CC: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "John.Youn@synopsys.com" <John.Youn@synopsys.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "a.seppala@gmail.com" <a.seppala@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Douglas Anderson <dianders@chromium.org>,
 Gregory Herrero <gregory.herrero@intel.com>, Mian Yousaf Kaukab
 <yousaf.kaukab@intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>
From: John Youn <John.Youn@synopsys.com>
Message-ID: <57369267.6060308@synopsys.com>
Date: Fri, 13 May 2016 19:50:15 -0700
MIME-Version: 1.0
In-Reply-To: <1463147559-544140-1-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 5/13/2016 6:53 AM, Arnd Bergmann wrote:
> A patch that went into Linux-4.4 to fix big-endian mode on a Lantiq
> MIPS system unfortunately broke big-endian operation on PowerPC
> APM82181 as reported by Christian Lamparter, and likely other
> systems.
> 
> It actually introduced multiple issues:
> 
> - it broke big-endian ARM kernels: any machine that was working
>   correctly with a little-endian kernel is no longer using byteswaps
>   on big-endian kernels, which clearly breaks them.
> - On PowerPC the same thing must be true: if it was working before,
>   using big-endian kernels is now broken. Unlike ARM, 32-bit PowerPC
>   usually uses big-endian kernels, so they are likely all broken.
> - The barrier for dwc2_writel is on the wrong side of the __raw_writel(),
>   so the MMIO no longer synchronizes with DMA operations.
> - On architectures that require specific CPU instructions for MMIO
>   access, using the __raw_ variant may turn this into a pointer
>   dereference that does not have the same effect as the readl/writel.
> 
> This patch is a simple revert for all architectures other than MIPS,
> in the hope that we can more easily backport it to fix the regression
> on PowerPC and ARM systems without breaking the Lantiq system again.
> 
> We should follow this up with a more elaborate change to add runtime
> detection of endianness, to make sure it also works on all other
> combinations of architectures and implementations of the usb-dwc2
> device. That patch however will be fairly large and not appropriate
> for backports to stable kernels.
> 
> Felipe suggested a different approach, using an endianness switching
> register to always put the device into LE mode, but unfortunately
> the dwc2 hardware does not provide a generic way to do that. Also,
> I see no practical way of addressing the problem more generally by
> patching architecture specific code on MIPS.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 95c8bc360944 ("usb: dwc2: Use platform endianness when accessing registers")
> ---
>  drivers/usb/dwc2/core.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
> index 3c58d633ce80..dec0b21fc626 100644
> --- a/drivers/usb/dwc2/core.h
> +++ b/drivers/usb/dwc2/core.h
> @@ -64,6 +64,17 @@
>  	DWC2_TRACE_SCHEDULER_VB(pr_fmt("%s: SCH: " fmt),		\
>  				dev_name(hsotg->dev), ##__VA_ARGS__)
>  
> +#ifdef CONFIG_MIPS
> +/*
> + * There are some MIPS machines that can run in either big-endian
> + * or little-endian mode and that use the dwc2 register without
> + * a byteswap in both ways.
> + * Unlike other architectures, MIPS apparently does not require a
> + * barrier before the __raw_writel() to synchronize with DMA but does
> + * require the barrier after the __raw_writel() to serialize a set of
> + * writes. This set of operations was added specifically for MIPS and
> + * should only be used there.
> + */
>  static inline u32 dwc2_readl(const void __iomem *addr)
>  {
>  	u32 value = __raw_readl(addr);
> @@ -90,6 +101,22 @@ static inline void dwc2_writel(u32 value, void __iomem *addr)
>  	pr_info("INFO:: wrote %08x to %p\n", value, addr);
>  #endif
>  }
> +#else
> +/* Normal architectures just use readl/write */
> +static inline u32 dwc2_readl(const void __iomem *addr)
> +{
> +	return readl(addr);
> +}
> +
> +static inline void dwc2_writel(u32 value, void __iomem *addr)
> +{
> +	writel(value, addr);
> +
> +#ifdef DWC2_LOG_WRITES
> +	pr_info("info:: wrote %08x to %p\n", value, addr);
> +#endif
> +}
> +#endif
>  
>  /* Maximum number of Endpoints/HostChannels */
>  #define MAX_EPS_CHANNELS	16
> 

Thanks Arnd.

Acked-by: John Youn <johnyoun@synopsys.com>

John
