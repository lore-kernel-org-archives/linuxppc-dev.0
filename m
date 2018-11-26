Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370A0C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 06:05:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8FB20664
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 06:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uu8MIxIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8FB20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433Gbb3GzNzDqPc
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 17:04:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Uu8MIxIQ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=viresh.kumar@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Uu8MIxIQ"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433GXl3F2HzDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 17:02:30 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id g62so6015392pfd.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2018 22:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=r1u8K0n6rtpEId+/esDvsEnjdzMp18LIYOpA/7ZeQoY=;
 b=Uu8MIxIQ/u6lu8ohtjf93as+hA0Zd2C6NjknMQPXBzwwNjnEeCeI8JDVKxZDDV3CqS
 +on5WUIaSl8bAbTBnzT2njhDi/CDIcmVsFfKOId5NgW1ndcoYH8JBBgtnZMHyKzRemm1
 3tQKDl/eUzO1Y//2w/CE4kZzI4CVDPkKjzql8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=r1u8K0n6rtpEId+/esDvsEnjdzMp18LIYOpA/7ZeQoY=;
 b=YOVkg7Lji7O4EEZFfJyjfj5/APGhCh8Dh26AsfEOstlSj9YSX4FUMmOayai2rPaW5X
 3kJtJ+hKq6ajWIhkWRhdb62rVbs/Q8bHT6SwON1UzwI3H/s1jO+Df49lodvIS+gOJmWi
 WujSrIMDXALixKjV6U4rJsWuT2IEkgkKCWEoNsYRFFoCy4oz8VM0WviuCP1lNcqnACbD
 OJ54W54TxyLSDIxu3Jn6713L0WV1ZZBfAMLhcD2cRvnORF2wss1L2pAUa9WiwlcvzW5o
 o7+9qppuuDU6QSXO/EZIUKoOBq6gFVyLbZdGKDdu9yarEbiUJJNmJn/S50jdjb2ekJMV
 9IOQ==
X-Gm-Message-State: AGRZ1gJoyJBkQw77LTMCV1NClx+3QOpJel5T3ZVRnKXwCfpHDGfAelZT
 Hu3+UFljO42B+nb1GqZUOUzncg==
X-Google-Smtp-Source: AJdET5fG6bRXOQmKH6ffUHgy93RTHgYoYpyCII9lbH/0T2Mmz2O8vO4NbsxmmkqDtrXDPKx0E++lOg==
X-Received: by 2002:a62:2e46:: with SMTP id u67mr26073868pfu.3.1543212148919; 
 Sun, 25 Nov 2018 22:02:28 -0800 (PST)
Received: from localhost ([122.172.88.116])
 by smtp.gmail.com with ESMTPSA id y26-v6sm24668763pfi.123.2018.11.25.22.02.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Nov 2018 22:02:28 -0800 (PST)
Date: Mon, 26 Nov 2018 11:32:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH v2] cpufreq: pmac64: add of_node_put()
Message-ID: <20181126060226.wsludir4g7bao4lk@vireshk-i7>
References: <20181123133340.26849-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123133340.26849-1-tiny.windzz@gmail.com>
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

On 23-11-18, 08:33, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> g5_neo2_cpufreq_init() doesn't do that, so fix it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Changes in v2:
> -update changelog
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
