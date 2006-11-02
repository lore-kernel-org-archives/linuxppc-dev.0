Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 02A4667C4D
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 00:23:07 +1100 (EST)
Message-Id: <20061102125629.335003000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
Date: Thu, 02 Nov 2006 13:56:08 +0100
From: s.hauer@pengutronix.de
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 13/16] powerpc: make prom_init.o dependent on PPC_OF
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

prom_init.o is used for OF machines, so make compilation dependent
on that and not on PPC_MULTIPLATFORM

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: arch/powerpc/kernel/Makefile
===================================================================
--- a/arch/powerpc/kernel/Makefile.orig
+++ b/arch/powerpc/kernel/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o binfm
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
-obj-$(CONFIG_PPC_OF)		+= of_device.o prom_parse.o
+obj-$(CONFIG_PPC_OF)		+= of_device.o prom_parse.o prom_init.o
 procfs-$(CONFIG_PPC64)		:= proc_ppc64.o
 obj-$(CONFIG_PROC_FS)		+= $(procfs-y)
 rtaspci-$(CONFIG_PPC64)		:= rtas_pci.o
@@ -53,7 +53,6 @@ obj-y				+= time.o prom.o traps.o setup-
 				   udbg.o misc.o io.o
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o misc_32.o
 obj-$(CONFIG_PPC64)		+= misc_64.o dma_64.o iommu.o
-obj-$(CONFIG_PPC_MULTIPLATFORM)	+= prom_init.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_SMP)		+= smp.o

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
