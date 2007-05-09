Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6768EDDE1C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 20:54:08 +1000 (EST)
Date: Wed, 9 May 2007 14:53:53 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: "Samuel Ortiz" <samuel@sortiz.org>
Subject: Re: [PATCH] [POWERPC] 8xx: PQ SoC IRDA support
Message-ID: <20070509145353.483896a1@localhost.localdomain>
In-Reply-To: <6Hmj76sd.1178700163.8964600.samuel@sortiz.org>
References: <20070508224206.4039.87074.stgit@localhost.localdomain>
	<6Hmj76sd.1178700163.8964600.samuel@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9 May 2007 08:42:44 -0000
Samuel Ortiz wrote:

> 
> Hi Vitaly,
> 
> On 5/8/2007, "Vitaly Bordug" <vitb@kernel.crashing.org> wrote:
> 
> >
> >Adds support of IRDA transceiver residing on PowerQUICC processors
> >and enabling such on mpc885ads reference board. The driver is
> >implemented using of_device concept, hereby implies arch/powerpc
> >support of the target.
> >
> >Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> I'd really prefer this patch to be splitted in 2 parts: The PPC
> specific bits, and the IrDA driver that would apply on top of it.
> Meanwhile, I can comment on the IrDA driver code:
> 
I used to do such before with network drivers but it may result in badly breakage since stuff is heading through different routes. The most productive way seems to acquire ACK from both driver-wise and arch-wise areas,
and have Andrew to merge it. IOW, separating stuff that cannot live one without other is error-prone.

