Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C3EC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 16:06:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489D3206BA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 16:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489D3206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zDGf2wLrzDrPl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 03:06:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=mark.rutland@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42zDCy6tS8zF3J8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 03:03:58 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A970680D;
 Mon, 19 Nov 2018 08:03:57 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CC013F575;
 Mon, 19 Nov 2018 08:03:55 -0800 (PST)
Date: Mon, 19 Nov 2018 16:03:52 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 09/10] drivers/perf: perf/core: generalise event
 exclusion checking with perf macro
Message-ID: <20181119160352.ua2lx72l754imiek@lakrids.cambridge.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-10-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542363853-13849-10-git-send-email-andrew.murray@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 linux-alpha@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 16, 2018 at 10:24:12AM +0000, Andrew Murray wrote:
> Replace checking of perf event exclusion flags with perf macro.
> 
> This is a functional change as exclude_host and exclude_guest are added
> in the following files:
> 
>  - drivers/perf/qcom_l2_pmu.c
>  - drivers/perf/qcom_l3_pmu.c
>  - drivers/perf/arm_pmu.c
> 
> And exclude_idle and exclude_hv are added in these files:
> 
>  - drivers/perf/xgene_pmu.c

FWIW, that all sounds fine to me.

Assuming you fix up the 'macro' nit:

Acked-by: Mark Rutland <mark.rutland@arm.com>

... unless we go for Peter's core cap for this.

Thanks,
Mark.

> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  drivers/perf/arm-cci.c                   | 7 +------
>  drivers/perf/arm-ccn.c                   | 5 +----
>  drivers/perf/arm_dsu_pmu.c               | 7 +------
>  drivers/perf/arm_pmu.c                   | 9 +--------
>  drivers/perf/hisilicon/hisi_uncore_pmu.c | 7 +------
>  drivers/perf/qcom_l2_pmu.c               | 3 +--
>  drivers/perf/qcom_l3_pmu.c               | 3 +--
>  drivers/perf/xgene_pmu.c                 | 3 +--
>  8 files changed, 8 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> index 1bfeb16..d749f19 100644
> --- a/drivers/perf/arm-cci.c
> +++ b/drivers/perf/arm-cci.c
> @@ -1328,12 +1328,7 @@ static int cci_pmu_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  
>  	/* We have no filtering of any kind */
> -	if (event->attr.exclude_user	||
> -	    event->attr.exclude_kernel	||
> -	    event->attr.exclude_hv	||
> -	    event->attr.exclude_idle	||
> -	    event->attr.exclude_host	||
> -	    event->attr.exclude_guest)
> +	if (event_has_exclude_flags(event))
>  		return -EINVAL;
>  
>  	/*
> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> index 7dd850e..9a22a95 100644
> --- a/drivers/perf/arm-ccn.c
> +++ b/drivers/perf/arm-ccn.c
> @@ -741,10 +741,7 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  	}
>  
> -	if (has_branch_stack(event) || event->attr.exclude_user ||
> -			event->attr.exclude_kernel || event->attr.exclude_hv ||
> -			event->attr.exclude_idle || event->attr.exclude_host ||
> -			event->attr.exclude_guest) {
> +	if (has_branch_stack(event) || event_has_exclude_flags(event)) {
>  		dev_dbg(ccn->dev, "Can't exclude execution levels!\n");
>  		return -EINVAL;
>  	}
> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> index 660cb8a..300ff3d 100644
> --- a/drivers/perf/arm_dsu_pmu.c
> +++ b/drivers/perf/arm_dsu_pmu.c
> @@ -563,12 +563,7 @@ static int dsu_pmu_event_init(struct perf_event *event)
>  	}
>  
>  	if (has_branch_stack(event) ||
> -	    event->attr.exclude_user ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv ||
> -	    event->attr.exclude_idle ||
> -	    event->attr.exclude_host ||
> -	    event->attr.exclude_guest) {
> +	    event_has_exclude_flags(event)) {
>  		dev_dbg(dsu_pmu->pmu.dev, "Can't support filtering\n");
>  		return -EINVAL;
>  	}
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 7f01f6f..a03634f 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -357,13 +357,6 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
>  }
>  
>  static int
> -event_requires_mode_exclusion(struct perf_event_attr *attr)
> -{
> -	return attr->exclude_idle || attr->exclude_user ||
> -	       attr->exclude_kernel || attr->exclude_hv;
> -}
> -
> -static int
>  __hw_perf_event_init(struct perf_event *event)
>  {
>  	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> @@ -395,7 +388,7 @@ __hw_perf_event_init(struct perf_event *event)
>  	 */
>  	if ((!armpmu->set_event_filter ||
>  	     armpmu->set_event_filter(hwc, &event->attr)) &&
> -	     event_requires_mode_exclusion(&event->attr)) {
> +	     event_has_exclude_flags(event)) {
>  		pr_debug("ARM performance counters do not support "
>  			 "mode exclusion\n");
>  		return -EOPNOTSUPP;
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index 9efd241..d3edff9 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> @@ -143,12 +143,7 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  
>  	/* counters do not have these bits */
> -	if (event->attr.exclude_user	||
> -	    event->attr.exclude_kernel	||
> -	    event->attr.exclude_host	||
> -	    event->attr.exclude_guest	||
> -	    event->attr.exclude_hv	||
> -	    event->attr.exclude_idle)
> +	if (event_has_exclude_flags(event))
>  		return -EINVAL;
>  
>  	/*
> diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
> index 842135c..d7d85a2 100644
> --- a/drivers/perf/qcom_l2_pmu.c
> +++ b/drivers/perf/qcom_l2_pmu.c
> @@ -510,8 +510,7 @@ static int l2_cache_event_init(struct perf_event *event)
>  	}
>  
>  	/* We cannot filter accurately so we just don't allow it. */
> -	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv || event->attr.exclude_idle) {
> +	if (event_has_exclude_flags(event)) {
>  		dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
>  				    "Can't exclude execution levels\n");
>  		return -EOPNOTSUPP;
> diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
> index 2dc63d6..f27af67 100644
> --- a/drivers/perf/qcom_l3_pmu.c
> +++ b/drivers/perf/qcom_l3_pmu.c
> @@ -497,8 +497,7 @@ static int qcom_l3_cache__event_init(struct perf_event *event)
>  	/*
>  	 * There are no per-counter mode filters in the PMU.
>  	 */
> -	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv || event->attr.exclude_idle)
> +	if (event_has_exclude_flags(event))
>  		return -EINVAL;
>  
>  	/*
> diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> index 0e31f13..1fcd5a0 100644
> --- a/drivers/perf/xgene_pmu.c
> +++ b/drivers/perf/xgene_pmu.c
> @@ -915,8 +915,7 @@ static int xgene_perf_event_init(struct perf_event *event)
>  		return -EINVAL;
>  
>  	/* SOC counters do not have usr/os/guest/host bits */
> -	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> -	    event->attr.exclude_host || event->attr.exclude_guest)
> +	if (event_has_exclude_flags(event))
>  		return -EINVAL;
>  
>  	if (event->cpu < 0)
> -- 
> 2.7.4
> 
