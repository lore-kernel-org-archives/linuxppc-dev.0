Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id B6944B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 12:04:33 +1100 (EST)
Date: Thu, 8 Mar 2012 12:04:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: manual merge of the powerpc tree with the arm tree
Message-Id: <20120308120422.e071cba36425eacbee1f8d98@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__8_Mar_2012_12_04_22_+1100_4rv=5QsZlsW4prit"
Cc: Russell King <rmk@arm.linux.org.uk>, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__8_Mar_2012_12_04_22_+1100_4rv=5QsZlsW4prit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in
arch/powerpc/Kconfig between commit 2ed86b16eabe ("irq: make SPARSE_IRQ
an optionally hidden option") from the arm tree and commit ad5b7f1350c2
("powerpc: Make SPARSE_IRQ required") from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/powerpc/Kconfig
index bf7dbc2,4eecaaa..0000000
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@@ -133,7 -133,8 +133,8 @@@ config PP
  	select HAVE_REGS_AND_STACK_ACCESS_API
  	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
  	select HAVE_GENERIC_HARDIRQS
 -	select HAVE_SPARSE_IRQ
 +	select MAY_HAVE_SPARSE_IRQ
+ 	select SPARSE_IRQ
  	select IRQ_PER_CPU
  	select GENERIC_IRQ_SHOW
  	select GENERIC_IRQ_SHOW_LEVEL

--Signature=_Thu__8_Mar_2012_12_04_22_+1100_4rv=5QsZlsW4prit
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPWAWWAAoJEECxmPOUX5FEH7QP/j6Y3U7+zv7/KWkSwFsgu8uG
JdlmDFbdo/OXrYtUx2i0E+Y6zV53rn6Yq1ZeDf5iAkbrgjiZ/z071eJAG3uuEKaK
jhuQy2u4Ww7sfQQd5+gZNTiODX4175XUt2tXFCK9sQ/4mdGso14TO5HJo3zKP9z6
C/9rPqRHYmfLboJMWLr6Jv6DGmIdI31/HsSRD2+DM12i4RZOa07de0bKm4mtFzOC
JbV1NULFD8vdB8XhxiLX2ZKiDxFHb6whJ/1i87MVPJ75NleboNUZzQ2aK6zQxlMr
zFNw+2/f+a++O7Lx2pBHpCJiLtWTXbZS9CbJiE0DXUUmuwYDGteZqJ0F8MMxbxgN
jlRBH+sKVtX1fgO642h2E++fCAxSvFbMB2Q+N/55oS/sZCZ41fW7qitpE7sLvh07
oFhsI6rf8fR30btc6M6b7U/ZUzGU9hdIrYh8+ISDNe6LYiB5Wdw7cATEwFE1AUGG
HheHmLPwhb6oq8QldgDlr7asDcpML7W8edXm2yfM7KbI620Nxvq1N54Bz7yUVAvF
/7yUx87I/TG4fS1LVuPLHrytKGq4tIROq2bTwor1bp+MDVFy4IWhAVKzU3ZWF2dP
zmviAB8F2rVgBZhyXZZd91MRRfkAV1jN1xPNOaaW5DQcYRp5eWDTz0iYrhHpQBsk
L3rglVqwyMNajl/IMng5
=lPb/
-----END PGP SIGNATURE-----

--Signature=_Thu__8_Mar_2012_12_04_22_+1100_4rv=5QsZlsW4prit--
