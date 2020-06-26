Return-Path: <SRS0=Zm8d=AH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E404EC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 02:55:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8C2206A1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 02:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cld7GXxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8C2206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49tM2N5dGVzDqkD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 12:55:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=viresh.kumar@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cld7GXxL; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49tM0N017PzDqLt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2020 12:53:53 +1000 (AEST)
Received: by mail-pj1-x1044.google.com with SMTP id b7so4099397pju.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2020 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OE2Vo0qG83iB7BMo6JAJNv84RiXgGFQgXdTAJPIwfFc=;
 b=cld7GXxLM80Gcp9eugoMDXHxz/hjT0bnh0DaxZN5lsxVfByA91/he+oQFCAt9j+qcT
 0QJCW0YGkoXAmN2lJZ8Vrjbs3mS5nj+5u0dIAVohlo5Lhw90FN0s+cp1v8GSTPAlcdF2
 tXXDtkIEjHRUonv7SK4Wdhxb5i2197fZ4WdtVoo4eEhvg4F5KQw2zobB+mGPK8VPUdn0
 m9EBR9D6JPLnx/J0OzRt52gGu5OGYVJTqonbfd/FL8zVLi0zP1Z+aiXjZixqmPD1TRUJ
 Tkvnc+DtPbUOG094aIDb3j1liAbmH7dv1zXH+gZUktDQT9A4P6rGR3O1YFSJ9KmS1oJM
 6bPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OE2Vo0qG83iB7BMo6JAJNv84RiXgGFQgXdTAJPIwfFc=;
 b=Y3WYKxA/paLoomQ6PzCd5T1L9x+UqML9T9YgGv78Ll5zZOjZfmf30/5rTklH1JvLZ8
 +11dIqc6XgBojKvd/XvcEMVOhWzu3kzdzXYf2zLas89IMxU4Zm/CSqVOQlLXKq8gNVGC
 lkYtydS7PdgNCwDyus6grIhjRvRm32fqlR2qFduK9BERCgRQOoFB8H0AFp3SxToJB82a
 hDA75SV6HQWMV/KxLj6sAo5qgM2MGZ5j55t4rg4hKsX76hASTx3iW1f2svHxUmnmEYM0
 jaG7m/FX+DXfC5q66+B+Or0uknD2H1tmBsR0WFEUSImtfkaRaC6mZVRksVMUwoR/c7yy
 4KdA==
X-Gm-Message-State: AOAM533xTIMj4eG5GtwN37DU6KxdrhdcIxZSw32yd2RAGH+GlfoaA+f/
 mDmykfy9iUQ8EyTzwq9pTeRK4Q==
X-Google-Smtp-Source: ABdhPJzC8gnl+ASvdyCwQjS7mvY7SDXrNT8HJFNc3QUXgxsHMb+BJL+HfBNqpOHWdy26y6bBKheJkw==
X-Received: by 2002:a17:90b:3685:: with SMTP id
 mj5mr1095889pjb.162.1593140028573; 
 Thu, 25 Jun 2020 19:53:48 -0700 (PDT)
Received: from localhost ([122.172.127.76])
 by smtp.gmail.com with ESMTPSA id fv7sm5997431pjb.22.2020.06.25.19.53.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jun 2020 19:53:47 -0700 (PDT)
Date: Fri, 26 Jun 2020 08:23:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200626025346.z3g3ikdcin56gjlo@vireshk-i7>
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

On 23-06-20, 15:21, Quentin Perret wrote:
> @@ -2789,7 +2796,13 @@ static int __init cpufreq_core_init(void)
>  	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
>  	BUG_ON(!cpufreq_global_kobject);
>  
> +	mutex_lock(&cpufreq_governor_mutex);
> +	if (!default_governor)

Also is this check really required ? The pointer will always be NULL
at this point, isn't it ?

> +		default_governor = cpufreq_default_governor();
> +	mutex_unlock(&cpufreq_governor_mutex);
> +
>  	return 0;
>  }
>  module_param(off, int, 0444);
> +module_param_string(default_governor, cpufreq_param_governor, CPUFREQ_NAME_LEN, 0444);
>  core_initcall(cpufreq_core_init);
> -- 
> 2.27.0.111.gc72c7da667-goog

-- 
viresh
