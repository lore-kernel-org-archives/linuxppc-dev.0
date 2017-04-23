Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9rbn5f9jzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 23:56:05 +1000 (AEST)
Date: Sun, 23 Apr 2017 15:55:59 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com,
 kan.liang@intel.com, yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 2/7] perf/x86/intel: Record branch type
Message-ID: <20170423135559.GA23073@krava>
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
 <1492690075-17243-3-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492690075-17243-3-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 20, 2017 at 08:07:50PM +0800, Jin Yao wrote:

SNIP

>  
> +#define X86_BR_TYPE_MAP_MAX	16
> +
> +static int
> +common_branch_type(int type)
> +{
> +	int i, mask;
> +	const int branch_map[X86_BR_TYPE_MAP_MAX] = {
> +		PERF_BR_CALL,		/* X86_BR_CALL */
> +		PERF_BR_RET,		/* X86_BR_RET */
> +		PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
> +		PERF_BR_SYSRET,		/* X86_BR_SYSRET */
> +		PERF_BR_INT,		/* X86_BR_INT */
> +		PERF_BR_IRET,		/* X86_BR_IRET */
> +		PERF_BR_JCC,		/* X86_BR_JCC */
> +		PERF_BR_JMP,		/* X86_BR_JMP */
> +		PERF_BR_IRQ,		/* X86_BR_IRQ */
> +		PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
> +		PERF_BR_NONE,		/* X86_BR_ABORT */
> +		PERF_BR_NONE,		/* X86_BR_IN_TX */
> +		PERF_BR_NONE,		/* X86_BR_NO_TX */
> +		PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
> +		PERF_BR_NONE,		/* X86_BR_CALL_STACK */
> +		PERF_BR_IND_JMP,	/* X86_BR_IND_JMP */
> +	};
> +
> +	type >>= 2; /* skip X86_BR_USER and X86_BR_KERNEL */
> +	mask = ~(~0 << 1);

is that a fancy way to get 1 into the mask? what do I miss?

> +
> +	for (i = 0; i < X86_BR_TYPE_MAP_MAX; i++) {
> +		if (type & mask)
> +			return branch_map[i];

I wonder some bit search would be faster in here, but maybe not big deal

jirka

> +
> +		type >>= 1;
> +	}
> +
> +	return PERF_BR_NONE;
> +}
> +
>  /*
