Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sd8qS3HwkzDsd9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 01:26:12 +1000 (AEST)
Date: Mon, 19 Sep 2016 12:26:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, treeze.taeung@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, markus@trippelsdorf.de,
 chris.ryder@arm.com, pawel.moll@arm.com, mhiramat@kernel.org,
 rmk+kernel@arm.linux.org.uk, jolsa@kernel.org, mpe@ellerman.id.au,
 hemant@linux.vnet.ibm.com, namhyung@kernel.org
Subject: Re: [PATCH v6 3/7] perf annotate: Add support for powerpc
Message-ID: <20160919152602.GB4840@kernel.org>
References: <1471611578-11255-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1471611578-11255-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471611578-11255-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Fri, Aug 19, 2016 at 06:29:34PM +0530, Ravi Bangoria escreveu:
> From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> 
> +static struct ins *ins__find_powerpc(const char *name)
> +{
> +	int i;
> +	struct ins *ins;
> +	struct ins_ops *ops;
> +	static struct instructions_powerpc head;
> +	static bool list_initialized;
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
> +	if (!list_initialized) {
> +		INIT_LIST_HEAD(&head.list);
> +		list_initialized = true;
> +	}

Why not ditch list_initialized and instead just declare the list as:

static struct instructions_powerpc head = {
	.list = LIST_HEAD_INIT(head.list),
}

Just like the kernel sources do? See for instance:

  net/core/net_namespace.c

struct net init_net = {
        .dev_base_head = LIST_HEAD_INIT(init_net.dev_base_head),
};

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
> @@ -585,6 +699,8 @@ static struct ins *ins__find(const char *name, const char *norm_arch)
>  	} else if (!strcmp(norm_arch, NORM_ARM)) {
>  		instructions = instructions_arm;
>  		nmemb = ARRAY_SIZE(instructions_arm);
> +	} else if (!strcmp(norm_arch, NORM_POWERPC)) {
> +		return ins__find_powerpc(name);
>  	} else {
>  		pr_err("perf annotate not supported by %s arch\n", norm_arch);
>  		return NULL;
> -- 
> 2.5.5
