Date: Fri, 21 Jun 2002 17:08:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Armin Kuster <akuster@mvista.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: irq_resources cleanup (step 1)
Message-ID: <20020621070833.GD9087@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The patch below fixes the two worst problems with the current
irq_resources setup used by the OCP EMAC driver, to wit:
	- The fact that the board specific files need to directly
reference the interrupt handler functions is a big abstraction
violation, and can cause compile problems if EMAC support is not
included.
	- The name "irq_resource" for this global data structure is
confusing, since on a number of architectures "irq_resource" is the
name of the top level (struct resource) which handles irq allocation.

So, this patch renames struct irq_resources to struct ocp_irq_desc and
the global table of these to "ocp_irq_table".  Actually that's still a
misleading since the emac driver assumes it is the only user of this
table, but we'll save that for another day.  It also removes both the
irq_name and irq_handler fields and instead the ibm_ocp_enet driver
supplies this information directly to request_irq() from it's own
internal table.

This works on my 405GP, but needs testing on 440GP, NP405H and NP405L
(it should work, but I don't have the hardware to check).  It is
orthogonal to all my other outstanding ocp patches.

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ocp.c linux-grinch/arch/ppc/kernel/ocp.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ocp.c	Wed Jun 19 10:32:59 2002
+++ linux-grinch/arch/ppc/kernel/ocp.c	Fri Jun 21 16:22:03 2002
@@ -75,7 +75,6 @@

 LIST_HEAD(ocp_list);

-extern struct irq_resources irq_resource[][OCP_MAX_IRQS];
 extern struct ocp_def core_ocp[];

 struct type_info ocp_type_info[] = {
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ocp_proc.c linux-grinch/arch/ppc/kernel/ocp_proc.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ocp_proc.c	Wed Jun 19 10:32:59 2002
+++ linux-grinch/arch/ppc/kernel/ocp_proc.c	Fri Jun 21 16:23:53 2002
@@ -57,7 +57,7 @@
 #include <asm/byteorder.h>
 #include <asm/ocp.h>
 extern struct type_info ocp_type_info[];
-extern struct irq_resources irq_resource[][OCP_MAX_IRQS];
+extern struct ocp_irq_desc ocp_irq_table[][OCP_MAX_IRQS];

 /* iterator */
 static void *
@@ -104,7 +104,7 @@
 		seq_printf(m, " N/A");
 	} else if (i == OCP_IRQ_MUL) {
 		for (i = 0; i < OCP_MAX_IRQS; i++) {
-			seq_printf(m, " %02d", irq_resource[drv->num][i].irq);
+			seq_printf(m, " %02d", ocp_irq_table[drv->num][i].irq);
 		}
 	} else {
 		seq_printf(m, " %02d", drv->irq);
@@ -144,7 +144,7 @@
 	} else if (i == OCP_IRQ_MUL) {
 		for (i = 0; i < OCP_MAX_IRQS; i++) {
 			seq_printf(m, "   irq: %02d\n",
-				   irq_resource[drv->num][i].irq);
+				   ocp_irq_table[drv->num][i].irq);
 		}
 	} else {
 		seq_printf(m, "   irq: %02d\n", drv->irq);
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm405gp.c linux-grinch/arch/ppc/platforms/ibm405gp.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm405gp.c	Fri May 24 11:19:23 2002
+++ linux-grinch/arch/ppc/platforms/ibm405gp.c	Fri Jun 21 16:36:23 2002
@@ -48,14 +48,14 @@
 #include <platforms/ibm405gp.h>
 #include <asm/ocp.h>

-const struct irq_resources irq_resource[][OCP_MAX_IRQS] = {
-	{{"405eth Wakeup", 9, ppc405_eth_wakeup, 0},
-	 {"405eth MAL SERR", 10, ppc405_eth_serr, 0},
-	 {"405eth TX DE", 13, ppc405_eth_txde, 0},
-	 {"405eth RX DE", 14, ppc405_eth_rxde, 0},
-	 {"405eth MAC", 15, ppc405_eth_mac, 0},
-	 {"405eth TX EOB", 11, ppc405_eth_txeob, 0},
-	 {"405eth RX EOB", 12, ppc405_eth_rxeob, 0}}
+const struct ocp_irq_desc ocp_irq_table[][OCP_MAX_IRQS] = {
+	{{9, 0}, /* WOL */
+	 {10, 0}, /* MAL SERR */
+	 {13, 0}, /* MAL TX DE */
+	 {14, 0}, /* MAL RX DE */
+	 {15, 0}, /* MAC */
+	 {11, 0}, /* MAL TX EOB */
+	 {12, 0}} /* MAL RX EOB */
 };

 struct ocp_def core_ocp[] = {
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm440gp.c linux-grinch/arch/ppc/platforms/ibm440gp.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm440gp.c	Wed Jun  5 10:05:32 2002
+++ linux-grinch/arch/ppc/platforms/ibm440gp.c	Fri Jun 21 17:00:39 2002
@@ -32,30 +32,22 @@
  * We only have onboard EMAC support for now.  I2C, DMA, timers,
  * etc. have yet to be enabled.
  */
-#ifdef CONFIG_IBM_OCP_ENET
-const struct irq_resources irq_resource[EMAC_NUMS][OCP_MAX_IRQS] = {
-	{
-	 {"EMAC0 WOL", 61, ppc405_eth_wakeup, 0},
-	 {"MAL SERR", 32, ppc405_eth_serr, OCP_INTR_FLAG_SHARED},
-	 {"MAL TXDE", 33, ppc405_eth_txde, OCP_INTR_FLAG_SHARED},
-	 {"MAL RXDE", 34, ppc405_eth_rxde, OCP_INTR_FLAG_SHARED},
-	 {"EMAC0 MAC", 60, ppc405_eth_mac, 0},
-	 {"MAL TXEOB", 10, ppc405_eth_txeob, OCP_INTR_FLAG_SHARED},
-	 {"MAL RXEOB", 11, ppc405_eth_rxeob, OCP_INTR_FLAG_SHARED},
-	 },
-	{
-	 {"EMAC1 WOL", 63, ppc405_eth_wakeup, 0},
-	 {"MAL SERR", 32, ppc405_eth_serr, OCP_INTR_FLAG_SHARED},
-	 {"MAL TXDE", 33, ppc405_eth_txde, OCP_INTR_FLAG_SHARED},
-	 {"MAL RXDE", 34, ppc405_eth_rxde, OCP_INTR_FLAG_SHARED},
-	 {"EMAC1 MAC", 62, ppc405_eth_mac, 0},
-	 {"MAL TXEOB", 10, ppc405_eth_txeob, OCP_INTR_FLAG_SHARED},
-	 {"MAL RXEOB", 11, ppc405_eth_rxeob, OCP_INTR_FLAG_SHARED},
-	 }
+const struct ocp_irq_desc ocp_irq_table[EMAC_NUMS][OCP_MAX_IRQS] = {
+	{{61, 0}, /* WOL */
+	 {32, OCP_INTR_FLAG_SHARED}, /* MAL SERR */
+	 {33, OCP_INTR_FLAG_SHARED}, /* MAL TX DE */
+	 {34, OCP_INTR_FLAG_SHARED}, /* MAL RX DE */
+	 {60, 0}, /* MAC */
+	 {10, OCP_INTR_FLAG_SHARED}, /* MAL TX EOB */
+	 {11, OCP_INTR_FLAG_SHARED}}, /* MAL RX EOB */
+	{{63, 0}, /* WOL */
+	 {32, OCP_INTR_FLAG_SHARED}, /* MAL SERR */
+	 {33, OCP_INTR_FLAG_SHARED}, /* MAL TX DE */
+	 {34, OCP_INTR_FLAG_SHARED}, /* MAL RX DE */
+	 {62, 0}, /* MAC */
+	 {10, OCP_INTR_FLAG_SHARED}, /* MAL TX EOB */
+	 {11, OCP_INTR_FLAG_SHARED}} /* MAL RX EOB */
 };
-#else
-const struct irq_resources irq_resource[EMAC_NUMS][OCP_MAX_IRQS];
-#endif

 struct ocp_def core_ocp[] = {
 	{UART, PPC440GP_UART0_ADDR, UART0_INT},
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm_ocp.h linux-grinch/arch/ppc/platforms/ibm_ocp.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm_ocp.h	Sat May 11 12:05:45 2002
+++ linux-grinch/arch/ppc/platforms/ibm_ocp.h	Fri Jun 21 16:42:41 2002
@@ -49,14 +49,6 @@
 #include <linux/types.h>
 #include <asm/ptrace.h>

-extern void ppc405_eth_wakeup(int, void *, struct pt_regs *);
-extern void ppc405_eth_serr(int, void *, struct pt_regs *);
-extern void ppc405_eth_txeob(int, void *, struct pt_regs *);
-extern void ppc405_eth_rxeob(int, void *, struct pt_regs *);
-extern void ppc405_eth_txde(int, void *, struct pt_regs *);
-extern void ppc405_eth_rxde(int, void *, struct pt_regs *);
-extern void ppc405_eth_mac(int, void *, struct pt_regs *);
-
  /* PCI 32 */

 struct pmm_regs {
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibmnp405h.c linux-grinch/arch/ppc/platforms/ibmnp405h.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibmnp405h.c	Fri May 24 11:19:23 2002
+++ linux-grinch/arch/ppc/platforms/ibmnp405h.c	Fri Jun 21 16:41:06 2002
@@ -52,35 +52,35 @@
 #include <platforms/ibmnp405h.h>
 #include <asm/ocp.h>

-const struct irq_resources irq_resource[][OCP_MAX_IRQS] = {
-	{{"405eth Wakeup", 41, ppc405_eth_wakeup, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 SERR", 45, ppc405_eth_serr, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 TX DE", 46, ppc405_eth_txde, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 RX DE", 47, ppc405_eth_rxde, OCP_INTR_FLAG_SHARED},
-	 {"405eth0 MAC", 37, ppc405_eth_mac, 0},
-	 {"405mal0 TX EOB", 17, ppc405_eth_txeob, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 RX EOB", 18, ppc405_eth_rxeob, OCP_INTR_FLAG_SHARED}},
-	{{"405eth Wakeup", 41, ppc405_eth_wakeup, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 SERR", 45, ppc405_eth_serr, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 TX DE", 46, ppc405_eth_txde, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 RX DE", 47, ppc405_eth_rxde, OCP_INTR_FLAG_SHARED},
-	 {"405eth1 MAC", 38, ppc405_eth_mac, 0},
-	 {"405mal0 TX EOB", 17, ppc405_eth_txeob, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 RX EOB", 18, ppc405_eth_rxeob, OCP_INTR_FLAG_SHARED}},
-	{{"405eth Wakeup", 41, ppc405_eth_wakeup, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 SERR", 45, ppc405_eth_serr, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 TX DE", 46, ppc405_eth_txde, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 RX DE", 47, ppc405_eth_rxde, OCP_INTR_FLAG_SHARED},
-	 {"405eth2 MAC", 39, ppc405_eth_mac, 0},
-	 {"405mal0 TX EOB", 17, ppc405_eth_txeob, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 RX EOB", 18, ppc405_eth_rxeob, OCP_INTR_FLAG_SHARED}},
-	{{"405eth Wakeup", 41, ppc405_eth_wakeup, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 SERR", 45, ppc405_eth_serr, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 TX DE", 46, ppc405_eth_txde, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 RX DE", 47, ppc405_eth_rxde, OCP_INTR_FLAG_SHARED},
-	 {"405eth3 MAC", 40, ppc405_eth_mac, 0},
-	 {"405mal0 TX EOB", 17, ppc405_eth_txeob, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 RX EOB", 18, ppc405_eth_rxeob, OCP_INTR_FLAG_SHARED}}
+const struct ocp_irq_desc ocp_irq_table[][OCP_MAX_IRQS] = {
+	{{41, OCP_INTR_FLAG_SHARED}, /* WOL */
+	 {45, OCP_INTR_FLAG_SHARED}, /* MAL SERR */
+	 {46, OCP_INTR_FLAG_SHARED}, /* MAL TXDE */
+	 {47, OCP_INTR_FLAG_SHARED}, /* MAL RXDE */
+	 {37, 0}, /* MAC */
+	 {17, OCP_INTR_FLAG_SHARED}, /* MAL TX EOB */
+	 {18, OCP_INTR_FLAG_SHARED}}, /* MAL RX EOB */
+	{{41, OCP_INTR_FLAG_SHARED}, /* WOL */
+	 {45, OCP_INTR_FLAG_SHARED}, /* MAL SERR */
+	 {46, OCP_INTR_FLAG_SHARED}, /* MAL TXDE */
+	 {47, OCP_INTR_FLAG_SHARED}, /* MAL RXDE */
+	 {38, 0}, /* MAC */
+	 {17, OCP_INTR_FLAG_SHARED}, /* MAL TX EOB */
+	 {18, OCP_INTR_FLAG_SHARED}}, /* MAL RX EOB */
+	{{41, OCP_INTR_FLAG_SHARED}, /* WOL */
+	 {45, OCP_INTR_FLAG_SHARED}, /* MAL SERR */
+	 {46, OCP_INTR_FLAG_SHARED}, /* MAL TXDE */
+	 {47, OCP_INTR_FLAG_SHARED}, /* MAL RXDE */
+	 {39, 0}, /* MAC */
+	 {17, OCP_INTR_FLAG_SHARED}, /* MAL TX EOB */
+	 {18, OCP_INTR_FLAG_SHARED}}, /* MAL RX EOB */
+	{{41, OCP_INTR_FLAG_SHARED}, /* WOL */
+	 {45, OCP_INTR_FLAG_SHARED}, /* MAL SERR */
+	 {46, OCP_INTR_FLAG_SHARED}, /* MAL TXDE */
+	 {47, OCP_INTR_FLAG_SHARED}, /* MAL RXDE */
+	 {40, 0}, /* MAC */
+	 {17, OCP_INTR_FLAG_SHARED}, /* MAL TX EOB */
+	 {18, OCP_INTR_FLAG_SHARED}}, /* MAL RX EOB */
 };

 struct ocp_def core_ocp[] = {
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibmnp405l.c linux-grinch/arch/ppc/platforms/ibmnp405l.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibmnp405l.c	Fri May 24 11:19:23 2002
+++ linux-grinch/arch/ppc/platforms/ibmnp405l.c	Fri Jun 21 16:41:38 2002
@@ -51,22 +51,21 @@
 #include <platforms/ibmnp405l.h>
 #include <asm/ocp.h>

-const struct irq_resources irq_resource[][OCP_MAX_IRQS] = {
-	{{"405eth Wakeup", 41, ppc405_eth_wakeup, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 SERR", 45, ppc405_eth_serr, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 TX DE", 46, ppc405_eth_txde, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 RX DE", 47, ppc405_eth_rxde, OCP_INTR_FLAG_SHARED},
-	 {"405eth0 MAC", 37, ppc405_eth_mac, 0},
-	 {"405mal0 TX EOB", 17, ppc405_eth_txeob, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 RX EOB", 18, ppc405_eth_rxeob, OCP_INTR_FLAG_SHARED}},
-	{{"405eth Wakeup", 41, ppc405_eth_wakeup, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 SERR", 45, ppc405_eth_serr, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 TX DE", 46, ppc405_eth_txde, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 RX DE", 47, ppc405_eth_rxde, OCP_INTR_FLAG_SHARED},
-	 {"405eth1 MAC", 38, ppc405_eth_mac, 0},
-	 {"405mal0 TX EOB", 17, ppc405_eth_txeob, OCP_INTR_FLAG_SHARED},
-	 {"405mal0 RX EOB", 18, ppc405_eth_rxeob, OCP_INTR_FLAG_SHARED}}
-
+const struct ocp_irq_descs ocp_irq_table[][OCP_MAX_IRQS] = {
+	{{41, OCP_INTR_FLAG_SHARED}, /* WOL */
+	 {45, OCP_INTR_FLAG_SHARED}, /* MAL SERR */
+	 {46, OCP_INTR_FLAG_SHARED}, /* MAL TXDE */
+	 {47, OCP_INTR_FLAG_SHARED}, /* MAL RXDE */
+	 {37, 0}, /* MAC */
+	 {17, OCP_INTR_FLAG_SHARED}, /* MAL TX EOB */
+	 {18, OCP_INTR_FLAG_SHARED}}, /* MAL RX EOB */
+	{{41, OCP_INTR_FLAG_SHARED}, /* WOL */
+	 {45, OCP_INTR_FLAG_SHARED}, /* MAL SERR */
+	 {46, OCP_INTR_FLAG_SHARED}, /* MAL TXDE */
+	 {47, OCP_INTR_FLAG_SHARED}, /* MAL RXDE */
+	 {38, 0}, /* MAC */
+	 {17, OCP_INTR_FLAG_SHARED}, /* MAL TX EOB */
+	 {18, OCP_INTR_FLAG_SHARED}}, /* MAL RX EOB */
 };

 struct ocp_def core_ocp[] = {
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/drivers/net/ibm_ocp/ibm_ocp_enet.c linux-grinch/drivers/net/ibm_ocp/ibm_ocp_enet.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/drivers/net/ibm_ocp/ibm_ocp_enet.c	Wed Jun 19 10:32:59 2002
+++ linux-grinch/drivers/net/ibm_ocp/ibm_ocp_enet.c	Fri Jun 21 16:57:47 2002
@@ -203,13 +203,13 @@
 static int ppc405_enet_close(struct net_device *);
 static void ppc405_enet_set_multicast_list(struct net_device *);

-void ppc405_eth_wakeup(int, void *, struct pt_regs *);
-void ppc405_eth_serr(int, void *, struct pt_regs *);
-void ppc405_eth_txeob(int, void *, struct pt_regs *);
-void ppc405_eth_rxeob(int, void *, struct pt_regs *);
-void ppc405_eth_txde(int, void *, struct pt_regs *);
-void ppc405_eth_rxde(int, void *, struct pt_regs *);
-void ppc405_eth_mac(int, void *, struct pt_regs *);
+static void ppc405_eth_wakeup(int, void *, struct pt_regs *);
+static void ppc405_eth_serr(int, void *, struct pt_regs *);
+static void ppc405_eth_txeob(int, void *, struct pt_regs *);
+static void ppc405_eth_rxeob(int, void *, struct pt_regs *);
+static void ppc405_eth_txde(int, void *, struct pt_regs *);
+static void ppc405_eth_rxde(int, void *, struct pt_regs *);
+static void ppc405_eth_mac(int, void *, struct pt_regs *);
 static void ppc405_rx_fill(struct net_device *, int);
 static int ppc405_rx_clean(struct net_device *);

@@ -227,6 +227,19 @@

 int emac_max;

+static const struct {
+	char *name;
+	void *handler;
+} irq_handler_table[7] = {
+	{"OCP EMAC Wakeup", ppc405_eth_wakeup},
+	{"OCP EMAC MAL SERR", ppc405_eth_serr},
+	{"OCP EMAC TX DE", ppc405_eth_txde},
+	{"OCP EMAC RX DE", ppc405_eth_rxde},
+	{"OCP EMAC MAC", ppc405_eth_mac},
+	{"OCP EMAC TX EOB", ppc405_eth_txeob},
+	{"OCP EMAC RX EOB", ppc405_eth_rxeob}
+};
+
 static int skb_res = SKB_RES;
 MODULE_PARM(skb_res, "i");
 MODULE_PARM_DESC(skb_res, "Amount of data to reserve on skb buffs\n"
@@ -351,13 +364,12 @@
 	out_be32(&emacp->em0iser, emac_ier);

 	for (i = BL_MAC_WOL; i <= BL_MAL_RXEOB; i++) {
-		if (!(irq_resource[fep->emac_num][i].flags &
+		if (!(ocp_irq_table[fep->emac_num][i].flags &
 		      OCP_INTR_FLAG_SHARED) || (get_mal_dcrn(fep, DCRN_MALTXCASR)==0x0)) {
-			request_irq(irq_resource[fep->emac_num][i].irq,
-				    irq_resource[fep->emac_num][i].
-				    irq_handler, 0,
-				    irq_resource[fep->emac_num][i].
-				    irq_name, dev);
+			request_irq(ocp_irq_table[fep->emac_num][i].irq,
+				    irq_handler_table[i].handler,
+				    0,
+				    irq_handler_table[i].name, dev);
 		}
 	}

@@ -443,9 +455,9 @@

 	/* Free the irq's */
 	for (i = BL_MAC_WOL; i <= BL_MAL_RXEOB; i++) {
-		if (!(irq_resource[fep->emac_num][i].flags &
+		if (!(ocp_irq_table[fep->emac_num][i].flags &
 		      OCP_INTR_FLAG_SHARED) || (get_mal_dcrn(fep, DCRN_MALTXCASR)== 0x0)) {
-			free_irq(irq_resource[fep->emac_num][i].irq, dev);
+			free_irq(ocp_irq_table[fep->emac_num][i].irq, dev);
 		}
 	}
 	free_phy(dev);
@@ -558,7 +570,7 @@
 	ocp_set_drvdata(emac_driver, dev);
 	ep->txchan = 0x80000000  >> curr_emac*2 ;
 	ep->rxchan = 0x80000000 >> curr_emac;
-	dev->irq = irq_resource[curr_emac][BL_MAC_ETH].irq;
+	dev->irq = ocp_irq_table[curr_emac][BL_MAC_ETH].irq;
 	/* read the MAC Address */
 	bd = (bd_t *) __res;
 	for (i = 0; i < 6; i++)
@@ -794,7 +806,7 @@
 	}
 }

-void
+static void
 ppc405_eth_wakeup(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	/* On Linux the 405 ethernet will always be active if configured
@@ -803,7 +815,7 @@
 	printk(KERN_INFO "interrupt ppc405_eth_wakeup\n");
 }

-void
+static void
 ppc405_eth_serr(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct net_device *dev = dev_instance;
@@ -866,7 +878,7 @@
 	return;
 }

-void
+static void
 ppc405_eth_txeob(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	int i, count, isr;
@@ -1005,7 +1017,7 @@
 	return i;
 }

-void
+static void
 ppc405_eth_rxeob(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	int i, n, isr;
@@ -1017,7 +1029,7 @@
 	 * this function is using.
 	 */

-	disable_irq(irq_resource[0][BL_MAL_RXDE].irq);
+	disable_irq(ocp_irq_table[0][BL_MAL_RXDE].irq);

 	isr = get_mal_dcrn(fep, DCRN_MALRXEOBISR);
 	set_mal_dcrn(fep, DCRN_MALRXEOBISR, isr);
@@ -1031,7 +1043,7 @@
 		}
 	}

-	enable_irq(irq_resource[0][BL_MAL_RXDE].irq);
+	enable_irq(ocp_irq_table[0][BL_MAL_RXDE].irq);
 	return;
 }

@@ -1039,7 +1051,7 @@
  * This interrupt should never occurr, we don't program
  * the MAL for contiunous mode.
  */
-void
+static void
 ppc405_eth_txde(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct net_device *dev = dev_instance;
@@ -1065,7 +1077,7 @@
  * handled and reinitialize each along the way.  At that point the driver
  * will be restarted.
  */
-void
+static void
 ppc405_eth_rxde(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	int i, isr;
@@ -1094,7 +1106,7 @@
 	 * EMACs below.
 	 */

-	disable_irq(irq_resource[0][BL_MAL_RXEOB].irq);
+	disable_irq(ocp_irq_table[0][BL_MAL_RXEOB].irq);
 	for (i = 0; i < emac_max; i++) {
 		isr = get_mal_dcrn(fep, DCRN_MALRXEOBISR);
 		if (isr & 0x80000000 >> i) {
@@ -1120,13 +1132,13 @@
 	/* Clear the interrupt */
 	set_mal_dcrn(fep, DCRN_MALRXDEIR, get_mal_dcrn(fep, DCRN_MALRXDEIR));

-	enable_irq(irq_resource[0][BL_MAL_RXEOB].irq);
+	enable_irq(ocp_irq_table[0][BL_MAL_RXEOB].irq);

 	/* Reenable the receive channels */
 	set_mal_dcrn(fep, DCRN_MALRXCASR, get_mal_dcrn(fep, DCRN_MALRXCASR));
 }

-void
+static void
 ppc405_eth_mac(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	unsigned long tmp_em0isr;
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/drivers/net/ibm_ocp/ibm_ocp_enet.h linux-grinch/drivers/net/ibm_ocp/ibm_ocp_enet.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/drivers/net/ibm_ocp/ibm_ocp_enet.h	Tue Jun 11 10:12:43 2002
+++ linux-grinch/drivers/net/ibm_ocp/ibm_ocp_enet.h	Fri Jun 21 16:59:33 2002
@@ -125,7 +125,7 @@
 						((VAL & 0xffff) << 16))


-extern struct irq_resources irq_resource[][7];
+extern struct ocp_irq_desc ocp_irq_table[][7];
 //extern struct emac_regs *EMAC_ADDR[];
 /* MAL Buffer Descriptor structure */
 typedef struct {
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/ocp.h linux-grinch/include/asm-ppc/ocp.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/ocp.h	Wed Jun 19 10:32:59 2002
+++ linux-grinch/include/asm-ppc/ocp.h	Fri Jun 21 16:58:36 2002
@@ -98,10 +98,8 @@

 #define OCP_INTR_FLAG_SHARED 0x1

-struct irq_resources {
-	char irq_name[16];
+struct ocp_irq_desc {
 	u16 irq;
-	void *irq_handler;
 	int flags;
 };



--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