Of course, there's np do do that for your convenience - I'm just against pushing it through different trees.
> 
> >diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
> >index 7c8ccc0..b3681e7 100644
> >--- a/drivers/net/irda/Kconfig
> >+++ b/drivers/net/irda/Kconfig
> >@@ -17,6 +17,10 @@ config IRTTY_SIR
> >
> > 	  If unsure, say Y.
> >
> >+config 8XX_SIR
> >+	  tristate "mpc8xx SIR"
> >+	  depends on 8xx && IRDA
> >+
> Some "help" field here wouldn't hurt.
> 
OK
> 
> 
> >+static void mpc8xx_irda_rx(struct net_device *dev)
> >+{
> >+	struct mpc8xx_irda *si = dev->priv;
> >+	cbd_t *bdp;
> >+	struct sk_buff *skb;
> >+	int len;
> >+	ushort status;
> >+
> >+	bdp = si->cur_rx;
> >+
> >+	for (;;) {
> >+		if (bdp->cbd_sc & BD_AHDLC_RX_EMPTY)
> >+			break;
> >+		status = bdp->cbd_sc;
> >+
> >+		if (status & BD_AHDLC_RX_STATS) {
> >+			/* process errors
> >+			 */
> >+			if (bdp->cbd_sc & BD_AHDLC_RX_AB)
> >+				si->stats.rx_length_errors++;
> >+			if (bdp->cbd_sc & BD_AHDLC_RX_CR)	/*
> >CRC Error */
> >+				si->stats.rx_crc_errors++;
> >+			if (bdp->cbd_sc & BD_AHDLC_RX_OV)	/*
> >FIFO overrun */
> >+				si->stats.rx_over_errors++;
> >+		} else {
> >+			/* Process the incoming frame.
> >+			 */
> >+			len = bdp->cbd_datlen;
> >+
> >+			skb = dev_alloc_skb(len + 1);
> >+			if (skb == NULL) {
> >+				printk(KERN_INFO
> >+				       "%s: Memory squeeze,
> >dropping packet.\n",
> >+				       dev->name);
> >+				si->stats.rx_dropped++;
> >+			} else {
> >+				skb->dev = dev;
> >+				skb_reserve(skb, 1);
> >+				memcpy(skb_put(skb, len),
> >+				       si->rx_vaddr[bdp -
> >si->rx_bd_base], len);
> >+				skb_trim(skb, skb->len - 2);
> >+
> >+				si->stats.rx_packets++;
> >+				si->stats.rx_bytes += len;
> >+
> >+				skb->mac.raw = skb->data;
> This should be
> +				skb_reset_mac_header(skb);
> 
OK
> 
> >+static irqreturn_t mpc8xx_irda_irq(int irq, void *dev_id)
> >+{
> >+	struct net_device *dev = dev_id;
> >+	struct mpc8xx_irda *si = dev->priv;
> >+	scc_t *sccp = si->sccp;
> >+	cbd_t *bdp;
> >+	ushort int_events;
> >+	int must_restart = 0;
> >+
> >+	/* Get the interrupt events that caused us to be here.
> >+	 */
> >+	int_events = in_be16(&sccp->scc_scce);
> >+	out_be16(&sccp->scc_scce, int_events);
> >+
> >+	/* Handle receive event in its own function.
> >+	 */
> >+	if (int_events & SCC_AHDLC_RXF)
> >+		mpc8xx_irda_rx(dev);
> >+
> >+	spin_lock(&si->lock);
> >+
> >+	/* Transmit OK, or non-fatal error.  Update the buffer
> >descriptors.
> >+	 */
> >+	if (int_events & (SCC_AHDLC_TXE | SCC_AHDLC_TXB)) {
> >+		bdp = si->dirty_tx;
> >+
> >+		while ((bdp->cbd_sc & BD_AHDLC_TX_READY) == 0) {
> >+			if (si->tx_free == TX_RING_SIZE)
> >+				break;
> >+
> >+			if (bdp->cbd_sc & BD_AHDLC_TX_CTS)
> >+				must_restart = 1;
> >+
> >+			si->stats.tx_packets++;
> >+
> >+			/* Free the sk buffer associated with this
> >last transmit.
> >+			 */
> >+
> >dev_kfree_skb_irq(si->tx_skbuff[si->skb_dirty]);
> >+			si->skb_dirty = (si->skb_dirty + 1) &
> >TX_RING_MOD_MASK; +
> >+			/* Update pointer to next buffer descriptor
> >to be transmitted.
> >+			 */
> >+			if (bdp->cbd_sc & BD_AHDLC_TX_WRAP)
> >+				bdp = si->tx_bd_base;
> >+			else
> >+				bdp++;
> >+
> >+			/* Since we have freed up a buffer, the
> >ring is no longer full.
> >+			 */
> >+			if (!si->tx_free++) {
> >+				if (netif_queue_stopped(dev))
> >+					netif_wake_queue(dev);
> >+			}
> >+
> >+			si->dirty_tx = (cbd_t *) bdp;
> >+
> >+			if (si->newspeed) {
> >+				mpc8xx_irda_set_speed(dev,
> >si->newspeed);
> >+				si->speed = si->newspeed;
> >+				si->newspeed = 0;
> >+			}
> >+		}
> >+
> >+		if (must_restart) {
> >+			cpm8xx_t *cp = immr_map(im_cpm);
> >+			printk(KERN_INFO "restart TX\n");
> >+
> >+			/* Some transmit errors cause the
> >transmitter to shut
> >+			 * down.  We now issue a restart transmit.
> >Since the
> >+			 * errors close the BD and update the
> >pointers, the restart
> >+			 * _should_ pick up without having to reset
> >any of our
> >+			 * pointers either.
> >+			 */
> >+			out_be16(&cp->cp_cpcr,
> >+			    mk_cr_cmd(CPM_CR_CH_SCC2,
> >+				      CPM_CR_RESTART_TX) |
> >CPM_CR_FLG);
> >+			while (in_be16(&cp->cp_cpcr) & CPM_CR_FLG) ;
> You're busy looping in an interrupt handler, that's not really nice.
That's correct. In fact, I included protection stuff for SCC Ethernet in fs_enet driver to
get rid of indefinite loop in case something really bad happens in CPM microcode.

I'll move it here.

> In general, I think this interrupt handler would deserve a bottom half
> split since it looks quite busy.
> 
I don't think it worths bh stuff - scc/FCC/etc ethernet (drivers/net/fs_enet/) use more busy int handler  and is for 
the similar (SCC) SoC device on the same target board (with higher throughout  speed) without performance affected.

It is doable but I guess we'll lose more than win. Also we have to keep in mind, that 8xx PQ SoC is not speed-blasting and having IRQ path between schedule() ticks would not be great either. 

So to recap, similar handling path for similar SoC device existing in current kernel for a while now, and working good.
You are right that we have to provide some protection in case of CPM lockup though.
> 
> >+static struct device_driver m8xxir_driver = {
> >+	.name = "fsl-cpm-scc:irda",
> >+	.bus = &platform_bus_type,
> >+	.probe = mpc8xx_irda_probe,
> >+	.remove = mpc8xx_irda_remove,
> >+};
> Why not a platform driver ?
> 
Now I have full of_platform_driver implementation so I better drop platform_devices here.

Thanks for review, will follow-up with fixes shortly.

-- 
Sincerely, Vitaly
