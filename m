Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BcGS6HWrzDqmS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 18:44:48 +1100 (AEDT)
Date: Thu, 29 Mar 2018 18:43:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the powerpc tree
Message-ID: <20180329184356.3926ac30@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/b6Qko=yiUe0v/qv=l3mtbT4"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/b6Qko=yiUe0v/qv=l3mtbT4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the powerpc tree, today's linux-next build (powerpc64
allnoconfig) failed like this:

WARNING: vmlinux.o(.text+0x12e34): Section mismatch in reference from the f=
unction .setup_rfi_flush() to the function .init.text:.ppc64_bolted_size()
The function .setup_rfi_flush() references
the function __init .ppc64_bolted_size().
This is often because .setup_rfi_flush lacks a __init=20
annotation or the annotation of .ppc64_bolted_size is wrong.

WARNING: vmlinux.o(.text+0x12e64): Section mismatch in reference from the f=
unction .setup_rfi_flush() to the function .init.text:.memblock_alloc_base()
The function .setup_rfi_flush() references
the function __init .memblock_alloc_base().
This is often because .setup_rfi_flush lacks a __init=20
annotation or the annotation of .memblock_alloc_base is wrong.

FATAL: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy to allow them.

Caused by commit

  abf110f3e1ce ("powerpc/rfi-flush: Make it possible to call setup_rfi_flus=
h() again")

I have left it broken for now.

--=20
Cheers,
Stephen Rothwell

--Sig_/b6Qko=yiUe0v/qv=l3mtbT4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq8mTwACgkQAVBC80lX
0Gx++wf+K3TQovQlP/H4cmMZdxA7+9i9P4Xt9DfDGGvXtYvRXKtXplvtos6Gr86e
HSVTh+n6brGCYAuX6iojrS6IBWhkpZvSUvOIsjyMqIEmgwQVi/smq1l+dRXBS0N1
VosXrFKEc6bqpc6Zkg9XhcIA9GVQlWwc/v3bY8MGr/SiE2nLu4dXtTJmMdKCTw6a
HEr1N9ez1k2apXq9u7gQQYM2J69GXBJAfsbyIhMbTiUo0iNlNWEjD/LngqnyE/aK
9SLtislTrLFoqBGFKvOrD9ei9poLw5n+H+WKHSycHcoX68S1vbWQ+OLD0oEbtHue
SRIm2EBfCI1F+I1RhPZ9DFrRYPQjIQ==
=/zVf
-----END PGP SIGNATURE-----

--Sig_/b6Qko=yiUe0v/qv=l3mtbT4--
