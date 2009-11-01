Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 08/27] Add SLB switching code for entry/exit
In-reply-to: <1256917647-6200-9-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
	<1256917647-6200-9-git-send-email-agraf@suse.de>
Date: Mon, 02 Nov 2009 10:23:47 +1100
Message-ID: <6695.1257117827@neuling.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org,
	bphilips@suse.de, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> This is the really low level of guest entry/exit code.
> 
> Book3s_64 has an SLB, which stores all ESID -> VSID mappings we're
> currently aware of.
> 
> The segments in the guest differ from the ones on the host, so we need
> to switch the SLB to tell the MMU that we're in a new context.
> 
> So we store a shadow of the guest's SLB in the PACA, switch to that on
> entry and only restore bolted entries on exit, leaving the rest to the
> Linux SLB fault handler.
> 
> That way we get a really clean way of switching the SLB.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/powerpc/kvm/book3s_64_slb.S |  277 ++++++++++++++++++++++++++++++++++++
++
>  1 files changed, 277 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/kvm/book3s_64_slb.S
> 
> diff --git a/arch/powerpc/kvm/book3s_64_slb.S b/arch/powerpc/kvm/book3s_64_sl
b.S
> new file mode 100644
> index 0000000..00a8367
> --- /dev/null
> +++ b/arch/powerpc/kvm/book3s_64_slb.S
> @@ -0,0 +1,277 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + *
> + * Copyright SUSE Linux Products GmbH 2009
> + *
> + * Authors: Alexander Graf <agraf@suse.de>
> + */
> +
> +/***************************************************************************
***
> + *                                                                          
  *
> + *                               Entry code                                 
  *
> + *                                                                          
  *
> + ***************************************************************************
**/
> +
> +.global kvmppc_handler_trampoline_enter
> +kvmppc_handler_trampoline_enter:
> +
> +	/* Required state:
> +	 *
> +	 * MSR = ~IR|DR
> +	 * R13 = PACA
> +	 * R9 = guest IP
> +	 * R10 = guest MSR
> +	 * R11 = free
> +	 * R12 = free
> +	 * PACA[PACA_EXMC + EX_R9] = guest R9
> +	 * PACA[PACA_EXMC + EX_R10] = guest R10
> +	 * PACA[PACA_EXMC + EX_R11] = guest R11
> +	 * PACA[PACA_EXMC + EX_R12] = guest R12
> +	 * PACA[PACA_EXMC + EX_R13] = guest R13
> +	 * PACA[PACA_EXMC + EX_CCR] = guest CR
> +	 * PACA[PACA_EXMC + EX_R3] = guest XER
> +	 */
> +
> +	mtsrr0	r9
> +	mtsrr1	r10
> +
> +	mtspr	SPRN_SPRG_SCRATCH0, r0
> +
> +	/* Remove LPAR shadow entries */
> +
> +#if SLB_NUM_BOLTED == 3

You could alternatively check the persistent entry in the slb_shawdow
buffer.  This would give you a run time check.  Not sure what's best
though.  

> +
> +	ld	r12, PACA_SLBSHADOWPTR(r13)
> +	ld	r10, 0x10(r12)
> +	ld	r11, 0x18(r12)

Can you define something in asm-offsets.c for these magic constants 0x10
and 0x18.  Similarly below.

> +	/* Invalid? Skip. */
> +	rldicl. r0, r10, 37, 63
> +	beq	slb_entry_skip_1
> +	xoris	r9, r10, SLB_ESID_V@h
> +	std	r9, 0x10(r12)
> +slb_entry_skip_1:
> +	ld	r9, 0x20(r12)
> +	/* Invalid? Skip. */
> +	rldicl. r0, r9, 37, 63
> +	beq	slb_entry_skip_2
> +	xoris	r9, r9, SLB_ESID_V@h
> +	std	r9, 0x20(r12)
> +slb_entry_skip_2:
> +	ld	r9, 0x30(r12)
> +	/* Invalid? Skip. */
> +	rldicl. r0, r9, 37, 63
> +	beq	slb_entry_skip_3
> +	xoris	r9, r9, SLB_ESID_V@h
> +	std	r9, 0x30(r12)

