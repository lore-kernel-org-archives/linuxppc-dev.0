Return-Path: <domen@coderock.org>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by ozlabs.org (Postfix) with ESMTP id 96F852BDB5
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Dec 2004 06:56:40 +1100 (EST)
Date: Wed, 29 Dec 2004 20:53:09 +0100
From: Domen Puncer <domen@coderock.org>
To: paulus@samba.org
Message-ID: <20041229195309.GB25967@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Subject: [patch] ppc: remove casts in motorola ethernet drivers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove (void *) pointer casts.


 arch/ppc/8260_io/enet.c     |   12 ++++++------
 arch/ppc/8260_io/fcc_enet.c |   28 ++++++++++++++--------------
 arch/ppc/8xx_io/enet.c      |   12 ++++++------
 arch/ppc/8xx_io/fec.c       |    6 +++---
 4 files changed, 29 insertions(+), 29 deletions(-)


Signed-off-by: Domen Puncer <domen@coderock.org>

diff -pruNX dontdiff c/arch/ppc/8260_io/enet.c a/arch/ppc/8260_io/enet.c
--- c/arch/ppc/8260_io/enet.c	2004-12-25 15:50:14.000000000 +0100
+++ a/arch/ppc/8260_io/enet.c	2004-12-29 20:46:26.000000000 +0100
@@ -167,7 +167,7 @@ scc_enet_open(struct net_device *dev)
 static int
 scc_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct scc_enet_private *cep = (struct scc_enet_private *)dev->priv;
+	struct scc_enet_private *cep = dev->priv;
 	volatile cbd_t	*bdp;
 
 
