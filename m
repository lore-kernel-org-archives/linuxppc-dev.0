Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp8.wanadoo.fr (smtp8.wanadoo.fr [193.252.22.23])
	by ozlabs.org (Postfix) with ESMTP id 033BB67A2F
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Mar 2005 22:38:10 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0812.wanadoo.fr (SMTP Server) with ESMTP id 5B98C1C00203
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Mar 2005 14:38:07 +0200 (CEST)
Date: Sun, 27 Mar 2005 14:37:03 +0200
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Message-ID: <20050327123703.GA23113@pegasos>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
From: Sven Luther <sven.luther@wanadoo.fr>
Subject: ppc32 power3/4 pmac_cache.S build breakage fix.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hello,

Find attached a trivial fix for the 32bit power3 and power4 introduced by
benh's latest round of pmac sleep fixes.

I am not sure if this is the best way to solve this problem, but it fixes the
issue.

Friendly,

Sven Luther

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="pmac-cache.diff"

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

--u3/rZRmxL6MmkK24--
