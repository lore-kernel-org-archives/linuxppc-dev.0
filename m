Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sptgd6w9CzDrKS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 22:23:09 +1100 (AEDT)
Date: Wed, 5 Oct 2016 08:22:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, kim.phillips@arm.com,
 linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 treeze.taeung@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 markus@trippelsdorf.de, namhyung@kernel.org, pawel.moll@arm.com,
 chris.ryder@arm.com, jolsa@kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH v7 2/6] perf annotate: Add support for powerpc
Message-ID: <20161005112252.GR7143@kernel.org>
References: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1474472876-2706-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474472876-2706-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Sep 21, 2016 at 09:17:52PM +0530, Ravi Bangoria escreveu:
> From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> 
> Current perf can disassemble annotated function but it does not have
> parsing logic for powerpc instructions. So all navigation options are
> not available for powerpc.
> 
> Apart from that, Powerpc has long list of branch instructions and
> hardcoding them in table appears to be error-prone. So, add function
> to find instruction instead of creating table. This function dynamically
> create table (list of 'struct ins'), and instead of creating object
> every time, first check if list already contain object for that
> instruction.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
> Changes in v7:
>   - Little bit change in initializing instruction list.
> 
>  tools/perf/util/annotate.c | 112 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 816aa2c..5aa72d9 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -531,6 +531,11 @@ static struct ins instructions_arm[] = {
>  	{ .name = "retq",  .ops  = &ret_ops, },
>  };
>  
> +struct instructions_powerpc {
> +	struct ins *ins;
> +	struct list_head list;
> +};
> +

I'm considering accepting even more arch specific stuff in here, but we
need to stop doing that, and getting this as arch neutral as we possibly
can, instead of continuing to sprinkle strcmp(arch, "foo") around.

>  static int ins__key_cmp(const void *name, const void *insp)
>  {
>  	const struct ins *ins = insp;
> @@ -546,6 +551,111 @@ static int ins__cmp(const void *a, const void *b)
>  	return strcmp(ia->name, ib->name);
>  }
>  
> +static struct ins *list_add__ins_powerpc(struct instructions_powerpc *head,
> +					 const char *name, struct ins_ops *ops)
> +{
> +	struct instructions_powerpc *ins_powerpc;
> +	struct ins *ins;
> +
> +	ins = zalloc(sizeof(struct ins));
> +	if (!ins)
> +		return NULL;
> +
> +	ins_powerpc = zalloc(sizeof(struct instructions_powerpc));
> +	if (!ins_powerpc)
> +		goto out_free_ins;
> +
> +	ins->name = strdup(name);
> +	if (!ins->name)
> +		goto out_free_ins_power;
> +
> +	ins->ops = ops;
> +	ins_powerpc->ins = ins;
> +	list_add_tail(&(ins_powerpc->list), &(head->list));
> +
> +	return ins;
> +
> +out_free_ins_power:
> +	zfree(&ins_powerpc);
> +out_free_ins:
> +	zfree(&ins);
> +	return NULL;
> +}
> +
> +static struct ins *list_search__ins_powerpc(struct instructions_powerpc *head,
> +					    const char *name)
> +{
> +	struct instructions_powerpc *pos;
> +
> +	list_for_each_entry(pos, &head->list, list) {
> +		if (!strcmp(pos->ins->name, name))
> +			return pos->ins;
> +	}
> +	return NULL;
> +}
> +
> +static struct ins *ins__find_powerpc(const char *name)
> +{
> +	int i;
> +	struct ins *ins;
> +	struct ins_ops *ops;
> +	static struct instructions_powerpc head = {
> +		.list = LIST_HEAD_INIT(head.list),
> +	};
> +
> +	/*
> +	 * - Interested only if instruction starts with 'b'.
> +	 * - Few start with 'b', but aren't branch instructions.
> +	 */
> +	if (name[0] != 'b'             ||
> +	    !strncmp(name, "bcd", 3)   ||
> +	    !strncmp(name, "brinc", 5) ||
> +	    !strncmp(name, "bper", 4))
> +		return NULL;
> +
> +	/*
> +	 * Return if we already have object of 'struct ins' for this instruction
> +	 */
> +	ins = list_search__ins_powerpc(&head, name);
> +	if (ins)
> +		return ins;
> +
> +	ops = &jump_ops;
> +
> +	i = strlen(name) - 1;
> +	if (i < 0)
> +		return NULL;
> +
> +	/* ignore optional hints at the end of the instructions */
> +	if (name[i] == '+' || name[i] == '-')
> +		i--;
> +
> +	if (name[i] == 'l' || (name[i] == 'a' && name[i-1] == 'l')) {
> +		/*
> +		 * if the instruction ends up with 'l' or 'la', then
> +		 * those are considered 'calls' since they update LR.
> +		 * ... except for 'bnl' which is branch if not less than
> +		 * and the absolute form of the same.
> +		 */
> +		if (strcmp(name, "bnl") && strcmp(name, "bnl+") &&
> +		    strcmp(name, "bnl-") && strcmp(name, "bnla") &&
> +		    strcmp(name, "bnla+") && strcmp(name, "bnla-"))
> +			ops = &call_ops;
> +	}
> +	if (name[i] == 'r' && name[i-1] == 'l')
> +		/*
> +		 * instructions ending with 'lr' are considered to be
> +		 * return instructions
> +		 */
> +		ops = &ret_ops;
> +
> +	/*
> +	 * Add instruction to list so next time no need to
> +	 * allocate memory for it.
> +	 */
> +	return list_add__ins_powerpc(&head, name, ops);
> +}
> +
>  static void ins__sort(struct ins *instructions, int nmemb)
>  {
>  	qsort(instructions, nmemb, sizeof(struct ins), ins__cmp);
> @@ -581,6 +691,8 @@ static struct ins *ins__find(const char *name)
>  	} else if (!strcmp(norm_arch, "arm")) {
>  		instructions = instructions_arm;
>  		nmemb = ARRAY_SIZE(instructions_arm);
> +	} else if (!strcmp(norm_arch, "powerpc")) {
> +		return ins__find_powerpc(name);
>  	} else {
>  		pr_err("perf annotate not supported by %s arch\n", norm_arch);
>  		return NULL;
> -- 
> 2.5.5
