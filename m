Return-Path: <SRS0=XJaO=A2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7029DC433E3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 03:13:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB3020663
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 03:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zr5JWRbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB3020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B62WY6jLczDqfb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 13:12:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::644;
 helo=mail-pl1-x644.google.com; envelope-from=viresh.kumar@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zr5JWRbT; dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B62PS5yHBzDqWM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 13:07:40 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id q17so1306703pls.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2020 20:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=G2eRhXKmTEwTRQanSal/vSTAH9sP+NPQp5iAdhOZfgg=;
 b=zr5JWRbTGLJp8u1/MRQxIwWW/APlv9WqwsvnqgQGG8mSRtvxbJYHVHv43e4/bUsskg
 m9YsiPUcPQSqG9NYzOsapwL/AL0euAzYN+yFHAygI6Rbv2i0iy2VW3erNMQMx6b+o+bK
 CqQ5PR5wRHps18XmeeLDlHBdpaFq4Dbp/NA/AK/UaTjmxhqlqq7ncpED5RPZnusmlFdI
 ZvXa96YRX4SN4a6TVM9u+nBQtNNFuSk2CDQP32u/iJd+rBShWhobxpQlmQ2ErLkN3r24
 F7sZD2wX99im9YbzgEC1lDsjOXAzZS6uDX+t3YnDY9MDgpytN3Tyd90smDlsEZ4i9qRV
 w3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=G2eRhXKmTEwTRQanSal/vSTAH9sP+NPQp5iAdhOZfgg=;
 b=l6QQjNDoEEAcT8wL2w/BqIKqxGKcg/vJ9y+W5HQcR37JpRCtH4M3QsDsQuvHfJJlDa
 68Zk34hYtY79XtdinPV4DVOcZMg+1MDhvZhhiyEdfD7sU8gLAQmCPSr8qorY28s7xxy+
 nSOGL8DfjzNjfjRFFXEtxex7jEe95MTlm14qhmFSX9PZZoIWuE2T4ikvaYlKaWFfCgbY
 ZNHPaTEb8Jg0tJZJ4ii4gLX5aF3pNng6DWFT4lJ3Z3zQoYXjdgqexbDC0XJz8aAXJcus
 YmoGNy8O0La5A4vFwubbCMGMcBo1M1IzjpWSFrfkn6qFtML+IukcWlMp5NMiOa3d3+w/
 YJGA==
X-Gm-Message-State: AOAM531vZ2xPV75gC1HF7V+3IhXEaxHoIZm+QKrK3N6/HD6ZmgWTVV4Z
 jpuEaP+5uO0/rDZslrLKDu1iiQ==
X-Google-Smtp-Source: ABdhPJy6G78yRMtYXULRufyLyim3gEDYCwAAZwkqYmBwjzlqARktEGcx+FHp/26xKL2ZJaDT5cfH6w==
X-Received: by 2002:a17:90a:db02:: with SMTP id
 g2mr7405784pjv.43.1594782456515; 
 Tue, 14 Jul 2020 20:07:36 -0700 (PDT)
Received: from localhost ([122.172.34.142])
 by smtp.gmail.com with ESMTPSA id b15sm465430pga.54.2020.07.14.20.07.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Jul 2020 20:07:35 -0700 (PDT)
Date: Wed, 15 Jul 2020 08:37:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 06/13] cpufreq: powernv-cpufreq: Functions only used in
 call-backs should be static
Message-ID: <20200715030734.3kdqmyr7rjlmrd3h@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-7-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714145049.2496163-7-lee.jones@linaro.org>
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

On 14-07-20, 15:50, Lee Jones wrote:
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
