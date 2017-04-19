Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7PD84YCczDqFq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 00:15:36 +1000 (AEST)
Date: Wed, 19 Apr 2017 16:15:31 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com,
 kan.liang@intel.com, yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 4/7] perf report: Refactor the branch info printing code
Message-ID: <20170419141531.GD19643@krava>
References: <1492616894-3635-1-git-send-email-yao.jin@linux.intel.com>
 <1492616894-3635-5-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492616894-3635-5-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 19, 2017 at 11:48:11PM +0800, Jin Yao wrote:

SNIP

>  static int counts_str_build(char *bf, int bfsize,
>  			     u64 branch_count, u64 predicted_count,
>  			     u64 abort_count, u64 cycles_count,
>  			     u64 iter_count, u64 samples_count)
>  {
> -	double predicted_percent = 0.0;
> -	const char *null_str = "";
> -	char iter_str[32];
> -	char cycle_str[32];
> -	char *istr, *cstr;
>  	u64 cycles;
> +	int printed = 0, i = 0;
>  
>  	if (branch_count == 0)
>  		return scnprintf(bf, bfsize, " (calltrace)");
>  
>  	cycles = cycles_count / branch_count;
> +	if (cycles)
> +		printed += count_pri64_printf(i++, "cycles",
> +				cycles,
> +				bf + printed, bfsize - printed);
>  
> -	if (iter_count && samples_count) {
> -		if (cycles > 0)
> -			scnprintf(iter_str, sizeof(iter_str),
> -				 " iterations:%" PRId64 "",
> -				 iter_count / samples_count);
> -		else
> -			scnprintf(iter_str, sizeof(iter_str),
> -				 "iterations:%" PRId64 "",
> -				 iter_count / samples_count);
> -		istr = iter_str;
> -	} else
> -		istr = (char *)null_str;
> -
> -	if (cycles > 0) {
> -		scnprintf(cycle_str, sizeof(cycle_str),
> -			  "cycles:%" PRId64 "", cycles);
> -		cstr = cycle_str;
> -	} else
> -		cstr = (char *)null_str;
> +	if (iter_count && samples_count)
> +		printed += count_pri64_printf(i++, "iterations",
> +				iter_count / samples_count,
> +				bf + printed, bfsize - printed);

please put the multiline condition code into {} brackets
for all of the cases in this function

thanks,
jirka
