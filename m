Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7PDH2nJZzDqFT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 00:15:43 +1000 (AEST)
Date: Wed, 19 Apr 2017 16:15:38 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com,
 kan.liang@intel.com, yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 7/7] perf report: Show branch type in callchain entry
Message-ID: <20170419141538.GE19643@krava>
References: <1492616894-3635-1-git-send-email-yao.jin@linux.intel.com>
 <1492616894-3635-8-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492616894-3635-8-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 19, 2017 at 11:48:14PM +0800, Jin Yao wrote:

SNIP

> +static int count_str_printf(int index, const char *str,
> +	char *bf, int bfsize)
> +{
> +	int printed;
> +
> +	printed = scnprintf(bf, bfsize,
> +		"%s%s",
> +		(index) ? " " : " (", str);
> +
> +	return printed;
> +}
> +
> +static int branch_type_str(struct branch_type_stat *stat,
> +			   char *bf, int bfsize)
> +{
> +	int i, j = 0, printed = 0;
> +	u64 total = 0;
> +
> +	for (i = 0; i < PERF_BR_MAX; i++)
> +		total += stat->counts[i];
> +
> +	if (total == 0)
> +		return 0;
> +
> +	if (stat->jcc_fwd > 0)
> +		printed += count_str_printf(j++, "JCC forward",
> +				bf + printed, bfsize - printed);
> +
> +	if (stat->jcc_bwd > 0)
> +		printed += count_str_printf(j++, "JCC backward",
> +				bf + printed, bfsize - printed);
> +
> +	for (i = 0; i < PERF_BR_MAX; i++) {
> +		if (i == PERF_BR_JCC)
> +			continue;
> +
> +		if (stat->counts[i] > 0)
> +			printed += count_str_printf(j++, branch_type_name(i),
> +					bf + printed, bfsize - printed);
> +	}
> +
> +	if (stat->cross_4k > 0)
> +		printed += count_str_printf(j++, "CROSS_4K",
> +				bf + printed, bfsize - printed);
> +
> +	if (stat->cross_2m > 0)
> +		printed += count_str_printf(j++, "CROSS_2M",
> +				bf + printed, bfsize - printed);
> +
> +	return printed;
> +}

could you please also move this one to that new branch.c file

thanks,
jirka
