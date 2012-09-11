Return-Path: <B02008@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BF2BC2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 03:06:44 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>
Subject: RE: [PATCH 2/2] powerpc/e6500: TLB miss handler with hardware
 tablewalk support
Date: Tue, 11 Sep 2012 17:06:31 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF1DC945@039-SN2MPN1-011.039d.mgd.msft.net>
References: <20120614234101.GB17147@tyr.buserror.net>
In-Reply-To: <20120614234101.GB17147@tyr.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> diff --git a/arch/powerpc/mm/tlb_low_64e.S
> b/arch/powerpc/mm/tlb_low_64e.S
> index efe0f33..8e82772 100644
> --- a/arch/powerpc/mm/tlb_low_64e.S
> +++ b/arch/powerpc/mm/tlb_low_64e.S
> @@ -232,6 +232,173 @@ itlb_miss_fault_bolted:
>  	beq	tlb_miss_common_bolted
>  	b	itlb_miss_kernel_bolted
>=20
> +/*
> + * TLB miss handling for e6500 and derivatives, using hardware
> tablewalk.
> + *
> + * Linear mapping is bolted: no virtual page table or nested TLB misses
> + * Indirect entries in TLB1, hardware loads resulting direct entries
> + *    into TLB0
> + * No HES or NV hint on TLB1, so we need to do software round-robin
> + * No tlbsrx. so we need a spinlock, and we have to deal
> + *    with MAS-damage caused by tlbsx
> + * 4K pages only
> + */
> +
> +	START_EXCEPTION(instruction_tlb_miss_e6500)
> +	tlb_prolog_bolted SPRN_SRR0
> +
> +	ld	r11,PACA_TLB_PER_CORE_PTR(r13)
> +	srdi.	r15,r16,60		/* get region */
> +	ori	r16,r16,1
> +
> +	TLB_MISS_STATS_SAVE_INFO_BOLTED
> +	bne	tlb_miss_kernel_e6500	/* user/kernel test */
> +
> +	b	tlb_miss_common_e6500
> +
> +	START_EXCEPTION(data_tlb_miss_e6500)
> +	tlb_prolog_bolted SPRN_DEAR
> +
> +	ld	r11,PACA_TLB_PER_CORE_PTR(r13)
> +	srdi.	r15,r16,60		/* get region */
> +	rldicr	r16,r16,0,62
> +
> +	TLB_MISS_STATS_SAVE_INFO_BOLTED
> +	bne	tlb_miss_kernel_e6500	/* user vs kernel check */
> +

This ends up calling DO_KVM macro twice with same parameters which
generates the following compile error:

 arch/powerpc/mm/tlb_low_64e.S:307: Error: symbol `kvmppc_resume_14_0x01B' =
is already defined
 arch/powerpc/mm/tlb_low_64e.S:319: Error: symbol `kvmppc_resume_13_0x01B' =
is already defined

We can live with it if we patch DO_KVM like this:

diff --git a/arch/powerpc/include/asm/kvm_booke_hv_asm.h b/arch/powerpc/inc=
lude/asm/kvm_booke_hv_asm.h
index 4610fb0..029ecab 100644
--- a/arch/powerpc/include/asm/kvm_booke_hv_asm.h
+++ b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
@@ -55,9 +55,9 @@
 #ifdef CONFIG_KVM_BOOKE_HV
 BEGIN_FTR_SECTION
        mtocrf  0x80, r11       /* check MSR[GS] without clobbering reg */
-       bf      3, kvmppc_resume_\intno\()_\srr1
+       bf      3, 1f
        b       kvmppc_handler_\intno\()_\srr1
-kvmppc_resume_\intno\()_\srr1:
+1:
 END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 #endif
 .endm

-Mike
