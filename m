Return-Path: <tony@bakeyournoodle.com>
Date: Wed, 20 Jun 2012 15:38:08 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: fix uninitialised error in numa.c
Message-ID: <20120620053808.GD11330@thor.bakeyournoodle.com>
References: <20741.1340165867@neuling.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
In-Reply-To: <20741.1340165867@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2012 at 02:17:47PM +1000, Michael Neuling wrote:
> chroma_defconfig currently gives me this with gcc 4.6:
>   arch/powerpc/mm/numa.c:638:13: error: 'dm' may be used uninitialized in=
 this function [-Werror=3Duninitialized]
>=20
> It's a bogus warning since of_get_drconf_memory() only writes it
> anyway. =20
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> cc: stable@kernel.org
> ---
> Also affects 3.4 and 3.3 stable.
>=20
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 5ca3a15..880acde 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -637,7 +637,7 @@ static inline int __init read_usm_ranges(const u32 **=
usm)
>   */
>  static void __init parse_drconf_memory(struct device_node *memory)
>  {
> -	const u32 *dm, *usm;
> +	const u32 *dm =3D NULL, *usm;

Woot bikeshed!  I think that's what the uninitialized_var() macro is for.

Yours Tony

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJP4WHAAAoJEEsCiJRY75GKhCAQAIq9FGUxU3DWnt0KnHPs07FC
uc/yPagP0SDBSi7bdJkHICi71WkTuvS1AMQhzd2izN+l2VrUsT3o1rjesqaHxlVU
jgV7ZUeZz2qhW2F8lOFKPmYjA/Vn11YwegQKjBSZIBGwfh23aorSFY8NUR4sjbDY
KSmOHlRW4GO3m6bAs3HARaLijlpWtXEIOWHvWYS8VDxyiO4psJl4hqRtM9dRzgdO
DJuCvlhBRhGduyBYIS/XQzmzAnUKqnM+U5W071GBwuafS7nE3ZzwaXjyZuumhJqd
vqX9/lOU0b5FnvWCOc1NxvDef0tpC/B8FOTVmyTrLaf5qNlkKsXp8Ewu1vynHzZo
w3N+XNQg+ZK6BCm9S6Yj+1T1HXgZPkJYZrQgsOV4fHWaTpEaXMt6IwCyz4vtdK9L
yCPuZ0eo3jXS9SI2g8yeIkClFVzIw4M1dK6gwNI7Z4ZmB6wdsFFM2Aee7PYn2Gsa
+VWZ5mt8DarQ/lslCVYBzBtKwCQfMclkFKIHKfyIKyrVbGbtlgqoe0Pyb79qTkNH
4x5gzm9ShuAx7VNQF6c3eB8qWs00IZKsfttJGRNputKkQe9++d3gGdexIH429hF1
FLSOHwAA7dF6SHQmkzb/FIKBXexSvOrxH0tG+9fSdcRbLNF+OlPEuRVd3JxKrXcT
DAzD6Q5g5vGPztWjEe5B
=9mvF
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
