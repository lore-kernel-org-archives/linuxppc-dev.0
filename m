Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E94361A08B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 20:31:36 +1000 (AEST)
Date: Wed, 3 Jun 2015 12:31:30 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 03/14] perf, tools: Use pmu_events_map table to
 create event aliases
Message-ID: <20150603103129.GG1828@krava.redhat.com>
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

> @@ -225,26 +221,47 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
>  	alias->unit[0] = '\0';
>  	alias->per_pkg = false;
>  
> -	ret = parse_events_terms(&alias->terms, buf);
> +	ret = parse_events_terms(&alias->terms, val);
>  	if (ret) {
> +		pr_err("Cannot parse alias %s: %d\n", val, ret);
>  		free(alias);
>  		return ret;
>  	}
>  
>  	alias->name = strdup(name);
> +	if (dir) {
> +		/*
> +		 * load unit name and scale if available
> +		 */
> +		perf_pmu__parse_unit(alias, dir, name);
> +		perf_pmu__parse_scale(alias, dir, name);
> +		perf_pmu__parse_per_pkg(alias, dir, name);
> +		perf_pmu__parse_snapshot(alias, dir, name);
> +	}
> +
>  	/*
> -	 * load unit name and scale if available
> +	 * TODO: pickup description from Andi's patchset
>  	 */
> -	perf_pmu__parse_unit(alias, dir, name);
> -	perf_pmu__parse_scale(alias, dir, name);
> -	perf_pmu__parse_per_pkg(alias, dir, name);
> -	perf_pmu__parse_snapshot(alias, dir, name);
> +	//alias->desc = desc ? strdpu(desc) : NULL;

please remove the TODO line and above commented code,
it is addressed later in this patchset

jirka
