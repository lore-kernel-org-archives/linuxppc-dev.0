Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B812B1A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 20:30:41 +1000 (AEST)
Date: Wed, 3 Jun 2015 12:30:33 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 03/14] perf, tools: Use pmu_events_map table to
 create event aliases
Message-ID: <20150603103033.GB1828@krava.redhat.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433265135-20426-4-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433265135-20426-4-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 02, 2015 at 10:12:03AM -0700, Sukadev Bhattiprolu wrote:

SNIP

> +
> +/*
> + * From the pmu_events_map, find the table of PMU events that corresponds
> + * to the current running CPU. Then, add all PMU events from that table
> + * as aliases.
> + */
> +static int pmu_add_cpu_aliases(void *data)

any reason why the argument is not 'head' directly?

jirka

> +{
> +	struct list_head *head = (struct list_head *)data;
> +	int i;
> +	struct pmu_events_map *map;
> +	struct pmu_event *pe;
> +	char *cpuid;
> +
> +	cpuid = get_cpuid_str();
> +	if (!cpuid)
> +		return 0;
> +
> +	i = 0;
> +	while (1) {
> +		map = &pmu_events_map[i++];
> +		if (!map->table) {
> +			goto out;
> +		}
> +
> +		if (!strcmp(map->cpuid, cpuid))
> +			break;
> +	}
> +
> +	/*
> +	 * Found a matching PMU events table. Create aliases
> +	 */
> +	i = 0;
> +	while (1) {
> +		pe = &map->table[i++];
> +		if (!pe->name)
> +			break;
> +
> +		/* need type casts to override 'const' */
> +		__perf_pmu__new_alias(head, (char *)pe->name, NULL,
> +				(char *)pe->desc, (char *)pe->event);
> +	}
> +
> +out:
> +	free(cpuid);
> +	return 0;
> +}
> +
> +
>  static struct perf_pmu *pmu_lookup(const char *name)
>  {
>  	struct perf_pmu *pmu;
> @@ -464,6 +540,8 @@ static struct perf_pmu *pmu_lookup(const char *name)
>  	if (pmu_aliases(name, &aliases))
>  		return NULL;
>  
> +	if (!strcmp(name, "cpu"))
> +		(void)pmu_add_cpu_aliases(&aliases);
>  	if (pmu_type(name, &type))
>  		return NULL;
>  
> -- 
> 1.7.9.5
> 
