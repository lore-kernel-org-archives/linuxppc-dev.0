Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01892DDECF
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 18:57:12 +1000 (EST)
Subject: Re: [PATCH v2] via-pmu: remove LED sleep notifier
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17982.59298.848311.626151@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178084161.13233.16.camel@johannes.berg>
	<20070502205741.72dc191b.sfr@canb.auug.org.au>
	<1178116377.13233.63.camel@johannes.berg>
	<17982.59298.848311.626151@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Gj6mSRRkKnNMZWnjHWSf"
Date: Mon, 07 May 2007 10:58:33 +0200
Message-Id: <1178528314.7261.3.camel@johannes.berg>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Gj6mSRRkKnNMZWnjHWSf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-05-07 at 18:47 +1000, Paul Mackerras wrote:

> With this patch I get:
>=20
>   LD      .tmp_vmlinux1
> drivers/built-in.o:(.toc1+0x71d8): undefined reference to `pmu_sys_suspen=
ded'
>=20
> with a 64-bit config that has CONFIG_PPC_PMAC=3Dy and CONFIG_PM=3Dn.

Ouch, sorry about that. I suppose I should make it

#ifdef CONFIG_PM
extern int pmu_sys_suspended;
#else
#define pmu_sys_suspended 0
#endif

in the header file. Will look at it again and send an updated patch
later.

johannes

--=-Gj6mSRRkKnNMZWnjHWSf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGPuo5/ETPhpq3jKURAkypAKCBLExiaFv0o8BzDwEPiXNLfHEDHgCfS074
uWuP2BUJZUSsKgi6t1AgjF8=
=QznT
-----END PGP SIGNATURE-----

--=-Gj6mSRRkKnNMZWnjHWSf--
