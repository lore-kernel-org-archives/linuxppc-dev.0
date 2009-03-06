Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 19A09DDF33
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 09:45:50 +1100 (EST)
Subject: Re: USB Host in 2.6.24-r3 Arch=PPC
From: Joachim Foerster <mls.JOFT@gmx.de>
To: "A. Nolson" <alohanono@gmail.com>
In-Reply-To: <49B1469B.9030609@gmail.com>
References: <49B1469B.9030609@gmail.com>
Content-Type: text/plain
Date: Fri, 06 Mar 2009 23:45:42 +0100
Message-Id: <1236379543.13132.10.camel@md40100b.ft>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Fri, 2009-03-06 at 16:51 +0100, A. Nolson wrote:
>  just a little question. I am using 2.6.24-rc3 (secretlab) and I would
> like to use c67x00 driver from Peter Kosgaard for USB-Host in my Xilinx
> ML403 board. Is there support to use USB Host in Arch=ppc  Apparently I
> cannot select  CONFIG_USB_ARCH_HAS_HCD=y option. What should I do to get
> the USB working?

The problem of not being able to select the c67x00 driver, may be solved
by simply pretending that ARCH=ppc "has a HCD" ... e.g.:

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 755823c..eea0277 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -22,6 +22,7 @@ config USB_ARCH_HAS_HCD
        default y if PCMCIA && !M32R                    # sl811_cs
        default y if ARM                                # SL-811
        default y if SUPERH                             # r8a66597-hcd
+       default y if PPC
        default PCI
 
 # many non-PCI SOC chips embed OHCI

BTW: For a long time I'm wondering about what is the reason for making
it not selectable by default ...

 Joachim
