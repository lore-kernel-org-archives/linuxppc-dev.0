Return-Path: <SRS0=a/z+=75=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB77AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 09:56:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E742071A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 09:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zrq7TkrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E742071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49mNrX5JWKzDqfS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 19:56:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::441;
 helo=mail-pf1-x441.google.com; envelope-from=viresh.kumar@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Zrq7TkrI; dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49mNpX6dgFzDqZN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2020 19:54:43 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id x22so9255581pfn.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2020 02:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=l9/ZHQGipIrOoq5y2llLzfpy6Wx+X9yAE1JveALeHdc=;
 b=Zrq7TkrI6b0M48sbi6PdxOk9kKcWNUY6JdnA8vPenSSWIPTbMtZR0/46Legu3j0OSS
 YnNL9TXbRkwz90ASeUFJ6Uy1a4XavE1gdm2FtW15G/G328pINz2Am0oyj5axkrSTRAzV
 CON0wC5CK0nBtf8rUhP312tL2EXZV3Ze9RMRnQElpd58mF3TRmP+gswR92sxlHiwTN5H
 FYagGbwhvYogIZNVRlEqC9d8FW1J5hgO6aJM3Abq5kv87hOPHE6xH4/eO3r61lFWPsR2
 7Ke6S337xpp6SvcjG/U6yAKTFsyO9n6DBvlwyzLCHtdYI40slRlewewgdBy9st5wq7Zy
 zcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=l9/ZHQGipIrOoq5y2llLzfpy6Wx+X9yAE1JveALeHdc=;
 b=j513me6g2MNg4KwXPeEQTAq7rayloIMCh2enetji286XLRKiMNaxdLn4/wYsd8cwc9
 OBAWVLUw8HQuWmaeSeY7PpJ2XA8aoKJKSS/1FpBjLcUb9PvrNVUQuJEFOicOkKDogBBP
 kETihVXn2ufKl66gJ8HrkGJ9l2Tv6cEHYeZgDYAn43paWLgm9ce4sFjdxbuWkEj+E+7h
 /Gcb6b5dE8qbZJIjWvcnevvwgbcfVdOsmBLF6ns+8NHmbcCAakH+s7enGgiyNZ3YMawx
 Vq65BWmZkyvgytPppo+ks30RgDimbKNH4bFIcVNXKGLe1szSBkwGGVM76QV1n5Ubnhpq
 3Tqg==
X-Gm-Message-State: AOAM531wRQscj3t+h/9G7vDs9VaEZPebRS5IA08X5xgd+EHR836b1xli
 gSqmMrpTUtULLLtnJ8ThDFSsUw==
X-Google-Smtp-Source: ABdhPJwcFpKI9llvV/hiCbHlmggb6SvTCk47o//zCCLLDejPSv7SyKqdnPffI6cRjZSvsO7NBRr5Cg==
X-Received: by 2002:a62:1704:: with SMTP id 4mr1358860pfx.290.1592301281329;
 Tue, 16 Jun 2020 02:54:41 -0700 (PDT)
Received: from localhost ([122.172.119.132])
 by smtp.gmail.com with ESMTPSA id z186sm14155351pgb.93.2020.06.16.02.54.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jun 2020 02:54:40 -0700 (PDT)
Date: Tue, 16 Jun 2020 15:24:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200616095438.v7wywhfq5ealvyih@vireshk-i7>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-3-qperret@google.com>
 <20200616043143.obk5k3rv737j5dnd@vireshk-i7>
 <20200616083107.GA122049@google.com>
 <20200616092759.rjnk3lef4tedfust@vireshk-i7>
 <20200616094802.GA139416@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616094802.GA139416@google.com>
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
Cc: juri.lelli@redhat.com, kernel-team@android.com, vincent.guittot@linaro.org,
 arnd@arndb.de, rafael@kernel.org, peterz@infradead.org,
 adharmap@codeaurora.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, mingo@redhat.com, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, tkjos@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 16-06-20, 10:48, Quentin Perret wrote:
> ---8<---
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0f05caedc320..a9219404e07f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2340,6 +2340,11 @@ int cpufreq_register_governor(struct cpufreq_governor *governor)
>  		list_add(&governor->governor_list, &cpufreq_governor_list);
>  	}
>  
> +	if (!strncasecmp(cpufreq_param_governor, governor->name, CPUFREQ_NAME_LEN))
> +		default_governor = governor;
> +	else if (!default_governor && cpufreq_default_governor() == governor)
> +		default_governor = cpufreq_default_governor();

Instead of the else part here, maybe just do this from
cpufreq_core_init() only once, and so we will always have
default_governor set.

> +
>  	mutex_unlock(&cpufreq_governor_mutex);
>  	return err;
>  }
> @@ -2368,6 +2373,8 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor)
>  
>  	mutex_lock(&cpufreq_governor_mutex);
>  	list_del(&governor->governor_list);
> +	if (governor == default_governor)
> +		default_governor = cpufreq_default_governor();
>  	mutex_unlock(&cpufreq_governor_mutex);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
> --->8---
> 
> should do the trick. That removes the unnecessary reference count, and
> feels like a good place to hook things -- that is how cpuidle does it
> too IIRC.
> 
> I'll double check the locking/synchronization, but that shouldn't be too
> bad (famous last words).
> 
> Cheers,
> Quentin

-- 
viresh
