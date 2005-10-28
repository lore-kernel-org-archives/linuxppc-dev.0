Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 195B968613
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Oct 2005 06:29:54 +1000 (EST)
Date: Fri, 28 Oct 2005 13:21:09 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: David Jander <david.jander@protonic.nl>, Greg KH <greg@kroah.com>
Message-ID: <20051028152109.GB18915@logos.cnet>
References: <200510271439.48990.david.jander@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200510271439.48990.david.jander@protonic.nl>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8xx support in 2.6 and [PATCH] USB host controller
	selection...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greg, please refer to the end of the message.

On Thu, Oct 27, 2005 at 02:39:48PM +0200, David Jander wrote:
> 
> Hi all,
> 
> I am trying to figure out if kernel-2.6.x is already a (stable) option for 
> MPC8xx processors. Any hints? experience?

We're using v2.6.11 on production (with a custom board). Has survived
internal QA procedure, which took a couple of months under various
stress tests.

> I just rsynced DENX's git tree (cg-clone will crash on a 404 error).
> Problems I have found until now:
> 
> - Processor identification is still shady. Thanks to Marcello's patch 
> yesterday, it now boots up without problems, but this definitely needs to be 
> done. Who is working on this part?

Vitaly, can you please push your patch upstream now that v2.6.14 is out?

> - USB Kconfig file for 2.6 kernel is broken. It is not correct to assume that 
> you either have a PCI interface or a processor with internal HCI. Proof: We 
> have a board based on MPC852T (no internal UHCI) which can plug into an 
> (optional) daughter board with a ISP1160 on it. See attached patch.

Is it driven by the UHCI driver?

>From http://www.semiconductors.philips.com/cgi-bin/pldb/pip/isp1160.html

The ISP1160 is an embedded Universal Serial Bus (USB) Host Controller
(HC) that complies with Universal Serial Bus Specification Rev. 2.0,
supporting data transfer at full-speed (12 Mbit/s) and low-speed (1.5
Mbit/s).

> Maybe the patch should be sent elsewere since it has not much to do with PPC, 
> so can someone please tell me where?

I guess that you should have something like

config USB_ARCH_HAS_HCD
	default y if USB_ARCH_HAS_OHCI
	default y if USB_ARCH_HAS_UHCI

config USB_ARCH_UHCI
	default y if 8xx

Greg?

> Greetings,
> 
> -- 
> David Jander

> --- drivers/usb/Kconfig.old	2005-10-27 14:26:03.701868944 +0200
> +++ drivers/usb/Kconfig	2005-10-27 14:26:37.729695928 +0200
> @@ -4,37 +4,9 @@
>  
>  menu "USB support"
>  
> -# Host-side USB depends on having a host controller
> -# NOTE:  dummy_hcd is always an option, but it's ignored here ...
> -# NOTE:  SL-811 option should be board-specific ...
> -config USB_ARCH_HAS_HCD
> -	boolean
> -	default y if USB_ARCH_HAS_OHCI
> -	default y if ARM				# SL-811
> -	default PCI
> -
> -# many non-PCI SOC chips embed OHCI
> -config USB_ARCH_HAS_OHCI
> -	boolean
> -	# ARM:
> -	default y if SA1111
> -	default y if ARCH_OMAP
> -	default y if ARCH_LH7A404
> -	default y if ARCH_S3C2410
> -	default y if PXA27x
> -	# PPC:
> -	default y if STB03xxx
> -	default y if PPC_MPC52xx
> -	default y if 440EP
> -	# MIPS:
> -	default y if SOC_AU1X00
> -	# more:
> -	default PCI
> -
>  # ARM SA1111 chips have a non-PCI based "OHCI-compatible" USB host interface.
>  config USB
>  	tristate "Support for Host-side USB"
> -	depends on USB_ARCH_HAS_HCD
>  	---help---
>  	  Universal Serial Bus (USB) is a specification for a serial bus
>  	  subsystem which offers higher speeds and more features than the
