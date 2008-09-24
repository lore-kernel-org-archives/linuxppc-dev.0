Return-Path: <Yu.Liu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1D172DDE0D
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 14:28:58 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m8O4SqI1012132
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 21:28:52 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m8O4Snc3026525
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 23:28:50 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc/math-emu: Use kernel generic math-emu code
Date: Wed, 24 Sep 2008 12:28:48 +0800
Message-ID: <D8176E55B81822498D63816C4ADC70100937C8@zch01exm26.fsl.freescale.net>
In-Reply-To: <1222229100-22375-1-git-send-email-galak@kernel.crashing.org>
References: <1222229100-22375-1-git-send-email-galak@kernel.crashing.org>
From: "Liu Yu-B13201" <Yu.Liu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> diff --git a/arch/powerpc/include/asm/sfp-machine.h=20
> b/arch/powerpc/include/asm/sfp-machine.h
> new file mode 100644
> index 0000000..ced34f1
> --- /dev/null
> +++ b/arch/powerpc/include/asm/sfp-machine.h
> @@ -0,0 +1,353 @@
> +/* Machine-dependent software floating-point definitions. =20
> PPC version.
> +   Copyright (C) 1997 Free Software Foundation, Inc.
> +   This file is part of the GNU C Library.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Library General=20
> Public License as
> +   published by the Free Software Foundation; either version 2 of the
> +   License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will=20
> be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Library General Public License for more details.
> +
> +   You should have received a copy of the GNU Library General Public
> +   License along with the GNU C Library; see the file=20
> COPYING.LIB.  If
> +   not, write to the Free Software Foundation, Inc.,
> +   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> +
> +   Actually, this is a PPC (32bit) version, written based on the
> +   i386, sparc, and sparc64 versions, by me,
> +   Peter Maydell (pmaydell@chiark.greenend.org.uk).
> +   Comments are by and large also mine, although they may be=20
> inaccurate.
> +
> +   In picking out asm fragments I've gone with the lowest common
> +   denominator, which also happens to be the hardware I have :->
> +   That is, a SPARC without hardware multiply and divide.
> + */
> +
> +/* basic word size definitions */
> +#define _FP_W_TYPE_SIZE		32
> +#define _FP_W_TYPE		unsigned long
> +#define _FP_WS_TYPE		signed long
> +#define _FP_I_TYPE		long
> +
> +#define __ll_B			((UWtype) 1 <<=20
> (W_TYPE_SIZE / 2))
> +#define __ll_lowpart(t)		((UWtype) (t) & (__ll_B - 1))
> +#define __ll_highpart(t)	((UWtype) (t) >> (W_TYPE_SIZE / 2))
> +
> +/* You can optionally code some things like addition in asm. For
> + * example, i386 defines __FP_FRAC_ADD_2 as asm. If you don't
> + * then you get a fragment of C code [if you change an #ifdef 0
> + * in op-2.h] or a call to add_ssaaaa (see below).
> + * Good places to look for asm fragments to use are gcc and glibc.
> + * gcc's longlong.h is useful.
> + */
> +
> +/* We need to know how to multiply and divide. If the host word size
> + * is >=3D 2*fracbits you can use FP_MUL_MEAT_n_imm(t,R,X,Y) which
> + * codes the multiply with whatever gcc does to 'a * b'.
> + * _FP_MUL_MEAT_n_wide(t,R,X,Y,f) is used when you have an asm
> + * function that can multiply two 1W values and get a 2W result.
> + * Otherwise you're stuck with _FP_MUL_MEAT_n_hard(t,R,X,Y) which
> + * does bitshifting to avoid overflow.
> + * For division there is FP_DIV_MEAT_n_imm(t,R,X,Y,f) for word size
> + * >=3D 2*fracbits, where f is either _FP_DIV_HELP_imm or
> + * _FP_DIV_HELP_ldiv (see op-1.h).
> + * _FP_DIV_MEAT_udiv() is if you have asm to do 2W/1W =3D> (1W, 1W).
> + * [GCC and glibc have longlong.h which has the asm macro udiv_qrnnd
> + * to do this.]
> + * In general, 'n' is the number of words required to hold the type,
> + * and 't' is either S, D or Q for single/double/quad.
> + *           -- PMM
> + */
> +/* Example: SPARC64:
> + * #define _FP_MUL_MEAT_S(R,X,Y)	_FP_MUL_MEAT_1_imm(S,R,X,Y)
> + * #define _FP_MUL_MEAT_D(R,X,Y)=09
> _FP_MUL_MEAT_1_wide(D,R,X,Y,umul_ppmm)
> + * #define _FP_MUL_MEAT_Q(R,X,Y)=09
> _FP_MUL_MEAT_2_wide(Q,R,X,Y,umul_ppmm)
> + *
> + * #define _FP_DIV_MEAT_S(R,X,Y)=09
> _FP_DIV_MEAT_1_imm(S,R,X,Y,_FP_DIV_HELP_imm)
> + * #define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_1_udiv(D,R,X,Y)
> + * #define _FP_DIV_MEAT_Q(R,X,Y)	_FP_DIV_MEAT_2_udiv_64(Q,R,X,Y)
> + *
> + * Example: i386:
> + * #define _FP_MUL_MEAT_S(R,X,Y)  =20
> _FP_MUL_MEAT_1_wide(S,R,X,Y,_i386_mul_32_64)
> + * #define _FP_MUL_MEAT_D(R,X,Y)  =20
> _FP_MUL_MEAT_2_wide(D,R,X,Y,_i386_mul_32_64)
> + *
> + * #define _FP_DIV_MEAT_S(R,X,Y)  =20
> _FP_DIV_MEAT_1_udiv(S,R,X,Y,_i386_div_64_32)
> + * #define _FP_DIV_MEAT_D(R,X,Y)   _FP_DIV_MEAT_2_udiv_64(D,R,X,Y)
> + */
> +
> +#define _FP_MUL_MEAT_S(R,X,Y)  =20
> _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
> +#define _FP_MUL_MEAT_D(R,X,Y)  =20
> _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
> +
> +#define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_udiv(S,R,X,Y)

It seems _FP_DIV_MEAT_S() should be defined to
_FP_DIV_MEAT_1_udiv_norm().
I can't remember very clear, but it seems single point float need to be
normalized before calling udiv_qrnnd.
