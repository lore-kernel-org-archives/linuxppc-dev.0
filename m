Return-Path: <SRS0=XJaO=A2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C80C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 03:43:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55252206D5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 03:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNkj1nFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55252206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B63BT3SPszDqgx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 13:43:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=viresh.kumar@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SNkj1nFU; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B638X6kDgzDqX7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 13:41:30 +1000 (AEST)
Received: by mail-pj1-x1044.google.com with SMTP id f16so1889535pjt.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2020 20:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vTG1xamLSWn3+gjpIQxGwQTRUmaQ7UcFDFjtnK+VAKI=;
 b=SNkj1nFUb/t+RuAmTygCKpTD0PfGcdL9in336B12K/AwZ/knTpnpA3PiN0VgEmKaAm
 aR/LFJr2OAohyyNODc8u23ouAF/UnMTM/RIBNY06UXq6ZAvZHqGpYel1z2ZKaNBh6vki
 VzG34DiD7XEui+AXbg33Ir2hM/8L5yP6RcX7o0PIipbNCRjfenSoh0nG3QPRGg90t6+2
 46fZXigjVaRTIDaNtDXIx4vYpq0uqAJZ5oZmocC4CW376L3q8nfiHUCGp7TgphVTAEmc
 tQDKvL9aaKyDMFrRQi7LoyzPLxWt8oa7rp6OTV6M8JJLpbOj14PCYp78dAFyyzb4UWiS
 5uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vTG1xamLSWn3+gjpIQxGwQTRUmaQ7UcFDFjtnK+VAKI=;
 b=VktN/v6+/7gaUr7ucBKgqWLXz3xqugFmVvcNqLt/+wc29ZXvMYoSfdp+h/r1jjN79f
 mSNAK+exbvG+XcU7fjh+7etwGnB612jShlpCuchpRhLqGrj5kcGMKGIXD/QgsKWiZxbu
 CwZ+9EFc2IxJIx4VPizfi57wyagRTVx2jmhgykTiHVM7kFOr7GFznjAUawN/s/QAP9mr
 jTvQeeVyvRB3HmSZFztlRUJWXvvscUKmu/DPKo7JhopgLsceyO+zJfqxJqkWoIoQk+ng
 XvE7gQ+U3MGwu69lvMEc8E3lO39ir/YUjllYWIp3XeccqxLuWUy5/yS1CC1XY4nA7YC+
 8Axg==
X-Gm-Message-State: AOAM533PaqMBbLgySVTl/KWryClKg1qteRVoNAbr1I09P8yxEmgzlDsx
 okKSB/aakL5FgpzS6M3PJ7pE0Q==
X-Google-Smtp-Source: ABdhPJxJqZELAUdvWQzhKMiCqkL3CT9TroksY/E+OgIBdQMY5m4nMaJXdU8P5LtvJ/r9I2eH00/CbA==
X-Received: by 2002:a17:902:c402:: with SMTP id
 k2mr6251062plk.185.1594784488572; 
 Tue, 14 Jul 2020 20:41:28 -0700 (PDT)
Received: from localhost ([122.172.34.142])
 by smtp.gmail.com with ESMTPSA id o18sm534061pfu.138.2020.07.14.20.41.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Jul 2020 20:41:27 -0700 (PDT)
Date: Wed, 15 Jul 2020 09:11:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wei Yongjun <weiyongjun1@huawei.com>, lee.jones@linaro.org
Subject: Re: [PATCH -next] cpufreq: powernv: Make some symbols static
Message-ID: <20200715034125.6x37w3csqmnia2jg@vireshk-i7>
References: <20200714142355.29819-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714142355.29819-1-weiyongjun1@huawei.com>
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
Cc: Hulk Robot <hulkci@huawei.com>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 14-07-20, 22:23, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/cpufreq/powernv-cpufreq.c:88:1: warning:
>  symbol 'pstate_revmap' was not declared. Should it be static?
> drivers/cpufreq/powernv-cpufreq.c:383:18: warning:
>  symbol 'cpufreq_freq_attr_cpuinfo_nominal_freq' was not declared. Should it be static?
> drivers/cpufreq/powernv-cpufreq.c:669:6: warning:
>  symbol 'gpstate_timer_handler' was not declared. Should it be static?
> drivers/cpufreq/powernv-cpufreq.c:902:6: warning:
>  symbol 'powernv_cpufreq_work_fn' was not declared. Should it be static?
> 
> Those symbols are not used outside of this file, so mark
> them static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Lee also sent a fix for this, but yours look complete :)

https://lore.kernel.org/lkml/20200714145049.2496163-7-lee.jones@linaro.org/

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
