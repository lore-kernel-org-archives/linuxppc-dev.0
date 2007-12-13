Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E28D3DE2E0
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 06:53:24 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBDJrKor028802
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 14:53:20 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBDJrKoe141522
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 12:53:20 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBDJrJ0D032012
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 12:53:19 -0700
Date: Thu, 13 Dec 2007 13:53:17 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/20] [POWERPC] Reworking machine check handling and Fix
	440/440A
Message-ID: <20071213135317.0cffbfb8@weaponx>
In-Reply-To: <20071213073836.A25EDDDF80@ozlabs.org>
References: <20071213073836.A25EDDDF80@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 13 Dec 2007 18:38:31 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This adds a cputable function pointer for the CPU-side machine
> check handling. The semantic is still the same as the old one,
> the one in ppc_md. overrides the one in cputable, though
> ultimately we'll want to change that so the CPU gets first.
>=20
> This removes CONFIG_440A which was a problem for multiplatform
> kernels and instead fixes up the IVOR at runtime from a setup_cpu
> function. The "A" version of the machine check also tweaks the
> regs->trap value to differenciate the 2 versions at the C level.

[snip]

> Index: linux-merge/include/asm-ppc/reg_booke.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-merge.orig/include/asm-ppc/reg_booke.h	2007-12-11 16:21:38.0000=
00000 +1100
> +++ linux-merge/include/asm-ppc/reg_booke.h	2007-12-11 16:23:21.000000000=
 +1100
> @@ -207,7 +207,7 @@
>  #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
>=20
>  /* Bit definitions for the MCSR. */
> -#ifdef CONFIG_440A
> +#ifdef CONFIG_44x
>  #define MCSR_MCS	0x80000000 /* Machine Check Summary */
>  #define MCSR_IB		0x40000000 /* Instruction PLB Error */
>  #define MCSR_DRB	0x20000000 /* Data Read PLB Error */

This breaks non-44x based arch/ppc platforms.  For example ep405 in
arch/ppc fails with:

/home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c: In function =E2=80=98m=
achine_check_440A=E2=80=99:
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:260: error: =E2=80=98MC=
SR_IB=E2=80=99 undeclared (first use in this function)
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:260: error: (Each undec=
lared identifier is reported only once
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:260: error: for each fu=
nction it appears in.)
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:262: error: =E2=80=98MC=
SR_DRB=E2=80=99 undeclared (first use in this function)
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:264: error: =E2=80=98MC=
SR_DWB=E2=80=99 undeclared (first use in this function)
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:266: error: =E2=80=98MC=
SR_TLBP=E2=80=99 undeclared (first use in this function)
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:268: error: =E2=80=98MC=
SR_ICP=E2=80=99 undeclared (first use in this function)
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:272: error: =E2=80=98MC=
SR_DCSP=E2=80=99 undeclared (first use in this function)
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:274: error: =E2=80=98MC=
SR_DCFP=E2=80=99 undeclared (first use in this function)
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/traps.c:276: error: =E2=80=98MC=
SR_IMPE=E2=80=99 undeclared (first use in this function)
make[2]: *** [arch/ppc/kernel/traps.o] Error 1

The same is true for other platforms as well.  Getting closer...

josh
