Return-Path: <jan.damborsky@devcom.cz>
Received: from swip.net (mailfe05.swip.net [212.247.154.129])
	by ozlabs.org (Postfix) with ESMTP id 90B1067A7C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 21:48:22 +1100 (EST)
Message-ID: <421324EC.5000104@devcom.cz>
Date: Wed, 16 Feb 2005 11:48:12 +0100
From: Jan Damborsky <jan.damborsky@devcom.cz>
MIME-Version: 1.0
To: Markus Westergren <markus.westergren@biologigrand.ac>
References: <Pine.LNX.4.50.0502131246140.3196-100000@220a.licentiaten.umea.hsb.se>
	<42109B82.9070604@devcom.cz>
	<Pine.LNX.4.50.0502142045070.28518-100000@220a.licentiaten.umea.hsb.se>
In-Reply-To: <Pine.LNX.4.50.0502142045070.28518-100000@220a.licentiaten.umea.hsb.se>
Content-Type: multipart/mixed; boundary="------------030807050800070300070005"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Support for Adder875 in Linux 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030807050800070300070005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Markus Westergren wrote:

>I got my board working with both ethernet ports today. I'm interested in your
>patch so that I can see if we made the same ugly hack and if I have overlocked
>something :)
>
>/Markus
>  
>
The patch is here. I am sorry it has not been done against current denk 
source tree,
I used  the one from 19th January. But I hope it might satisfy for 
understanding the way
the hack is done.


--------------030807050800070300070005
Content-Type: text/plain;
 name="fec.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fec.diff"

