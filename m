Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 943E768593
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Oct 2005 22:57:17 +1000 (EST)
Message-ID: <4360CEA7.6090906@ru.mvista.com>
Date: Thu, 27 Oct 2005 16:57:11 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: David Jander <david.jander@protonic.nl>
References: <200510271439.48990.david.jander@protonic.nl>
In-Reply-To: <200510271439.48990.david.jander@protonic.nl>
Content-Type: text/plain; charset=KOI8-R; format=flowed
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

David Jander wrote:
> Hi all,
> 
> I am trying to figure out if kernel-2.6.x is already a (stable) option for 
> MPC8xx processors. Any hints? experience?
What option do you mean? The last kernel supports a number of 8xx, and I 
have MPC885ADS and MPC866ADS run it without major problems.
> I just rsynced DENX's git tree (cg-clone will crash on a 404 error).
> Problems I have found until now:
> 
> - Processor identification is still shady. Thanks to Marcello's patch 
> yesterday, it now boots up without problems, but this definitely needs to be 
> done. Who is working on this part?
> 
The fix is in the mm tree. And it has been submitted here as well btw.
> - USB Kconfig file for 2.6 kernel is broken. It is not correct to assume that 
> you either have a PCI interface or a processor with internal HCI. Proof: We 
> have a board based on MPC852T (no internal UHCI) which can plug into an 
> (optional) daughter board with a ISP1160 on it. See attached patch.
> 
> Maybe the patch should be sent elsewere since it has not much to do with PPC, 
> so can someone please tell me where?
I guess linux-usb-devel@lists.sourceforge.net is the correct place to 
issue this.

> 
> Greetings,
> 
> 
> 
> ------------------------------------------------------------------------
> 
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
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Sincerely,
Vitaly