@@ -238,7 +238,7 @@ scc_enet_start_xmit(struct sk_buff *skb,
 static void
 scc_enet_timeout(struct net_device *dev)
 {
-	struct scc_enet_private *cep = (struct scc_enet_private *)dev->priv;
+	struct scc_enet_private *cep = dev->priv;
 
 	printk("%s: transmit timed out.\n", dev->name);
 	cep->stats.tx_errors++;
@@ -281,7 +281,7 @@ scc_enet_interrupt(int irq, void * dev_i
 	ushort	int_events;
 	int	must_restart;
 
-	cep = (struct scc_enet_private *)dev->priv;
+	cep = dev->priv;
 
 	/* Get the interrupt events that caused us to be here.
 	*/
@@ -419,7 +419,7 @@ scc_enet_rx(struct net_device *dev)
 	struct	sk_buff *skb;
 	ushort	pkt_len;
 
-	cep = (struct scc_enet_private *)dev->priv;
+	cep = dev->priv;
 
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
@@ -520,7 +520,7 @@ scc_enet_close(struct net_device *dev)
 
 static struct net_device_stats *scc_enet_get_stats(struct net_device *dev)
 {
-	struct scc_enet_private *cep = (struct scc_enet_private *)dev->priv;
+	struct scc_enet_private *cep = dev->priv;
 
 	return &cep->stats;
 }
@@ -542,7 +542,7 @@ static void set_multicast_list(struct ne
 	u_char	*mcptr, *tdptr;
 	volatile scc_enet_t *ep;
 	int	i, j;
-	cep = (struct scc_enet_private *)dev->priv;
+	cep = dev->priv;
 
 	/* Get pointer to SCC area in parameter RAM.
 	*/
diff -pruNX dontdiff c/arch/ppc/8260_io/fcc_enet.c a/arch/ppc/8260_io/fcc_enet.c
--- c/arch/ppc/8260_io/fcc_enet.c	2004-12-25 15:50:14.000000000 +0100
+++ a/arch/ppc/8260_io/fcc_enet.c	2004-12-29 20:46:26.000000000 +0100
@@ -369,7 +369,7 @@ static void	fcc_stop(struct net_device *
 static int
 fcc_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct fcc_enet_private *cep = (struct fcc_enet_private *)dev->priv;
+	struct fcc_enet_private *cep = dev->priv;
 	volatile cbd_t	*bdp;
 	int idx;
 
@@ -460,7 +460,7 @@ fcc_enet_start_xmit(struct sk_buff *skb,
 static void
 fcc_enet_timeout(struct net_device *dev)
 {
-	struct fcc_enet_private *cep = (struct fcc_enet_private *)dev->priv;
+	struct fcc_enet_private *cep = dev->priv;
 
 	printk("%s: transmit timed out.\n", dev->name);
 	cep->stats.tx_errors++;
@@ -502,7 +502,7 @@ fcc_enet_interrupt(int irq, void * dev_i
 	int	must_restart;
 	int idx;
 
-	cep = (struct fcc_enet_private *)dev->priv;
+	cep = dev->priv;
 
 	/* Get the interrupt events that caused us to be here.
 	*/
@@ -644,7 +644,7 @@ fcc_enet_rx(struct net_device *dev)
 	struct	sk_buff *skb;
 	ushort	pkt_len;
 
-	cep = (struct fcc_enet_private *)dev->priv;
+	cep = dev->priv;
 
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
@@ -734,7 +734,7 @@ fcc_enet_close(struct net_device *dev)
 
 static struct net_device_stats *fcc_enet_get_stats(struct net_device *dev)
 {
-	struct fcc_enet_private *cep = (struct fcc_enet_private *)dev->priv;
+	struct fcc_enet_private *cep = dev->priv;
 
 	return &cep->stats;
 }
@@ -1352,7 +1352,7 @@ set_multicast_list(struct net_device *de
 	volatile fcc_enet_t *ep;
 	int	i, j;
 
-	cep = (struct fcc_enet_private *)dev->priv;
+	cep = dev->priv;
 
 return;
 	/* Get pointer to FCC area in parameter RAM.
@@ -1417,13 +1417,13 @@ return;
  */
 int fcc_enet_set_mac_address(struct net_device *dev, void *p)
 {
-	struct sockaddr *addr= (struct sockaddr *) p;
+	struct sockaddr *addr= p;
 	struct fcc_enet_private *cep;
 	volatile fcc_enet_t *ep;
 	unsigned char *eap;
 	int i;
 
-	cep = (struct fcc_enet_private *)(dev->priv);
+	cep = dev->priv;
 	ep = cep->ep;
 
         if (netif_running(dev))
@@ -1610,7 +1610,7 @@ init_fcc_param(fcc_info_t *fip, struct n
 	volatile	cbd_t		*bdp;
 	volatile	cpm_cpm2_t	*cp;
 
-	cep = (struct fcc_enet_private *)(dev->priv);
+	cep = dev->priv;
 	ep = cep->ep;
 	cp = cpmp;
 
@@ -1624,10 +1624,10 @@ init_fcc_param(fcc_info_t *fip, struct n
 	/* Allocate space for the buffer descriptors from regular memory.
 	 * Initialize base addresses for the buffer descriptors.
 	 */
-	cep->rx_bd_base = (cbd_t *)kmalloc(sizeof(cbd_t) * RX_RING_SIZE,
+	cep->rx_bd_base = kmalloc(sizeof(cbd_t) * RX_RING_SIZE,
 			GFP_KERNEL | GFP_DMA);
 	ep->fen_genfcc.fcc_rbase = __pa(cep->rx_bd_base);
-	cep->tx_bd_base = (cbd_t *)kmalloc(sizeof(cbd_t) * TX_RING_SIZE,
+	cep->tx_bd_base = kmalloc(sizeof(cbd_t) * TX_RING_SIZE,
 			GFP_KERNEL | GFP_DMA);
 	ep->fen_genfcc.fcc_tbase = __pa(cep->tx_bd_base);
 
@@ -1809,7 +1809,7 @@ init_fcc_startup(fcc_info_t *fip, struct
 	volatile fcc_t	*fccp;
 	struct fcc_enet_private *cep;
 
-	cep = (struct fcc_enet_private *)(dev->priv);
+	cep = dev->priv;
 	fccp = cep->fccp;
 
 	fccp->fcc_fcce = 0xffff;	/* Clear any pending events */
@@ -1968,7 +1968,7 @@ fcc_stop(struct net_device *dev)
 	volatile fcc_t	*fccp;
 	struct fcc_enet_private	*fcp;
 
-	fcp = (struct fcc_enet_private *)(dev->priv);
+	fcp = dev->priv;
 	fccp = fcp->fccp;
 
 	/* Disable transmit/receive */
@@ -1982,7 +1982,7 @@ fcc_restart(struct net_device *dev, int 
 	volatile fcc_t	*fccp;
 	struct fcc_enet_private	*fcp;
 
-	fcp = (struct fcc_enet_private *)(dev->priv);
+	fcp = dev->priv;
 	fccp = fcp->fccp;
 
 	if (duplex)
diff -pruNX dontdiff c/arch/ppc/8xx_io/enet.c a/arch/ppc/8xx_io/enet.c
--- c/arch/ppc/8xx_io/enet.c	2004-12-25 15:50:14.000000000 +0100
+++ a/arch/ppc/8xx_io/enet.c	2004-12-29 20:46:26.000000000 +0100
@@ -197,7 +197,7 @@ scc_enet_open(struct net_device *dev)
 static int
 scc_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct scc_enet_private *cep = (struct scc_enet_private *)dev->priv;
+	struct scc_enet_private *cep = dev->priv;
 	volatile cbd_t	*bdp;
 
 	/* Fill in a Tx ring entry */
@@ -273,7 +273,7 @@ scc_enet_start_xmit(struct sk_buff *skb,
 static void
 scc_enet_timeout(struct net_device *dev)
 {
-	struct scc_enet_private *cep = (struct scc_enet_private *)dev->priv;
+	struct scc_enet_private *cep = dev->priv;
 
 	printk("%s: transmit timed out.\n", dev->name);
 	cep->stats.tx_errors++;
@@ -314,7 +314,7 @@ scc_enet_interrupt(void *dev_id, struct 
 	ushort	int_events;
 	int	must_restart;
 
-	cep = (struct scc_enet_private *)dev->priv;
+	cep = dev->priv;
 
 	/* Get the interrupt events that caused us to be here.
 	*/
@@ -449,7 +449,7 @@ scc_enet_rx(struct net_device *dev)
 	struct	sk_buff *skb;
 	ushort	pkt_len;
 
-	cep = (struct scc_enet_private *)dev->priv;
+	cep = dev->priv;
 
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
@@ -550,7 +550,7 @@ scc_enet_close(struct net_device *dev)
 
 static struct net_device_stats *scc_enet_get_stats(struct net_device *dev)
 {
-	struct scc_enet_private *cep = (struct scc_enet_private *)dev->priv;
+	struct scc_enet_private *cep = dev->priv;
 
 	return &cep->stats;
 }
@@ -572,7 +572,7 @@ static void set_multicast_list(struct ne
 	u_char	*mcptr, *tdptr;
 	volatile scc_enet_t *ep;
 	int	i, j;
-	cep = (struct scc_enet_private *)dev->priv;
+	cep = dev->priv;
 
 	/* Get pointer to SCC area in parameter RAM.
 	*/
diff -pruNX dontdiff c/arch/ppc/8xx_io/fec.c a/arch/ppc/8xx_io/fec.c
--- c/arch/ppc/8xx_io/fec.c	2004-12-25 15:50:14.000000000 +0100
+++ a/arch/ppc/8xx_io/fec.c	2004-12-29 20:46:26.000000000 +0100
@@ -781,7 +781,7 @@ fec_enet_mii(struct net_device *dev)
 	mii_list_t	*mip;
 	uint		mii_reg;
 
-	fep = (struct fec_enet_private *)dev->priv;
+	fep = dev->priv;
 	ep = &(((immap_t *)IMAP_ADDR)->im_cpm.cp_fec);
 	mii_reg = ep->fec_mii_data;
 
@@ -1485,7 +1485,7 @@ fec_enet_close(struct net_device *dev)
 
 static struct net_device_stats *fec_enet_get_stats(struct net_device *dev)
 {
-	struct fec_enet_private *fep = (struct fec_enet_private *)dev->priv;
+	struct fec_enet_private *fep = dev->priv;
 
 	return &fep->stats;
 }
@@ -1505,7 +1505,7 @@ static void set_multicast_list(struct ne
 	struct	fec_enet_private *fep;
 	volatile fec_t *ep;
 
-	fep = (struct fec_enet_private *)dev->priv;
+	fep = dev->priv;
 	ep = &(((immap_t *)IMAP_ADDR)->im_cpm.cp_fec);
 
 	if (dev->flags&IFF_PROMISC) {
