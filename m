Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B8A01A0D0F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 May 2015 01:38:32 +1000 (AEST)
Date: Sat, 2 May 2015 17:38:14 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 4/4] perf: Create aliases for PMU events
Message-ID: <20150502153814.GA21242@krava.redhat.com>
References: <1430463941-26109-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1430463941-26109-5-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430463941-26109-5-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: ak@linux.intel.com, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 01, 2015 at 12:05:41AM -0700, Sukadev Bhattiprolu wrote:

SNIP

> +
> +static int pmu_add_cpu_aliases(char *cpustr, void *data)
> +{
> +	struct list_head *head = (struct list_head *)data;
> +	struct perf_pmu_alias *alias;
> +	int i;
> +	struct perf_pmu_event *events_table, *event;
> +	struct parse_events_term *term;
> +
> +	events_table = arch_get_events_table(cpustr);
> +	if (!events_table)
> +		return 0;
> +
> +	for (i = 0; events_table[i].name != NULL; i++) {
> +		event = &events_table[i];
> +
> +		alias = malloc(sizeof(*alias));
> +		if (!alias)
> +			return -ENOMEM;
> +
> +		term = malloc(sizeof(*term));
> +		if (!term) {
> +			/*
> +			 * TODO: cleanup aliases allocated so far?
> +			 */
> +			free(alias);
> +			return -ENOMEM;
> +		}
> +
> +		/* ->config is not const; cast to override */
> +		term->config = (char *)"event";
> +		term->val.num = event->code;
> +		term->type_val = PARSE_EVENTS__TERM_TYPE_NUM;
> +		term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
> +		INIT_LIST_HEAD(&term->list);
> +		term->used = 0;

hum, so I checked and for x86 the 'struct perf_pmu_event::code' is not enough

Andi introduced following JSON notation for event:

[
  {
    "EventCode": "0x00",
    "UMask": "0x01",
    "EventName": "INST_RETIRED.ANY",
    "BriefDescription": "Instructions retired from execution.",
    "PublicDescription": "Instructions retired from execution.",
    "Counter": "Fixed counter 1",
    "CounterHTOff": "Fixed counter 1",
    "SampleAfterValue": "2000003",
    "MSRIndex": "0",
    "MSRValue": "0",
    "TakenAlone": "0",
    "CounterMask": "0",
    "Invert": "0",
    "AnyThread": "0",
    "EdgeDetect": "0",
    "PEBS": "0",
    "PRECISE_STORE": "0",
    "Errata": "null",
    "Offcore": "0"
  }

which gets processed/translated into string of terms "event=..,umask=,..."
which is used to create alias 'struct perf_pmu_alias'

please check Andi's patch:
  [PATCH v9 04/11] perf, tools: Add support for reading JSON event files

  function json_events


I wonder we should stay with JSON description during build time
translate all (for architecture) events into strings in term format
"event=..,umask=,...'  and this array of string would be loaded
as aliases in runtime

so we would have architecture specific tool that would translate
JSON events data into array of strings (events in terms form for
given architecture) which would get compiled into perf

I personaly like having set of event files in JSON notation
rather than having them directly in C structure

thoughts?

jirka
