Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7PDQ4Bl5zDqFx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 00:15:50 +1000 (AEST)
Date: Wed, 19 Apr 2017 16:15:45 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com,
 kan.liang@intel.com, yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 6/7] perf report: Show branch type statistics for
 stdio mode
Message-ID: <20170419141545.GF19643@krava>
References: <1492616894-3635-1-git-send-email-yao.jin@linux.intel.com>
 <1492616894-3635-7-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492616894-3635-7-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 19, 2017 at 11:48:13PM +0800, Jin Yao wrote:

SNIP

> +static void branch_type_stat_display(FILE *fp, struct branch_type_stat *stat)
> +{
> +	u64 total = 0;
> +	int i;
> +
> +	for (i = 0; i < PERF_BR_MAX; i++)
> +		total += stat->counts[i];
> +
> +	if (total == 0)
> +		return;
> +
> +	fprintf(fp, "\n#");
> +	fprintf(fp, "\n# Branch Statistics:");
> +	fprintf(fp, "\n#");
> +
> +	if (stat->jcc_fwd > 0)
> +		fprintf(fp, "\n%12s: %5.1f%%",
> +			"JCC forward",
> +			100.0 * (double)stat->jcc_fwd / (double)total);
> +
> +	if (stat->jcc_bwd > 0)
> +		fprintf(fp, "\n%12s: %5.1f%%",
> +			"JCC backward",
> +			100.0 * (double)stat->jcc_bwd / (double)total);
> +
> +	if (stat->cross_4k > 0)
> +		fprintf(fp, "\n%12s: %5.1f%%",
> +			"CROSS_4K",
> +			100.0 * (double)stat->cross_4k / (double)total);
> +
> +	if (stat->cross_2m > 0)
> +		fprintf(fp, "\n%12s: %5.1f%%",
> +			"CROSS_2M",
> +			100.0 * (double)stat->cross_2m / (double)total);
> +
> +	for (i = 0; i < PERF_BR_MAX; i++) {
> +		if (stat->counts[i] > 0)
> +			fprintf(fp, "\n%12s: %5.1f%%",
> +				branch_type_name(i),
> +				100.0 *
> +				(double)stat->counts[i] / (double)total);
> +	}
> +}

could you please also move this one to that new branch.c file

thanks,
jirka
