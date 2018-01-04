Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zBqWX0sdkzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jan 2018 12:11:36 +1100 (AEDT)
Date: Thu, 4 Jan 2018 11:48:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, benh@au1.ibm.com
Subject: Re: [PATCH v3 1/1] powerpc/pseries: Make RAS IRQ explicitly
 dependent on DLPAR WQ
Message-ID: <20180104004811.GR24581@umbus.fritz.box>
References: <20180103211252.24615-1-joserz@linux.vnet.ibm.com>
 <20180103211252.24615-2-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZRLamLUCLuRJXeX8"
In-Reply-To: <20180103211252.24615-2-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ZRLamLUCLuRJXeX8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2018 at 07:12:52PM -0200, Jose Ricardo Ziviani wrote:
> The hotplug engine uses its own workqueue to handle IRQ requests, the
> problem is that such workqueue is initialized after init_ras_IRQ, which
> will cause a kernel panic if any hotplug interruption is issued in that
> period of time.
>=20
> This patch makes RAS IRQ registration explicitly dependent on DLPAR
> workqueue and adds a check to make sure that the workqueue is not
> initialized more than once.
>=20
> Reported-by: Min Deng <mdeng@redhat.com>
> Reported-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> Tested-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Michael, If this can be merged to a non-rebasing tree sooner rather
than later, that would be quite helpful to me.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZRLamLUCLuRJXeX8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpNecUACgkQbDjKyiDZ
s5K0PQ//QsYTKr/if40LYC+cDXRaPySs93r5G07JQsCLeZPQR0o8mtyp1vu6pbom
YplfnCpgfXT2jzIK9bHKdCxoKFthUvxFgoahJV8i5P1/4tm6FfC0zTXekRHnVYsM
ebgI6h+oi09BQi0KprLScz+xsGn0NXdTYwBU86XKgeerx/0NUlloVCHMFoovi6R8
g5h1gmggvzYx6EwfuTyF08ake1nX4tF09gXp2zM2HaeNFsqt0jEoNMYV7bwa0DmS
k0bFfI7xSaErFpuUkMz6lLJazBtZBzrMHKPo8FfOMCO+2XeNAbBCjCwTTzFX0K76
dSS2CLiVCxGq8pIDbVYq18iN79sZug8/hjNaYMqrtnnIJ0aq3VYK0pLQtC5w6Bzf
B9waXu4Dz4oVw3TcckEHDDxFDzNfkqehSRYfTzwLC/pdKwWrnR+F5SGjk/9carV7
EQDB2vEH0GhsGRFvlIfJSTHzoDorwvIUJxTV0FbgZN9Y/KdFQM22ARNt21t8FpWu
8pPMIZdixnMWa6VRzAoh8xFbDzst4XGA4yxVXLcJPo09A9wy3HTlA8PWWZ3Kel8p
JEf2ADJFt3eshCUOcMbNXdJYaLwDQqam3Ua2BTI9P6AGSEr6RgSK1wAvvt/wpb5x
e6wTuMkQRZ3pboVc2rEut30RsLz5A0iphrFrqk3t7AUgnCPakxY=
=b7bS
-----END PGP SIGNATURE-----

--ZRLamLUCLuRJXeX8--
