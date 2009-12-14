Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 60FD6B6F09
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Dec 2009 17:35:22 +1100 (EST)
Date: Mon, 14 Dec 2009 17:35:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Subject: powerpc/kvm tree build failure
Message-Id: <20091214173512.91e4e39a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__14_Dec_2009_17_35_12_+1100_cqJ=M75hCdP5qQaP"
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__14_Dec_2009_17_35_12_+1100_cqJ=M75hCdP5qQaP
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

A powerpc allmodconfig fails like this:

arch/powerpc/kvm/built-in.o:(.toc1+0x18): undefined reference to `kvm_debug=
fs_dir'

This is because CONFIG_KVM_EXIT_TIMING is a bool while
CONFIG_KVM_BOOK3S_64 is tristate. This causes arch/powerpc/kvm/timing.o
(which references kvm_debugfs_dir) to be built in, but
virt/kvm/kvm_main.o (which defines it) to be modular.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__14_Dec_2009_17_35_12_+1100_cqJ=M75hCdP5qQaP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksl3KAACgkQjjKRsyhoI8w29gCgm218Og9pn23CjoGVoBKvD2Vj
KG0AnAqOaH7cPzvwp4S+lhz2G+l9/lrL
=VKQO
-----END PGP SIGNATURE-----

--Signature=_Mon__14_Dec_2009_17_35_12_+1100_cqJ=M75hCdP5qQaP--
