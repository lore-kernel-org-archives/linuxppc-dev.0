Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F4D52C01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 01:13:44 +1000 (EST)
Subject: Re: [Qemu-ppc] [RFC PATCH 15/17] KVM: PPC64: bookehv: Add support for
 interrupt handling
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1340627195-11544-16-git-send-email-mihai.caraman@freescale.com>
Date: Wed, 4 Jul 2012 17:13:36 +0200
Message-Id: <FB7DFF5C-5E14-4202-9180-7968294F6A56@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-16-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 25.06.2012, at 14:26, Mihai Caraman wrote:

> Add bookehv interrupt handling support for 64-bit hosts. Change common =
stack
> layout to refer PPC_LR_STKOFF kernel constant. Dispatch the 64-bit =
execution
> flow to the existing kvm_handler_common asm macro. Update input =
register
> values documentation.
> Only the bolted version of TLB miss exception handlers is supported =
now.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/include/asm/kvm_booke_hv_asm.h |   12 +++-
> arch/powerpc/kvm/bookehv_interrupts.S       |  120 =
+++++++++++++++++++++++++--
> 2 files changed, 122 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_booke_hv_asm.h =
b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
> index 30a600f..8be6f87 100644
> --- a/arch/powerpc/include/asm/kvm_booke_hv_asm.h
> +++ b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
> @@ -1,5 +1,5 @@
> /*
> - * Copyright 2010-2011 Freescale Semiconductor, Inc.
> + * Copyright 2010-2012 Freescale Semiconductor, Inc.
>  *
>  * This program is free software; you can redistribute it and/or =
modify
>  * it under the terms of the GNU General Public License, version 2, as
> @@ -17,6 +17,7 @@
>  * there are no exceptions for which we fall through directly to
>  * the normal host handler.
>  *
> + * 32-bit host
>  * Expected inputs (normal exceptions):
>  *   SCRATCH0 =3D saved r10
>  *   r10 =3D thread struct
> @@ -33,6 +34,15 @@
>  *   *(r8 + GPR9) =3D saved r9
>  *   *(r8 + GPR10) =3D saved r10 (r10 not yet clobbered)
>  *   *(r8 + GPR11) =3D saved r11
> + *
> + * 64-bit host
> + * Expected inputs (exception types GEN/DBG/CRIT/MC):
> + *  r13 =3D PACA_POINTER
> + *  r10 =3D saved CR
> + *  SPRN_SPRG_##type##_SCRATCH =3D saved r13
> + *  *(r13 + PACA_EX##type + EX_R10) =3D saved r10
> + *  *(r13 + PACA_EX##type + EX_R11) =3D saved r11
> + * Only the bolted version of TLB miss exception handlers is =
supported now.
>  */
> .macro DO_KVM intno srr1
> #ifdef CONFIG_KVM_BOOKE_HV
> diff --git a/arch/powerpc/kvm/bookehv_interrupts.S =
b/arch/powerpc/kvm/bookehv_interrupts.S
> index dff8ed4..04097de 100644
> --- a/arch/powerpc/kvm/bookehv_interrupts.S
> +++ b/arch/powerpc/kvm/bookehv_interrupts.S
> @@ -12,10 +12,11 @@
>  * along with this program; if not, write to the Free Software
>  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  =
02110-1301, USA.
>  *
> - * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
> + * Copyright (C) 2010-2012 Freescale Semiconductor, Inc.
>  *
>  * Author: Varun Sethi <varun.sethi@freescale.com>
>  * Author: Scott Wood <scotwood@freescale.com>
> + * Author: Mihai Caraman <mihai.caraman@freescale.com>
>  *
>  * This file is derived from arch/powerpc/kvm/booke_interrupts.S
>  */
> @@ -30,7 +31,11 @@
> #include <asm/bitsperlong.h>
> #include <asm/thread_info.h>
>=20
> +#ifdef CONFIG_64BIT
> +#include <asm/exception-64e.h>
> +#else
> #include "../kernel/head_booke.h" /* for THREAD_NORMSAVE() */
> +#endif
>=20
> #define LONGBYTES		(BITS_PER_LONG / 8)
>=20
> @@ -38,20 +43,21 @@
> #define VCPU_GUEST_SPRG(n)	(VCPU_GUEST_SPRGS + (n * LONGBYTES))
>=20
> /* The host stack layout: */
> -#define HOST_R1         (0 * LONGBYTES) /* Implied by stwu. */
> -#define HOST_CALLEE_LR  (1 * LONGBYTES)
> -#define HOST_RUN        (2 * LONGBYTES) /* struct kvm_run */
> +#define HOST_R1         0 /* Implied by stwu. */
> +#define HOST_CALLEE_LR  PPC_LR_STKOFF
> +#define HOST_RUN        (HOST_CALLEE_LR + LONGBYTES)
> /*
>  * r2 is special: it holds 'current', and it made nonvolatile in the
>  * kernel with the -ffixed-r2 gcc option.
>  */
> -#define HOST_R2         (3 * LONGBYTES)
> -#define HOST_CR         (4 * LONGBYTES)
> -#define HOST_NV_GPRS    (5 * LONGBYTES)
> +#define HOST_R2         (HOST_RUN + LONGBYTES)
> +#define HOST_CR         (HOST_R2 + LONGBYTES)
> +#define HOST_NV_GPRS    (HOST_CR + LONGBYTES)
> #define HOST_NV_GPR(n)  (HOST_NV_GPRS + ((n - 14) * LONGBYTES))
> #define HOST_MIN_STACK_SIZE (HOST_NV_GPR(31) + LONGBYTES)
> #define HOST_STACK_SIZE ((HOST_MIN_STACK_SIZE + 15) & ~15) /* Align. =
*/
> -#define HOST_STACK_LR   (HOST_STACK_SIZE + LONGBYTES) /* In caller =
stack frame. */
> +/* LR in caller stack frame. */
> +#define HOST_STACK_LR	(HOST_STACK_SIZE + PPC_LR_STKOFF)
>=20
> #define NEED_EMU		0x00000001 /* emulation -- save nv regs =
*/
> #define NEED_DEAR		0x00000002 /* save faulting DEAR */
> @@ -202,6 +208,102 @@
> 	b	kvmppc_resume_host
> .endm
>=20
> +#ifdef CONFIG_64BIT
> +/*
> + * For input register values, see =
arch/powerpc/include/asm/kvm_booke_hv_asm.h
> + */
> +.macro kvm_handler intno scratch, paca_ex, ex_r10, ex_r11, srr0, =
srr1, flags
> + _GLOBAL(kvmppc_handler_\intno\()_\srr1)

Is this code so vastly different from the 32bit variant that they can't =
be the same with a few simple ifdef's here and there?


Alex
