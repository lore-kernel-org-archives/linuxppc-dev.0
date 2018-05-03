Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c8RY0QPYzF2VQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 19:07:20 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id j5so14197885pfh.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 May 2018 02:07:20 -0700 (PDT)
Date: Thu, 3 May 2018 17:07:16 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/11] KVM: PPC: reconstruct non-SIMD LOAD/STORE
 instruction mmio emulation with analyse_intr() input
Message-ID: <20180503090716.GG6755@simonLocalRHEL7.x64>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
 <1524657284-16706-8-git-send-email-wei.guo.simon@gmail.com>
 <20180503060346.GH6795@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503060346.GH6795@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2018 at 04:03:46PM +1000, Paul Mackerras wrote:
> On Wed, Apr 25, 2018 at 07:54:40PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > This patch reconstructs non-SIMD LOAD/STORE instruction MMIO emulation
> > with analyse_intr() input. It utilizes the BYTEREV/UPDATE/SIGNEXT
> > properties exported by analyse_instr() and invokes
> > kvmppc_handle_load(s)/kvmppc_handle_store() accordingly.
> > 
> > It also move CACHEOP type handling into the skeleton.
> > 
> > instruction_type within sstep.h is renamed to avoid conflict with
> > kvm_ppc.h.
> 
> I'd prefer to change the one in kvm_ppc.h, especially since that one
> isn't exactly about the type of instruction, but more about the type
> of interrupt led to us trying to fetch the instruction.
> 
Agreed.

> > Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> > ---
> >  arch/powerpc/include/asm/sstep.h     |   2 +-
> >  arch/powerpc/kvm/emulate_loadstore.c | 282 +++++++----------------------------
> >  2 files changed, 51 insertions(+), 233 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
> > index ab9d849..0a1a312 100644
> > --- a/arch/powerpc/include/asm/sstep.h
> > +++ b/arch/powerpc/include/asm/sstep.h
> > @@ -23,7 +23,7 @@
> >  #define IS_RFID(instr)		(((instr) & 0xfc0007fe) == 0x4c000024)
> >  #define IS_RFI(instr)		(((instr) & 0xfc0007fe) == 0x4c000064)
> >  
> > -enum instruction_type {
> > +enum analyse_instruction_type {
> >  	COMPUTE,		/* arith/logical/CR op, etc. */
> >  	LOAD,			/* load and store types need to be contiguous */
> >  	LOAD_MULTI,
> > diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
> > index 90b9692..aaaf872 100644
> > --- a/arch/powerpc/kvm/emulate_loadstore.c
> > +++ b/arch/powerpc/kvm/emulate_loadstore.c
> > @@ -31,9 +31,12 @@
> >  #include <asm/kvm_ppc.h>
> >  #include <asm/disassemble.h>
> >  #include <asm/ppc-opcode.h>
> > +#include <asm/sstep.h>
> >  #include "timing.h"
> >  #include "trace.h"
> >  
> > +int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
> > +		  unsigned int instr);
> 
> You shouldn't need this prototype here, since there's one in sstep.h.
> 
Yes.

> >  #ifdef CONFIG_PPC_FPU
> >  static bool kvmppc_check_fp_disabled(struct kvm_vcpu *vcpu)
> >  {
> > @@ -84,8 +87,9 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
> >  	struct kvm_run *run = vcpu->run;
> >  	u32 inst;
> >  	int ra, rs, rt;
> > -	enum emulation_result emulated;
> > +	enum emulation_result emulated = EMULATE_FAIL;
> >  	int advance = 1;
> > +	struct instruction_op op;
> >  
> >  	/* this default type might be overwritten by subcategories */
> >  	kvmppc_set_exit_type(vcpu, EMULATED_INST_EXITS);
> > @@ -114,144 +118,64 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
> >  	vcpu->arch.mmio_update_ra = 0;
> >  	vcpu->arch.mmio_host_swabbed = 0;
> >  
> > -	switch (get_op(inst)) {
> > -	case 31:
> > -		switch (get_xop(inst)) {
> > -		case OP_31_XOP_LWZX:
> > -			emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1);
> > -			break;
> > -
> > -		case OP_31_XOP_LWZUX:
> > -			emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1);
> > -			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
> > -			break;
> > -
> > -		case OP_31_XOP_LBZX:
> > -			emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1);
> > -			break;
> > +	emulated = EMULATE_FAIL;
> > +	vcpu->arch.regs.msr = vcpu->arch.shared->msr;
> > +	vcpu->arch.regs.ccr = vcpu->arch.cr;
> > +	if (analyse_instr(&op, &vcpu->arch.regs, inst) == 0) {
> > +		int type = op.type & INSTR_TYPE_MASK;
> > +		int size = GETSIZE(op.type);
> >  
> > -		case OP_31_XOP_LBZUX:
> > -			emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1);
> > -			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
> > -			break;
> > +		switch (type) {
> > +		case LOAD:  {
> > +			int instr_byte_swap = op.type & BYTEREV;
> >  
> > -		case OP_31_XOP_STDX:
> > -			emulated = kvmppc_handle_store(run, vcpu,
> > -					kvmppc_get_gpr(vcpu, rs), 8, 1);
> > -			break;
> > +			if (op.type & UPDATE) {
> > +				vcpu->arch.mmio_ra = op.update_reg;
> > +				vcpu->arch.mmio_update_ra = 1;
> > +			}
> 
> Any reason we can't just update RA here immediately?
> 
> >  
> > -		case OP_31_XOP_STDUX:
> > -			emulated = kvmppc_handle_store(run, vcpu,
> > -					kvmppc_get_gpr(vcpu, rs), 8, 1);
> > -			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
> > -			break;
> > -
> > -		case OP_31_XOP_STWX:
> > -			emulated = kvmppc_handle_store(run, vcpu,
> > -					kvmppc_get_gpr(vcpu, rs), 4, 1);
> > -			break;
> > -
> > -		case OP_31_XOP_STWUX:
> > -			emulated = kvmppc_handle_store(run, vcpu,
> > -					kvmppc_get_gpr(vcpu, rs), 4, 1);
> > -			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
> > -			break;
> > -
> > -		case OP_31_XOP_STBX:
> > -			emulated = kvmppc_handle_store(run, vcpu,
> > -					kvmppc_get_gpr(vcpu, rs), 1, 1);
> > -			break;
> > -
> > -		case OP_31_XOP_STBUX:
> > -			emulated = kvmppc_handle_store(run, vcpu,
> > -					kvmppc_get_gpr(vcpu, rs), 1, 1);
> > -			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
> > -			break;
> > -
> > -		case OP_31_XOP_LHAX:
> > -			emulated = kvmppc_handle_loads(run, vcpu, rt, 2, 1);
> > -			break;
> > -
> > -		case OP_31_XOP_LHAUX:
> > -			emulated = kvmppc_handle_loads(run, vcpu, rt, 2, 1);
> > -			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
> > -			break;
> > +			if (op.type & SIGNEXT)
> > +				emulated = kvmppc_handle_loads(run, vcpu,
> > +						op.reg, size, !instr_byte_swap);
> > +			else
> > +				emulated = kvmppc_handle_load(run, vcpu,
> > +						op.reg, size, !instr_byte_swap);
> >  
> > -		case OP_31_XOP_LHZX:
> > -			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1);
> >  			break;
> > -
> > -		case OP_31_XOP_LHZUX:
> > -			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1);
> > -			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
> > -			break;
> > -
> > -		case OP_31_XOP_STHX:
> > -			emulated = kvmppc_handle_store(run, vcpu,
> > -					kvmppc_get_gpr(vcpu, rs), 2, 1);
> > -			break;
> > -
> > -		case OP_31_XOP_STHUX:
> > -			emulated = kvmppc_handle_store(run, vcpu,
> > -					kvmppc_get_gpr(vcpu, rs), 2, 1);
> > -			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
> > -			break;
> > -
> > -		case OP_31_XOP_DCBST:
> > -		case OP_31_XOP_DCBF:
> > -		case OP_31_XOP_DCBI:
> > +		}
> > +		case STORE:
> > +			if (op.type & UPDATE) {
> > +				vcpu->arch.mmio_ra = op.update_reg;
> > +				vcpu->arch.mmio_update_ra = 1;
> > +			}
> 
> Same comment again about updating RA.
> 
> > +
> > +			/* if need byte reverse, op.val has been reverted by
> 
> "reversed" rather than "reverted".  "Reverted" means put back to a
> former state.
I will correct that.

> 
> Paul.

Thanks,
- Simon
