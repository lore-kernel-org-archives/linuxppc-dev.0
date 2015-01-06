Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22B5D1A0769
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 20:40:36 +1100 (AEDT)
Date: Tue, 6 Jan 2015 10:40:02 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 2/4] tools/perf: extend format_alias() to include
 event parameters
Message-ID: <20150106094002.GB24841@krava.brq.redhat.com>
References: <1419234567-22784-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1419234567-22784-3-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419234567-22784-3-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, dev@codyps.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 21, 2014 at 11:49:25PM -0800, Sukadev Bhattiprolu wrote:
> From: Cody P Schafer <cody@linux.vnet.ibm.com>
> 
> This causes `perf list pmu` to show parameters for parameterized events
> like:
> 
>   pmu/event_name,param1=?,param2=?/ [Kernel PMU event]
> 
> An example:
> 
>   hv_24x7/HPM_TLBIE__PHYS_CORE,core=?/ [Kernel PMU event]
> 
> Changelog[v6]
> 	[Jir Olsa, Sukadev Bhattiprolu] Drop the '$' sign and go back to
> 	just printing whatevever sysfs provides (which is '=?') to identify
> 	required parameters. sysfs also now uses parameters like 'core'
> 	and 'vcpu' rather than 'starting_index'.
> 
> Changelog[v5]
> 	[Jiri Olsa, Peter Zijlstra] Use '$' to prefix parameterized events.
> 
> Changelog[v4]
> 	[Jiri Olsa] If the parameter for an event in sysfs is 'param=val',
> 	have perf-list show the event as 'param=?' rather than 'val=?'.
> 
> CC: Haren Myneni <hbabu@us.ibm.com>
> CC: Cody P Schafer <dev@codyps.com>
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/pmu.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index cb516dd..d208fef 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -810,10 +810,35 @@ void perf_pmu__set_format(unsigned long *bits, long from, long to)
>  		set_bit(b, bits);
>  }
>  
> +static int sub_non_neg(int a, int b)
> +{
> +	if (b > a)
> +		return 0;
> +	return a - b;
> +}
> +
>  static char *format_alias(char *buf, int len, struct perf_pmu *pmu,
>  			  struct perf_pmu_alias *alias)
>  {
> -	snprintf(buf, len, "%s/%s/", pmu->name, alias->name);
> +	struct parse_events_term *term;
> +	int used = snprintf(buf, len, "%s/%s", pmu->name, alias->name);
> +
> +	list_for_each_entry(term, &alias->terms, list)
> +		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
> +			used += snprintf(buf + used, sub_non_neg(len, used),
> +					",%s=%s", term->config,
> +					term->val.str);

also please enclose above loop and if in {}

jirka
