Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r6cfK3v1dzDq92
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 May 2016 05:46:00 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: John Youn <John.Youn@synopsys.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "a.seppala@gmail.com" <a.seppala@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
Date: Sat, 14 May 2016 21:45:27 +0200
Message-ID: <2626585.pWJiHSe1F4@wuerfel>
In-Reply-To: <2920638.peXreEnG6d@debian64>
References: <4231696.iL6nGs74X8@debian64> <5734CE1C.8070208@synopsys.com>
 <2920638.peXreEnG6d@debian64>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 14 May 2016 15:11:34 Christian Lamparter wrote:
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
> +static inline u32 dwc2_readl(struct dwc2_hsotg *hsotg,
> +                            ptrdiff_t reg)
> +{
> +       const void __iomem *addr = hsotg->regs + reg;
> +       u32 value = __raw_readl(addr);
> +
> 

I see you keep the special case for MIPS here, I'd vote for folding
that back into the architecture-independent version and not treating
MIPS any different from the others. With your endianness detection, MIPS
should have no way of getting the byteorder wrong, and on MIPS the
platform is responsible for adding the appropriate barriers to
readl/writel.

Other than this, the patch looks good to me.

	Arnd
