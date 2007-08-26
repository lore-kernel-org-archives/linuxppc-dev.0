Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B0C84DDDDB
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Aug 2007 11:08:36 +1000 (EST)
Date: Sun, 26 Aug 2007 11:08:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH, RFC] linkstation: implement standby
Message-Id: <20070826110830.dfe6ea24.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
References: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__26_Aug_2007_11_08_30_+1000_cH7VJvUkjfhc5E_R"
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__26_Aug_2007_11_08_30_+1000_cH7VJvUkjfhc5E_R
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Aug 2007 02:03:49 +0200 (CEST) Guennadi Liakhovetski <g.liakhove=
tski@gmx.de> wrote:
>
> +static int ls_pm_enter(suspend_state_t state)
> +{
> +	char ier;
> +	int ret =3D 0;
> +	u64 tb;
> +
> +	if ((ret =3D mpc10x_suspend(state)) < 0)
> +		return ret;
> +
> +	/* Get timebase */
> +	tb =3D get_tb();
> +
> +	/* put CPU to sleep, re-enabling interrupts */
> +	mpc6xx_enter_sleep();
> +
> +	local_irq_disable();
> +
> +	set_tb(tb >> 32, tb & 0xfffffffful);
> +
> +fail:

Unused label?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__26_Aug_2007_11_08_30_+1000_cH7VJvUkjfhc5E_R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG0NKUTgG2atn1QN8RAoV8AJ4zFSSVpZh54FVgXYo9sPYnt7Hr3ACfRkJC
RjlQLdK9pglb/EMO0awtVIY=
=9GuF
-----END PGP SIGNATURE-----

--Signature=_Sun__26_Aug_2007_11_08_30_+1000_cH7VJvUkjfhc5E_R--
