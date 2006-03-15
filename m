Return-Path: <johannes@sipsolutions.net>
Subject: Re: RFC: [PATCH Upated]: snd-pmac-gpio interfaces for snd-powermac
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <1137630485.4425.2.camel@grayson>
References: <1137630485.4425.2.camel@grayson>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-CEpJtCsjfCcJD36B4UXL"
Date: Wed, 15 Mar 2006 19:00:30 +0100
Message-Id: <1142445631.4670.9.camel@localhost>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-CEpJtCsjfCcJD36B4UXL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I have no idea if this is the latest version of this patch, but I
couldn't find any more recent one...

A few of comments inlined below.

> +static struct pmf_function *get_audio_pfunc(const char *name, const char=
 *altname)
> +{
> +	struct device_node *np;
> +	struct pmf_function *pfunc =3D NULL;
> +
> +	if (! (np =3D find_devices("i2s-a")))
> +		return NULL;

Can we have this function take an explicit device parameter instead? As
it is now, it can only handle the i2s-a soundcard, while the latest
powermacs have two sound cards (codecs?): i2s-a and i2s-c.

> +int snd_pmac_get_gpio(const char *name, const char *altname,
> +                            snd_pmac_gpio_t *gp)
> +{
> +        memset(gp, 0, sizeof(*gp));
> +
> +	gp->name =3D name;
> +	gp->altname =3D altname;
> +
> +        /* Platform functions are prefered */
> +        if ((gp->pfunc =3D get_audio_pfunc(name, altname)))
> +                return 0;
> +
> +	/* Else, fallback to direct gpio */
> +	return get_audio_gpio(name, altname, gp);

Maybe there ought to be a way to disable the fallback when we're on
newer chips? I don't grok the sound architecture well enough yet to
tell.

> +			/* XXX: pmf_unregister_irq_client doesn't use its
> +			 * first two arguments. We only need to send it
> +			 * the irq_client. WATCH FOR THIS CHANGING!
> +			 */
> +			pmf_unregister_irq_client(NULL, NULL, &gp->irq_client);

Heh, so I'm looking at an old version of this patch. The current
pmf_unregister_irq_client makes this explicit and only takes one
parameter :)

> +int snd_pmac_request_irq(snd_pmac_gpio_t *gp, void (*handler)(void *),
> +			 void *data)
> +{
> +	int ret =3D -ENODEV;
> +	struct device_node *np;
> +
> +	gp->irq_client.handler =3D handler;
> +	gp->irq_client.data =3D data;
> +	gp->irq_client.owner =3D NULL;
> +
> +	if (gp->pfunc) {
> +		gp->irq_client.owner =3D THIS_MODULE;
> +
> +		if ((np =3D find_devices("i2s-a"))) {

same comment here as the first one -- the powermac needs to be able to
access i2s-c through this too, I think.

johannes

--=-CEpJtCsjfCcJD36B4UXL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARBhWPaVg1VMiehFYAQJf0A/7BLVsU+1EHfT2bnUgGiitWSOAIhxpHvHA
vTHdTXoaElaRZN+sf8FrYfURnJkWD5k5/9wuK4VXLLpmxjZp1szE55n4XbBXdsbU
8/b4BCRl70ewKRSpgDR6/7+9S7yLRfHr0eHcqzZTlV3JZk1XSnj54H1I3ftIfuaU
1jaqkO8lcxZEY4uVox8fxsjA6lrgP4I0AEwtAzY6SDWRpHmXjd8vAkzV3db9WX7u
kR+oXusQcs149gcstIwc1B9PVDvWBa3wXQOQUeVvbd/1duvNR8MWsb6/zJ63s1Po
Olpv61cEMyPMdNxDXGNTEaG0ad5upgmmQkjo3fAw/kN/k4puHeHWHveetkJ/Obj5
eT4zN/yVnubXOR/Xxrm8i8aFJU+hXIoIb8iXLBy8BCpassEsiiLWcdLP8E9I586x
/+vzZh73K4kdqeWHiK2ITku7TaQHfO9A9sKf7AM6ZmRo8hNK2YvIfxmxxBPdXsDH
Lvox996YWQv2y71tY5SgFqZmcwqqFALsd6WAQEfidY3DA7K5LGMThnvmuXGqlEfb
UUM/y55y+oizbqBMrlsOoMboSQJsCRR1Wk/thcy5Y6a2RBzrBvOFBdtmlBbpaVOy
L1pQ5bjpKZDnaXW2ckhwJLudYuAJX5q3AJgD6oO7l3WzYJEvlODNplW4YMsbjQ4p
vvGU0itjPs0=
=hFcq
-----END PGP SIGNATURE-----

--=-CEpJtCsjfCcJD36B4UXL--
