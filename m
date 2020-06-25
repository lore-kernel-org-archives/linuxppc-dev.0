Return-Path: <SRS0=tFHQ=AG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3685EC433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 11:37:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB78F20781
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 11:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L248HdTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB78F20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49sygC66X1zDqrs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 21:37:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=viresh.kumar@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=L248HdTs; dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49sydP2CHLzDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2020 21:36:09 +1000 (AEST)
Received: by mail-pj1-x1041.google.com with SMTP id l6so113318pjq.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2020 04:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zQMqcazx04oPZQDkNalK3c+oZ7+4RMlmpEj0gizKox0=;
 b=L248HdTsPVnj/dY7XKrltNkz4VYCOnOgsSQfRfZu/tPmRa0oZMbcjKF+5ejsPs/2Y1
 NL5I8SsxCo24n66/lBXA+bygwjzf5iJTi/DZlzUczZbpR7wRK1iWGCbwRKOcb9cvc/f/
 gJslRoo/GTy/cuYo1p55x5m4tK+urvm5yXU10mM1U1oaUKX14HbI3DdE3d16qXqww8Pp
 K0YpNhy99bRpIj+9f5r7EgDls76+B/xn9bxjFPIbXXRc833qLbghfPmrba7L95Y3CKx8
 Yjqh3hPP1F5kprbOpUPbOWSQTvlef3cYCeVh7vnXxZQYLEZRa1if4spadTWe2wiNiiiK
 w8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zQMqcazx04oPZQDkNalK3c+oZ7+4RMlmpEj0gizKox0=;
 b=A3tCDZB1KVOXp34vZNIg9g4ifleB2o53edTo/3RocieL2cmN9k27MhJZE0CWvQStRP
 2XRs6rgzdCFo1c/MGEg/NJnPG0TD4kmhjs536mZc3YyzQvAXmORwiM5FZPFPxQbyR4Rn
 +o6G43sFJgpSbXY4UWLIZFP7tU0AKFw4ZPUg1+itiuSAumJ35wFIE3I7wqoahk2+GsH+
 OxRUoKpQI2l7j1HuOek73/dhDxqNtn9FXeyyKptVoCzZuImSFfxeadw00YdXbb6TKjOb
 sX1jRNMr8rrlS/dZKxz73KoWDaUOIJEeKxYQnNpmjiWbuxbSZQ7nEtgorgtgsq1mc+s4
 lmSA==
X-Gm-Message-State: AOAM530xq2310cJ1ZZ8N1wIOMadLCfL60Swhu4bBJ6DOFLB1jzdsPf31
 nyCvE7AZAhoGrluWdfwJtNJCzQ==
X-Google-Smtp-Source: ABdhPJwuUmK8E9MFP4gCexgTFH6CLEAZn2UkSkrEV9QFJ0/Po7aUxoQVoHBtPpVEHTgbwLK9Ms70Qg==
X-Received: by 2002:a17:902:7787:: with SMTP id
 o7mr9561302pll.327.1593084965635; 
 Thu, 25 Jun 2020 04:36:05 -0700 (PDT)
Received: from localhost ([122.172.111.76])
 by smtp.gmail.com with ESMTPSA id r4sm19096550pgp.60.2020.06.25.04.36.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jun 2020 04:36:04 -0700 (PDT)
Date: Thu, 25 Jun 2020 17:06:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200625113602.z2xrwebd2gngbww3@vireshk-i7>
References: <20200623142138.209513-1-qperret@google.com>
 <20200623142138.209513-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623142138.209513-3-qperret@google.com>
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

After your last email (reply to my patch), I noticed a change which
isn't required. :)

On 23-06-20, 15:21, Quentin Perret wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0128de3603df..4b1a5c0173cf 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -50,6 +50,9 @@ static LIST_HEAD(cpufreq_governor_list);
>  #define for_each_governor(__governor)				\
>  	list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
>  
> +static char cpufreq_param_governor[CPUFREQ_NAME_LEN];
> +static struct cpufreq_governor *default_governor;
> +
>  /**
>   * The "cpufreq driver" - the arch- or hardware-dependent low
>   * level driver of CPUFreq support, and its spinlock. This lock
> @@ -1055,7 +1058,6 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
>  
>  static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  {
> -	struct cpufreq_governor *def_gov = cpufreq_default_governor();
>  	struct cpufreq_governor *gov = NULL;
>  	unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
>  
> @@ -1065,8 +1067,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  		if (gov) {
>  			pr_debug("Restoring governor %s for cpu %d\n",
>  				 policy->governor->name, policy->cpu);
> -		} else if (def_gov) {
> -			gov = def_gov;
> +		} else if (default_governor) {
> +			gov = default_governor;
>  		} else {
>  			return -ENODATA;
>  		}


> @@ -1074,8 +1076,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  		/* Use the default policy if there is no last_policy. */
>  		if (policy->last_policy) {
>  			pol = policy->last_policy;
> -		} else if (def_gov) {
> -			pol = cpufreq_parse_policy(def_gov->name);
> +		} else if (default_governor) {
> +			pol = cpufreq_parse_policy(default_governor->name);

This change is not right IMO. This part handles the set-policy case,
where there are no governors. Right now this code, for some reasons
unknown to me, forcefully uses the default governor set to indicate
the policy, which is not a great idea in my opinion TBH. This doesn't
and shouldn't care about governor modules and should only be looking
at strings instead of governor pointer.

Rafael, I even think we should remove this code completely and just
rely on what the driver has sent to us. Using the selected governor
for set policy drivers is very confusing and also we shouldn't be
forced to compiling any governor for the set-policy case.

-- 
viresh
