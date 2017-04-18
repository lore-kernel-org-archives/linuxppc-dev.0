Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6vRD26zLzDqC6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 04:53:28 +1000 (AEST)
Date: Tue, 18 Apr 2017 20:53:23 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com,
 kan.liang@intel.com, yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 5/5] perf report: Show branch type in callchain entry
Message-ID: <20170418185323.GB15584@krava>
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

>  static int counts_str_build(char *bf, int bfsize,
>  			     u64 branch_count, u64 predicted_count,
>  			     u64 abort_count, u64 cycles_count,
> -			     u64 iter_count, u64 samples_count)
> +			     u64 iter_count, u64 samples_count,
> +			     struct branch_type_stat *brtype_stat)
>  {
> -	double predicted_percent = 0.0;
> -	const char *null_str = "";
> -	char iter_str[32];
> -	char cycle_str[32];
> -	char *istr, *cstr;
>  	u64 cycles;
> +	int printed, i = 0;
>  
>  	if (branch_count == 0)
>  		return scnprintf(bf, bfsize, " (calltrace)");
>  
> +	printed = branch_type_str(brtype_stat, bf, bfsize);
> +	if (printed)
> +		i++;
> +
>  	cycles = cycles_count / branch_count;
> +	if (cycles) {
> +		if (i++)
> +			printed += scnprintf(bf + printed, bfsize - printed,
> +				" cycles:%" PRId64 "", cycles);
> +		else
> +			printed += scnprintf(bf + printed, bfsize - printed,
> +				" (cycles:%" PRId64 "", cycles);
> +	}
>  
>  	if (iter_count && samples_count) {
> -		if (cycles > 0)
> -			scnprintf(iter_str, sizeof(iter_str),
> -				 " iterations:%" PRId64 "",
> -				 iter_count / samples_count);
> +		if (i++)
> +			printed += scnprintf(bf + printed, bfsize - printed,
> +				" iterations:%" PRId64 "",
> +				iter_count / samples_count);
>  		else
> -			scnprintf(iter_str, sizeof(iter_str),
> -				 "iterations:%" PRId64 "",
> -				 iter_count / samples_count);
> -		istr = iter_str;

could you please put the change from using iter_str
to bf into separate patch before the actual branch
display change?

it's hard to see if anything is broken ;-)

thanks,
jirka
