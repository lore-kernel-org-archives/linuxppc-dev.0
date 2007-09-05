Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 482EADDF3D
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 09:39:53 +1000 (EST)
Date: Thu, 6 Sep 2007 09:39:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: use of asm/prom.h
Message-Id: <20070906093943.95037b79.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__6_Sep_2007_09_39_43_+1000_O6x2KOb=HuJVEOYG"
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>,
	Helt <krzysztof.h1@wp.pl>, Krzysztof
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__6_Sep_2007_09_39_43_+1000_O6x2KOb=HuJVEOYG
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I noticed in the ALSA tree:

------------------------------ sound/sparc/dbri.c -------------------------=
-----
index 12d11fc..e96023f 100644
@@ -66,6 +66,7 @@
 #include <sound/control.h>
 #include <sound/initval.h>
=20
+#include <asm/prom.h>
 #include <asm/sbus.h>
 #include <asm/atomic.h>

(I don't mean to pick on this particular example, it is just what was in
front of me.)

Could people please consider using linux/{of,of_device,of_platform}.h
instead of asm/prom.h now that these exist.  Using asm/prom.h only works
now because it includes the above files, but that may (will?) change
eventually.

Most includes of asm/prom.h are there to get access to the routines and
data structures associated with the Open Firmware device tree, and these
are now all available from the above files instead.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__6_Sep_2007_09_39_43_+1000_O6x2KOb=HuJVEOYG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG3z5DTgG2atn1QN8RAoHGAJ9yjtabflhdM1Nv3px2GJgbZlmXwQCbBY5y
gl3or8BlSbUkAu99u9qtXEY=
=hUZa
-----END PGP SIGNATURE-----

--Signature=_Thu__6_Sep_2007_09_39_43_+1000_O6x2KOb=HuJVEOYG--
