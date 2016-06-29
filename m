Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rflpS6KBTzDqvq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 00:45:36 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TEiFPm037855
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 10:45:34 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23utc96j44-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 10:45:34 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 00:45:31 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E01C32CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 00:45:27 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TEjR3O4325792
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 00:45:27 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TEjQqN006446
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 00:45:27 +1000
Date: Wed, 29 Jun 2016 20:15:21 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, acme@kernel.org,
 linuxppc-dev@lists.ozlabs.org, anton@ozlabs.org, mpe@ellerman.id.au,
 ananth@in.ibm.com, dja@axtens.net, David.Laight@ACULAB.COM
Subject: Re: [PATCH v2 3/4] perf annotate: add powerpc support
References: <1467198958-9195-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467198958-9195-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467198958-9195-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <20160629144521.GC14508@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/06/29 04:45PM, Ravi Bangoria wrote:
> From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> Powerpc has long list of branch instructions and hardcoding them in
> table appears to be error-prone. So, add new function to find
> instruction instead of creating table. This function dynamically
> create table(list of 'struct ins'), and instead of creating object
> every time, first check if list already contain object for that
> nemonics.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
> Changes in v2:
>   - Corrected few memory leaks.
>   - Created Dynamic list for powerpc to optimize memory consumption
> 
>  tools/perf/util/annotate.c | 121 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 36a5825..812bfad 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -461,6 +461,11 @@ static struct ins instructions_arm[] = {
>  	{ .name = "bne",   .ops  = &jump_ops, },
>  };
> 
> +struct instructions_powerpc {
> +	struct ins *ins;
> +	struct list_head list;
> +};
> +
>  static int ins__key_cmp(const void *name, const void *insp)
>  {
>  	const struct ins *ins = insp;
> @@ -476,6 +481,120 @@ static int ins__cmp(const void *a, const void *b)
>  	return strcmp(ia->name, ib->name);
>  }
> 
> +static int list_add__ins_powerpc(struct instructions_powerpc *head,
> +				 struct ins *ins)
> +{
> +	struct instructions_powerpc *ins_powerpc;
> +
> +	ins_powerpc = zalloc(sizeof(struct instructions_powerpc));
> +	if (!ins_powerpc)
> +		return -1;
> +
> +	ins_powerpc->ins = ins;
> +	list_add_tail(&(ins_powerpc->list), &(head->list));
> +
> +	return 0;
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
> +	static struct instructions_powerpc head;
> +	static bool list_initialized;
> +
> +	if (!list_initialized) {
> +		INIT_LIST_HEAD(&head.list);
> +		list_initialized = true;
> +	}
> +
> +	/*
> +	 * Search if we already created object of 'struct ins'
> +	 * for this instruction
> +	 */
> +	ins = list_search__ins_powerpc(&head, name);
> +	if (ins)
> +		return ins;
> +
> +	ins = zalloc(sizeof(struct ins));
> +	if (!ins)
> +		return NULL;
> +
> +	ins->name = strdup(name);
> +	if (!ins->name)
> +		goto err;

You can move the above two inside the below if condition, so that you 
only allocate memory if needed.

Or, what would be better would be to pass 'name' and the appropriate ops 
pointer to the helper above (list_add__ins_powerpc) and have that 
allocate 'struct ins' and insert into the list.

> +
> +	if (name[0] == 'b') {
> +		/* branch instructions */
> +		ins->ops = &jump_ops;
> +
> +		/*
> +		 * - Few start with 'b', but aren't branch instructions.
> +		 * - Let's also ignore instructions involving 'ctr' and
> +		 *   'tar' since target branch addresses for those can't
> +		 *   be determined statically.
> +		 */
> +		if (!strncmp(name, "bcd", 3)   ||
> +		    !strncmp(name, "brinc", 5) ||
> +		    !strncmp(name, "bper", 4)  ||
> +		    strstr(name, "ctr")        ||
> +		    strstr(name, "tar"))
> +			goto err;

You are still leaking ins->name here.

- Naveen

> +
> +		i = strlen(name) - 1;
> +		if (i < 0)
> +			goto err;
> +
> +		/* ignore optional hints at the end of the instructions */
> +		if (name[i] == '+' || name[i] == '-')
> +			i--;
> +
> +		if (name[i] == 'l' || (name[i] == 'a' && name[i-1] == 
> 'l')) {
> +			/*
> +			 * if the instruction ends up with 'l' or 'la', then
> +			 * those are considered 'calls' since they update LR.
> +			 * ... except for 'bnl' which is branch if not less than
> +			 * and the absolute form of the same.
> +			 */
> +			if (strcmp(name, "bnl") && strcmp(name, "bnl+") &&
> +			    strcmp(name, "bnl-") && strcmp(name, "bnla") &&
> +			    strcmp(name, "bnla+") && strcmp(name, "bnla-"))
> +				ins->ops = &call_ops;
> +		}
> +		if (name[i] == 'r' && name[i-1] == 'l')
> +			/*
> +			 * instructions ending with 'lr' are considered to be
> +			 * return instructions
> +			 */
> +			ins->ops = &ret_ops;
> +
> +		/*
> +		 * Add instruction to list so next time no need to
> +		 * allocate memory for it.
> +		 */
> +		if (list_add__ins_powerpc(&head, ins) < 0)
> +			goto err;
> +
> +		return ins;
> +	}
> +
> +err:
> +	zfree(&ins);
> +	return NULL;
> +}
> +
>  static void ins__sort(struct ins *instructions, int nmemb)
>  {
>  	qsort(instructions, nmemb, sizeof(struct ins), ins__cmp);
> @@ -511,6 +630,8 @@ static struct ins *ins__find(const char *name, const char *norm_arch)
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
> 
