Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sptwW34q4zDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 22:34:19 +1100 (AEDT)
Date: Wed, 5 Oct 2016 08:34:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, kim.phillips@arm.com,
 linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 treeze.taeung@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 markus@trippelsdorf.de, namhyung@kernel.org, pawel.moll@arm.com,
 chris.ryder@arm.com, jolsa@kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH v7 6/6] perf annotate: cross arch annotate support fixes
 for ARM
Message-ID: <20161005113406.GV7143@kernel.org>
References: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1474472876-2706-7-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474472876-2706-7-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Sep 21, 2016 at 09:17:56PM +0530, Ravi Bangoria escreveu:
> From: Kim Phillips <kim.phillips@arm.com>
> 
> For ARM we remove the list that contains non-arm insns, and
> instead add more maintainable branch instruction regex logic.

This one looks ok and actually is in the direction of having facilities
for all arches, should've come as infrastructure that then gets used by
ARM and powerpc.

- Arnaldo
 
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
> Changes in v7:
>   - Little bit change in initializing instruction list.
> 
>  tools/perf/util/annotate.c | 177 +++++++++++++++++----------------------------
>  1 file changed, 65 insertions(+), 112 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index fc44dd1..83d5ac8 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -28,6 +28,7 @@ const char 	*disassembler_style;
>  const char	*objdump_path;
>  static regex_t	 file_lineno;
>  static char	*norm_arch;
> +static regex_t	arm_call_insn, arm_jump_insn;
>  
>  static struct ins *ins__find(const char *name);
>  static int disasm_line__parse(char *line, char **namep, char **rawp);
> @@ -449,98 +450,7 @@ static struct ins instructions_x86[] = {
>  	{ .name = "retq",  .ops  = &ret_ops, },
>  };
>  
> -static struct ins instructions_arm[] = {
> -	{ .name = "add",   .ops  = &mov_ops, },
> -	{ .name = "addl",  .ops  = &mov_ops, },
> -	{ .name = "addq",  .ops  = &mov_ops, },
> -	{ .name = "addw",  .ops  = &mov_ops, },
> -	{ .name = "and",   .ops  = &mov_ops, },
> -	{ .name = "b",     .ops  = &jump_ops, }, /* might also be a call */
> -	{ .name = "bcc",   .ops  = &jump_ops, },
> -	{ .name = "bcs",   .ops  = &jump_ops, },
> -	{ .name = "beq",   .ops  = &jump_ops, },
> -	{ .name = "bge",   .ops  = &jump_ops, },
> -	{ .name = "bgt",   .ops  = &jump_ops, },
> -	{ .name = "bhi",   .ops  = &jump_ops, },
> -	{ .name = "bl",    .ops  = &call_ops, },
> -	{ .name = "bls",   .ops  = &jump_ops, },
> -	{ .name = "blt",   .ops  = &jump_ops, },
> -	{ .name = "blx",   .ops  = &call_ops, },
> -	{ .name = "bne",   .ops  = &jump_ops, },
> -	{ .name = "bts",   .ops  = &mov_ops, },
> -	{ .name = "call",  .ops  = &call_ops, },
> -	{ .name = "callq", .ops  = &call_ops, },
> -	{ .name = "cmp",   .ops  = &mov_ops, },
> -	{ .name = "cmpb",  .ops  = &mov_ops, },
> -	{ .name = "cmpl",  .ops  = &mov_ops, },
> -	{ .name = "cmpq",  .ops  = &mov_ops, },
> -	{ .name = "cmpw",  .ops  = &mov_ops, },
> -	{ .name = "cmpxch", .ops  = &mov_ops, },
> -	{ .name = "dec",   .ops  = &dec_ops, },
> -	{ .name = "decl",  .ops  = &dec_ops, },
> -	{ .name = "imul",  .ops  = &mov_ops, },
> -	{ .name = "inc",   .ops  = &dec_ops, },
> -	{ .name = "incl",  .ops  = &dec_ops, },
> -	{ .name = "ja",	   .ops  = &jump_ops, },
> -	{ .name = "jae",   .ops  = &jump_ops, },
> -	{ .name = "jb",	   .ops  = &jump_ops, },
> -	{ .name = "jbe",   .ops  = &jump_ops, },
> -	{ .name = "jc",	   .ops  = &jump_ops, },
> -	{ .name = "jcxz",  .ops  = &jump_ops, },
> -	{ .name = "je",	   .ops  = &jump_ops, },
> -	{ .name = "jecxz", .ops  = &jump_ops, },
> -	{ .name = "jg",	   .ops  = &jump_ops, },
> -	{ .name = "jge",   .ops  = &jump_ops, },
> -	{ .name = "jl",    .ops  = &jump_ops, },
> -	{ .name = "jle",   .ops  = &jump_ops, },
> -	{ .name = "jmp",   .ops  = &jump_ops, },
> -	{ .name = "jmpq",  .ops  = &jump_ops, },
> -	{ .name = "jna",   .ops  = &jump_ops, },
> -	{ .name = "jnae",  .ops  = &jump_ops, },
> -	{ .name = "jnb",   .ops  = &jump_ops, },
> -	{ .name = "jnbe",  .ops  = &jump_ops, },
> -	{ .name = "jnc",   .ops  = &jump_ops, },
> -	{ .name = "jne",   .ops  = &jump_ops, },
> -	{ .name = "jng",   .ops  = &jump_ops, },
> -	{ .name = "jnge",  .ops  = &jump_ops, },
> -	{ .name = "jnl",   .ops  = &jump_ops, },
> -	{ .name = "jnle",  .ops  = &jump_ops, },
> -	{ .name = "jno",   .ops  = &jump_ops, },
> -	{ .name = "jnp",   .ops  = &jump_ops, },
> -	{ .name = "jns",   .ops  = &jump_ops, },
> -	{ .name = "jnz",   .ops  = &jump_ops, },
> -	{ .name = "jo",	   .ops  = &jump_ops, },
> -	{ .name = "jp",	   .ops  = &jump_ops, },
> -	{ .name = "jpe",   .ops  = &jump_ops, },
> -	{ .name = "jpo",   .ops  = &jump_ops, },
> -	{ .name = "jrcxz", .ops  = &jump_ops, },
> -	{ .name = "js",	   .ops  = &jump_ops, },
> -	{ .name = "jz",	   .ops  = &jump_ops, },
> -	{ .name = "lea",   .ops  = &mov_ops, },
> -	{ .name = "lock",  .ops  = &lock_ops, },
> -	{ .name = "mov",   .ops  = &mov_ops, },
> -	{ .name = "movb",  .ops  = &mov_ops, },
> -	{ .name = "movdqa",.ops  = &mov_ops, },
> -	{ .name = "movl",  .ops  = &mov_ops, },
> -	{ .name = "movq",  .ops  = &mov_ops, },
> -	{ .name = "movslq", .ops  = &mov_ops, },
> -	{ .name = "movzbl", .ops  = &mov_ops, },
> -	{ .name = "movzwl", .ops  = &mov_ops, },
> -	{ .name = "nop",   .ops  = &nop_ops, },
> -	{ .name = "nopl",  .ops  = &nop_ops, },
> -	{ .name = "nopw",  .ops  = &nop_ops, },
> -	{ .name = "or",    .ops  = &mov_ops, },
> -	{ .name = "orl",   .ops  = &mov_ops, },
> -	{ .name = "test",  .ops  = &mov_ops, },
> -	{ .name = "testb", .ops  = &mov_ops, },
> -	{ .name = "testl", .ops  = &mov_ops, },
> -	{ .name = "xadd",  .ops  = &mov_ops, },
> -	{ .name = "xbeginl", .ops  = &jump_ops, },
> -	{ .name = "xbeginq", .ops  = &jump_ops, },
> -	{ .name = "retq",  .ops  = &ret_ops, },
> -};
> -
> -struct instructions_powerpc {
> +struct instructions_arch {
>  	struct ins *ins;
>  	struct list_head list;
>  };
> @@ -560,41 +470,41 @@ static int ins__cmp(const void *a, const void *b)
>  	return strcmp(ia->name, ib->name);
>  }
>  
> -static struct ins *list_add__ins_powerpc(struct instructions_powerpc *head,
> -					 const char *name, struct ins_ops *ops)
> +static struct ins *list_add__ins_arch(struct instructions_arch *head,
> +				      const char *name, struct ins_ops *ops)
>  {
> -	struct instructions_powerpc *ins_powerpc;
> +	struct instructions_arch *ins_arch;
>  	struct ins *ins;
>  
>  	ins = zalloc(sizeof(struct ins));
>  	if (!ins)
>  		return NULL;
>  
> -	ins_powerpc = zalloc(sizeof(struct instructions_powerpc));
> -	if (!ins_powerpc)
> +	ins_arch = zalloc(sizeof(struct instructions_arch));
> +	if (!ins_arch)
>  		goto out_free_ins;
>  
>  	ins->name = strdup(name);
>  	if (!ins->name)
> -		goto out_free_ins_power;
> +		goto out_free_ins_arch;
>  
>  	ins->ops = ops;
> -	ins_powerpc->ins = ins;
> -	list_add_tail(&(ins_powerpc->list), &(head->list));
> +	ins_arch->ins = ins;
> +	list_add_tail(&(ins_arch->list), &(head->list));
>  
>  	return ins;
>  
> -out_free_ins_power:
> -	zfree(&ins_powerpc);
> +out_free_ins_arch:
> +	zfree(&ins_arch);
>  out_free_ins:
>  	zfree(&ins);
>  	return NULL;
>  }
>  
> -static struct ins *list_search__ins_powerpc(struct instructions_powerpc *head,
> -					    const char *name)
> +static struct ins *list_search__ins_arch(struct instructions_arch *head,
> +					 const char *name)
>  {
> -	struct instructions_powerpc *pos;
> +	struct instructions_arch *pos;
>  
>  	list_for_each_entry(pos, &head->list, list) {
>  		if (!strcmp(pos->ins->name, name))
> @@ -608,7 +518,7 @@ static struct ins *ins__find_powerpc(const char *name)
>  	int i;
>  	struct ins *ins;
>  	struct ins_ops *ops;
> -	static struct instructions_powerpc head = {
> +	static struct instructions_arch head = {
>  		.list = LIST_HEAD_INIT(head.list),
>  	};
>  
> @@ -625,7 +535,7 @@ static struct ins *ins__find_powerpc(const char *name)
>  	/*
>  	 * Return if we already have object of 'struct ins' for this instruction
>  	 */
> -	ins = list_search__ins_powerpc(&head, name);
> +	ins = list_search__ins_arch(&head, name);
>  	if (ins)
>  		return ins;
>  
> @@ -662,7 +572,40 @@ static struct ins *ins__find_powerpc(const char *name)
>  	 * Add instruction to list so next time no need to
>  	 * allocate memory for it.
>  	 */
> -	return list_add__ins_powerpc(&head, name, ops);
> +	return list_add__ins_arch(&head, name, ops);
> +}
> +
> +static struct ins *ins__find_arm(const char *name)
> +{
> +	struct ins *ins;
> +	struct ins_ops *ops = &mov_ops;
> +	regmatch_t match[2];
> +	int ret;
> +	static struct instructions_arch head = {
> +		.list = LIST_HEAD_INIT(head.list),
> +	};
> +
> +	/*
> +	 * Return if we already have object of 'struct ins' for this instruction
> +	 */
> +	ins = list_search__ins_arch(&head, name);
> +	if (ins)
> +		return ins;
> +
> +	ret = regexec(&arm_call_insn, name, 2, match, 0);
> +	if (!ret) {
> +		ops = &call_ops;
> +	} else {
> +		ret = regexec(&arm_jump_insn, name, 2, match, 0);
> +		if (!ret)
> +			ops = &jump_ops;
> +	}
> +
> +	/*
> +	 * Add instruction to list so next time no need to
> +	 * allocate memory for it.
> +	 */
> +	return list_add__ins_arch(&head, name, ops);
>  }
>  
>  static void ins__sort(struct ins *instructions, int nmemb)
> @@ -682,15 +625,26 @@ static const char *annotate__norm_arch(char *arch)
>  	return normalize_arch(arch);
>  }
>  
> +#define ARM_CONDS "(cc|cs|eq|ge|gt|hi|le|ls|lt|mi|ne|pl|vc|vs)"
> +
>  static struct ins *ins__find(const char *name)
>  {
>  	static bool sorted;
>  	struct ins *instructions;
> -	int nmemb;
> +	int nmemb, ret;
>  
>  	if (!sorted) {
>  		ins__sort(instructions_x86, ARRAY_SIZE(instructions_x86));
> -		ins__sort(instructions_arm, ARRAY_SIZE(instructions_arm));
> +		if (!strcmp(norm_arch, "arm")) {
> +			ret = regcomp(&arm_call_insn,
> +				      "^blx?" ARM_CONDS "?$", REG_EXTENDED);
> +			ret |= regcomp(&arm_jump_insn,
> +				       "^bx?" ARM_CONDS "?$", REG_EXTENDED);
> +			if (ret) {
> +				pr_err("regcomp failed\n");
> +				return NULL;
> +			}
> +		}
>  		sorted = true;
>  	}
>  
> @@ -698,8 +652,7 @@ static struct ins *ins__find(const char *name)
>  		instructions = instructions_x86;
>  		nmemb = ARRAY_SIZE(instructions_x86);
>  	} else if (!strcmp(norm_arch, "arm")) {
> -		instructions = instructions_arm;
> -		nmemb = ARRAY_SIZE(instructions_arm);
> +		return ins__find_arm(name);
>  	} else if (!strcmp(norm_arch, "powerpc")) {
>  		return ins__find_powerpc(name);
>  	} else {
> -- 
> 2.5.5
