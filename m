Return-Path: <samuel@sortiz.org>
Received: from 25.mail-out.ovh.net (25.mail-out.ovh.net [213.186.37.103])
	by ozlabs.org (Postfix) with SMTP id 791C4DDEC1
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 23:46:23 +1000 (EST)
Date: 9 May 2007 13:46:11 -0000
To: vitb@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] 8xx: PQ SoC IRDA support
Message-ID: <irUYA8PN.1178718371.1966580.samuel@sortiz.org>
In-Reply-To: <20070509145353.483896a1@localhost.localdomain>
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

On 5/9/2007, "Vitaly Bordug" <vitb@kernel.crashing.org> wrote:
>> I'd really prefer this patch to be splitted in 2 parts: The PPC
>> specific bits, and the IrDA driver that would apply on top of it.
>> Meanwhile, I can comment on the IrDA driver code:
>>
>I used to do such before with network drivers but it may result in badly bre=
akage since stuff is heading through different routes. The most productive wa=
y seems to acquire ACK from both driver-wise and arch-wise areas,
>and have Andrew to merge it. IOW, separating stuff that cannot live one with=
out other is error-prone.
>
>Of course, there's np do do that for your convenience - I'm just against pus=
hing it through different trees.
>>
Fine, but please CC netdev and irda-users@lists.sourceforge.net for your
next patch iteration.


>> >+static irqreturn_t mpc8xx_irda_irq(int irq, void *dev_id)
>> >+{
>> >+=09struct net_device *dev =3D dev_id;
>> >+=09struct mpc8xx_irda *si =3D dev->priv;
>> >+=09scc_t *sccp =3D si->sccp;
>> >+=09cbd_t *bdp;
>> >+=09ushort int_events;
>> >+=09int must_restart =3D 0;
>> >+
>> >+=09/* Get the interrupt events that caused us to be here.
>> >+=09 */
>> >+=09int_events =3D in_be16(&sccp->scc_scce);
>> >+=09out_be16(&sccp->scc_scce, int_events);
>> >+
>> >+=09/* Handle receive event in its own function.
>> >+=09 */
>> >+=09if (int_events & SCC_AHDLC_RXF)
>> >+=09=09mpc8xx_irda_rx(dev);
>> >+
>> >+=09spin_lock(&si->lock);
>> >+
>> >+=09/* Transmit OK, or non-fatal error.  Update the buffer
>> >descriptors.
>> >+=09 */
>> >+=09if (int_events & (SCC_AHDLC_TXE | SCC_AHDLC_TXB)) {
>> >+=09=09bdp =3D si->dirty_tx;
>> >+
>> >+=09=09while ((bdp->cbd_sc & BD_AHDLC_TX_READY) =3D=3D 0) {
>> >+=09=09=09if (si->tx_free =3D=3D TX_RING_SIZE)
>> >+=09=09=09=09break;
>> >+
>> >+=09=09=09if (bdp->cbd_sc & BD_AHDLC_TX_CTS)
>> >+=09=09=09=09must_restart =3D 1;
>> >+
>> >+=09=09=09si->stats.tx_packets++;
>> >+
>> >+=09=09=09/* Free the sk buffer associated with this
>> >last transmit.
>> >+=09=09=09 */
>> >+
>> >dev_kfree_skb_irq(si->tx_skbuff[si->skb_dirty]);
>> >+=09=09=09si->skb_dirty =3D (si->skb_dirty + 1) &
>> >TX_RING_MOD_MASK; +
>> >+=09=09=09/* Update pointer to next buffer descriptor
>> >to be transmitted.
>> >+=09=09=09 */
>> >+=09=09=09if (bdp->cbd_sc & BD_AHDLC_TX_WRAP)
>> >+=09=09=09=09bdp =3D si->tx_bd_base;
>> >+=09=09=09else
>> >+=09=09=09=09bdp++;
>> >+
>> >+=09=09=09/* Since we have freed up a buffer, the
>> >ring is no longer full.
>> >+=09=09=09 */
>> >+=09=09=09if (!si->tx_free++) {
>> >+=09=09=09=09if (netif_queue_stopped(dev))
>> >+=09=09=09=09=09netif_wake_queue(dev);
>> >+=09=09=09}
>> >+
>> >+=09=09=09si->dirty_tx =3D (cbd_t *) bdp;
>> >+
>> >+=09=09=09if (si->newspeed) {
>> >+=09=09=09=09mpc8xx_irda_set_speed(dev,
>> >si->newspeed);
>> >+=09=09=09=09si->speed =3D si->newspeed;
>> >+=09=09=09=09si->newspeed =3D 0;
>> >+=09=09=09}
>> >+=09=09}
>> >+
>> >+=09=09if (must_restart) {
>> >+=09=09=09cpm8xx_t *cp =3D immr_map(im_cpm);
>> >+=09=09=09printk(KERN_INFO "restart TX\n");
>> >+
>> >+=09=09=09/* Some transmit errors cause the
>> >transmitter to shut
>> >+=09=09=09 * down.  We now issue a restart transmit.
>> >Since the
>> >+=09=09=09 * errors close the BD and update the
>> >pointers, the restart
>> >+=09=09=09 * _should_ pick up without having to reset
>> >any of our
>> >+=09=09=09 * pointers either.
>> >+=09=09=09 */
>> >+=09=09=09out_be16(&cp->cp_cpcr,
>> >+=09=09=09    mk_cr_cmd(CPM_CR_CH_SCC2,
>> >+=09=09=09=09      CPM_CR_RESTART_TX) |
>> >CPM_CR_FLG);
>> >+=09=09=09while (in_be16(&cp->cp_cpcr) & CPM_CR_FLG) ;
>> You're busy looping in an interrupt handler, that's not really nice.
>That's correct. In fact, I included protection stuff for SCC Ethernet in fs_=
enet driver to
>get rid of indefinite loop in case something really bad happens in CPM micro=
code.
>
>I'll move it here.
Good.


>> In general, I think this interrupt handler would deserve a bottom half
>> split since it looks quite busy.
>>
>I don't think it worths bh stuff - scc/FCC/etc ethernet (drivers/net/fs_enet=
/) use more busy int handler  and is for
>the similar (SCC) SoC device on the same target board (with higher throughou=
t  speed) without performance affected.
>
>It is doable but I guess we'll lose more than win. Also we have to keep in m=
ind, that 8xx PQ SoC is not speed-blasting and having IRQ path between schedu=
le() ticks would not be great either.
>
>So to recap, similar handling path for similar SoC device existing in curren=
t kernel for a while now, and working good.

I'm sure it works good, but doing the whole RX path from an interrupt
handler doesn't sound like the best thing to do, at least to me. And
with a SIR IrDA device, you can afford to offload your interrupt
processing to a BH, nobody will notice the difference in terms of
performance.
I'm not against your proposed implementation, but I just think there's
a nicer way to achieve the same result.

>Thanks for review, will follow-up with fixes shortly.
Thanks for the patch.

Cheers,
Samuel.
