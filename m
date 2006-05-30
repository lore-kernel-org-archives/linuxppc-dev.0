Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5137667AC6
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 22:43:33 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 4/7] snd-aoa: add codecs
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5h8xol9gom.wl%tiwai@suse.de>
References: <20060528190026.754474000@johannes.berg>
	<20060528190125.927852000@johannes.berg> <s5h8xol9gom.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-snKVV9vrQ2Fd8JPriS7s"
Date: Tue, 30 May 2006 14:43:16 +0200
Message-Id: <1148992996.3102.8.camel@johannes>
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


--=-snKVV9vrQ2Fd8JPriS7s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-29 at 14:08 +0200, Takashi Iwai wrote:
> > +	if (reg !=3D ONYX_REG_CONTROL) {
> > +		*value =3D onyx->cache[reg-FIRSTREGISTER];
> > +		return 0;
> > +	}
> > +	v =3D i2c_smbus_read_byte_data(&onyx->i2c, reg);
> > +	if (v < 0)
> > +		return -1;
> > +	*value =3D (u8)v;
> > +	onyx->cache[ONYX_REG_CONTROL-FIRSTREGISTER] =3D *value;
>=20
> Isn't it "reg - FIRSTREGISTER" ?

Nah, look at the first line I quoted :)


> I'd define a constant for 128.

#define OFFSET_BECAUSE_ALSA_USERSPACE_PROGRAMS_SUCK 128
;)

Just kidding, will do.

> Fold lines to fit with 80 columns (heh, blaming other one's code is
> easy :)

Heh. I thought I'd Lindent'ed most of it.

> > +	/* FIXME: we could be checking if anything changed */
> > +	mutex_unlock(&onyx->mutex);
> > +
> > +	return 1;
>=20
> The put callback is supposed to return 0 if the values are unchanged
> (although most apps ignore the return value).

Does it have to? This way there's an event, but...

> > +static u8 initial_values[] =3D {
>=20
> Should have ARRAY_SIZE(register_map) since this size must be identical
> with register_map.

Good point.

> > +#define ADDCTL(n)							\
> > +	do {								\
> > +		ctl =3D snd_ctl_new1(&n, onyx);				\
> > +		if (ctl) {						\
> > +			ctl->id.device =3D				\
> > +				onyx->codec.soundbus_dev->pcm->device;	\
> > +			aoa_snd_ctl_add(ctl);				\
>=20
> No error check?

Hmm, yeah, I guess it should have error checks. Will revisit that.

> Use strlcpy, or MAX_CODEC_NAME_LEN-1.  Similar lines are found in
> tas driver too.

Right.

> Looks a bit too hacky.  IMO, it's better to define a struct

Maybe I'll just get rid of it completely, it's never hooked up as far as
I know. But yeah, I guess you're right.

> > +static int tas_snd_capture_source_info(struct snd_kcontrol *kcontrol,
> > +	struct snd_ctl_elem_info *uinfo)
> > +{
> > +	static char* texts[] =3D { "Line-In", "Microphone" };
>=20
> char *texts[]

Any particular reason?

> > +/* I need help here!
>=20
> Use ifdef.  Nested comments are bad.

I know. Temporary code, probably going away completely.

> > +	aoa_snd_ctl_add(snd_ctl_new1(&volume_control, tas));
>=20
> Error checks please.

What should it do on such errors?

Thanks,
johannes

--=-snKVV9vrQ2Fd8JPriS7s
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHw94aVg1VMiehFYAQJAug/+OIa55SASnMv/ZpquSLUmRv0V1vrTb8X2
fFWNdpk35bU0WPFPqhfmogujVfQgzhRMGFiw4JjJ17IDvYP3JDlN5viCqRJF7R6Y
c8oSGAdWktUEPgfs/GcGKaBB6lpgExILE1Ww+3guhdEV1IzVbBvHhgG/LeqexQOk
TFzHgvkrlGBUoMTMb76dBSniaFCojcNMCwqtielz/QIvdYrY1M1wTWqTe/bGlKUr
ffhrsIXXj1TvTYsVhLWvmfYQMeslSuJGvv/5s4CVonHQPFNt3tn1ukp0You3rikf
AFzEM7dsCWo8xA79ZkIFIQlkZ9kUHCnYlSzmuzvRFP4Ji/hg4VLt91v5J/GC5vJf
iTU1sq7tInovN1JVLTIefhWAjXWro2medAGwQ5KyCOWbKG2CECzQovhvBJRZ0UV5
lfxTwOex4bU3GplErJmkcaWakFAvCcswWvBo10mLjDfC/ykdNcpfba9T7gkbRxYw
ER4DZnvexCPIarQPjaihkI3PaqcniGTeDEOVWQ9PebzhlHlHpKmGQWtoBv94J6wk
bksIJN6rxx6NIjNVnjkshEp2Vt0nGUOpcKbejZyfzVFoiiHNIAxDPITXpwKlZWPN
PZS0t9Wv+tq5JxO6VE5fTx9dpLuxCDxF9jLTo28i+/NjQnFa9zNPqXYOmuD5neKJ
CtCRq90Xt54=
=r+8W
-----END PGP SIGNATURE-----

--=-snKVV9vrQ2Fd8JPriS7s--
