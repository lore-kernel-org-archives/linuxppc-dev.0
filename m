Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlyrp5C8DzDr56
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 12:20:42 +1000 (AEST)
Message-ID: <1467944442.27479.155.camel@neuling.org>
Subject: Re: [PATCH v7 07/11] powerpc/powernv: Add platform support for stop
 instruction
From: Michael Neuling <mikey@neuling.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, ego@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com
Date: Fri, 08 Jul 2016 12:20:42 +1000
In-Reply-To: <1467924432-29003-8-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1467924432-29003-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1467924432-29003-8-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/as=
m/cpuidle.h
> index d2f99ca..3d7fc06 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -13,6 +13,8 @@
> =C2=A0#ifndef __ASSEMBLY__
> =C2=A0extern u32 pnv_fastsleep_workaround_at_entry[];
> =C2=A0extern u32 pnv_fastsleep_workaround_at_exit[];
> +
> +extern u64 pnv_first_deep_stop_state;

mpe asked a question about this which you neither answered or addressed.
"Should this have some safe initial value?"

I'm thinking we could do this which is what you have in the init call.
=C2=A0 =C2=A0u64 pnv_first_deep_stop_state =3D=C2=A0MAX_STOP_STATE;


> @@ -439,7 +540,18 @@ timebase_resync:
> =C2=A0	=C2=A0*/
> =C2=A0	bne	cr4,clear_lock
> =C2=A0
> -	/* Restore per core state */
> +	/*
> +	=C2=A0* First thread in the core to wake up and its waking up with
> +	=C2=A0* complete hypervisor state loss. Restore per core hypervisor
> +	=C2=A0* state.
> +	=C2=A0*/
> +BEGIN_FTR_SECTION
> +	ld	r4,_PTCR(r1)
> +	mtspr	SPRN_PTCR,r4
> +	ld	r4,_RPR(r1)
> +	mtspr	SPRN_RPR,r4

RPR looks wrong here. =C2=A0This should be on POWER8 too.

This has changed since v6 and not noted in the v7 comments. =C2=A0Why are y=
ou
changing this now?

> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
> +
> =C2=A0	ld	r4,_TSCR(r1)
> =C2=A0	mtspr	SPRN_TSCR,r4
> =C2=A0	ld	r4,_WORC(r1)
> @@ -461,9 +573,7 @@ common_exit:
> =C2=A0
> =C2=A0	/* Waking up from winkle */
> =C2=A0
> -	/* Restore per thread state */
> -	bl	__restore_cpu_power8
> -
> +BEGIN_MMU_FTR_SECTION
> =C2=A0	/* Restore SLB=C2=A0=C2=A0from PACA */
> =C2=A0	ld	r8,PACA_SLBSHADOWPTR(r13)
> =C2=A0
> @@ -477,6 +587,9 @@ common_exit:
> =C2=A0	slbmte	r6,r5
> =C2=A01:	addi	r8,r8,16
> =C2=A0	.endr
> +END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
> +
> +	/* Restore per thread state */

This FTR section is too big =C2=A0It ends up at 25 instructions with the lo=
op.
Probably better like this:

BEGIN_MMU_FTR_SECTION
	b	no_segments
END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
	/* Restore SLB=C2=A0=C2=A0from PACA */
	ld	r8,PACA_SLBSHADOWPTR(r13)

	.rept	SLB_NUM_BOLTED
	li	r3, SLBSHADOW_SAVEAREA
	LDX_BE	r5, r8, r3
	addi	r3, r3, 8
	LDX_BE	r6, r8, r3
	andis.	r7,r5,SLB_ESID_V@h
	beq	1f
	slbmte	r6,r5
1:	addi	r8,r8,16
	.endr

no_segments:
