Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6vR43qqYzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 04:53:20 +1000 (AEST)
Date: Tue, 18 Apr 2017 20:53:14 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com,
 kan.liang@intel.com, yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 5/5] perf report: Show branch type in callchain entry
Message-ID: <20170418185314.GA15584@krava>
References: <1491949266-6835-1-git-send-email-yao.jin@linux.intel.com>
 <1491949266-6835-6-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491949266-6835-6-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 12, 2017 at 06:21:06AM +0800, Jin Yao wrote:

SNIP

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
> +	printed += scnprintf(bf + printed, bfsize - printed, " (");
> +
> +	if (stat->jcc_fwd > 0) {
> +		j++;
> +		printed += scnprintf(bf + printed, bfsize - printed,
> +				     "JCC forward");
> +	}
> +
> +	if (stat->jcc_bwd > 0) {
> +		if (j++)
> +			printed += scnprintf(bf + printed, bfsize - printed,
> +					     " JCC backward");
> +		else
> +			printed += scnprintf(bf + printed, bfsize - printed,
> +					     "JCC backward");
> +	}
> +
> +	if (stat->cross_4k > 0) {
> +		if (j++)
> +			printed += scnprintf(bf + printed, bfsize - printed,
> +					     " CROSS_4K");
> +		else
> +			printed += scnprintf(bf + printed, bfsize - printed,
> +					     "CROSS_4K");
> +	}

could that 2 legs if be shortened to just one scnprintf like (untested):

   printed += scnprintf(bf + printed, bfsize - printed, "%s%s", j++ ? " " : "", "CROSS_4K");

I'd also probably use some kind of macro or function
with all that similar code, but I dont insist ;-)

thanks,
jirka
