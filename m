Return-Path: <SRS0=XJaO=A2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EA2C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 09:49:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350FB2067D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 09:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZiDAjjBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350FB2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B6CJl2BRGzDqPv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 19:49:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=viresh.kumar@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ZiDAjjBZ; dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6CD71l0dzDql2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 19:45:10 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id w17so2156809ply.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=4BTTr5oucsR8JbbShHUL2XbMTStwAjQe5P0BncDXj58=;
 b=ZiDAjjBZM/18U5oGdS+177O7tJJlRYSHzUSAe7RuMTwrs0ACtN+bj5Vbw0m+RP4NPH
 FTONJ3j3zDRFBi+lWSl0lFFi7SsWDRcd3haI5usSaW9MdEiP5pSEiaaw6TRA4ipn7D+E
 0PY7Zn85htsoso7JuhFupFcqKQb8r//K9EGlDqKbcPdEA0afofS2/DMj6UdomWTvtScp
 kYjZIsAPHODHik5Xo0NOQXlzKz0x9Roae3Yw6eUgGmnnn8P1/OlOZ7C7HDIkHseLKkUI
 0l2LtzDn74BqqRTB4jYPHTGn2lZk9HZ4dXGm8iF00EjXaN74jT/lxWmYZoqyD9Ncao+T
 cK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=4BTTr5oucsR8JbbShHUL2XbMTStwAjQe5P0BncDXj58=;
 b=jIMn7hGNACE30qjQmT+9mMttTm3tRGMRZiAtGZEttQ+gzhIqmMrkbRav3sgSupUiD8
 0zcXEjsmi6DzpOia/AhKegDsWmI1Mj4+Qr7KWSlm42ije7Jwi2Zl2E/PIc9MMUwX9RpD
 8vKJQQundFhu8bA56jsXmg02/ng1a3UXi0RlOwfA4uTmJ7wxwabwcsQ+g5tgERQ0+gdg
 AJpFtaMTux9UD70LwZwqMJWiN8YKCCth0F87Sod7RbzGX9o0V+RVK5vCPeBnDKp5vRu8
 uP8HoTOyCd8YCvwncbfw3KQOqt5eBeLvFIMCcqNshQDpAKI+TDwJZ5krHiz+89RWR1Au
 QKJw==
X-Gm-Message-State: AOAM532TtYuh640yPk9UpQtWghMHsQUL4QKebd8b9A2yVztfA+PMYIHK
 fgBs5qk7XWitc7ucJjDfUAuzRg==
X-Google-Smtp-Source: ABdhPJyrLXJkqRK/7BhC4BFVruLsng1ogMN6DlNeSjBGIhJnVoVhQXAvhZxEgnc3/B4w8m9S8AXf5Q==
X-Received: by 2002:a17:902:d916:: with SMTP id
 c22mr7404932plz.69.1594806307293; 
 Wed, 15 Jul 2020 02:45:07 -0700 (PDT)
Received: from localhost ([122.172.34.142])
 by smtp.gmail.com with ESMTPSA id z13sm1605674pfq.220.2020.07.15.02.45.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jul 2020 02:45:06 -0700 (PDT)
Date: Wed, 15 Jul 2020 15:15:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 06/13] cpufreq: powernv-cpufreq: Functions only used
 in call-backs should be static
Message-ID: <20200715094504.val6rb7wibysh7dn@vireshk-i7>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
 <20200715082634.3024816-7-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715082634.3024816-7-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
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
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 15-07-20, 09:26, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/cpufreq/powernv-cpufreq.c:669:6: warning: no previous prototype for ‘gpstate_timer_handler’ [-Wmissing-prototypes]
>  drivers/cpufreq/powernv-cpufreq.c:902:6: warning: no previous prototype for ‘powernv_cpufreq_work_fn’ [-Wmissing-prototypes]
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 8646eb197cd96..068cc53abe320 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -666,7 +666,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
>   * according quadratic equation. Queues a new timer if it is still not equal
>   * to local pstate
>   */
> -void gpstate_timer_handler(struct timer_list *t)
> +static void gpstate_timer_handler(struct timer_list *t)
>  {
>  	struct global_pstate_info *gpstates = from_timer(gpstates, t, timer);
>  	struct cpufreq_policy *policy = gpstates->policy;
> @@ -899,7 +899,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  	.notifier_call = powernv_cpufreq_reboot_notifier,
>  };
>  
> -void powernv_cpufreq_work_fn(struct work_struct *work)
> +static void powernv_cpufreq_work_fn(struct work_struct *work)
>  {
>  	struct chip *chip = container_of(work, struct chip, throttle);
>  	struct cpufreq_policy *policy;

Don't you want to drop this patch now ? As you already reviewed the
other one on the list ?

-- 
viresh