Can these 3 be made into a macro?

> +slb_entry_skip_3:
> +	
> +#else
> +#error unknown number of bolted entries
> +#endif
> +
> +	/* Flush SLB */
> +
> +	slbia
> +
> +	/* r0 = esid & ESID_MASK */
> +	rldicr  r10, r10, 0, 35
> +	/* r0 |= CLASS_BIT(VSID) */
> +	rldic   r12, r11, 56 - 36, 36
> +	or      r10, r10, r12
> +	slbie	r10
> +
> +	isync
> +
> +	/* Fill SLB with our shadow */
> +
> +	lbz	r12, PACA_KVM_SLB_MAX(r13)
> +	mulli	r12, r12, 16
> +	addi	r12, r12, PACA_KVM_SLB
> +	add	r12, r12, r13
> +
> +	/* for (r11 = kvm_slb; r11 < kvm_slb + kvm_slb_size; r11+=slb_entry) */
> +	li	r11, PACA_KVM_SLB
> +	add	r11, r11, r13
> +
> +slb_loop_enter:
> +
> +	ld	r10, 0(r11)
> +
> +	rldicl. r0, r10, 37, 63
> +	beq	slb_loop_enter_skip
> +
> +	ld	r9, 8(r11)
> +	slbmte	r9, r10

If you're updating the first 3 slbs, you need to make sure the slb
shadow is updated at the same time (BTW dumb question: can we run this
under PHYP?)

> +
> +slb_loop_enter_skip:
> +	addi	r11, r11, 16
> +	cmpd	cr0, r11, r12
> +	blt	slb_loop_enter
> +
> +slb_do_enter:
> +
> +	/* Enter guest */
> +
> +	mfspr	r0, SPRN_SPRG_SCRATCH0
> +
> +	ld	r9, (PACA_EXMC+EX_R9)(r13)
> +	ld	r10, (PACA_EXMC+EX_R10)(r13)
> +	ld	r12, (PACA_EXMC+EX_R12)(r13)
> +
> +	lwz	r11, (PACA_EXMC+EX_CCR)(r13)
> +	mtcr	r11
> +
> +	ld	r11, (PACA_EXMC+EX_R3)(r13)
> +	mtxer	r11
> +
> +	ld	r11, (PACA_EXMC+EX_R11)(r13)
> +	ld	r13, (PACA_EXMC+EX_R13)(r13)
> +
> +	RFI
> +kvmppc_handler_trampoline_enter_end:
> +
> +
> +
> +/***************************************************************************
***
> + *                                                                          
  *
> + *                               Exit code                                  
  *
> + *                                                                          
  *
> + ***************************************************************************
**/
> +
> +.global kvmppc_handler_trampoline_exit
> +kvmppc_handler_trampoline_exit:
> +
> +	/* Register usage at this point:
> +	 *
> +	 * SPRG_SCRATCH0 = guest R13
> +	 * R01           = host R1
> +	 * R02           = host R2
> +	 * R10           = guest PC
> +	 * R11           = guest MSR
> +	 * R12           = exit handler id
> +	 * R13           = PACA
> +	 * PACA.exmc.CCR  = guest CR
> +	 * PACA.exmc.R9  = guest R1
> +	 * PACA.exmc.R10 = guest R10
> +	 * PACA.exmc.R11 = guest R11
> +	 * PACA.exmc.R12 = guest R12
> +	 * PACA.exmc.R13 = guest R2
> +	 *
> +	 */
> +
> +	/* Save registers */
> +
> +	std	r0, (PACA_EXMC+EX_SRR0)(r13)
> +	std	r9, (PACA_EXMC+EX_R3)(r13)
> +	std	r10, (PACA_EXMC+EX_LR)(r13)
> +	std	r11, (PACA_EXMC+EX_DAR)(r13)
> +
> +	/*
> +	 * In order for us to easily get the last instruction,
> +	 * we got the #vmexit at, we exploit the fact that the
> +	 * virtual layout is still the same here, so we can just
> +	 * ld from the guest's PC address
> +	 */
> +
> +	/* We only load the last instruction when it's safe */
> +	cmpwi	r12, BOOK3S_INTERRUPT_DATA_STORAGE
> +	beq	ld_last_inst
> +	cmpwi	r12, BOOK3S_INTERRUPT_PROGRAM
> +	beq	ld_last_inst
> +
> +	b	no_ld_last_inst
> +
> +ld_last_inst:
> +	/* Save off the guest instruction we're at */
> +	/*    1) enable paging for data */
> +	mfmsr	r9
> +	ori	r11, r9, MSR_DR			/* Enable paging for data */
> +	mtmsr	r11
> +	/*    2) fetch the instruction */
> +	lwz	r0, 0(r10)
> +	/*    3) disable paging again */
> +	mtmsr	r9
> +
> +no_ld_last_inst:
> +
> +	/* Restore bolted entries from the shadow and fix it along the way */
> +
> +	/* We don't store anything in entry 0, so we don't need to take care of
 that */
