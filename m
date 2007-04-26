Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A7532DDEEF
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 20:22:59 +1000 (EST)
Subject: Re: [PATCH v2] [2.6.22] pasemi: cpufreq driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070426053700.GA23922@lixom.net>
References: <20070425204633.GC19781@lixom.net>
	<20070426053700.GA23922@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xjJKaMAnWVCuD66V6FnN"
Date: Thu, 26 Apr 2007 12:26:00 +0200
Message-Id: <1177583160.6814.37.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, egor@pasemi.com, paulus@samba.org, arnd@arndb.de,
	cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xjJKaMAnWVCuD66V6FnN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-26 at 00:37 -0500, Olof Johansson wrote:
>=20
> +       policy->cur =3D pas_freqs[cur_astate].frequency;
> +       policy->cpus =3D cpu_possible_map;=20

That doesn't seem right.

Either, all your processors scale along each other in which case you
should use cpu_online_map here, or they scale each on their own in which
case you just set a single bit here.

The generic code works like this:
CPU 0 is brought online and cpufreq initialised for it
CPU 1 is brought online and cpufreq initialised for it. if cpus includes
more than a single bit, cpufreq is linked to the first other CPU in
policy->cpus and then cpufreq for CPU1 is deinitialised again.

We have the same bug on powermac but for some reason the patch to fix it
that I posted a long time ago (look for "powermac: fix G5-cpufreq for
cpu on/offline") wasn't applied yet. Look at it though, it includes a
comment on what needs to be done.

johannes

--=-xjJKaMAnWVCuD66V6FnN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMH44/ETPhpq3jKURAlU+AJ9d/LDRDKOppdnvVSqq12PC9NhAIACeL4cp
XMKnXESIr5HWBvG3mNmaV98=
=S0c+
-----END PGP SIGNATURE-----

--=-xjJKaMAnWVCuD66V6FnN--
