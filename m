Return-Path: <samuel@sortiz.org>
Received: from 25.mail-out.ovh.net (25.mail-out.ovh.net [213.186.37.103])
	by ozlabs.org (Postfix) with SMTP id C21E5DDE40
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 18:49:52 +1000 (EST)
Date: 9 May 2007 08:42:44 -0000
To: vitb@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] 8xx: PQ SoC IRDA support
Message-ID: <6Hmj76sd.1178700163.8964600.samuel@sortiz.org>
In-Reply-To: <20070508224206.4039.87074.stgit@localhost.localdomain>
From: "Samuel Ortiz" <samuel@sortiz.org>
Errors-To: "Samuel Ortiz" <samuel@sortiz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Vitaly,

On 5/8/2007, "Vitaly Bordug" <vitb@kernel.crashing.org> wrote:

>
>Adds support of IRDA transceiver residing on PowerQUICC processors and
>enabling such on mpc885ads reference board. The driver is implemented
>using of_device concept, hereby implies arch/powerpc support of the target.
>
>Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
I'd really prefer this patch to be splitted in 2 parts: The PPC specific
bits, and the IrDA driver that would apply on top of it.
Meanwhile, I can comment on the IrDA driver code:


>diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
>index 7c8ccc0..b3681e7 100644
>--- a/drivers/net/irda/Kconfig
>+++ b/drivers/net/irda/Kconfig
>@@ -17,6 +17,10 @@ config IRTTY_SIR
>
> =09  If unsure, say Y.
>
>+config 8XX_SIR
>+=09  tristate "mpc8xx SIR"
>+=09  depends on 8xx && IRDA
>+
Some "help" field here wouldn't hurt.