> +	slbia
> +	isync
> +
> +#if SLB_NUM_BOLTED == 3
> +
> +	ld	r11, PACA_SLBSHADOWPTR(r13)
> +
> +	ld	r10, 0x10(r11)
> +	cmpdi	r10, 0
> +	beq	slb_exit_skip_1
> +	oris	r10, r10, SLB_ESID_V@h
> +	ld	r9, 0x18(r11)
> +	slbmte	r9, r10
> +	std	r10, 0x10(r11)
> +slb_exit_skip_1:
> +	
> +	ld	r10, 0x20(r11)
> +	cmpdi	r10, 0
> +	beq	slb_exit_skip_2
> +	oris	r10, r10, SLB_ESID_V@h
> +	ld	r9, 0x28(r11)
> +	slbmte	r9, r10
> +	std	r10, 0x20(r11)
> +slb_exit_skip_2:
> +	
> +	ld	r10, 0x30(r11)
> +	cmpdi	r10, 0
> +	beq	slb_exit_skip_3
> +	oris	r10, r10, SLB_ESID_V@h
> +	ld	r9, 0x38(r11)
> +	slbmte	r9, r10
> +	std	r10, 0x30(r11)
> +slb_exit_skip_3:

Again, a macro here?

> +	
> +#else
> +#error unknown number of bolted entries
> +#endif
> +
> +slb_do_exit:
> +
> +	/* Restore registers */
> +
> +	ld	r11, (PACA_EXMC+EX_DAR)(r13)
> +	ld	r10, (PACA_EXMC+EX_LR)(r13)
> +	ld	r9, (PACA_EXMC+EX_R3)(r13)
> +
> +	/* Save last inst */
> +	stw	r0, (PACA_EXMC+EX_LR)(r13)
> +
> +	/* Save DAR and DSISR before going to paged mode */
> +	mfdar	r0
> +	std	r0, (PACA_EXMC+EX_DAR)(r13)
> +	mfdsisr	r0
> +	stw	r0, (PACA_EXMC+EX_DSISR)(r13)
> +
> +	/* RFI into the highmem handler */
> +	mfmsr	r0
> +	ori	r0, r0, MSR_IR|MSR_DR|MSR_RI	/* Enable paging */
> +	mtsrr1	r0
> +	ld	r0, PACASAVEDMSR(r13)		/* Highmem handler address */
> +	mtsrr0	r0
> +
> +	mfspr	r0, SPRN_SPRG_SCRATCH0
> +
> +	RFI
> +kvmppc_handler_trampoline_exit_end:
> +
> -- 
> 1.6.0.2
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
