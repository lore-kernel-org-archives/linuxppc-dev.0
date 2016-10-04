Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp08s1jF2zDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 11:26:53 +1100 (AEDT)
Date: Mon, 3 Oct 2016 21:26:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 12/19] perf, tools: Support long descriptions with
 perf list
Message-ID: <20161004002640.GC7143@kernel.org>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1473978296-20712-13-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473978296-20712-13-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Sep 15, 2016 at 03:24:49PM -0700, Sukadev Bhattiprolu escreveu:
> Previously we were dropping the useful longer descriptions that some
> events have in the event list completely. This patch makes them appear with
> perf list.

Squashed this with 11/19 so that we don't break bisect.
 
> Old perf list:
> 
> baclears:
>   baclears.all
>        [Counts the number of baclears]
> 
> vs new:
> 
> perf list -v:
> ...
> baclears:
>   baclears.all
>        [The BACLEARS event counts the number of times the front end is
>         resteered, mainly when the Branch Prediction Unit cannot provide
> 	a correct prediction and this is corrected by the Branch Address
> 	Calculator at the front end. The BACLEARS.ANY event counts the
>         number of baclears for any type of branch]
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> ---
> 
> Changelog[v15]
> 	- [Jir Olsa, Andi Kleen] Fix usage strings; update man page.
> 
> Changelog[v14]
> 	- [Jiri Olsa] Break up independent parts of the patch into
> 	  separate patches.
> 
> Changelog[v18]:
> 	- Fix minor conflict in tools/perf/builtin-list.c; add long_desc_flag
> 	  parameter to new print_pmu_events() call site.
> 
> Changelog[v21]
> 	- Fix minor conflicts in tools/perf/builtin-list.c
> ---
>  tools/perf/Documentation/perf-list.txt |  6 +++++-
>  tools/perf/builtin-list.c              | 16 +++++++++++-----
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index 72209bc..41857cc 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -8,7 +8,7 @@ perf-list - List all symbolic event types
>  SYNOPSIS
>  --------
>  [verse]
> -'perf list' [--no-desc] [hw|sw|cache|tracepoint|pmu|event_glob]
> +'perf list' [--no-desc] [--long-desc] [hw|sw|cache|tracepoint|pmu|event_glob]
>  
>  DESCRIPTION
>  -----------
> @@ -20,6 +20,10 @@ OPTIONS
>  --no-desc::
>  Don't print descriptions.
>  
> +-v::
> +--long-desc::
> +Print longer event descriptions.
> +
>  
>  [[EVENT_MODIFIERS]]
>  EVENT MODIFIERS
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index b14cb16..ba9322f 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -22,14 +22,17 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
>  {
>  	int i;
>  	bool raw_dump = false;
> +	bool long_desc_flag = false;
>  	struct option list_options[] = {
>  		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
>  		OPT_BOOLEAN('d', "desc", &desc_flag,
>  			    "Print extra event descriptions. --no-desc to not print."),
> +		OPT_BOOLEAN('v', "long-desc", &long_desc_flag,
> +			    "Print longer event descriptions."),
>  		OPT_END()
>  	};
>  	const char * const list_usage[] = {
> -		"perf list [--no-desc] [hw|sw|cache|tracepoint|pmu|sdt|event_glob]",
> +		"perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|event_glob]",
>  		NULL
>  	};
>  
> @@ -44,7 +47,7 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
>  		printf("\nList of pre-defined events (to be used in -e):\n\n");
>  
>  	if (argc == 0) {
> -		print_events(NULL, raw_dump, !desc_flag);
> +		print_events(NULL, raw_dump, !desc_flag, long_desc_flag);
>  		return 0;
>  	}
>  
> @@ -65,14 +68,16 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
>  			 strcmp(argv[i], "hwcache") == 0)
>  			print_hwcache_events(NULL, raw_dump);
>  		else if (strcmp(argv[i], "pmu") == 0)
> -			print_pmu_events(NULL, raw_dump, !desc_flag);
> +			print_pmu_events(NULL, raw_dump, !desc_flag,
> +						long_desc_flag);
>  		else if (strcmp(argv[i], "sdt") == 0)
>  			print_sdt_events(NULL, NULL, raw_dump);
>  		else if ((sep = strchr(argv[i], ':')) != NULL) {
>  			int sep_idx;
>  
>  			if (sep == NULL) {
> -				print_events(argv[i], raw_dump, !desc_flag);
> +				print_events(argv[i], raw_dump, !desc_flag,
> +							long_desc_flag);
>  				continue;
>  			}
>  			sep_idx = sep - argv[i];
> @@ -94,7 +99,8 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
>  			print_symbol_events(s, PERF_TYPE_SOFTWARE,
>  					    event_symbols_sw, PERF_COUNT_SW_MAX, raw_dump);
>  			print_hwcache_events(s, raw_dump);
> -			print_pmu_events(s, raw_dump, !desc_flag);
> +			print_pmu_events(s, raw_dump, !desc_flag,
> +						long_desc_flag);
>  			print_tracepoint_events(NULL, s, raw_dump);
>  			print_sdt_events(NULL, s, raw_dump);
>  			free(s);
> -- 
> 1.8.3.1
