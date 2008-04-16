Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD721DE23E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 21:24:25 +1000 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1Jm5kO-0000SF-Qw
	for linuxppc-dev@ozlabs.org; Wed, 16 Apr 2008 13:24:20 +0200
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Wed, 16 Apr 2008 13:24:15 +0200
References: <47FDEF9B.5000506@semihalf.com> <47FF135E.2060003@246tnt.com>
	<200804151003.17865.jbe@pengutronix.de>
In-Reply-To: <200804151003.17865.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804161324.15887.jbe@pengutronix.de>
Subject: Re: State of the MPC5200 PSC AC97 driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 15 April 2008 10:03, Juergen Beisert wrote:
> Currently it fails to play anything with an external Wolfson WM9712
> connected to it. It seems the current AC97 reset sequence switches the
> WM9712 into testmode due to SDATA_OUT and Sync are not held low while the
> reset is active. Any idea to solve this? Switching both signals to GPIO a=
nd
> force them to low level while reset is active? How to cover PSC1 and PSC2
> with different GPIOs for this case?

Cannot reproduce the reset issue now, but in my case the bestcomm was
programmed to service the wrong PSC unit. That was the reason I never heard
any sound.

Can us give the oftree a better differentiation to program the bestcomm in a
correct manner?

Subject: [@num@/@total@] mpc52xx: Change the AC97 driver to be more generic
=46rom: Juergen Beisert <j.beisert@pengutronix.de>

The current AC97 driver for the mpc52xx CPU is fixed to work on PSC2. This
patch tries to make it more generic, as it detects the PSC unit for AC97 us=
age
to forward this information into the Bestcomm-API.

Signed-off-by: Juergen Beisert <j.beisert@pengutronix.de>
=2D--
 sound/ppc/mpc52xx_ac97.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

Index: sound/ppc/mpc52xx_ac97.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- sound/ppc/mpc52xx_ac97.c.orig
+++ sound/ppc/mpc52xx_ac97.c
@@ -651,6 +651,7 @@ mpc52xx_ac97_probe(struct of_device *op,
 	struct mpc52xx_ac97_priv *priv;
 	struct snd_card *card;
 	struct resource res;
+	int tx_initiator;
 	int rv;
=20
 	dev_dbg(&op->dev, "probing MPC52xx PSC AC97 driver\n");
@@ -699,10 +700,27 @@ mpc52xx_ac97_probe(struct of_device *op,
 	/* Setup Bestcomm tasks */
 	spin_lock_init(&priv->dma_lock);
=20
+	/*
+	 * PSC1 or PSC2 can be configured for AC97 usage. Select the right
+	 * channel, to let the BCOMM unit does its job correctly.
+	 */
+	switch (priv->mem_start & 0xFFFF) {
+	case 0x2000:	/* PSC1 */
+		tx_initiator =3D 14;
+		break;
+	case 0x2200:	/* PSC2 */
+		tx_initiator =3D 12;
+		break;
+	default:
+		dev_dbg(priv->dev, "Unknown PSC unit for AC97 usage!\n");
+		rv - ENODEV;
+		goto err_irq;
+	}
+
 	priv->tsk_tx =3D bcom_gen_bd_tx_init(AC97_TX_NUM_BD,
 				priv->mem_start + offsetof(struct mpc52xx_psc,
 							tfdata),
=2D				12,	/* initiator : FIXME */
+				tx_initiator,
 				2);	/* ipr : FIXME */
 	if (!priv->tsk_tx) {
 		printk(KERN_ERR DRV_NAME ": bcom_gen_bd_tx_init failed\n");
@@ -759,6 +777,7 @@ err_irqreq:
 	bcom_gen_bd_tx_release(priv->tsk_tx);
 err_bcomm:
 	mpc52xx_ac97_hwshutdown(priv);
+err_irq:
 	irq_dispose_mapping(priv->irq);
 err_irqmap:
 	iounmap(priv->psc);

Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
