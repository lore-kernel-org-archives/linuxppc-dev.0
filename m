Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxfNn1W6CzDr4q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 18:34:33 +1000 (AEST)
Subject: Re: [PATCH v4 3/9] powerpc/kprobes/optprobes: Move over to
 patch_instruction
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org
References: <20170627074903.19324-1-bsingharora@gmail.com>
 <20170627074903.19324-4-bsingharora@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <83a385d1-872d-8782-7557-7fbc9352c54c@c-s.fr>
Date: Tue, 27 Jun 2017 10:34:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170627074903.19324-4-bsingharora@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 27/06/2017 à 09:48, Balbir Singh a écrit :
> With text moving to read-only migrate optprobes to using
> the patch_instruction infrastructure. Without this optprobes
> will fail and complain.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Didn't Michael picked it up already ?

Christophe


> ---
>   arch/powerpc/kernel/optprobes.c | 58 ++++++++++++++++++++++++++---------------
>   1 file changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
> index ec60ed0..1c7326c 100644
> --- a/arch/powerpc/kernel/optprobes.c
> +++ b/arch/powerpc/kernel/optprobes.c
> @@ -158,12 +158,13 @@ void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
>   void patch_imm32_load_insns(unsigned int val, kprobe_opcode_t *addr)
>   {
>   	/* addis r4,0,(insn)@h */
> -	*addr++ = PPC_INST_ADDIS | ___PPC_RT(4) |
> -		  ((val >> 16) & 0xffff);
> +	patch_instruction((unsigned int *)addr, PPC_INST_ADDIS | ___PPC_RT(4) |
> +					((val >> 16) & 0xffff));
> +	addr++;
>   
>   	/* ori r4,r4,(insn)@l */
> -	*addr = PPC_INST_ORI | ___PPC_RA(4) | ___PPC_RS(4) |
> -		(val & 0xffff);
> +	patch_instruction((unsigned int *)addr, PPC_INST_ORI | ___PPC_RA(4) |
> +					___PPC_RS(4) | (val & 0xffff));
>   }
>   
>   /*
> @@ -173,24 +174,28 @@ void patch_imm32_load_insns(unsigned int val, kprobe_opcode_t *addr)
>   void patch_imm64_load_insns(unsigned long val, kprobe_opcode_t *addr)
>   {
>   	/* lis r3,(op)@highest */
> -	*addr++ = PPC_INST_ADDIS | ___PPC_RT(3) |
> -		  ((val >> 48) & 0xffff);
> +	patch_instruction((unsigned int *)addr, PPC_INST_ADDIS | ___PPC_RT(3) |
> +					((val >> 48) & 0xffff));
> +	addr++;
>   
>   	/* ori r3,r3,(op)@higher */
> -	*addr++ = PPC_INST_ORI | ___PPC_RA(3) | ___PPC_RS(3) |
> -		  ((val >> 32) & 0xffff);
> +	patch_instruction((unsigned int *)addr, PPC_INST_ORI | ___PPC_RA(3) |
> +				___PPC_RS(3) | ((val >> 32) & 0xffff));
> +	addr++;
>   
>   	/* rldicr r3,r3,32,31 */
> -	*addr++ = PPC_INST_RLDICR | ___PPC_RA(3) | ___PPC_RS(3) |
> -		  __PPC_SH64(32) | __PPC_ME64(31);
> +	patch_instruction((unsigned int *)addr, PPC_INST_RLDICR | ___PPC_RA(3) |
> +				___PPC_RS(3) | __PPC_SH64(32) | __PPC_ME64(31));
> +	addr++;
>   
>   	/* oris r3,r3,(op)@h */
> -	*addr++ = PPC_INST_ORIS | ___PPC_RA(3) | ___PPC_RS(3) |
> -		  ((val >> 16) & 0xffff);
> +	patch_instruction((unsigned int *)addr, PPC_INST_ORIS | ___PPC_RA(3) |
> +					___PPC_RS(3) | ((val >> 16) & 0xffff));
> +	addr++;
>   
>   	/* ori r3,r3,(op)@l */
> -	*addr = PPC_INST_ORI | ___PPC_RA(3) | ___PPC_RS(3) |
> -		(val & 0xffff);
> +	patch_instruction((unsigned int *)addr, PPC_INST_ORI | ___PPC_RA(3) |
> +				___PPC_RS(3) | (val & 0xffff));
>   }
>   
>   int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
> @@ -198,7 +203,8 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
>   	kprobe_opcode_t *buff, branch_op_callback, branch_emulate_step;
>   	kprobe_opcode_t *op_callback_addr, *emulate_step_addr;
>   	long b_offset;
> -	unsigned long nip;
> +	unsigned long nip, size;
> +	int rc, i;
>   
>   	kprobe_ppc_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
>   
> @@ -231,8 +237,15 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
>   		goto error;
>   
>   	/* Setup template */
> -	memcpy(buff, optprobe_template_entry,
> -			TMPL_END_IDX * sizeof(kprobe_opcode_t));
> +	/* We can optimize this via patch_instruction_window later */
> +	size = (TMPL_END_IDX * sizeof(kprobe_opcode_t)) / sizeof(int);
> +	pr_devel("Copying template to %p, size %lu\n", buff, size);
> +	for (i = 0; i < size; i++) {
> +		rc = patch_instruction((unsigned int *)buff + i,
> +			*((unsigned int *)(optprobe_template_entry) + i));
> +		if (rc < 0)
> +			goto error;
> +	}
>   
>   	/*
>   	 * Fixup the template with instructions to:
> @@ -261,8 +274,10 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
>   	if (!branch_op_callback || !branch_emulate_step)
>   		goto error;
>   
> -	buff[TMPL_CALL_HDLR_IDX] = branch_op_callback;
> -	buff[TMPL_EMULATE_IDX] = branch_emulate_step;
> +	patch_instruction((unsigned int *)buff + TMPL_CALL_HDLR_IDX,
> +				branch_op_callback);
> +	patch_instruction((unsigned int *)buff + TMPL_EMULATE_IDX,
> +				branch_emulate_step);
>   
>   	/*
>   	 * 3. load instruction to be emulated into relevant register, and
> @@ -272,8 +287,9 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
>   	/*
>   	 * 4. branch back from trampoline
>   	 */
> -	buff[TMPL_RET_IDX] = create_branch((unsigned int *)buff + TMPL_RET_IDX,
> -				(unsigned long)nip, 0);
> +	patch_instruction((unsigned int *)buff + TMPL_RET_IDX,
> +				create_branch((unsigned int *)buff +
> +				TMPL_RET_IDX, (unsigned long)nip, 0));
>   
>   	flush_icache_range((unsigned long)buff,
>   			   (unsigned long)(&buff[TMPL_END_IDX]));
> 
