Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 4F4EE67A5C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 May 2006 04:26:59 +1000 (EST)
Date: Thu, 25 May 2006 14:26:57 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 3/5] Updates for WRS SBC82xx boards
Message-ID: <20060525182656.GE679@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: p_gortmaker@yahoo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


patch3: sbc82xx-CONFIG.diff1
	- add CONFIG_SBC82xx alongside CONFIG_PQ2FADS where required.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>



--- linux-2.6.16_rc5/arch/ppc/syslib/m82xx_pci.c.orig	2006-02-27 14:55:41.000000000 -0500
+++ linux-2.6.16_rc5/arch/ppc/syslib/m82xx_pci.c	2006-02-27 15:02:01.000000000 -0500
@@ -238,7 +238,7 @@
 		SIUMCR_APPC10 | SIUMCR_CS10PC00 |
 		SIUMCR_BCTLC00 | SIUMCR_MMR11 ;
 
-#elif defined CONFIG_PQ2FADS
+#elif defined(CONFIG_PQ2FADS) || defined(CONFIG_SBC82xx)
 	/*
 	 * Setting required to enable IRQ1-IRQ7 (SIUMCR [DPPC]),
 	 * and local bus for PCI (SIUMCR [LBPC]).
@@ -292,7 +292,7 @@
 #if defined CONFIG_ADS8272
 	/* PCI int highest prio */
 	immap->im_siu_conf.siu_82xx.sc_ppc_alrh = 0x01236745;
-#elif defined CONFIG_PQ2FADS
+#elif defined(CONFIG_PQ2FADS) || defined(CONFIG_SBC82xx)
 	immap->im_siu_conf.siu_82xx.sc_ppc_alrh = 0x03124567;
 #endif
 	/* park bus on PCI */
@@ -380,7 +380,10 @@
 			IORESOURCE_IO | 1, "PCI I/O");
 
 	ppc_md.pci_exclude_device = pq2pci_exclude_device;
+
+#ifndef CONFIG_SBC82xx
 	hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
+#endif
 
 	ppc_md.pci_map_irq = pq2pci_map_irq;
 	ppc_md.pcibios_fixup = NULL;
