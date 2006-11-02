Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id E6ED067BDC
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 00:23:05 +1100 (EST)
Message-Id: <20061102125630.211637000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
Date: Thu, 02 Nov 2006 13:56:10 +0100
From: s.hauer@pengutronix.de
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 15/16] powerpc: clean up usage of boot_dev
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

dev_t boot_dev is declared in arch/powerpc/kernel/setup_32.c
and in arch/powerpc/kernel/setup_64.c but not used in these files.
It is only used in arch/powerpc/platforms/powermac/setup.c, so make
it static in this file

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: arch/powerpc/kernel/setup_32.c
===================================================================
--- a/arch/powerpc/kernel/setup_32.c.orig
+++ b/arch/powerpc/kernel/setup_32.c
@@ -63,10 +63,6 @@ unsigned int DMA_MODE_WRITE;
 
 int have_of = 1;
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
-dev_t boot_dev;
-#endif /* CONFIG_PPC_MULTIPLATFORM */
-
 #ifdef CONFIG_VGA_CONSOLE
 unsigned long vgacon_remap_base;
 #endif
Index: arch/powerpc/kernel/setup_64.c
===================================================================
--- a/arch/powerpc/kernel/setup_64.c.orig
+++ b/arch/powerpc/kernel/setup_64.c
@@ -71,7 +71,6 @@
 
 int have_of = 1;
 int boot_cpuid = 0;
-dev_t boot_dev;
 u64 ppc64_pft_size;
 
 /* Pick defaults since we might want to patch instructions
Index: arch/powerpc/platforms/powermac/setup.c
===================================================================
--- a/arch/powerpc/platforms/powermac/setup.c.orig
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -361,7 +361,7 @@ char *bootdevice;
 void *boot_host;
 int boot_target;
 int boot_part;
-extern dev_t boot_dev;
+static dev_t boot_dev;
 
 #ifdef CONFIG_SCSI
 void __init note_scsi_host(struct device_node *node, void *host)

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
