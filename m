Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG3296ggDzDqxv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 11:00:17 +1000 (AEST)
Date: Mon, 24 Jul 2017 10:56:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] powerpc/pseries: Fix of_node_put() underflow during
 pseries remove
Message-ID: <20170724005627.GF3717@umbus.fritz.box>
References: <20170721145139.9384-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y1L3PTX8QE8cb2T+"
In-Reply-To: <20170721145139.9384-1-lvivier@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 04:51:39PM +0200, Laurent Vivier wrote:
> As for commit 68baf692c435 ("powerpc/pseries: Fix of_node_put()
> underflow during DLPAR remove"), the call to of_node_put()
> must be removed from pSeries_reconfig_remove_node().
>=20
> dlpar_detach_node() and pSeries_reconfig_remove_node() call
> of_detach_node(), and thus the node should not be released
> in this case too.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/pseries/reconfig.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/pla=
tforms/pseries/reconfig.c
> index e5bf1e8..011ef21 100644
> --- a/arch/powerpc/platforms/pseries/reconfig.c
> +++ b/arch/powerpc/platforms/pseries/reconfig.c
> @@ -82,7 +82,6 @@ static int pSeries_reconfig_remove_node(struct device_n=
ode *np)
> =20
>  	of_detach_node(np);
>  	of_node_put(parent);
> -	of_node_put(np); /* Must decrement the refcount */
>  	return 0;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Y1L3PTX8QE8cb2T+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll1RbsACgkQbDjKyiDZ
s5J3PBAAoXSTmPQPxIeoL0F8scxSFjPTkE2z8HO+SIOIQjobAOWzntBb0TgPQ0cr
pRyLKqxKJcUaulHlFXGeNpCwr6GNSfoC9v5P59Jtpg6LjMp9lYr8DL/u0d96H1eV
MPahCxwJMYwrMHro3G3etewIQySUD4xuR32h6scmHEKe2t1t25Pl2/GcAhHwG0vw
Pr1/xOdqRZiyuGuXLmDALTuoC9S5ESh0BV7mEE5el24vV7q/6l6NDQDkAXtj6bAF
Agz+PBI/oK0JUzxCqxYKolN9uZTPppVIQglnWdmB1I4rDszrbav/46BAkNNJc8YQ
5AjH9ry6jf16JagTjF+QUcLZj9bCIpI0Gaae1Js7aAnaTMDuh7AonI7gHLKhNQke
iQuEeslLl4s3cieCOGnkOP8PRrUtqbGtR25st90hXRvSnD95VoelP7ZGZsJE4Bil
+FFax4GRkRNjHOqV31vd5dMew7gJ7Pmn89Qg1dbCOgLgMHw57PzUxFx6Zw77gQIA
v6cvl5eTVGM7E3B7sQ/T11rOK3BLYE7kw1SGl7VjBPuZHC2QpnptGwNxTKVJQEfB
4mn3ytxw1W6BSJ9LNWhaGJ3S52asJIYr6Ne73fMLT5JaySowDDF6ZkiW0ueXcV/e
gAYk9XDWObW61DzgYpvU/budE+k1jTp+Zj26WUHAYVw9hU7urgY=
=428K
-----END PGP SIGNATURE-----

--Y1L3PTX8QE8cb2T+--
