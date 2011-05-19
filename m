Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3EE90B6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 13:19:21 +1000 (EST)
Date: Thu, 19 May 2011 13:19:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build warning after merge of the powerpc tree
Message-Id: <20110519131913.79c14fe7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__19_May_2011_13_19_13_+1000_4LoZgqk+29JvW/Pz"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__19_May_2011_13_19_13_+1000_4LoZgqk+29JvW/Pz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the powerpc tree, today's linux-next build (powerpc
allyesconfig) produced this warning:

WARNING: arch/powerpc/sysdev/built-in.o(.text+0x10eb8): Section mismatch in=
 reference from the function .ics_rtas_init() to the function .init.text:.x=
ics_register_ics()
The function .ics_rtas_init() references
the function __init .xics_register_ics().
This is often because .ics_rtas_init lacks a __init=20
annotation or the annotation of .xics_register_ics is wrong.

Introduced by commit 0b05ac6e2480 ("powerpc/xics: Rewrite XICS driver").

ics_rtas_init() is only called from xics_init() which is marked __init,
so ics_rtas_init() should be as well.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__19_May_2011_13_19_13_+1000_4LoZgqk+29JvW/Pz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN1IwxAAoJEDMEi1NhKgbsPH8IAIW5jLyxW5D1Q8J3j52PpFAB
yDgDtCSQ675W8NrKydXzCgk0pnwb4lXHidy/cK4xgvl6RswtSvwgeMQTRHG60hkl
fM6/8LsMtxfptClMb/6SATqblAxXkZn1l34LaQhJQ9/+LobvhkXZTaFqx1GZNMu2
RovOuhzsolWrmkNr+jYYbaHNV1eJ+gh3kVFej5gJ270HmLMA1/mxAXVjSJ01+zMe
7MGhr3+SurwNXJF7Py4VCqrUMFt/alyMlh2tCY0o/smYqTtV9/pYnRdeUsGbBYJQ
5j2cahrbK8f50nBqh3fNhJsOUloHl4FsHb84bnFq17LCxFoq6b3CXHy1LWsNQuA=
=v/Uj
-----END PGP SIGNATURE-----

--Signature=_Thu__19_May_2011_13_19_13_+1000_4LoZgqk+29JvW/Pz--
