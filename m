Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C91C10F14
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:51:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37EFC2075A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHZTd83F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EFC2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nWKx2NPYzDqQV
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 12:51:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="cHZTd83F"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nWJ82rQkzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 12:49:26 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id o7so2873084pll.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 19:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=44t5V0Va2hRnLgBaCtoI5tEHwfneD2rckQNHjjpXMhg=;
 b=cHZTd83Fw7HdPvqNJXw8/4Jq+Wpb37fiJO1sNRwpw3KRZKJA1yzudr5pyIEFyzxfOI
 AvbQP51dtZ2Rt5am5m8id7y12s3fjclxCgil5XopAPX9oufM17K5PStZ8Krw+P+Z/NuS
 d4I1jm7cMDg/s/azMKZIRJlchPqGP7Ssp7JqS7eVEtJmR0rnzcHYLjYXSK9Noma57d64
 DP6J8wuxSATbrDMWRoic62g2okOlNEae9VA7dniddKP+rvsEft9y/BXPNZhLoaZJO9Bz
 Je32fxTCoaB9ZZGfjhOHW/jCU1JQp7D77ZnMn1J9ENbfRCxsF4v15TySOdJBSZoretH2
 guFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=44t5V0Va2hRnLgBaCtoI5tEHwfneD2rckQNHjjpXMhg=;
 b=aHWun5dLu0cSZCYlSBeokU16uPu5GH3vFaoqH95O+G7eGEC/JvmdmGteoC7Ue2/MGv
 kFfvxJNY+TQKv6QVabNci1YpuIRCP+q5Vq5t/3IuL4z9J+V7gbNBrw3auHZddWCgo0/f
 sCoWUyy+oYEoTHL+UrlkCKdEctD8lkBQFgx9TRVFJ83PuuDtp5Qei/PdrpyBm68ZtTxM
 VCJE8vI2Aep1gwZ0xgqFVMhZD7u8AHyhSuBWIW9JdqOOGtxKnHTICDeWGDyMynn1eGHY
 ZShL8Xe26fopwzVAs8W3FbBmvJEUjlTkrfXU4kNZaODVr68y1jV1yVm6wEecf597XVuq
 6sWw==
X-Gm-Message-State: APjAAAWj4X3bf9+Va77phAsxnEaTGVi/t8YgD6DpezGzzAzeovX6eAXB
 JmCyGG6HzIrSEor7bTPbAEo=
X-Google-Smtp-Source: APXvYqykwUTfzLAv7lWudCjeJiurB76tBpVB+neVUYDb3myJ++ktsdAqkhD5lb61YkYx/lrGlkIoRw==
X-Received: by 2002:a17:902:6bc2:: with SMTP id
 m2mr17751238plt.194.1555901363343; 
 Sun, 21 Apr 2019 19:49:23 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 n5sm12727190pgp.80.2019.04.21.19.49.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 Apr 2019 19:49:22 -0700 (PDT)
Date: Sun, 21 Apr 2019 19:49:16 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V5 1/3] ASoC: fsl_asrc: Fix the issue about unsupported
 rate
Message-ID: <20190422024915.GA9768@Asurada>
References: <cover.1555900078.git.shengjiu.wang@nxp.com>
 <a74fe1798ef8f473e11f5e39452664b5e80515df.1555900078.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a74fe1798ef8f473e11f5e39452664b5e80515df.1555900078.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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

On Mon, Apr 22, 2019 at 02:32:32AM +0000, S.j. Wang wrote:
> When the output sample rate is [8kHz, 30kHz], the limitation
> of the supported ratio range is (1/24, 8). In the driver

Should be [1/24, 8].

Otherwise,
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> we use (8kHz, 30kHz) instead of [8kHz, 30kHz].
> So this patch is to fix this issue and the potential rounding
> issue with divider.
> 
> Fixes: fff6e03c7b65 ("ASoC: fsl_asrc: add support for 8-30kHz
> output sample rate")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 0b937924d2e4..ea035c12a325 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -282,8 +282,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  		return -EINVAL;
>  	}
>  
> -	if ((outrate > 8000 && outrate < 30000) &&
> -	    (outrate/inrate > 24 || inrate/outrate > 8)) {
> +	if ((outrate >= 8000 && outrate <= 30000) &&
> +	    (outrate > 24 * inrate || inrate > 8 * outrate)) {
>  		pair_err("exceed supported ratio range [1/24, 8] for \
>  				inrate/outrate: %d/%d\n", inrate, outrate);
>  		return -EINVAL;
> -- 
> 1.9.1
> 
