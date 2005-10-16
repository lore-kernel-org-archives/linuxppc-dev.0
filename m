Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp2.wanadoo.fr (smtp2.wanadoo.fr [193.252.22.29])
	by ozlabs.org (Postfix) with ESMTP id 53A036856A
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Oct 2005 20:40:20 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0201.wanadoo.fr (SMTP Server) with ESMTP id 3E3261C00460
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Oct 2005 12:40:16 +0200 (CEST)
Date: Sun, 16 Oct 2005 12:28:28 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, Andrew Morton <akpm@osdl.org>,
	debian-kernel@lists.debian.org
Message-ID: <20051016102828.GA32332@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="s2ZSL+KKDSLx8OML"
From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Two 32bit power3/4 build-failure patches ...
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I have here two 32bit power[34] build failure patches that the debian kernels
has been using for some time, and which i think i did post here in the past,
but it doesn't seem to be applied.

Well, those are 32 bit issues, and debian doesn't build anymore 32bit kernels
of those flavours, but i guess it may be possible that some random user wants
to build them, so it would be nice if they could be included upstream.

Friendly,

Sven Luther


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="powerpc-fix-power3-ftbfs.patch"

#! /bin/sh -e 
##
## All lines beginning with `## DP:' are a description of the patch.
## DP: Description: Works around a broken build system, namely the
## DP: Description: simple bootloader on power 3/4.
## DP: Misc: Pulled from the ubuntu tree.
## DP: Patch author: fabbione@ubuntu.com
## DP: Upstream status: FTBFS fix, guess it will be fixed upstream too

. $(dirname $0)/DPATCH

@DPATCH@
diff -urNad linux-source-2.6.10-2.6.10/arch/ppc/boot/simple/misc-prep.c /usr/src/dpatchtemp/dpep.cQRwcC/linux-source-2.6.10-2.6.10/arch/ppc/boot/simple/misc-prep.c
--- linux-source-2.6.10-2.6.10/arch/ppc/boot/simple/misc-prep.c	2004-12-24 22:33:51.000000000 +0100
+++ /usr/src/dpatchtemp/dpep.cQRwcC/linux-source-2.6.10-2.6.10/arch/ppc/boot/simple/misc-prep.c	2004-12-28 10:43:29.838010536 +0100
@@ -152,9 +152,11 @@
 		hold_residual->VitalProductData.Reserved5 = 0xdeadbeef;
 	}
 
+#if defined(CONFIG_6xx)
 	/* Now go and clear out the BATs and ensure that our MSR is
 	 * correct .*/
 	disable_6xx_mmu();
+#endif
 
 	/* Make r3 be a pointer to the residual data. */
 	return (unsigned long)hold_residual;

--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="powerpc-pmac-cache-power34-fix.patch"

#! /bin/sh -e
##
## All lines beginning with `## DP:' are a description of the patch.
## DP: Description: [PATCH] ppc32: fixes FTBFS on power3/4.
## DP: This patch doesn't build pmac_cache.S on power3/power4, since it is
## DP: broken there and not needed.
## DP: Patch author: Sven Luther <luther@debian.org>
## DP: Upstream status: FTBFS, submitted to linuxppc-dev and benh.

. $(dirname $0)/DPATCH

@DPATCH@
--- kernel-source-2.6.11/arch/ppc/platforms/Makefile.orig	2005-03-27 11:38:25.000000000 +0200
+++ kernel-source-2.6.11/arch/ppc/platforms/Makefile	2005-03-27 11:39:23.000000000 +0200
@@ -9,9 +9,15 @@
 ifeq ($(CONFIG_APUS),y)
 obj-$(CONFIG_PCI)		+= apus_pci.o
 endif
+ifeq ($(CONFIG_6xx),y)
 obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
 					pmac_feature.o pmac_pci.o pmac_sleep.o \
 					pmac_low_i2c.o pmac_cache.o
+else
+obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
+					pmac_feature.o pmac_pci.o pmac_sleep.o \
+					pmac_low_i2c.o
+endif
 obj-$(CONFIG_PPC_CHRP)		+= chrp_setup.o chrp_time.o chrp_pci.o \
 					chrp_pegasos_eth.o
 obj-$(CONFIG_PPC_PREP)		+= prep_pci.o prep_setup.o

--s2ZSL+KKDSLx8OML--
