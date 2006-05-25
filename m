Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 5C37767A42
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 May 2006 04:25:38 +1000 (EST)
Date: Thu, 25 May 2006 14:25:33 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/5] Updates for WRS SBC82xx boards
Message-ID: <20060525182533.GD679@windriver.com>
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


patch2: sbc82xx-PCI-diff1
	- allow m82xx_pci.c to be used by other platforms that have
	  their own map_irq

I'm open to doing this another way if desired -- I just went for the
minimal impact on the existing code with this.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>


diff -ur orig/linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.c linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.c
--- orig/linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.c	2006-02-09 16:20:35.000000000 -0500
+++ linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.c	2006-02-09 16:01:40.000000000 -0500
@@ -198,7 +198,7 @@
 	}
 }
 
-static int sbc82xx_pci_map_irq(struct pci_dev *dev, unsigned char idsel,
+int pq2pci_map_irq(struct pci_dev *dev, unsigned char idsel,
 			       unsigned char pin)
 {
 	static char pci_irq_table[][4] = {
@@ -247,7 +247,7 @@
 	callback_init_IRQ	= ppc_md.init_IRQ;
 
 	ppc_md.init_IRQ		= sbc82xx_init_IRQ;
-	ppc_md.pci_map_irq	= sbc82xx_pci_map_irq;
+	ppc_md.pci_map_irq	= pq2pci_map_irq;
 #ifdef CONFIG_GEN_RTC
 	ppc_md.time_init        = NULL;
 	ppc_md.get_rtc_time     = NULL;
diff -ur orig/linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.h linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.h
--- orig/linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.h	2006-02-09 16:20:35.000000000 -0500
+++ linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.h	2006-02-09 16:35:05.000000000 -0500
@@ -24,6 +24,7 @@
 
 #define BOOTROM_RESTART_ADDR      ((uint)0x40000104)
 
+#define HAVE_OWN_PQ2PCI_IRQ
 #define SBC82xx_PC_IRQA		(NR_CPM_INTS+0)
 #define SBC82xx_PC_IRQB		(NR_CPM_INTS+1)
 #define SBC82xx_MPC185_IRQ	(NR_CPM_INTS+2)
diff -ur orig/linux-2.6.16rc2/arch/ppc/syslib/m82xx_pci.c linux-2.6.16rc2/arch/ppc/syslib/m82xx_pci.c
--- orig/linux-2.6.16rc2/arch/ppc/syslib/m82xx_pci.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.16rc2/arch/ppc/syslib/m82xx_pci.c	2006-02-09 14:35:10.000000000 -0500
@@ -51,6 +51,10 @@
  * Interrupt routing
  */
 
+#ifdef HAVE_OWN_PQ2PCI_IRQ
+extern int
+pq2pci_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin);
+#else 
 static inline int
 pq2pci_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
 {
@@ -172,6 +176,7 @@
 	setup_irq(PCI_INT_TO_SIU, &pq2pci_irqaction);
 	return;
 }
+#endif	/* HAVE_OWN_PQ2PCI_IRQ */
 
 static int
 pq2pci_exclude_device(u_char bus, u_char devfn)