>+static void mpc8xx_irda_rx(struct net_device *dev)
>+{
>+=09struct mpc8xx_irda *si =3D dev->priv;
>+=09cbd_t *bdp;
>+=09struct sk_buff *skb;
>+=09int len;
>+=09ushort status;
>+
>+=09bdp =3D si->cur_rx;
>+
>+=09for (;;) {
>+=09=09if (bdp->cbd_sc & BD_AHDLC_RX_EMPTY)
>+=09=09=09break;
>+=09=09status =3D bdp->cbd_sc;
>+
>+=09=09if (status & BD_AHDLC_RX_STATS) {
>+=09=09=09/* process errors
>+=09=09=09 */
>+=09=09=09if (bdp->cbd_sc & BD_AHDLC_RX_AB)
>+=09=09=09=09si->stats.rx_length_errors++;
>+=09=09=09if (bdp->cbd_sc & BD_AHDLC_RX_CR)=09/* CRC Error */
>+=09=09=09=09si->stats.rx_crc_errors++;
>+=09=09=09if (bdp->cbd_sc & BD_AHDLC_RX_OV)=09/* FIFO overrun */
>+=09=09=09=09si->stats.rx_over_errors++;
>+=09=09} else {
>+=09=09=09/* Process the incoming frame.
>+=09=09=09 */
>+=09=09=09len =3D bdp->cbd_datlen;
>+
>+=09=09=09skb =3D dev_alloc_skb(len + 1);
>+=09=09=09if (skb =3D=3D NULL) {
>+=09=09=09=09printk(KERN_INFO
>+=09=09=09=09       "%s: Memory squeeze, dropping packet.\n",
>+=09=09=09=09       dev->name);
>+=09=09=09=09si->stats.rx_dropped++;
>+=09=09=09} else {
>+=09=09=09=09skb->dev =3D dev;
>+=09=09=09=09skb_reserve(skb, 1);
>+=09=09=09=09memcpy(skb_put(skb, len),
>+=09=09=09=09       si->rx_vaddr[bdp - si->rx_bd_base], len);
>+=09=09=09=09skb_trim(skb, skb->len - 2);
>+
>+=09=09=09=09si->stats.rx_packets++;
>+=09=09=09=09si->stats.rx_bytes +=3D len;
>+
>+=09=09=09=09skb->mac.raw =3D skb->data;
This should be
+=09=09=09=09skb_reset_mac_header(skb);


>+static irqreturn_t mpc8xx_irda_irq(int irq, void *dev_id)
>+{
>+=09struct net_device *dev =3D dev_id;
>+=09struct mpc8xx_irda *si =3D dev->priv;
>+=09scc_t *sccp =3D si->sccp;
>+=09cbd_t *bdp;
>+=09ushort int_events;
>+=09int must_restart =3D 0;
>+
>+=09/* Get the interrupt events that caused us to be here.
>+=09 */
>+=09int_events =3D in_be16(&sccp->scc_scce);
>+=09out_be16(&sccp->scc_scce, int_events);
>+
>+=09/* Handle receive event in its own function.
>+=09 */
>+=09if (int_events & SCC_AHDLC_RXF)
>+=09=09mpc8xx_irda_rx(dev);
>+
>+=09spin_lock(&si->lock);
>+
>+=09/* Transmit OK, or non-fatal error.  Update the buffer descriptors.
>+=09 */
>+=09if (int_events & (SCC_AHDLC_TXE | SCC_AHDLC_TXB)) {
>+=09=09bdp =3D si->dirty_tx;
>+
>+=09=09while ((bdp->cbd_sc & BD_AHDLC_TX_READY) =3D=3D 0) {
>+=09=09=09if (si->tx_free =3D=3D TX_RING_SIZE)
>+=09=09=09=09break;
>+
>+=09=09=09if (bdp->cbd_sc & BD_AHDLC_TX_CTS)
>+=09=09=09=09must_restart =3D 1;
>+
>+=09=09=09si->stats.tx_packets++;
>+
>+=09=09=09/* Free the sk buffer associated with this last transmit.
>+=09=09=09 */
>+=09=09=09dev_kfree_skb_irq(si->tx_skbuff[si->skb_dirty]);
>+=09=09=09si->skb_dirty =3D (si->skb_dirty + 1) & TX_RING_MOD_MASK;
>+
>+=09=09=09/* Update pointer to next buffer descriptor to be transmitted.
>+=09=09=09 */
>+=09=09=09if (bdp->cbd_sc & BD_AHDLC_TX_WRAP)
>+=09=09=09=09bdp =3D si->tx_bd_base;
>+=09=09=09else
>+=09=09=09=09bdp++;
>+
>+=09=09=09/* Since we have freed up a buffer, the ring is no longer full.
>+=09=09=09 */
>+=09=09=09if (!si->tx_free++) {
>+=09=09=09=09if (netif_queue_stopped(dev))
>+=09=09=09=09=09netif_wake_queue(dev);
>+=09=09=09}
>+
>+=09=09=09si->dirty_tx =3D (cbd_t *) bdp;
>+
>+=09=09=09if (si->newspeed) {
>+=09=09=09=09mpc8xx_irda_set_speed(dev, si->newspeed);
>+=09=09=09=09si->speed =3D si->newspeed;
>+=09=09=09=09si->newspeed =3D 0;
>+=09=09=09}
>+=09=09}
>+
>+=09=09if (must_restart) {
>+=09=09=09cpm8xx_t *cp =3D immr_map(im_cpm);
>+=09=09=09printk(KERN_INFO "restart TX\n");
>+
>+=09=09=09/* Some transmit errors cause the transmitter to shut
>+=09=09=09 * down.  We now issue a restart transmit.  Since the
>+=09=09=09 * errors close the BD and update the pointers, the restart
>+=09=09=09 * _should_ pick up without having to reset any of our
>+=09=09=09 * pointers either.
>+=09=09=09 */
>+=09=09=09out_be16(&cp->cp_cpcr,
>+=09=09=09    mk_cr_cmd(CPM_CR_CH_SCC2,
>+=09=09=09=09      CPM_CR_RESTART_TX) | CPM_CR_FLG);
>+=09=09=09while (in_be16(&cp->cp_cpcr) & CPM_CR_FLG) ;
You're busy looping in an interrupt handler, that's not really nice.
In general, I think this interrupt handler would deserve a bottom half
split since it looks quite busy.


>+static struct device_driver m8xxir_driver =3D {
>+=09.name =3D "fsl-cpm-scc:irda",
>+=09.bus =3D &platform_bus_type,
>+=09.probe =3D mpc8xx_irda_probe,
>+=09.remove =3D mpc8xx_irda_remove,
>+};
Why not a platform driver ?

Cheers,
Samuel.
