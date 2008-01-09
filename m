Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9EEB6DDF12
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 14:05:39 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m0935Y90015162
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 20:05:34 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m0935WWc009285
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 21:05:33 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Fix carry bug in 128-bit unsigned integer adding
Date: Wed, 9 Jan 2008 11:05:31 +0800
Message-ID: <6EBEC19BF4A8F843BCD6B9155BBE2515D1B58B@zch01exm26.fsl.freescale.net>
In-Reply-To: <7040EDB2-7E89-4BBD-A4FC-50E168F9286F@kernel.crashing.org>
References: <11996295742378-git-send-email-Yu.Liu@freescale.com>
	<7040EDB2-7E89-4BBD-A4FC-50E168F9286F@kernel.crashing.org>
From: "Liu Yu" <Yu.Liu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>=20
> take a look at how include/math-emu/op-4.h implements=20
> __FP_FRAC_ADD_4 & __FP_FRAC_SUB_4.  Will that fix the bug, if=20
> so we should make the code match how its done there.
>=20
> - k
>=20
>=20

The macro define __FP_FRAC_ADD_4 is below. It can fix the carry bug.=20
But still exist a problem that r[0-2] and x[0-2] cannot be referred to
the same variable.
If r0 and x0 are the same variable, the comparison ( r0 < x0 ) will
always fail.
I don't know whether we need to fix this problem.

---
#define __FP_FRAC_ADD_4(r3,r2,r1,r0,x3,x2,x1,x0,y3,y2,y1,y0)    \
  do {                                                          \
    int _c1, _c2, _c3;                                          \
    r0 =3D x0 + y0;                                               \
    _c1 =3D r0 < x0;                                              \
    r1 =3D x1 + y1;                                               \
    _c2 =3D r1 < x1;                                              \
    r1 +=3D _c1;                                                  \
    _c2 |=3D r1 < _c1;                                            \
    r2 =3D x2 + y2;                                               \
    _c3 =3D r2 < x2;                                              \
    r2 +=3D _c2;                                                  \
    _c3 |=3D r2 < _c2;                                            \
    r3 =3D x3 + y3 + _c3;                                         \
  } while (0)
#endif
