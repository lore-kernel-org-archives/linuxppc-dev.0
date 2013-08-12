Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id D610D2C00E5
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Aug 2013 15:02:09 +1000 (EST)
Date: Mon, 12 Aug 2013 15:02:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/2] powerpc: Use ibm,chip-id property to compute
 cpu_core_mask if available
Message-Id: <20130812150200.cbb7fa39afbc5f2a9344585d@canb.auug.org.au>
In-Reply-To: <20130810034615.GE5240@iris.ozlabs.ibm.com>
References: <20130810034530.GD5240@iris.ozlabs.ibm.com>
 <20130810034615.GE5240@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__12_Aug_2013_15_02_00_+1000_a5ajGO4Bmi5e6znr"
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__12_Aug_2013_15_02_00_+1000_a5ajGO4Bmi5e6znr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sat, 10 Aug 2013 13:46:15 +1000 Paul Mackerras <paulus@samba.org> wrote:
>
> +static void traverse_siblings_chip_id(int cpu, int add, int chipid)

Again, the "add is a boolean.

> +{
> +	const struct cpumask *mask;
> +	struct device_node *np;
> +	int i, plen;
> +	const int *prop;
> +
> +	mask =3D add ? cpu_online_mask : cpu_present_mask;
> +	for_each_cpu(i, mask) {
> +		np =3D of_get_cpu_node(i, NULL);
> +		if (!np)
> +			continue;
> +		prop =3D of_get_property(np, "ibm,chip-id", &plen);
> +		if (prop && plen =3D=3D sizeof(int) && *prop =3D=3D chipid) {
                                                   ^^^^^
You should be using of_read_number(), I think.

>  static void traverse_core_siblings(int cpu, int add)
>  {
> -	struct device_node *l2_cache;
> +	struct device_node *l2_cache, *np;
>  	const struct cpumask *mask;
> -	int i;
> +	int i, chip, plen;
> +	const int *prop;
> +
> +	/* First see if we have ibm,chip-id properties in cpu nodes */
> +	np =3D of_get_cpu_node(cpu, NULL);
> +	if (np) {
> +		chip =3D -1;
> +		prop =3D of_get_property(np, "ibm,chip-id", &plen);
> +		if (prop && plen =3D=3D sizeof(int))
> +			chip =3D *(int *)prop;

Here as well.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__12_Aug_2013_15_02_00_+1000_a5ajGO4Bmi5e6znr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSCGxOAAoJEECxmPOUX5FEVZUP/0qc90Sv1r5ALBLc0F7csaps
dru0O8iMgMRfed+ss+dpLigYje13ftW6L3WcRPWZtnlJr/1GUpQ7iKN7KPez2bDK
/cMGj4DoomPV9Ct+NqvZKqwficIWPES9HkSdpTMRBJGI3FcfWFFUGhQDilxPe3bN
69fxbFQt+aMQ4pzZFne7Ht03wgOxvCTaaC5q1hfO92O/ifT/P9K57nLaS2CH5M2Y
M3Ki+tgdNd3lZDUrp4pMVtGqXmZMmjfYc1Jgd67K+Zz5szbBxumVGlD8hBtckpZ8
OOY6vJEh1aLFEv/Xx5YHclrACHsR1ZZTor45gbde0umsv9APa5pm8C057dxqq5h1
jXgzD9ehIpF4Ai9pMD8I52LBgk6vsLuq4efea1PBoYK/7yYlS3mCBmLK6bf1fyP4
/8+b5aGYadWuXk+XzEt8I8JrhPu6gri/X8ZvrmuTKbesnujJdMU1n77bQvuEQoyX
Np0wfS+dw5AqBlUn+xqvU8sonH5YK54LJEsqSfDSxzzAyPaRPy+vV18TZEK40qJc
8sJH015oglyftBXhQT97SYSgzd4t6JWaAmGsH1ty06cvts5s/3eO89ra65WvbDVz
9C+N0esim4kg36+kF60y7sPYTqS4j9u6dLBP+m7Zf/sqSrK2qF32BOHpPzdLPv9S
A6rGk3XiW3a9Q0BYEunH
=XMSn
-----END PGP SIGNATURE-----

--Signature=_Mon__12_Aug_2013_15_02_00_+1000_a5ajGO4Bmi5e6znr--
