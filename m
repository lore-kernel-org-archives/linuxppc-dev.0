Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8EC5DDF05
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 12:24:25 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m091O9UK001387
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 18:24:10 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m091O8vS018779
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 19:24:09 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Fix remainder calculating bug in single floating point
	division
Date: Wed, 9 Jan 2008 09:24:07 +0800
Message-ID: <6EBEC19BF4A8F843BCD6B9155BBE2515D1B515@zch01exm26.fsl.freescale.net>
In-Reply-To: <CC561FA6-0590-4BC0-B42B-7EE1B379CE8E@kernel.crashing.org>
References: <11996296134110-git-send-email-Yu.Liu@freescale.com>
	<CC561FA6-0590-4BC0-B42B-7EE1B379CE8E@kernel.crashing.org>
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
> can you provide the test case that shows the error.
>=20

It seems that math-emu only be used for MPC8xx on current kernel.

---
#include <stdio.h>
#include <math.h>
#include <bits/nan.h>
#include <bits/inf.h>

void
fdiv(float f, float f1, float expected)
{
    float f2;

    f2 =3D f / f1;

    printf("fdiv %e / %e =3D %e expected %e %s \n", f, f1, f2, expected,
               (f2 =3D=3D expected) ? "(PASS)" : "(FAIL)");
}
=20
int
main(void)
{
	fdiv(1.1754941e-38f, 0.9999999f, 1.1754942e-38f);
}
