Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C0212B7B65
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Aug 2009 10:23:05 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B08EEDDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Aug 2009 10:23:05 +1000 (EST)
Date: Mon, 24 Aug 2009 10:22:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Subject: linux-next: powerpc tree build warning
Message-Id: <20090824102256.3e8d69b6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__24_Aug_2009_10_22_56_+1000_TsIzUDLM0EdywED="
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__24_Aug_2009_10_22_56_+1000_TsIzUDLM0EdywED=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next build (powerpc ppc64_defconfig) produced this warning:

kernel/time/tick-sched.c: In function 'tick_nohz_stop_sched_tick':
kernel/time/tick-sched.c:261: warning: format '%02x' expects type 'unsigned=
 int', but argument 2 has type 'long unsigned int'

Introduced by commit 6826a57d1abc8ac9f59b24f1a008554c6560a995 ("powerpc:
Switch to asm-generic/hardirq.h") which changed
irq_cpustat_t::__softirq_pending from "unsigned int" to "unsigned long"
on powerpc.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__24_Aug_2009_10_22_56_+1000_TsIzUDLM0EdywED=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqR3WAACgkQjjKRsyhoI8yuxACdENh3S1MUrabBRkUusT73XveS
BxcAn3kXMNnBe0PxH3H8DiujgkMYbWKA
=SnUD
-----END PGP SIGNATURE-----

--Signature=_Mon__24_Aug_2009_10_22_56_+1000_TsIzUDLM0EdywED=--
