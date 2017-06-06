Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wj1Zf74P0zDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 05:14:18 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v56JE5ZG129503
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Jun 2017 15:14:10 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2awnkn8hmm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jun 2017 15:14:09 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 7 Jun 2017 05:13:42 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v56JDVjI6947318
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jun 2017 05:13:39 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v56JD7IX004703
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jun 2017 05:13:07 +1000
Date: Wed, 7 Jun 2017 00:42:49 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, christophe.leroy@c-s.fr,
 paulus@samba.org
Subject: Re: [PATCH v3 3/9] powerpc/kprobes/optprobes: Move over to
 patch_instruction
References: <20170606042945.24997-1-bsingharora@gmail.com>
 <20170606042945.24997-4-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170606042945.24997-4-bsingharora@gmail.com>
Message-Id: <20170606191249.GG19390@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/06 02:29PM, Balbir Singh wrote:
> With text moving to read-only migrate optprobes to using
> the patch_instruction infrastructure. Without this optprobes
> will fail and complain.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/kernel/optprobes.c | 58 ++++++++++++++++++++++++++---------------
>  1 file changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
> index ec60ed0..1c7326c 100644
> --- a/arch/powerpc/kernel/optprobes.c
> +++ b/arch/powerpc/kernel/optprobes.c
> @@ -158,12 +158,13 @@ void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
>  void patch_imm32_load_insns(unsigned int val, kprobe_opcode_t *addr)
>  {
>  	/* addis r4,0,(insn)@h */
> -	*addr++ = PPC_INST_ADDIS | ___PPC_RT(4) |
> -		  ((val >> 16) & 0xffff);
> +	patch_instruction((unsigned int *)addr, PPC_INST_ADDIS | ___PPC_RT(4) |

We can probably get rid of those casts, seeing as we're not using it in 
kprobes.c.

> +					((val >> 16) & 0xffff));
> +	addr++;
> 
>  	/* ori r4,r4,(insn)@l */
> -	*addr = PPC_INST_ORI | ___PPC_RA(4) | ___PPC_RS(4) |
> -		(val & 0xffff);
> +	patch_instruction((unsigned int *)addr, PPC_INST_ORI | ___PPC_RA(4) |
> +					___PPC_RS(4) | (val & 0xffff));
>  }
> 
>  /*
> @@ -173,24 +174,28 @@ void patch_imm32_load_insns(unsigned int val, kprobe_opcode_t *addr)
>  void patch_imm64_load_insns(unsigned long val, kprobe_opcode_t *addr)
>  {
>  	/* lis r3,(op)@highest */
> -	*addr++ = PPC_INST_ADDIS | ___PPC_RT(3) |
> -		  ((val >> 48) & 0xffff);
> +	patch_instruction((unsigned int *)addr, PPC_INST_ADDIS | ___PPC_RT(3) |
> +					((val >> 48) & 0xffff));
> +	addr++;
> 
>  	/* ori r3,r3,(op)@higher */
> -	*addr++ = PPC_INST_ORI | ___PPC_RA(3) | ___PPC_RS(3) |
> -		  ((val >> 32) & 0xffff);
> +	patch_instruction((unsigned int *)addr, PPC_INST_ORI | ___PPC_RA(3) |
> +				___PPC_RS(3) | ((val >> 32) & 0xffff));
> +	addr++;
> 
>  	/* rldicr r3,r3,32,31 */
> -	*addr++ = PPC_INST_RLDICR | ___PPC_RA(3) | ___PPC_RS(3) |
> -		  __PPC_SH64(32) | __PPC_ME64(31);
> +	patch_instruction((unsigned int *)addr, PPC_INST_RLDICR | ___PPC_RA(3) |
> +				___PPC_RS(3) | __PPC_SH64(32) | __PPC_ME64(31));
> +	addr++;
> 
>  	/* oris r3,r3,(op)@h */
> -	*addr++ = PPC_INST_ORIS | ___PPC_RA(3) | ___PPC_RS(3) |
> -		  ((val >> 16) & 0xffff);
> +	patch_instruction((unsigned int *)addr, PPC_INST_ORIS | ___PPC_RA(3) |
> +					___PPC_RS(3) | ((val >> 16) & 0xffff));
> +	addr++;
> 
>  	/* ori r3,r3,(op)@l */
> -	*addr = PPC_INST_ORI | ___PPC_RA(3) | ___PPC_RS(3) |
> -		(val & 0xffff);
> +	patch_instruction((unsigned int *)addr, PPC_INST_ORI | ___PPC_RA(3) |
> +				___PPC_RS(3) | (val & 0xffff));
>  }
> 
>  int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
> @@ -198,7 +203,8 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
>  	kprobe_opcode_t *buff, branch_op_callback, branch_emulate_step;
>  	kprobe_opcode_t *op_callback_addr, *emulate_step_addr;
>  	long b_offset;
> -	unsigned long nip;
> +	unsigned long nip, size;
> +	int rc, i;
> 
>  	kprobe_ppc_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
> 
> @@ -231,8 +237,15 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
>  		goto error;
> 
>  	/* Setup template */
> -	memcpy(buff, optprobe_template_entry,
> -			TMPL_END_IDX * sizeof(kprobe_opcode_t));
> +	/* We can optimize this via patch_instruction_window later */

This probably needs a TODO just so it's clear. I do think this would be 
good to add since we copy many instructions while setting up the 
optprobe, so this is quite slow as it exists today.

> +	size = (TMPL_END_IDX * sizeof(kprobe_opcode_t)) / sizeof(int);

That's just TMPL_END_IDX.

Thanks,
Naveen

> +	pr_devel("Copying template to %p, size %lu\n", buff, size);
> +	for (i = 0; i < size; i++) {
> +		rc = patch_instruction((unsigned int *)buff + i,
> +			*((unsigned int *)(optprobe_template_entry) + i));
> +		if (rc < 0)
> +			goto error;
> +	}
> 
>  	/*
>  	 * Fixup the template with instructions to:
> @@ -261,8 +274,10 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
>  	if (!branch_op_callback || !branch_emulate_step)
>  		goto error;
> 
> -	buff[TMPL_CALL_HDLR_IDX] = branch_op_callback;
> -	buff[TMPL_EMULATE_IDX] = branch_emulate_step;
> +	patch_instruction((unsigned int *)buff + TMPL_CALL_HDLR_IDX,
> +				branch_op_callback);
> +	patch_instruction((unsigned int *)buff + TMPL_EMULATE_IDX,
> +				branch_emulate_step);
> 
>  	/*
>  	 * 3. load instruction to be emulated into relevant register, and
> @@ -272,8 +287,9 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
>  	/*
>  	 * 4. branch back from trampoline
>  	 */
> -	buff[TMPL_RET_IDX] = create_branch((unsigned int *)buff + TMPL_RET_IDX,
> -				(unsigned long)nip, 0);
> +	patch_instruction((unsigned int *)buff + TMPL_RET_IDX,
> +				create_branch((unsigned int *)buff +
> +				TMPL_RET_IDX, (unsigned long)nip, 0));
> 
>  	flush_icache_range((unsigned long)buff,
>  			   (unsigned long)(&buff[TMPL_END_IDX]));
> -- 
> 2.9.4
> 
