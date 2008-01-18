Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4D660DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 17:06:19 +1100 (EST)
Date: Fri, 18 Jan 2008 17:06:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH v5] [POWERPC] Add LED driver for Promess Motion-PRO board.
Message-Id: <20080118170613.5f5d49a5.sfr@canb.auug.org.au>
In-Reply-To: <20080117180805.18035.60818.stgit@hekate.izotz.org>
References: <20080117180805.18035.60818.stgit@hekate.izotz.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__18_Jan_2008_17_06_13_+1100_taUJ/CAyek3+3N.e"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__18_Jan_2008_17_06_13_+1100_taUJ/CAyek3+3N.e
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marian,

On Thu, 17 Jan 2008 19:09:17 +0100 Marian Balakowicz <m8@semihalf.com> wrot=
e:
>
> +static int __devinit mpled_probe(struct of_device *op,
> +				 const struct of_device_id *match)
> +{
> +	struct motionpro_led *mpled;
> +	const unsigned int *of_blink_delay;
> +	const char *label;
> +	int err;
> +
> +	dev_dbg(&op->dev, "mpled_probe: node=3D%s (op=3D%p, match=3D%p)\n",
> +		op->node->name, op, match);
> +
> +	mpled =3D kzalloc(sizeof(*mpled), GFP_KERNEL);
> +	if (!mpled)
> +		return -ENOMEM;
> +
> +	mpled->gpt =3D of_iomap(op->node, 0);
> +	if (!mpled->gpt) {
> +		printk(KERN_ERR __FILE__ ": "
> +			"Error mapping GPT registers for LED %s\n",
> +			op->node->full_name);
> +		err =3D -EIO;
> +		goto err_free;
> +	}
> +
> +	/* initialize GPT for LED use */
> +	mpled_init_led(&mpled->gpt->mode);
> +
> +	spin_lock_init(&mpled->led_lock);
> +	mpled->mode =3D LED_MODE_KERNEL;
> +
> +	/* get LED label, used to register led classdev */
> +	label =3D of_get_property(op->node, "label", NULL);
> +	if (label =3D=3D NULL) {
> +		printk(KERN_ERR __FILE__ ": "
> +			"No label property provided for LED %s\n",
> +			op->node->full_name);
> +		err =3D -EINVAL;
> +		goto err_free;

		goto err;

> +static struct of_device_id mpled_match[] =3D {

Make this const, please.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__18_Jan_2008_17_06_13_+1100_taUJ/CAyek3+3N.e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHkEHZTgG2atn1QN8RAhicAJ9Rx2XEsLrdMVVqVa98w8VRQXXaOgCdFjxB
o5hVlzH2Pv+pkp5mk5PwbpA=
=9/B4
-----END PGP SIGNATURE-----

--Signature=_Fri__18_Jan_2008_17_06_13_+1100_taUJ/CAyek3+3N.e--
