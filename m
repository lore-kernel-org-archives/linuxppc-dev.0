Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 7 Jul 2008 16:24:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: arnd@arndb.de
Subject: Re: [patch 05/11] powerpc/cell: add spu aware cpufreq governor
Message-Id: <20080707162457.e5f3cb9d.sfr@canb.auug.org.au>
In-Reply-To: <20080704190806.162475834@arndb.de>
References: <20080704190535.316377278@arndb.de>
	<20080704190806.162475834@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__7_Jul_2008_16_24_57_+1000_S1FbRlMfbJnNtMfI"
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Christian Krafft <krafft@de.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__7_Jul_2008_16_24_57_+1000_S1FbRlMfbJnNtMfI
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just a couple of trivial things.

On Fri, 04 Jul 2008 21:05:40 +0200 arnd@arndb.de wrote:
>
> + * (C) Copyright IBM Corporation 2006-2008
      ^^^
You should use =C2=A9.

> +#define POLL_TIME	100000		/* in us */
                                              ^
How about =CE=BC ?

> +struct spu_gov_info_struct {
> +	unsigned long busy_spus;	/* fixed-point */
> +	struct cpufreq_policy *policy;
> +	struct delayed_work work;
> +	unsigned int poll_int;		/* us */

And again.

> +static int calc_freq(struct spu_gov_info_struct *info)
> +{
> +	int cpu;
> +	int busy_spus;
> +
> +	cpu =3D info->policy->cpu;
> +	busy_spus =3D atomic_read(&cbe_spu_info[cpu_to_node(cpu)].busy_spus);
> +
> +	CALC_LOAD(info->busy_spus, EXP, busy_spus * FIXED_1);
> +	pr_debug(KERN_ERR "cpu %d: busy_spus=3D%d, info->busy_spus=3D%d\n", cpu=
, busy_spus, info->busy_spus);

Split this line.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__7_Jul_2008_16_24_57_+1000_S1FbRlMfbJnNtMfI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhxtrkACgkQjjKRsyhoI8y4OQCfY3KtAlp89wnP9nmaeNaPq65b
2D8AoJXlvpnGvq8IC2zeRhku56f4tY05
=QDhX
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Jul_2008_16_24_57_+1000_S1FbRlMfbJnNtMfI--
