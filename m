Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D17C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 04:02:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488BC2145D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 04:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dm+hdtdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488BC2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4308601RxtzF3cx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 15:02:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dm+hdtdQ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=viresh.kumar@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dm+hdtdQ"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43083C1rMczF3cl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 14:59:35 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id v1-v6so3456854plo.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 19:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WLVfDtgQ6dMyB51L8SjOel24v6nbaFrKazs5k12L7JM=;
 b=Dm+hdtdQ7e2DxFOxslOBy1kf+z/7GfVyHKMA75HDhGlDJbiMXbnqHrkk5l0gHI7TC/
 inVbLDLPSdgY8Igc9CyeqZxzI627+2oESyRD6D3n7mu9t4/DiGkycUqYEK8oNoV5TNui
 +O0mipytwm9p3rmA5N1jGE7FdFlc55y0+QAqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WLVfDtgQ6dMyB51L8SjOel24v6nbaFrKazs5k12L7JM=;
 b=DXe1CQ8P1mp3T3URU1wGdzJvq/lVYweB4KXFW+t0I84ssW2RIKrURJ9XvJFa1bYLf2
 ANfnLTOin9uqNLT0062f01sfiX3bjC8eraXoMwVO8CEVeOMnxPD317vP2xJLSXSsxmfy
 G6j1Jxb7ngUNEZyTrLz6iRM2XwDqxcUxEBA5J/tYXq11zy3vTGLO5GCRkF2vIKuloUIf
 59Qxebf+ger3nPFqtlIA1x9AWpPyr5JwcpqUfLS8yx1U4rS7hqK4MJsoC8qtu1nlPmkT
 K2mMn9LHuDPvhbHLQQXzEsWC/QqghzjP5zSww5AhtOFqX+CQug+P8v+IzXsYlyw8Pwd8
 eddw==
X-Gm-Message-State: AA+aEWaI6IOCgjcUz8Zxs7KGN0nGHw3aIfb/Y5tX8ny2lRJL2C1R4j5q
 7tRNcXWNX2VlaIrke1DkqEhJmg==
X-Google-Smtp-Source: AFSGD/X2gxcamV/45/9rwmm/ng7Hsx5N9QgQKGtMRuT8RfPpWhca6zTlDbsHA3YwRuB8fLSZxNYxjA==
X-Received: by 2002:a17:902:76c2:: with SMTP id
 j2mr5142138plt.339.1542772772901; 
 Tue, 20 Nov 2018 19:59:32 -0800 (PST)
Received: from localhost ([122.172.88.116])
 by smtp.gmail.com with ESMTPSA id i63-v6sm11568838pfi.66.2018.11.20.19.59.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Nov 2018 19:59:31 -0800 (PST)
Date: Wed, 21 Nov 2018 09:29:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH] cpufreq: pmac64: add of_node_put()
Message-ID: <20181121035925.67fsysw6jyswb3op@vireshk-i7>
References: <20181120125409.19314-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120125409.19314-1-tiny.windzz@gmail.com>
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
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 20-11-18, 07:54, Yangtao Li wrote:
> use of_node_put to release the refcount of node.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/pmac64-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
> index be623dd7b9f2..1d32a863332d 100644
> --- a/drivers/cpufreq/pmac64-cpufreq.c
> +++ b/drivers/cpufreq/pmac64-cpufreq.c
> @@ -411,6 +411,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
>  		pfunc_set_vdnap0 = pmf_find_function(root, "set-vdnap0");
>  		pfunc_vdnap0_complete =
>  			pmf_find_function(root, "slewing-done");
> +		of_node_put(root);
>  		if (pfunc_set_vdnap0 == NULL ||
>  		    pfunc_vdnap0_complete == NULL) {
>  			pr_err("Can't find required platform function\n");

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
