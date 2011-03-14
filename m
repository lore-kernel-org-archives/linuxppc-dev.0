Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 90DD2B6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Mar 2011 20:38:37 +1100 (EST)
Date: Mon, 14 Mar 2011 20:38:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the final tree (powerpc
	tree related)
Message-Id: <20110314203827.4b61818e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__14_Mar_2011_20_38_27_+1100_yTURHjo3lFb5miaK"
Cc: linux-next@vger.kernel.org, Lennert Buytenhek <buytenh@secretlab.ca>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__14_Mar_2011_20_38_27_+1100_yTURHjo3lFb5miaK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the final tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/gpio/langwell_gpio.c: In function 'lnw_irq_handler':
drivers/gpio/langwell_gpio.c:210: error: 'struct irq_desc' has no member na=
med 'chip'
drivers/gpio/langwell_gpio.c:211: error: 'struct irq_desc' has no member na=
med 'chip'

Caused by commit 17b9f9e2653a ("powerpc: Enable
GENERIC_HARDIRQS_NO_DEPRECATED") enabling
CONFIG_GENERIC_HARDIRQS_NO_DEPRECATED for powerpc without previously
fixing up the above driver.

I have reverted that commit for today.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__14_Mar_2011_20_38_27_+1100_yTURHjo3lFb5miaK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNfeITAAoJEDMEi1NhKgbsAUMH/0rAq0y/tCFW/d9TzFcxiUVJ
ZJZc/GHE/QkohpRXrwoBg0KYTTYL3qUk+oW8R0u6fywoQiKX3D5cdlgtQaXkemC8
BKWeWubR+SFeMEKRvUj7w0JRcpQ9LhQinJ6bnAvqc48kc99ziErv8H6ZDNkHXa6z
4WkGSGpT/bJD6Fq+ltTNEX0MWrtMu8vGrFJYN3iLx6CGHa0ZSs7ZeaVHlFpSZoqg
oTFd0GJWA8+RxzzJKig8i4TQ/NQNoCIRbq7fPjxl4B/mL4q9PZPJIlhnM9EqB4db
gu80ayl0ShO3syfOu8LMZX4zEdFhD9uQJ6xyLLB5yo1NHEikAjJX7PGyoNVJMJQ=
=myUI
-----END PGP SIGNATURE-----

--Signature=_Mon__14_Mar_2011_20_38_27_+1100_yTURHjo3lFb5miaK--
