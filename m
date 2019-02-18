Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871EEC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 05:01:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33C1218B0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 05:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmkG70WD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33C1218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442sCY0lTqzDqJB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 16:01:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=viresh.kumar@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="gmkG70WD"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442s9W3NBqzDqJB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 15:59:39 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id r14so8121874pls.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 20:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tTLyDYY9MACTqPCtHen/lI1O+0OKAyoxoVlb//Txr7E=;
 b=gmkG70WDl/KqN+NxvA0Y4eP6wemPxBOe8v4Nuiz55FKW0Dzys9op33thu+Y5C+wV0V
 ajisAaCQlWAFm/ry7C+UnKi1Ah7Su4S5frmtl3q7KZQIP/RkcmDUdq+hsZFYKey1oMf8
 q5xC/EcJl4E/2RWTu0W3tEkg2R5Uisuz/IjVraI5fFXjRMkZnfFSQdXvaPuiG3R/DsqQ
 A9kdX/queZbur2dF8JoTP8M74v3Rx5n3d4nod/h+0T2H0OKw8wXs5wUfa1wcYu+gt32X
 jDLV53UDo0v9cKiS+tp5QX+Qx/kjrXxC+fu2+qAXErIGdi7+50X6796iL8egpp3j9mDN
 /8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tTLyDYY9MACTqPCtHen/lI1O+0OKAyoxoVlb//Txr7E=;
 b=j+eq9C9XE2YIyD4XN7NDh7HPXt8H82m/QlaOoFJXN5kLF6RPeJs43S0fZixH2VdQNr
 akUwWbUf8nCCjzlzawIXaZSQZt1pDIXYp/Qzft02N+1gpfroqOcAtaGzr4HJTnR9Koe5
 1tkFFPTRgkh8GV7h16E4pHLjDu/iRVkFJ0b9liQSjA9Sa4tMYpfuWhkNZfg/PfGaTyla
 PfPvMnfvCPyzCV4xm37HkYmF80t8wRVzgyUdvCGMlgvwAZ1dv0wtSW8jhkrP76NrkjKJ
 12eBZDQOcdOgIgVVLnkv4WLow/yM8apMmTfU2SAKs52gR1s7LiNKdANO8dEMVFPrLAVc
 iChw==
X-Gm-Message-State: AHQUAubZl7xkuxbt5+nYD9DEhGMeDEf4VmXH0eDNGUrAOaHSUBje0Cv6
 BqivFFLxzJW2skVMlLFONwubfg==
X-Google-Smtp-Source: AHgI3IaNnxY2xRpGFhKyE4a8/hCHSLvx+Fd0BIKZj8nmuyBe4fjfmsc5vVAfwE4olv3tOXHMHoRRjw==
X-Received: by 2002:a17:902:2c83:: with SMTP id
 n3mr23563478plb.104.1550465977487; 
 Sun, 17 Feb 2019 20:59:37 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id i74sm23402151pfi.33.2019.02.17.20.59.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 20:59:36 -0800 (PST)
Date: Mon, 18 Feb 2019 10:29:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH] cpufreq: powernv: fix missing check of return value in
 init_powernv_pstates()
Message-ID: <20190218045934.5txhn3tumhm3wncn@vireshk-i7>
References: <20190216170623.12634-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216170623.12634-1-tiny.windzz@gmail.com>
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

On 16-02-19, 12:06, Yangtao Li wrote:
> kmalloc() could fail, so insert a check of its return value. And
> if it fails, returns -ENOMEM.
> 
> And remove (struct pstate_idx_revmap_data *) to fix coccinelle WARNING
> by the way.
> 
> WARNING: casting value returned by memory allocation function to (struct
> pstate_idx_revmap_data *) is useless.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 7e7ad3879c4e..d2230812fa4b 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -244,6 +244,7 @@ static int init_powernv_pstates(void)
>  	u32 len_ids, len_freqs;
>  	u32 pstate_min, pstate_max, pstate_nominal;
>  	u32 pstate_turbo, pstate_ultra_turbo;
> +	int rc = -ENODEV;
>  
>  	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
>  	if (!power_mgt) {
> @@ -327,8 +328,11 @@ static int init_powernv_pstates(void)
>  		powernv_freqs[i].frequency = freq * 1000; /* kHz */
>  		powernv_freqs[i].driver_data = id & 0xFF;
>  
> -		revmap_data = (struct pstate_idx_revmap_data *)
> -			      kmalloc(sizeof(*revmap_data), GFP_KERNEL);
> +		revmap_data = kmalloc(sizeof(*revmap_data), GFP_KERNEL);
> +		if (!revmap_data) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
>  
>  		revmap_data->pstate_id = id & 0xFF;
>  		revmap_data->cpufreq_table_idx = i;
> @@ -357,7 +361,7 @@ static int init_powernv_pstates(void)
>  	return 0;
>  out:
>  	of_node_put(power_mgt);
> -	return -ENODEV;
> +	return rc;
>  }
>  
>  /* Returns the CPU frequency corresponding to the pstate_id. */

Applied. Thanks.

-- 
viresh
