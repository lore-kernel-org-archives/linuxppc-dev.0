Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247E2C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 04:06:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E7720823
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 04:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRq4gKhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E7720823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ywJX6FY2zF3T4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 15:06:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kRq4gKhA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=viresh.kumar@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="kRq4gKhA"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ywFt01rszF3HS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 15:04:30 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id b85so7343277pfc.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 20:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=W6VB1c2dyfcWsF/AQxV4nxQYdWWfLaBDDIg/sraD0iQ=;
 b=kRq4gKhAYjBd3PG5oXb4Lvtfa4+kO5XhwHoa5tCnlzmHs7SO1bPpz1cUOdoMPZYcVD
 3K1EGYfFPhY3dhvabuoz2g9QVQlgK5LEsX2beWtONGDVdiJ2+ltXe0lqCleF/T1QWMd9
 S743dFXjM1222czClXNd+berTVapGKhNxPdV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=W6VB1c2dyfcWsF/AQxV4nxQYdWWfLaBDDIg/sraD0iQ=;
 b=rcNXFXyLrZR01PkaDH0GZVjIyP4KoWvJPCl42NfRR/Qg43VIegrIcsanW6cBj4JF1O
 uoxqLBcmwnEcyX0VW935XQBqtgzrmdg9IQOfNhwXiNft0nsOcTojE05QOdhYHJO5Kpek
 fer4JAlkUXypQuowFMjW3x49DSpfjEKI3jh9PlUX+BxN9NaTtHmGcD8ZF0EDbk+F7OFs
 9ZVWbAy4adHS/HfcKa9XhcudUEM8AUgitrK8Bhhq3LRs+aFdACJNkziG4PaxKO2zq0fk
 1wKs+hTgeQVMYDAS9m5Y9w5DWpVvXb84BTnpt6HgOs80UnCMcRQAEvybNUBQAZG9939N
 32wg==
X-Gm-Message-State: AGRZ1gJdpPgtP0WIvcUioukMCwSlxHKCfq+9PkXX0zjUTfCXSXxMX9gc
 SBuz7QByODEK+5vO6FsWGEk5sw==
X-Google-Smtp-Source: AJdET5dKkzAKLP8w5l6U/HD09LowaMHm49xfninmrk9lHCfNzYFLPxk+Ze6xWyyLE+vBXUfXg00ekw==
X-Received: by 2002:a63:a064:: with SMTP id u36mr18825475pgn.145.1542600267940; 
 Sun, 18 Nov 2018 20:04:27 -0800 (PST)
Received: from localhost ([122.172.88.116])
 by smtp.gmail.com with ESMTPSA id o13sm6510701pfk.57.2018.11.18.20.04.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Nov 2018 20:04:26 -0800 (PST)
Date: Mon, 19 Nov 2018 09:34:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 1/7] drivers/cpufreq: change CONFIG_6xx to
 CONFIG_PPC_BOOK3S_32
Message-ID: <20181119040423.pbfuszycad66e2qr@vireshk-i7>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
User-Agent: NeoMutt/20180323-120-3dd1ac
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
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 17-11-18, 10:24, Christophe Leroy wrote:
> Today, powerpc has three CONFIG labels which means exactly the same:
> - CONFIG_6xx
> - CONFIG_PPC_BOOK3S_32
> - CONFIG_PPC_STD_MMU_32
> 
> By consistency with PPC64, CONFIG_PPC_BOOK3S_32 is the preferred one.
> Using a label with includes _PPC_ also makes it clearer that it is
> linked to powerpc.
> 
> In preparation of the removal of CONFIG_6xx, this patch replaces it
> by CONFIG_PPC_BOOK3S_32
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  drivers/cpufreq/pmac32-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
> index 61ae06ca008e..52f0d91d30c1 100644
> --- a/drivers/cpufreq/pmac32-cpufreq.c
> +++ b/drivers/cpufreq/pmac32-cpufreq.c
> @@ -128,7 +128,7 @@ static int cpu_750fx_cpu_speed(int low_speed)
>  			mtspr(SPRN_HID2, hid2);
>  		}
>  	}
> -#ifdef CONFIG_6xx
> +#ifdef CONFIG_PPC_BOOK3S_32
>  	low_choose_750fx_pll(low_speed);
>  #endif
>  	if (low_speed == 1) {
> @@ -166,7 +166,7 @@ static int dfs_set_cpu_speed(int low_speed)
>  	}
>  
>  	/* set frequency */
> -#ifdef CONFIG_6xx
> +#ifdef CONFIG_PPC_BOOK3S_32
>  	low_choose_7447a_dfs(low_speed);
>  #endif
>  	udelay(100);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
