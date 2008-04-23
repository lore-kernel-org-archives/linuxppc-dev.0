Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6C059DDEF7
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 17:59:46 +1000 (EST)
Date: Wed, 23 Apr 2008 17:59:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: new warnings from stacktrace patch
Message-Id: <20080423175938.a4b3cc26.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__23_Apr_2008_17_59_38_+1000_Sd.IQrUmhv6ya4aW"
Cc: Christoph Hellwig <hch@lst.de>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__23_Apr_2008_17_59_38_+1000_Sd.IQrUmhv6ya4aW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Linus' kernel today produces these warnings for an allyesconfig build:
(it was actually a linux-next build, but the commit is in Linus' tree)

In file included from arch/powerpc/kernel/stacktrace.c:16:
include/asm/asm-offsets.h:113:1: warning: "CLONE_VM" redefined
In file included from arch/powerpc/kernel/stacktrace.c:13:
include/linux/sched.h:8:1: warning: this is the location of the previous de=
finition
In file included from arch/powerpc/kernel/stacktrace.c:16:
include/asm/asm-offsets.h:114:1: warning: "CLONE_UNTRACED" redefined
In file included from arch/powerpc/kernel/stacktrace.c:13:
include/linux/sched.h:22:1: warning: this is the location of the previous d=
efinition
In file included from arch/powerpc/kernel/stacktrace.c:16:
include/asm/asm-offsets.h:151:1: warning: "NSEC_PER_SEC" redefined
In file included from include/linux/timex.h:57,
                 from include/linux/sched.h:54,
                 from arch/powerpc/kernel/stacktrace.c:13:
include/linux/time.h:37:1: warning: this is the location of the previous de=
finition

This is from commit fd3e0bbc6052ca9747a5332b382584ece83aab6d ("[POWERPC]
Stacktrace support for lockdep").  We don't include asm-offsets.h in any
other C file in the powerpc build.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Apr_2008_17_59_38_+1000_Sd.IQrUmhv6ya4aW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIDuxuTgG2atn1QN8RApQEAJ9py97hxwtluYaHMl64GxfIRbnJdQCeP63t
NxqTMA1r9W8pTxqS0c2R0nw=
=ZWEV
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Apr_2008_17_59_38_+1000_Sd.IQrUmhv6ya4aW--
