Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 25B2D2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 11:06:53 +1000 (EST)
Date: Wed, 25 Sep 2013 11:06:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: linux-next: build failure after merge of the akpm tree
Message-Id: <20130925110643.db5fa154bea3838ed6affa45@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__25_Sep_2013_11_06_43_+1000_=pbgY2xoeaNwF_sN"
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
 Sergei Trofimovich <slyfox@gentoo.org>, linux-next@vger.kernel.org,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__25_Sep_2013_11_06_43_+1000_=pbgY2xoeaNwF_sN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm tree, linux-next builds (powerpc allmodconfig)
fail like this:

drivers/tty/ehv_bytechan.c:362:1: error: type defaults to 'int' in declarat=
ion of 'console_initcall' [-Werror=3Dimplicit-int]

Caused by commit 0f01cf96c2d4 ("./Makefile: enable -Werror=3Dimplicit-int
and -Werror=3Dstrict-prototypes by default") which has bee in linux-next
since Aug 16.  This commit exposed that fact that
drivers/tty/ehv_bytechan.c can be built as a module, but has a
console_initcall (which is not available to modules).  This was
originally introduced in commit dcd83aaff1c8 ("tty/powerpc: introduce the
ePAPR embedded hypervisor byte channel driver") in v3.2.

Anyone got a good solution?
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__25_Sep_2013_11_06_43_+1000_=pbgY2xoeaNwF_sN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBCAAGBQJSQjcnAAoJEECxmPOUX5FELSEP+wWHQRnG45pvXpbVMeSo+VE7
s8ZvM2trltNujcLG55fIlDVpMqEmOCOXCNVBWNw1PBzTzFtocm7TsgtDgRITu5T8
DUM/tAH2d9ySvzK1AkY9fM2ZhRs+LUZKI/jqAu08yjoAgUAXgVedwM3E7fKNYa31
nR9xXJm1LIcTDN2MDPzaBxTnxWzD3Q9O04jiuyRh8V9V7VU+qGugxzgUHisxnxLm
rrPDowhQlwA9xmncvGxreyrlAsZECoakZ5kEs04SPHx15Na+KKavcvEnfXg5IuxE
7BgVEpBukLrvpe19epY99EJCAv0i0/ZDhN7mg0b5V/Gjf5Xy6MboMSRfrL8w9ic3
YrGXK4LNHQUMtwBpNB3fZM6XToKKvqdOi7qsptly+RkXvzhnwI44kNG1/OsLvO39
EsGmy+8ToskaCTTgymIJQh5O0HgmQGA5ROo4o9UJwz4vZ6GUL3Uey60XLe9z9G29
w24DOYnLycGZ4U3AIlGEjpk8zhEZb4PMsuFdjWmOCsEPj44l+P+kZkZ5fpHJDBON
6fhhE6XmX9ugSvYtXkuPvioUuw3yKQD7HNF9xXvhNaBw+BPA/ESclzxsRtOk5Ga7
yx7q/aEnRsh3HJU+au6b2zb277GYb8cAWt1eBliOx2IV6+8jpMdeO0ywXjS3q5tb
ZgcNrMgrBoSb9Fl+bWIf
=92ne
-----END PGP SIGNATURE-----

--Signature=_Wed__25_Sep_2013_11_06_43_+1000_=pbgY2xoeaNwF_sN--
