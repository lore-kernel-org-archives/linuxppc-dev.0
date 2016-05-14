Return-Path: <chunkeey@googlemail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r6Lpk5R0QzDq8b
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 May 2016 19:22:22 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id n129so8039154wmn.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 May 2016 02:22:22 -0700 (PDT)
From: Christian Lamparter <chunkeey@googlemail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, linux-mips@linux-mips.org,
 johnyoun@synopsys.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, a.seppala@gmail.com,
 linuxppc-dev@lists.ozlabs.org, Douglas Anderson <dianders@chromium.org>,
 Gregory Herrero <gregory.herrero@intel.com>,
 Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4] usb: dwc2: fix regression on big-endian PowerPC/ARM
 systems
Date: Sat, 14 May 2016 11:22:12 +0200
Message-ID: <6179749.eyWcSy75sL@debian64>
In-Reply-To: <1463147559-544140-1-git-send-email-arnd@arndb.de>
References: <1463147559-544140-1-git-send-email-arnd@arndb.de>
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

On Friday, May 13, 2016 03:52:27 PM Arnd Bergmann wrote:
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
Thanks Arnd,

Tested-by: Christian Lamparter <chunkeey@googlemail.com>

dwc2 4bff80000.usbotg: Specified GNPTXFDEP=1024 > 256
dwc2 4bff80000.usbotg: EPs: 3, shared fifos, 2042 entries in SPRAM
dwc2 4bff80000.usbotg: DWC OTG Controller
dwc2 4bff80000.usbotg: new USB bus registered, assigned bus number 1
dwc2 4bff80000.usbotg: irq 33, io mem 0x00000000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected

Regards,
Christian
