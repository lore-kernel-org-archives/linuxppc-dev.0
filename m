Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0FA15B6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Jan 2010 14:32:45 +1100 (EST)
Date: Tue, 5 Jan 2010 14:32:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hollis Blanchard <hollisb@us.ibm.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: powerpc: allmod config build failure
Message-Id: <20100105143238.ed113985.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__5_Jan_2010_14_32_38_+1100_KFDNdDrEE2r5BMoa"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__5_Jan_2010_14_32_38_+1100_KFDNdDrEE2r5BMoa
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

The powerpc allmodconfig build of Linus' tree has been failing like this
since Dec 13 (and linux-next since Nov 7):

arch/powerpc/kvm/built-in.o:(.toc1+0x18): undefined reference to `kvm_debug=
fs_dir'

$ grep KVM .config
CONFIG_KVM=3Dy
CONFIG_KVM_BOOK3S_64_HANDLER=3Dy
CONFIG_KVM_BOOK3S_64=3Dm
CONFIG_KVM_EXIT_TIMING=3Dy

I assume that this failure was introduced by commit
c4f9c779f1019c7d5c61961a7c0aaaf1420d8f90 ("Include Book3s_64 target in
buildsystem").
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__5_Jan_2010_14_32_38_+1100_KFDNdDrEE2r5BMoa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktCstYACgkQjjKRsyhoI8wNGQCeJCWby0p9t/oGUB9U+cSYOM6a
p/oAoKWNaVGCvS1IohLXVgGTsrPl+m2l
=NNPi
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Jan_2010_14_32_38_+1100_KFDNdDrEE2r5BMoa--
