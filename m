Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D64C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 16:03:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7B020831
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 16:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7B020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zDCq3FGbzF3LY
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 03:03:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=mark.rutland@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42zD9275FMzF3J8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 03:01:26 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04D7A80D;
 Mon, 19 Nov 2018 08:01:25 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A4403F575;
 Mon, 19 Nov 2018 08:01:22 -0800 (PST)
Date: Mon, 19 Nov 2018 16:01:20 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 01/10] perf/core: Add macro to test for event exclusion
 flags
Message-ID: <20181119160119.mp6oq6rt5k4fdrd5@lakrids.cambridge.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-2-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542363853-13849-2-git-send-email-andrew.murray@arm.com>
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

On Fri, Nov 16, 2018 at 10:24:04AM +0000, Andrew Murray wrote:
> Add a macro that tests if any of the perf event exclusion flags
> are set on a given event.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Aside from the s/macro/function, or s/macro/helper/, this looks sound to
me.

Assuming you fix that up here and in subsequent commit messages, for
this patch feel free to add:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  include/linux/perf_event.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 53c500f..89ee7fa 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1004,6 +1004,15 @@ perf_event__output_id_sample(struct perf_event *event,
>  extern void
>  perf_log_lost_samples(struct perf_event *event, u64 lost);
>  
> +static inline bool event_has_exclude_flags(struct perf_event *event)
> +{
> +	struct perf_event_attr *attr = &event->attr;
> +
> +	return attr->exclude_idle || attr->exclude_user ||
> +	       attr->exclude_kernel || attr->exclude_hv ||
> +	       attr->exclude_guest || attr->exclude_host;
> +}
> +
>  static inline bool is_sampling_event(struct perf_event *event)
>  {
>  	return event->attr.sample_period != 0;
> -- 
> 2.7.4
> 
