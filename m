Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80D9B1A0764
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 20:31:51 +1000 (AEST)
Date: Wed, 3 Jun 2015 12:31:43 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 06/14] perf, tools: Support alias descriptions
Message-ID: <20150603103143.GH1828@krava.redhat.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433265135-20426-7-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433265135-20426-7-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 02, 2015 at 10:12:06AM -0700, Sukadev Bhattiprolu wrote:

SNIP

> @@ -1033,37 +1064,49 @@ void print_pmu_events(const char *event_glob, bool name_only)
>  						       event_glob))))
>  				continue;
>  
> -			if (is_cpu && !name_only)
> +			if (is_cpu && !name_only && !alias->desc)
>  				name = format_alias_or(buf, sizeof(buf), pmu, alias);
>  
> -			aliases[j] = strdup(name);
> -			if (aliases[j] == NULL)
> -				goto out_enomem;
> +			aliases[j].name = name;
> +			if (is_cpu && !name_only && !alias->desc)
> +				aliases[j].name = format_alias_or(buf, sizeof(buf),
> +								  pmu, alias);
> +			aliases[j].name = strdup(aliases[j].name);
> +			/* failure harmless */

yea but we still try to care everywhere.. ;-)
we would print "NULL" for name in the code below right?

please keep the above pattern:

			if (aliases[j].name == NULL)
				goto out_enomem;



> +			aliases[j].desc = alias->desc;
>  			j++;
>  		}
>  		if (pmu->selectable) {
>  			char *s;
>  			if (asprintf(&s, "%s//", pmu->name) < 0)
>  				goto out_enomem;
> -			aliases[j] = s;
> +			aliases[j].name = s;
>  			j++;
>  		}
>  	}
>  	len = j;
> -	qsort(aliases, len, sizeof(char *), cmp_string);
> +	qsort(aliases, len, sizeof(struct pair), cmp_pair);
>  	for (j = 0; j < len; j++) {
>  		if (name_only) {
> -			printf("%s ", aliases[j]);
> +			printf("%s ", aliases[j].name);
>  			continue;
>  		}
> -		printf("  %-50s [Kernel PMU event]\n", aliases[j]);
> +		if (aliases[j].desc) {
> +			if (numdesc++ == 0)
> +				printf("\n");
> +			printf("  %-50s\n", aliases[j].name);
> +			printf("%*s", 8, "[");
> +			wordwrap(aliases[j].desc, 8, columns, 0);
> +			printf("]\n");
> +		} else
> +			printf("  %-50s [Kernel PMU event]\n", aliases[j].name);
>  		printed++;

SNIP
