Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5DA81A1262
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 22:46:19 +1000 (AEST)
Date: Thu, 28 May 2015 14:46:12 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] Use pmu_events_map table to create event aliases
Message-ID: <20150528124612.GM12392@krava.redhat.com>
References: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432761809-4344-4-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432761809-4344-4-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 27, 2015 at 02:23:22PM -0700, Sukadev Bhattiprolu wrote:
> At run time, (i.e when perf is starting up), locate the specific events
> table for the current CPU and create event aliases for each of the events.
> 
> Use these aliases to parse user's specified perf event.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

please prefix the subject with 'perf tools'

SNIP

> +/*
> + * From the pmu_events_map, find the table of PMU events that corresponds
> + * to the current running CPU. Then, add all PMU events from that table
> + * as aliases.
> + */
> +static int pmu_add_cpu_aliases(void *data)
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
> +		if (!map->table)
> +			return 0;

leaking cpuid

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
> +	free(cpuid);
> +
> +	return 0;
> +}

SNIP
