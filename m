Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AAC2867A60
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jun 2006 21:17:39 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 4/8] snd-aoa: add i2sbus
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hr7274ox2.wl%tiwai@suse.de>
References: <20060601115844.343214000@sipsolutions.net>
	<20060601115847.420788000@sipsolutions.net>
	<s5hr7274ox2.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-KjFbz8B5FOc++tHUqs9w"
Date: Tue, 06 Jun 2006 13:17:27 +0200
Message-Id: <1149592647.5928.49.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-KjFbz8B5FOc++tHUqs9w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-02 at 16:23 +0200, Takashi Iwai wrote:
> > +	if (I2S_CLOCK_SPEED_18MHz % rate =3D=3D 0) {
> > +		if ((I2S_CLOCK_SPEED_18MHz / rate) % mclk =3D=3D 0) {
>=20
> Equivalent with "I2S_CLOCK_SPEED_18MHZ % (rate * mclk) =3D=3D 0" ?

Yeah, I guess, never really thought about that, just wrote it down the
way I thought to do it :) That said, I think it's more readable if
written that way, do you want me to change it regardless?

> > +	list_for_each_entry(cii, &sdev->codec_list, list) {
> > +		if (cii->codec->open) {
> > +			err =3D cii->codec->open(cii, pi->substream);
> > +			if (err) {
> > +				result =3D err;
> > +				goto out_unlock;
>=20
> What happens if the first code is opened but fail the secondary?
> No need to close the first?

Yes, that needs to be done, good catch.

> > +	/* well, we really should support scatter/gather DMA */
> > +	/* FIXME FIXME FIXME: If this fails, we BUG() when the alsa layer
> > +	 * later tries to allocate memory. Apparently we should be setting
> > +	 * some device pointer for that ...
> > +	 */
> > +	snd_pcm_lib_preallocate_pages_for_all(
> > +		dev->pcm, SNDRV_DMA_TYPE_DEV,
> > +		snd_dma_pci_data(macio_get_pci_dev(i2sdev->macio)),
> > +		64 * 1024, 64 * 1024);
>=20
> Is the comment true?  Yes, you have to set the device pointer via
> snd_pcm_lib_preallocate*().  But it must be OK even if preallocate
> fails.

Hah, I don't know actually, I didn't know you set the pointer using this
function, when I wrote the comment I just had forgotten the preallocate
call!
Does that mean that _preallocate_pages_for_all() has the side effect of
setting the pointer? If so, imho that's pretty bad.

> > +static irqreturn_t i2sbus_bus_intr(int irq, void *devid, struct pt_reg=
s *regs)
> > +{
> > +	struct i2sbus_dev *dev =3D devid;
> > +	u32 intreg;
> > +
> > +	spin_lock(&dev->low_lock);
> > +	intreg =3D in_le32(&dev->intfregs->intr_ctl);
> > +
> > +	printk(KERN_INFO "i2sbus: interrupt, intr reg is 0x%x!\n", intreg);
>=20
> Should this be really always printed?

no, gone.

johannes

--=-KjFbz8B5FOc++tHUqs9w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIVkRaVg1VMiehFYAQIOKw//enAomSW1wrwpBmtdgsg9CG57c8oPv/2Z
pfjWwSOGYE905+A2K0oRsJ5rWfTuKY9LYy2hIaT+RqT9rw/lwlzGfe4XUy18A1hH
PaLlfic4BaD5NAEYO4NS1L4RzJBvX5FkYOCopZAV8mP/MK9i+Ir9//kPsFfETXp1
ynH50ykjAwgbTwb5xgHvzId9gN9AfOGobQBRSaEoGDcm3bERwaRIZkShFyAUv8Z0
pNzJfGP+qVV9Y6yUB56X+kf6yWkc2sRphfKXCoTXzl68PXmolMioEzh1/psKUS1a
rFCUe6r7zXp0US7jLrODJfTqcTJpGnJDDdBinraHBFLP+ctyG5ZaRxRdwnTqUJjd
Azp4i0TXzjPn+a7Rsn+qA/+tCwBmjZESORdN3EMqbGb72Ibah+9zScl+ca4C7oA7
ZvG+/gRRHMZTSj7w0/roAc7hbiduqlpwRWBGlyVId2mcMqpcUw7eHrCMlGl6baYh
igs1r61as0KXGKM6gYNzLAfyM03O9wtO2bA4px+rpRRNPO+IYc595Dx4W1XXjLIC
+CyNSU8spfjZldSnp6v5Q9u4W1UcD33S60eFmtkEwQwQKr+qLkDCmnlqDHWbaZu8
MU2cyNlJI7yvYqB6brXI6e/OhAOLnHO4QC0W11CFlYHNpCEIif0JA+W7beDQ3Oyf
ZnBX+/+k7tY=
=hGoV
-----END PGP SIGNATURE-----

--=-KjFbz8B5FOc++tHUqs9w--
