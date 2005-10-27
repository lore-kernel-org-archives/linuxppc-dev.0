Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id C102A685A6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Oct 2005 22:39:56 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 7518429EBB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Oct 2005 14:38:17 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18566-08 for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Oct 2005 14:38:16 +0200 (CEST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 887C028067
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Oct 2005 14:38:16 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Date: Thu, 27 Oct 2005 14:39:48 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UqMYDU7iQcVmsuy"
Message-Id: <200510271439.48990.david.jander@protonic.nl>
Subject: MPC8xx support in 2.6 and [PATCH] USB host controller selection...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_UqMYDU7iQcVmsuy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi all,

I am trying to figure out if kernel-2.6.x is already a (stable) option for 
MPC8xx processors. Any hints? experience?
I just rsynced DENX's git tree (cg-clone will crash on a 404 error).
Problems I have found until now:

- Processor identification is still shady. Thanks to Marcello's patch 
yesterday, it now boots up without problems, but this definitely needs to be 
done. Who is working on this part?

- USB Kconfig file for 2.6 kernel is broken. It is not correct to assume that 
you either have a PCI interface or a processor with internal HCI. Proof: We 
have a board based on MPC852T (no internal UHCI) which can plug into an 
(optional) daughter board with a ISP1160 on it. See attached patch.

Maybe the patch should be sent elsewere since it has not much to do with PPC, 
so can someone please tell me where?

Greetings,

-- 
David Jander

--Boundary-00=_UqMYDU7iQcVmsuy
Content-Type: text/x-diff; charset="us-ascii"; name="usb-hcd-selection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usb-hcd-selection.patch"

--- drivers/usb/Kconfig.old	2005-10-27 14:26:03.701868944 +0200
+++ drivers/usb/Kconfig	2005-10-27 14:26:37.729695928 +0200
@@ -4,37 +4,9 @@
 
 menu "USB support"
 
-# Host-side USB depends on having a host controller
-# NOTE:  dummy_hcd is always an option, but it's ignored here ...
-# NOTE:  SL-811 option should be board-specific ...
-config USB_ARCH_HAS_HCD
-	boolean
-	default y if USB_ARCH_HAS_OHCI
-	default y if ARM				# SL-811
-	default PCI
-
-# many non-PCI SOC chips embed OHCI
-config USB_ARCH_HAS_OHCI
-	boolean
-	# ARM:
-	default y if SA1111
-	default y if ARCH_OMAP
-	default y if ARCH_LH7A404
-	default y if ARCH_S3C2410
-	default y if PXA27x
-	# PPC:
-	default y if STB03xxx
-	default y if PPC_MPC52xx
-	default y if 440EP
-	# MIPS:
-	default y if SOC_AU1X00
-	# more:
-	default PCI
-
 # ARM SA1111 chips have a non-PCI based "OHCI-compatible" USB host interface.
 config USB
 	tristate "Support for Host-side USB"
-	depends on USB_ARCH_HAS_HCD
 	---help---
 	  Universal Serial Bus (USB) is a specification for a serial bus
 	  subsystem which offers higher speeds and more features than the

--Boundary-00=_UqMYDU7iQcVmsuy--