diff -purN linuxppc_2_4_devel-org/arch/ppc/8xx_io/fec.c linuxppc_2_4_devel-new/arch/ppc/8xx_io/fec.c
--- linuxppc_2_4_devel-org/arch/ppc/8xx_io/fec.c	2004-08-02 17:34:43.000000000 +0200
+++ linuxppc_2_4_devel-new/arch/ppc/8xx_io/fec.c	2005-02-15 21:36:09.000000000 +0100
@@ -181,6 +181,7 @@ typedef struct {
  * the buffer descriptor determines the actual condition.
  */
 struct fec_enet_private {
+    int irq_num;
 	/* The saved address of a sent-in-place packet/buffer, for skfree(). */
 	struct	sk_buff* tx_skbuff[TX_RING_SIZE];
 	ushort	skb_cur;
@@ -232,6 +233,10 @@ struct fec_enet_private {
 #endif
 };
 
+/* Initialize the FEC Ethernet on 860T and 2nd FEC on Duet.
+ */
+static int __init fec_enet_low_init(int ch);
+
 static int fec_enet_open(struct net_device *dev);
 static int fec_enet_start_xmit(struct sk_buff *skb, struct net_device *dev);
 #ifdef	CONFIG_USE_MDIO
@@ -250,7 +255,6 @@ static struct net_device_stats *fec_enet
 static void set_multicast_list(struct net_device *dev);
 static void fec_restart(struct net_device *dev, int duplex);
 static void fec_stop(struct net_device *dev);
-static	ushort	my_enet_addr[3];
 
 #ifdef	CONFIG_USE_MDIO
 static int fec_enet_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
@@ -2018,7 +2022,7 @@ static void set_multicast_list(struct ne
 	volatile fec_t *ep;
 
 	fep = (struct fec_enet_private *)dev->priv;
-	ep = &(((immap_t *)IMAP_ADDR)->im_cpm.cp_fec);
+    ep = (volatile fec_t *)dev->base_addr;
 
 	if (dev->flags&IFF_PROMISC) {
 
@@ -2128,14 +2132,31 @@ static void set_multicast_list(struct ne
 	}
 }
 
-/* Initialize the FEC Ethernet on 860T.
- */
 int __init fec_enet_init(void)
 {
+#ifdef CONFIG_FEC2_ENET
+    int ret;
+
+    if ((ret = fec_enet_low_init(0)) < 0)
+        return(ret);
+
+    return(fec_enet_low_init(1));
+#else
+    return(fec_enet_low_init(0));
+#endif
+} /* end of fec_enet_init() */
+
+/* Initialize the FEC Ethernet on 860T and 2nd FEC on Duet.
+ */
+static int __init
+fec_enet_low_init(
+    int ch)
+{
 	struct net_device *dev;
 	struct fec_enet_private *fep;
 	int i, j, k;
-	unsigned char	*eap, *iap, *ba;
+
+	unsigned char	*iap, *ba;
 	dma_addr_t	mem_addr;
 	volatile	cbd_t	*bdp;
 	cbd_t		*cbd_base;
@@ -2162,7 +2183,10 @@ int __init fec_enet_init(void)
 	*/
 	dev = init_etherdev(0, 0);
 
+    if (ch == 0)
 	fecp = &(immap->im_cpm.cp_fec);
+    else
+	fecp = &(immap->im_cpm.cp_fec2);
 
 	/* Whack a reset.  We should wait for this.
 	*/
@@ -2179,7 +2203,7 @@ int __init fec_enet_init(void)
 	/* Set the Ethernet address.  If using multiple Enets on the 8xx,
 	 * this needs some work to get unique addresses.
 	 */
-	eap = (unsigned char *)my_enet_addr;
+
 	iap = bd->bi_enetaddr;
 
 #ifdef CONFIG_SCC_ENET
@@ -2201,12 +2225,15 @@ int __init fec_enet_init(void)
 	tmpaddr[3] |= 0x80;
 # endif
 	iap = tmpaddr;
-#endif
+#endif /* CONFIG_SCC_ENET */
 
 	for (i=0; i<6; i++) {
-		dev->dev_addr[i] = *eap++ = *iap++;
+		dev->dev_addr[i] = *iap++;
 	}
 
+    if (ch == 1)
+        dev->dev_addr[3] ^= 0x01;
+
 	/* Allocate memory for buffer descriptors.
 	*/
 	if (((RX_RING_SIZE + TX_RING_SIZE) * sizeof(cbd_t)) > PAGE_SIZE) {
@@ -2258,8 +2285,15 @@ int __init fec_enet_init(void)
 	fep->ph_priv = NULL;
 #endif
 	/* Install our interrupt handler. */
+    if (ch == 0) {
+        fep->irq_num = FEC_INTERRUPT;
 	if (request_irq(FEC_INTERRUPT, fec_enet_interrupt, 0, "fec", dev) != 0)
 		panic("Could not allocate FEC IRQ!");
+    } else {
+        fep->irq_num = FEC2_INTERRUPT;
+	if (request_irq(FEC2_INTERRUPT, fec_enet_interrupt, 0, "fec2", dev) != 0)
+		panic("Could not allocate FEC2 IRQ!");
+    }
 
 	dev->base_addr = (unsigned long)fecp;
 	dev->priv = fep;
@@ -2316,6 +2350,33 @@ int __init fec_enet_init(void)
 	mii_free = mii_cmds;
 #endif	/* CONFIG_USE_MDIO */
 
+/* MPC87x/88x have got 2 FECs and different pinout */
+#if defined(CONFIG_TS3_DUET)
+    if (ch == 0) {
+	immap->im_ioport.iop_papar |=  0xf830;
+	immap->im_ioport.iop_padir |=  0x0830;
+	immap->im_ioport.iop_padir &= ~0xf000;
+
+	immap->im_cpm.cp_pbpar     |=  0x00001001;
+	immap->im_cpm.cp_pbdir     &= ~0x00001001;
+
+	immap->im_ioport.iop_pcpar |=  0x000c;
+	immap->im_ioport.iop_pcdir &= ~0x000c;
+
+	immap->im_cpm.cp_pepar     |=  0x00000003;
+	immap->im_cpm.cp_pedir     |=  0x00000003;
+	immap->im_cpm.cp_peso      &= ~0x00000003;
+
+	immap->im_cpm.cp_cptr      &= ~0x00000100;
+    } else {
+        immap->im_cpm.cp_pepar     |= 0x0003fffc;
+        immap->im_cpm.cp_pedir     |= 0x0003fffc;
+        immap->im_cpm.cp_peso      &= ~0x000087fc;
+        immap->im_cpm.cp_peso      |= 0x00037800;
+
+        immap->im_cpm.cp_cptr      &= ~0x00000080;
+    } /*endif*/
+#else
 #ifndef CONFIG_ICU862
 	/* Configure all of port D for MII.
 	*/
@@ -2355,6 +2416,7 @@ int __init fec_enet_init(void)
 		immap->im_ioport.iop_pddir = 0x1c58;	/* Pre rev. D */
 	else
 		immap->im_ioport.iop_pddir = 0x1fff;	/* Rev. D and later */
+#endif /* CONFIG_TS3_DUET */
 
 #ifdef	CONFIG_USE_MDIO
 	/* Set MII speed to 2.5 MHz
@@ -2373,7 +2435,10 @@ int __init fec_enet_init(void)
 		", MII irq %d"
 #endif
 		", addr ",
-		dev->name, FEC_INTERRUPT
+
+		dev->name, 
+                fep->irq_num
+
 #ifdef PHY_INTERRUPT
 		, PHY_INTERRUPT
 #endif
@@ -2411,12 +2476,9 @@ fec_restart(struct net_device *dev, int 
 	struct fec_enet_private *fep;
 	int i;
 	volatile	cbd_t	*bdp;
-	volatile	immap_t	*immap;
 	volatile	fec_t	*fecp;
 
-	immap = (immap_t *)IMAP_ADDR;	/* pointer to internal registers */
-
-	fecp = &(immap->im_cpm.cp_fec);
+    fecp = (volatile fec_t *)dev->base_addr;
 
 	fep = dev->priv;
 
@@ -2439,8 +2501,9 @@ fec_restart(struct net_device *dev, int 
 
 	/* Set station address.
 	*/
-	fecp->fec_addr_low  = (my_enet_addr[0] << 16) | my_enet_addr[1];
-	fecp->fec_addr_high =  my_enet_addr[2];
+	fecp->fec_addr_low  = (dev->dev_addr[0] << 24) | (dev->dev_addr[1] << 16)
+     | (dev->dev_addr[2] << 8) | (dev->dev_addr[3] << 0);
+	fecp->fec_addr_high =  (dev->dev_addr[4] << 8) | dev->dev_addr[5];
 
 	/* Reset all multicast.
 	*/
@@ -2531,7 +2594,7 @@ fec_restart(struct net_device *dev, int 
 	*/
 	fecp->fec_ievent = 0xffc0;
 
-	fecp->fec_ivec = (FEC_INTERRUPT/2) << 29;
+    fecp->fec_ivec = (fep->irq_num/2) << 29;
 
 	/* Enable interrupts we wish to service.
 	*/
@@ -2552,21 +2615,17 @@ fec_restart(struct net_device *dev, int 
 static void
 fec_stop(struct net_device *dev)
 {
-	volatile	immap_t	*immap;
 	volatile	fec_t	*fecp;
 	struct fec_enet_private *fep;
 	int i;
 
-	immap = (immap_t *)IMAP_ADDR;	/* pointer to internal registers */
-
-	fecp = &(immap->im_cpm.cp_fec);
+    fecp = (volatile fec_t *)dev->base_addr;
 
 	if ((fecp->fec_ecntrl & FEC_ECNTRL_ETHER_EN) == 0)
 		return;	/* already down */
 
 	fep = dev->priv;
 
-
 	fecp->fec_x_cntrl = 0x01;	/* Graceful transmit stop */
 
 	for (i = 0;
@@ -2584,7 +2643,8 @@ fec_stop(struct net_device *dev)
 
 	/* Enable MII command finished interrupt
 	*/
-	fecp->fec_ivec = (FEC_INTERRUPT/2) << 29;
+    fecp->fec_ivec = (fep->irq_num/2) << 29;
+
 	fecp->fec_imask = FEC_ENET_MII;
 
 #ifdef	CONFIG_USE_MDIO
diff -purN linuxppc_2_4_devel-org/include/asm-ppc/8xx_immap.h linuxppc_2_4_devel-new/include/asm-ppc/8xx_immap.h
--- linuxppc_2_4_devel-org/include/asm-ppc/8xx_immap.h	2004-08-02 17:40:47.000000000 +0200
+++ linuxppc_2_4_devel-new/include/asm-ppc/8xx_immap.h	2005-02-15 21:09:22.000000000 +0100
@@ -9,6 +9,7 @@
  * a combination that I found difficult to separate into logical
  * functional files.....but anyone else is welcome to try.  -- Dan
  */
+
 #ifdef __KERNEL__
 #ifndef __IMMAP_8XX__
 #define __IMMAP_8XX__
@@ -426,8 +427,21 @@ typedef struct comm_proc {
 	uint	cp_pbpar;
 	char	res12[2];
 	ushort	cp_pbodr;
-	uint	cp_pbdat;
-	char	res13[0x18];
+        uint	cp_pbdat;
+
+	/* 
+	 * Port E - MPC87x/88x only.
+	 */
+	uint	cp_pedir;
+	uint	cp_pepar;
+	uint	cp_peso;
+	uint	cp_peodr;
+	uint	cp_pedat;
+
+	/* Communications Processor Timing Register -
+	   Contains RMII Timing for the FECs on MPC87x/88x only.
+	*/
+	uint	cp_cptr;
 
 	/* Serial Interface and Time Slot Assignment.
 	*/
@@ -454,7 +468,12 @@ typedef struct comm_proc {
 	union	fec_lcd fl_un;
 #define cp_fec	fl_un.fl_un_fec
 #define lcd_cmap fl_un.fl_un_cmap
-	char	res18[0x1000];
+
+	char	res18[0xE00];
+
+	/* The DUET family has a second FEC here */
+	fec_t	cp_fec2;
+#define cp_fec1	cp_fec	/* consistency macro */
 
 	/* Dual Ported RAM follows.
 	 * There are many different formats for this memory area

--------------030807050800070300070005--
