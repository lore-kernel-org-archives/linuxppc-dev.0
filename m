Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp0255fJwzDrLW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 11:21:01 +1100 (AEDT)
Date: Mon, 3 Oct 2016 21:20:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 11/19] perf, tools: Add alias support for long
 descriptions
Message-ID: <20161004002051.GB7143@kernel.org>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1473978296-20712-12-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473978296-20712-12-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Sep 15, 2016 at 03:24:48PM -0700, Sukadev Bhattiprolu escreveu:
> Previously we were dropping the useful longer descriptions that some
> events have in the event list completely. Now that jevents provides
> support for longer descriptions (see previous patch), add support for
> parsing the long descriptions
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> ---

This patch doesn't build, fixing... probably needs stuff that is in a
following patch.

- Arnaldo
 
> Changelog[v14]
> 	- [Jiri Olsa] Break up independent parts of the patch into
> 	  separate patches.
> ---
>  tools/perf/util/parse-events.c |  5 +++--
>  tools/perf/util/parse-events.h |  3 ++-
>  tools/perf/util/pmu.c          | 15 ++++++++++-----
>  tools/perf/util/pmu.h          |  4 +++-
>  4 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index a3c7739..9abd60d 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2229,7 +2229,8 @@ out_enomem:
>  /*
>   * Print the help text for the event symbols:
>   */
> -void print_events(const char *event_glob, bool name_only, bool quiet_flag)
> +void print_events(const char *event_glob, bool name_only, bool quiet_flag,
> +			bool long_desc)
>  {
>  	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
>  			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
> @@ -2239,7 +2240,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag)
>  
>  	print_hwcache_events(event_glob, name_only);
>  
> -	print_pmu_events(event_glob, name_only, quiet_flag);
> +	print_pmu_events(event_glob, name_only, quiet_flag, long_desc);
>  
>  	if (event_glob != NULL)
>  		return;
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 795f2579..7efde4a 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -171,7 +171,8 @@ void parse_events_update_lists(struct list_head *list_event,
>  void parse_events_evlist_error(struct parse_events_evlist *data,
>  			       int idx, const char *str);
>  
> -void print_events(const char *event_glob, bool name_only, bool quiet);
> +void print_events(const char *event_glob, bool name_only, bool quiet,
> +		  bool long_desc);
>  
>  struct event_symbol {
>  	const char	*symbol;
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 2291d2a..43838b3 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -223,7 +223,7 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
>  }
>  
>  static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
> -				 char *desc, char *val)
> +				 char *desc, char *val, char *long_desc)
>  {
>  	struct perf_pmu_alias *alias;
>  	int ret;
> @@ -257,6 +257,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>  	}
>  
>  	alias->desc = desc ? strdup(desc) : NULL;
> +	alias->long_desc = long_desc ? strdup(long_desc) :
> +				desc ? strdup(desc) : NULL;
>  
>  	list_add_tail(&alias->list, list);
>  
> @@ -274,7 +276,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
>  
>  	buf[ret] = 0;
>  
> -	return __perf_pmu__new_alias(list, dir, name, NULL, buf);
> +	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL);
>  }
>  
>  static inline bool pmu_alias_info_file(char *name)
> @@ -532,7 +534,8 @@ static int pmu_add_cpu_aliases(struct list_head *head)
>  
>  		/* need type casts to override 'const' */
>  		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
> -				(char *)pe->desc, (char *)pe->event);
> +				(char *)pe->desc, (char *)pe->event,
> +				(char *)pe->long_desc);
>  	}
>  
>  out:
> @@ -1091,7 +1094,8 @@ static void wordwrap(char *s, int start, int max, int corr)
>  	}
>  }
>  
> -void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
> +void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
> +			bool long_desc)
>  {
>  	struct perf_pmu *pmu;
>  	struct perf_pmu_alias *alias;
> @@ -1139,7 +1143,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
>  			if (!aliases[j].name)
>  				goto out_enomem;
>  
> -			aliases[j].desc = alias->desc;
> +			aliases[j].desc = long_desc ? alias->long_desc :
> +						alias->desc;
>  			j++;
>  		}
>  		if (pmu->selectable &&
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 42999c7..1aa614e 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -39,6 +39,7 @@ struct perf_pmu_info {
>  struct perf_pmu_alias {
>  	char *name;
>  	char *desc;
> +	char *long_desc;
>  	struct list_head terms; /* HEAD struct parse_events_term -> list */
>  	struct list_head list;  /* ELEM */
>  	char unit[UNIT_MAX_LEN+1];
> @@ -70,7 +71,8 @@ int perf_pmu__format_parse(char *dir, struct list_head *head);
>  
>  struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
>  
> -void print_pmu_events(const char *event_glob, bool name_only, bool quiet);
> +void print_pmu_events(const char *event_glob, bool name_only, bool quiet,
> +		      bool long_desc);
>  bool pmu_have_event(const char *pname, const char *name);
>  
>  int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
> -- 
> 1.8.3.1
