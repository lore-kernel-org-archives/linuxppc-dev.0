Return-Path: <B13201@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA980DDEE1
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 12:38:58 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lBB1cqnE008182
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 18:38:53 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lBB1cpr2015529
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 19:38:52 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Fix rounding bug in emulation for double floatoperating
Date: Tue, 11 Dec 2007 09:38:50 +0800
Message-ID: <6EBEC19BF4A8F843BCD6B9155BBE2515C79EFE@zch01exm26.fsl.freescale.net>
In-Reply-To: <AD0028E8-E305-443F-8872-C935D4E18F80@kernel.crashing.org>
References: <11972628522442-git-send-email-b13201@freescale.com>
	<20071210045616.GC29611@localhost.localdomain>
	<6EBEC19BF4A8F843BCD6B9155BBE2515C79D0D@zch01exm26.fsl.freescale.net>
	<AD0028E8-E305-443F-8872-C935D4E18F80@kernel.crashing.org>
From: "Liu Yu" <B13201@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Monday, December 10, 2007 11:01 PM
> To: Liu Yu
> Cc: David Gibson; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Fix rounding bug in emulation for double=20
> floatoperating
>=20
>=20
> On Dec 9, 2007, at 11:25 PM, Liu Yu wrote:
> >> -----Original Message-----
> >> From: David Gibson [mailto:david@gibson.dropbear.id.au]
> >> Sent: Monday, December 10, 2007 12:56 PM
> >> To: Liu Yu
> >> Cc: linuxppc-dev@ozlabs.org
> >> Subject: Re: [PATCH] Fix rounding bug in emulation for double=20
> >> floatoperating
> >>
> >>
> >> On Mon, Dec 10, 2007 at 01:00:52PM +0800, Liu Yu wrote:
> >>>
> >>> This patch fixes rounding bug in emulation for double float
> >> operating on PowerPC platform.
> >>>
> >>> When pack double float operand, it need to truncate the
> >> tail due to the limited precision.
> >>> If the truncated part is not zero, the last bit of work bit
> >> (totally 3 bits) need to '|' 1.
> >>>
> >>> This patch is completed in _FP_FRAC_SRS_2(X,N,sz)
> >> (arch/powerpc/math-emu/op-2.h).
> >>> Originally the code leftwards rotates the operand to just=20
> keep the=20
> >>> truncated part, then check whether it is zero. However, the
> >> number it
> >>> rotates is not correct when N is not smaller than
> >> _FP_W_TYPE_SIZE, and it will cause the work bit '|' 1 in=20
> the improper=20
> >> case.
> >>>
> >>> This patch fixes this issue.
> >>>
> >>> Signed-off-by: Liu Yu <b13201@freescale.com>
> >>
> >> Wow someone deciphered the hideous macro hell of the math=20
> emulation=20
> >> code enough to fix a bug.  I don't suppose you'd care to fix the=20
> >> millions of warnings that the math-emu code generates...?
> >
> > Oh, I don't like macro define either. But it's really a bug...
>=20
>=20
> how did you find this?

Well, when divide the min positive number by 2, you will get the work
bit "101" which is supposed to be "100".
And the wrong result will influent the succedent rounding operation.

In fact, the similar macro _FP_FRAC_SRS_1 and _FP_FRAC_SRS_4 are
correct. This bug just exists in _FP_FRAC_SRS_2.

>=20
> - k
>=20
