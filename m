Return-Path: <B13201@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1E336DDE09
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 16:25:41 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lBA5PaFr025233
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Dec 2007 22:25:36 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id lBA5PY5l005038
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Dec 2007 23:25:35 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Fix rounding bug in emulation for double floatoperating
Date: Mon, 10 Dec 2007 13:25:34 +0800
Message-ID: <6EBEC19BF4A8F843BCD6B9155BBE2515C79D0D@zch01exm26.fsl.freescale.net>
In-Reply-To: <20071210045616.GC29611@localhost.localdomain>
References: <11972628522442-git-send-email-b13201@freescale.com>
	<20071210045616.GC29611@localhost.localdomain>
From: "Liu Yu" <B13201@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




=20

> -----Original Message-----
> From: David Gibson [mailto:david@gibson.dropbear.id.au]=20
> Sent: Monday, December 10, 2007 12:56 PM
> To: Liu Yu
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Fix rounding bug in emulation for double=20
> floatoperating
>=20
>=20
> On Mon, Dec 10, 2007 at 01:00:52PM +0800, Liu Yu wrote:
> >=20
> > This patch fixes rounding bug in emulation for double float=20
> operating on PowerPC platform.
> >=20
> > When pack double float operand, it need to truncate the=20
> tail due to the limited precision.
> > If the truncated part is not zero, the last bit of work bit=20
> (totally 3 bits) need to '|' 1.
> >=20
> > This patch is completed in _FP_FRAC_SRS_2(X,N,sz)=20
> (arch/powerpc/math-emu/op-2.h).
> > Originally the code leftwards rotates the operand to just keep the=20
> > truncated part, then check whether it is zero. However, the=20
> number it=20
> > rotates is not correct when N is not smaller than=20
> _FP_W_TYPE_SIZE, and it will cause the work bit '|' 1 in the=20
> improper case.
> >=20
> > This patch fixes this issue.
> >=20
> > Signed-off-by: Liu Yu <b13201@freescale.com>
>=20
> Wow someone deciphered the hideous macro hell of the math=20
> emulation code enough to fix a bug.  I don't suppose you'd=20
> care to fix the millions of warnings that the math-emu code=20
> generates...?

Oh, I don't like macro define either. But it's really a bug...
