Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3BFE0DDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 13:25:17 +1100 (EST)
Date: Sun, 23 Dec 2007 13:24:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/3] [POWERPC] FSL UPM: routines to manage FSL UPMs
Message-Id: <20071223132457.a40e8100.sfr@canb.auug.org.au>
In-Reply-To: <20071221203925.GA4829@localhost.localdomain>
References: <20071221203552.GA4738@localhost.localdomain>
	<20071221203925.GA4829@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__23_Dec_2007_13_24_57_+1100_o05RuIGvXH/IF1V7"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__23_Dec_2007_13_24_57_+1100_o05RuIGvXH/IF1V7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Dec 2007 23:39:25 +0300 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +int fsl_upm_get_for(struct device_node *node, const char *name,
> +		    struct fsl_upm *upm)
> +{
> +	int ret;
> +	struct device_node *lbus;
> +	struct resource lbc_res;
> +	ptrdiff_t mxmr_offs;
> +
> +	lbus =3D of_get_parent(node);
> +	if (!lbus) {
> +		pr_err("FSL UPM: can't get parent local bus node\n");
> +		return -ENOENT;
> +	}
> +
> +	ret =3D of_address_to_resource(lbus, 0, &lbc_res);

of_node_put(lbus) as of_get_parent() gets a reference.

> +static inline void fsl_upm_start_pattern(struct fsl_upm *upm, u32 pat_of=
fset)
> +{
> +	spin_lock_irqsave(&upm_lock, upm_lock_flags);

I may be wrong, but don't we need the "flags" argument to
spin_lock_irqsave to be on the stack?  And the save and restore to be in
the same function?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__23_Dec_2007_13_24_57_+1100_o05RuIGvXH/IF1V7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFHbccMTgG2atn1QN8RApjHAJ9X0SS70dsMAOD4tVNwblkszH0AuQCYwZMc
HZTuGkwYEQRJ21SdvZpKDw==
=/Nb6
-----END PGP SIGNATURE-----

--Signature=_Sun__23_Dec_2007_13_24_57_+1100_o05RuIGvXH/IF1V7--
