Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B49C282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 18:25:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9862222C5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 18:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeQY8qwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9862222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44m4CK68FTzDqVq
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 04:25:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SeQY8qwS"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44m48T59DpzDqVV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 04:22:49 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id 188so2873592pfd.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Mwip4xZezPK38BfWEq5HR+HyqGo66D590Ox/hie+rI0=;
 b=SeQY8qwSDlpnGOISH0mOfevIBeUOKABdZwGg58V61jewHL90Zin0piuB9cXNkucHYB
 NjyqKWIGD8TOXK4SBfQKo//dTl5Mzrmcyex9yTzA3zlgfV7zJPF3adCqL1xLjyrDRTvQ
 RoiMuNuDmU6tvUDSmsYO4cXoDvGObu9Vg2QTTzbH9UlK8iyDtYSe4NCur9F/7kSR5C9T
 emJnwjm5lspYnxE9H0fk6P8AcD/iUT0VQpuBXRRULrhgdduJOsRT9KQAmBiiYem47GmO
 Fl5WvY9lp/tjOvgc261fc/K2Hlao5xws8CHm8wJgn4vhInVhYYKKAS3MWENqay3Q2KhQ
 t9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Mwip4xZezPK38BfWEq5HR+HyqGo66D590Ox/hie+rI0=;
 b=k0bWnMNb+/rVjzJcNQDwWTuWAmdOd1zeDng57jbWFUFWzQW9vSLhCwpzNuq0QEZWfh
 T1Deq/Zn8RxCi8qVQ18cNphZFe4bt0cqsRkouNtR1PtMpf+ZFsBWWCaoQN1xe8ZaLnoK
 qhVva/V0g17GLvQTMJYtNvZARkHolS04k+q9pHsb9yoSdDy+vdqpITH+jElTTz6+0YjP
 iNKqelZ6+Kdy0omo2CS9E1veVgenJ2ME7uoAypinX6eqG28BHG5xb/VuaNLlE3lLoX8q
 LNk1I2h6+A8bLr2NibvnYmcjTJrktsj/t31nTgpeqsZknHET1bGgys18PxI7SWXIcQjc
 R+Xg==
X-Gm-Message-State: APjAAAU+acuIPINzbjkqJhktlZcAuVhcVWC0Plk5r+TeSzNcRnfqeSKF
 c/mkTZgsojt6UEgFBkcq1uM=
X-Google-Smtp-Source: APXvYqzZB8yVOx4IzLDEk4pmvt9DS1y2/Fdc1TFsCUfUddB0JE2Q5EkxCjILiX4x3A/yUhrzhwUJ6g==
X-Received: by 2002:a62:ee0a:: with SMTP id e10mr5392640pfi.6.1555698165677;
 Fri, 19 Apr 2019 11:22:45 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id i15sm7397966pfd.162.2019.04.19.11.22.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 19 Apr 2019 11:22:45 -0700 (PDT)
Date: Fri, 19 Apr 2019 11:22:42 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V4 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190419182241.GB1136@Asurada-Nvidia.nvidia.com>
References: <cover.1555669068.git.shengjiu.wang@nxp.com>
 <0f7a6907c73e110c797b478fedaba2fc47b5e994.1555669068.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f7a6907c73e110c797b478fedaba2fc47b5e994.1555669068.git.shengjiu.wang@nxp.com>
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

On Fri, Apr 19, 2019 at 10:23:53AM +0000, S.j. Wang wrote:

> @@ -289,6 +318,12 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  		return -EINVAL;
>  	}
>  
> +	ret = fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);

Since the function always return 0, I am thinking of treating
this function as a lookup function, and then moving this call
right before the register settings -- as we have already made
sure that both inrate and outrate are supported.

> +	if (ret) {
> +		pair_err("No supported pre-processing options\n");
> +		return ret;
> +	}

And probably no longer need this error-out. If there's a new
limitation related to this function, I believe we can add it
to the rate validation section as we are doing now -- better
to have rate validation code at one place.

> @@ -380,8 +415,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  	/* Apply configurations for pre- and post-processing */

Here:
-  	/* Apply configurations for pre- and post-processing */
+  	/* Select and apply configurations for pre- and post-processing */
+	fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
>  	regmap_update_bits(asrc_priv->regmap, REG_ASRCFG,
>  			   ASRCFG_PREMODi_MASK(index) |	ASRCFG_POSTMODi_MASK(index),
> -			   ASRCFG_PREMOD(index, process_option[in][out][0]) |
> -			   ASRCFG_POSTMOD(index, process_option[in][out][1]));
> +			   ASRCFG_PREMOD(index, pre_proc) |
> +			   ASRCFG_POSTMOD(index, post_proc));
