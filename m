Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id A71BBDDE33
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 16:21:06 +1100 (EST)
Message-ID: <477F13C0.7040006@pikatech.com>
Date: Sat, 05 Jan 2008 00:21:04 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Miscellaneous for Taco
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Last ones for now.

This patch allows you to turn off scsi_wait_scan.

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index a6676be..960dc78 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -248,7 +248,7 @@ config SCSI_SCAN_ASYNC
          or async on the kernel's command line.
 
 config SCSI_WAIT_SCAN
-       tristate
+       tristate "SCSI wait scan"
        default m
        depends on SCSI
        depends on MODULES

This patch allows you to use the USB with the taco. The taco does not 
have PCI so we must specifically add it.

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 7580aa5..480580c 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -39,6 +39,7 @@ config USB_ARCH_HAS_OHCI
        # PPC:
        default y if STB03xxx
        default y if PPC_MPC52xx
+       default y if TACO
        # MIPS:
        default y if SOC_AU1X00
        # more:


Cheers,
    Sean
