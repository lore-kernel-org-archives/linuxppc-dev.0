Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 93726DDFA1
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 10:30:28 +1000 (EST)
Date: Fri, 25 Jul 2008 10:30:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: linux-next: origin tree build failure
Message-Id: <20080725103021.b913c24c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__25_Jul_2008_10_30_21_+1000_HmNCL7n6LctfkuOC"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Steven Whitehouse <swhiteho@redhat.com>,
	linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__25_Jul_2008_10_30_21_+1000_HmNCL7n6LctfkuOC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next (really just Linus' tree) build (powerpc
ppc64_defconfig) failed like this:

fs/nfs/nfsroot.c:130: error: tokens causes a section type conflict

"tokens" is a match_table_t which has const added to it in commit
f9247273cb69ba101877e946d2d83044409cc8c5 "UFS: add const to parser token
table".  But "tokens" is also marked __initdata.  I changed it to
__initconst.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__25_Jul_2008_10_30_21_+1000_HmNCL7n6LctfkuOC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiJHp0ACgkQjjKRsyhoI8xG9wCeOutOS7BqKHvo2K8f1LaW1qlK
zMsAn3XtT+yNaYCbr0xpkkKm+D4N8RPr
=/L8s
-----END PGP SIGNATURE-----

--Signature=_Fri__25_Jul_2008_10_30_21_+1000_HmNCL7n6LctfkuOC--
