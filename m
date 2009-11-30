Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 46AC51007E1
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 10:23:57 +1100 (EST)
Date: Tue, 1 Dec 2009 10:23:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Subject: linux-next: powerpc tree build failure
Message-Id: <20091201102352.8a2d0a52.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__1_Dec_2009_10_23_52_+1100_9kD/jf7JG0Z1.H3l"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__1_Dec_2009_10_23_52_+1100_9kD/jf7JG0Z1.H3l
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

Today's linux-next build (powerpc ppc64_defconfig) failed like this:

arch/powerpc/mm/mmu_context_hash64.c: In function 'destroy_context':
arch/powerpc/mm/mmu_context_hash64.c:96: error: passing argument 1 of 'subp=
age_prot_free' from incompatible pointer type
arch/powerpc/include/asm/mmu-hash64.h:404: note: expected 'pgd_t *' but arg=
ument is of type 'struct mm_struct *'

Casued by commit c045256d146800ea1d741a8e9e377dada6b7e195 ("powerpc/mm:
Fix bug in pagetable cache cleanup with CONFIG_PPC_SUBPAGE_PROT") which I
have reverted for today.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__1_Dec_2009_10_23_52_+1100_9kD/jf7JG0Z1.H3l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksUVAgACgkQjjKRsyhoI8zmmgCfTeShjC/JngEwzVslw/LgHG56
29QAn0CMZ2f+t28ylqHQtbzxphS7whDb
=GLt3
-----END PGP SIGNATURE-----

--Signature=_Tue__1_Dec_2009_10_23_52_+1100_9kD/jf7JG0Z1.H3l--
