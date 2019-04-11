Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64391C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 20:07:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEB120850
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 20:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/OHgrTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEB120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gBsC3QFjzDqRB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 06:07:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="J/OHgrTK"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gBqV6HJhzDqQX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 06:06:12 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id y13so3955693pfm.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Fj1uFWvOmJpD3UmwZi5Xp9F4935177QKEo3naEvsMCw=;
 b=J/OHgrTKyFI9Y77YJxiuMPWMpYIzOExlqLdh8POog4dA7cKfdhfQ1HuNcOsn7Rrre2
 46LGFu7DfyIQsHWDV9cS5KjBpwztEjT/nIE+cKdDNd6upYqeK3azCNEK4qmH7Bp19vmE
 s/IA06fBnWCIIEtv1izx71K0us2vnc2jjd+YYwJYsA8VnijbAa32kTV5wiqSuJkiAQEI
 lk7pKo18qefedOqgdXJoPEIkM54a9It3OzlgJnwZ8xSwW9Y8xsdjAQ3nz62+PRXHLHly
 g60xGwr66U9Uq6W5QRXBX9aLr47AHGpukXDTAsiaKSOnIf6rR9zYzeQIOsbFHcqif7FB
 6j0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Fj1uFWvOmJpD3UmwZi5Xp9F4935177QKEo3naEvsMCw=;
 b=F2kW/LsoyhazPSKcxIWdJpPitc2Sy3OgE4hT8IavNoCp9w9RTggWXgrxgqdmuOzAMe
 XrBIEfLWjn/T0PSALnWI6Km/7s4CVY1cNAuk2cvLq0I6zZlWMDm29CMzYA+bJqNYEE+R
 LINxJePpi8uFMEzrB8uMeXsR4xr34S5NDRnGjyKbetWN/MDKUqH/TG+CnPuUQGYXP6ln
 o1Q4Skg1wEIIQMJucL80aKlLO5BiziHNHXOxeiQg9K8N5U4miK8e/0nyytpHX2gdgYcQ
 0A5ZaZ8FMyOOl3wEqTrC9I5wSFl0BMQfuO1ZPy12MGu68YajryoyK/n4JGhNJScRs7BM
 1/MA==
X-Gm-Message-State: APjAAAWn0TiQaqCH1uzeNFNvWZyotNPqFeMkFKdf6nH956ETPFjpuDnJ
 pbULOZRM+ghWykFSXd71LUg=
X-Google-Smtp-Source: APXvYqy+PNsMy6Awjlvd8g/cUqHjsuEpim1CbzmDSsniW2DWsC0cgMme7H9N8p4taRY1KpQ5lEyENw==
X-Received: by 2002:a63:6a42:: with SMTP id f63mr48235058pgc.207.1555013168534; 
 Thu, 11 Apr 2019 13:06:08 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id x24sm53749580pfn.128.2019.04.11.13.06.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 11 Apr 2019 13:06:07 -0700 (PDT)
Date: Thu, 11 Apr 2019 13:06:03 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190411200602.GA13170@Asurada-Nvidia.nvidia.com>
References: <cover.1554975348.git.shengjiu.wang@nxp.com>
 <a04859bff36ba26cb4cb51ff092a3f2e2eca455d.1554975348.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a04859bff36ba26cb4cb51ff092a3f2e2eca455d.1554975348.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 11, 2019 at 09:39:06AM +0000, S.j. Wang wrote:
  
> +/*
> + * Select the pre-processing and post-processing options

By aligning with other function comments:
/**
 * Select the pre-processing and post-processing options

> + *
> + * Fsin: input sample rate
> + * Fsout: output sample rate

I would suggest to use inrate and outrate to keep naming consistent.

> + * pre_proc: return value for pre-processing option
> + * post_proc: return value for post-processing option
> + */
> +static int fsl_asrc_sel_proc(int Fsin, int Fsout, int *pre_proc, int *post_proc)
> +{
> +	bool det_out_op2_cond;
> +	bool det_out_op0_cond;

By looking at the comments below. Probably better to rename them
	bool post_proc_cond2, post_proc_cond0;

> +	/* Codition for selection of post-processing */

"Codition" -> "Conditions"

> +	det_out_op2_cond = (((Fsin * 15 > Fsout * 16) & (Fsout < 56000)) |
> +					((Fsin > 56000) & (Fsout < 56000)));

Combining Daniel's comments + indentation alignment:
	det_out_op2_cond = (Fsin * 15 > Fsout * 16 && Fsout < 56000) ||
			   (Fsin > 56000 && Fsout < 56000);

> +	det_out_op0_cond = (Fsin * 23 < Fsout * 8);
> +
> +	/*
> +	 * unsupported case: Tsout>16.125*Tsin, and Tsout>8.125*Tsin.

Funny thing is that there'd be no point in checking the 16.125, if
Tsout is bigger than 8.125 times of Tsin, i.e. only one condition:
	Tsout > 8.125 * Tsin

> +	 * Tsout>16.125*Tsin -> Fsin * 8 > 129 * Fsout
> +	 * Tsout>8.125*Tsin  -> Fsin * 8 > 65 * Fsout
> +	 * Tsout>4.125*Tsin  -> Fsin * 8 > 33 * Fsout
> +	 * Tsout>1.875*Tsin  -> Fsin * 8 > 15 * Fsout

Took me a while to understand what it is saying....

Better to write like this:
	/* Does not support cases: Tsout > 8.125 * Tsin */
	if (Fsin * 8 > 65 * Fsout) {
		pair_err("Does not support %d > 8.125 * %d\n", Fsout, Fsin);
		return -EINVAL;
	}

	/* Otherwise, select pre_proc between [0, 2] */
	if (Fsin * 8 > 33 * Fsout)
> +		*pre_proc = 2;
> +	else if (Fsin * 8 > 15 * Fsout) {
> +		if (Fsin > 152000)
> +			*pre_proc = 2;
> +		else
> +			*pre_proc = 1;
> +	} else if (Fsin < 76000)
> +		*pre_proc = 0;
> +	else if (Fsin > 152000)
> +		*pre_proc = 2;
> +	else
> +		*pre_proc = 1;

<== Would look better by moving post_cond calculations here.

> +	if (det_out_op2_cond)
> +		*post_proc = 2;
> +	else if (det_out_op0_cond)
> +		*post_proc = 0;
> +	else
> +		*post_proc = 1;

And we could remove this check below:
> +	/* unsupported options */
> +	if (*pre_proc == 4 || *pre_proc == 5)
> +		return -EINVAL;

So basically we are doing:
	1) Error out unsupported cases
	2) Select pre_proc
	3) Calculate conditions for post_proc
	4) Select post_proc

Thanks
