Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4E22DDE0C1
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 08:21:42 +1100 (EST)
Message-Id: <200803282121.m2SLL7WL010663@imap1.linux-foundation.org>
Subject: [patch 02/24] ppc: replace remaining __FUNCTION__ occurrences
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Fri, 28 Mar 2008 14:21:07 -0700
Cc: akpm@linux-foundation.org, harvey.harrison@gmail.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Harvey Harrison <harvey.harrison@gmail.com>

__FUNCTION__ is gcc-specific, use __func__

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/ppc/8xx_io/fec.c               |    4 ++--
 arch/ppc/platforms/radstone_ppc7d.c |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff -puN arch/ppc/8xx_io/fec.c~ppc-replace-remaining-__function__-occurences arch/ppc/8xx_io/fec.c
--- a/arch/ppc/8xx_io/fec.c~ppc-replace-remaining-__function__-occurences
+++ a/arch/ppc/8xx_io/fec.c
@@ -520,7 +520,7 @@ fec_enet_interrupt(int irq, void * dev_i
 #ifdef	CONFIG_USE_MDIO
 			fec_enet_mii(dev);
 #else
-printk("%s[%d] %s: unexpected FEC_ENET_MII event\n", __FILE__,__LINE__,__FUNCTION__);
+printk("%s[%d] %s: unexpected FEC_ENET_MII event\n", __FILE__, __LINE__, __func__);
 #endif	/* CONFIG_USE_MDIO */
 		}
 
@@ -1441,7 +1441,7 @@ irqreturn_t mii_link_interrupt(int irq, 
 		fecp->fec_ecntrl = ecntrl;	/* restore old settings */
 	}
 #else
-printk("%s[%d] %s: unexpected Link interrupt\n", __FILE__,__LINE__,__FUNCTION__);
+printk("%s[%d] %s: unexpected Link interrupt\n", __FILE__, __LINE__, __func__);
 #endif	/* CONFIG_USE_MDIO */
 
 #ifndef CONFIG_RPXCLASSIC
diff -puN arch/ppc/platforms/radstone_ppc7d.c~ppc-replace-remaining-__function__-occurences arch/ppc/platforms/radstone_ppc7d.c
--- a/arch/ppc/platforms/radstone_ppc7d.c~ppc-replace-remaining-__function__-occurences
+++ a/arch/ppc/platforms/radstone_ppc7d.c
@@ -512,7 +512,7 @@ static void __init ppc7d_init_irq(void)
 {
 	int irq;
 
-	pr_debug("%s\n", __FUNCTION__);
+	pr_debug("%s\n", __func__);
 	i8259_init(0, 0);
 	mv64360_init_irq();
 
@@ -569,7 +569,7 @@ static int __init ppc7d_map_irq(struct p
 	};
 	const long min_idsel = 10, max_idsel = 14, irqs_per_slot = 4;
 
-	pr_debug("%s: %04x/%04x/%x: idsel=%hx pin=%hu\n", __FUNCTION__,
+	pr_debug("%s: %04x/%04x/%x: idsel=%hx pin=%hu\n", __func__,
 		 dev->vendor, dev->device, PCI_FUNC(dev->devfn), idsel, pin);
 
 	return PCI_IRQ_TABLE_LOOKUP;
@@ -1300,7 +1300,7 @@ static void ppc7d_init2(void)
 	u32 data;
 	u8 data8;
 
-	pr_debug("%s: enter\n", __FUNCTION__);
+	pr_debug("%s: enter\n", __func__);
 
 	/* Wait for debugger? */
 	if (ppc7d_wait_debugger) {
@@ -1333,7 +1333,7 @@ static void ppc7d_init2(void)
         ppc_md.set_rtc_time = ppc7d_set_rtc_time;
         ppc_md.get_rtc_time = ppc7d_get_rtc_time;
 
-	pr_debug("%s: exit\n", __FUNCTION__);
+	pr_debug("%s: exit\n", __func__);
 }
 
 /* Called from machine_init(), early, before any of the __init functions
_
