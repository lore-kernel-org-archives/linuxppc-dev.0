Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 227D21A08C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 20:21:31 +1000 (AEST)
Date: Fri, 5 Jun 2015 12:21:16 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 09/19] perf, tools: Support alias descriptions
Message-ID: <20150605102017.GA29934@krava.redhat.com>
References: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433485647-9314-10-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433485647-9314-10-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 04, 2015 at 11:27:17PM -0700, Sukadev Bhattiprolu wrote:

SNIP

> ---
>  tools/perf/util/pmu.c |   80 +++++++++++++++++++++++++++++++++++++++----------
>  tools/perf/util/pmu.h |    1 +
>  2 files changed, 66 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 7863d05..e377598 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -241,6 +241,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,

nit, no need for __maybe_unused for 'desc' arg

jirka
>  		perf_pmu__parse_snapshot(alias, dir, name);
>  	}
>  
> +	alias->desc = desc ? strdup(desc) : NULL;
> +
>  	list_add_tail(&alias->list, list);
>  
>  	return 0;
> @@ -989,11 +991,42 @@ static char *format_alias_or(char *buf, int len, struct perf_pmu *pmu,
>  	return buf;

SNIP
