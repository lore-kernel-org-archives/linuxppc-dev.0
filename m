Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93674C282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 18:11:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2B2222E6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 18:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwCw9SHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2B2222E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44m3vn4tfvzDqWc
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 04:11:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SwCw9SHk"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44m3sz0ZglzDqVT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 04:10:12 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id p6so2963317pgh.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 11:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8DHK4rYDwWPVNuuRQozpzQhPs53i6eTIw/NWHTPBpUw=;
 b=SwCw9SHkBEdf0FNwY3ddHfVt/5MXgvQz8yLP6w+50L7rBCJTPluD7bwwgk4+1Wl1Kz
 5IAjZaOb6rtGAjK9pbFCcTXW3IrwKt+9noZyd+6mQ/5kGe/c9dUp3EwlqSwS1ywQMsSD
 QZY6XymID6Nl8Pq01a9OmT64PczfAR1cF6Xn/fM/sdubY9RfrCT6hqElx/m8RJDQkoYW
 /iRoT07AnZ1mvW6PSt0sgl7Ab56eLwwj3lvm+lubyo65xPl+UEI1dASI32AsYQAfMKIN
 xYLabW3+MuWY3sQHXKl+knWnBgRmj59ZaM7HhzJI6bplqm8AYTlO6tpEm0GImFXLTvKS
 c3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8DHK4rYDwWPVNuuRQozpzQhPs53i6eTIw/NWHTPBpUw=;
 b=EMLxpqD5JqTxHfsHN/qCT9SS1Djk1tDBXmDYfFL4l57LXLqYK9j5GC94d/xiVhXB63
 m0jllcffvge6Bc9IauLFAR1JvPmF4A6r0YMvDZtTGxr1AyBQd5sm8krjl/eBC5v8/PGV
 9hAxHL0OT7ZXv0KaHZHmzFYXLTiu7Sb2s7xq0oVnGTOSPClqHMHCt4Pd0IPNwKHNkeps
 g07PSV0sbsVzJCMieDrbyV5kQECFSljpX6z0U4URd35MsLXoiXbLkSWKirwjWnV6sGVU
 E5qCwXZ0zZQ3hUa0PB9XXTBGXNQa6FtozCarpTAZcYqSH7lijLng2Wd9AORb3ER3iUyJ
 zdng==
X-Gm-Message-State: APjAAAXhU21IFchAMlX9IUZPmrjD2QiH3AOEnYzmj0hZnD0MX8RKWwXq
 ufSPPUIo6QbpgeSph7n4gVM=
X-Google-Smtp-Source: APXvYqxXTtMHqYYynxTETSbHUOU21HgptNIMEddHodFNpZQSo9L8d6bCM19EOo6YY03u1fW/a6agzg==
X-Received: by 2002:a63:d84a:: with SMTP id k10mr5084606pgj.441.1555697409412; 
 Fri, 19 Apr 2019 11:10:09 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id i129sm9382006pfc.163.2019.04.19.11.10.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 19 Apr 2019 11:10:09 -0700 (PDT)
Date: Fri, 19 Apr 2019 11:10:03 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V4 1/3] ASoC: fsl_asrc: Fix the issue about unsupported
 rate
Message-ID: <20190419181003.GA1136@Asurada-Nvidia.nvidia.com>
References: <cover.1555669068.git.shengjiu.wang@nxp.com>
 <06c3e420b9fabfbec67becc2f9de009ce79a1d4b.1555669068.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c3e420b9fabfbec67becc2f9de009ce79a1d4b.1555669068.git.shengjiu.wang@nxp.com>
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

On Fri, Apr 19, 2019 at 10:23:50AM +0000, S.j. Wang wrote:
> When the output sample rate is [8kHz, 30kHz], the limitation
> of the supported ratio range is (1/24, 8). In the driver
> we use (8kHz, 30kHz) instead of [8kHz, 30kHz].
> So this patch is to fix this issue and the potential rounding
> issue with divider.
> 
> Fixes: fff6e03c7b65 ("ASoC: fsl_asrc: add support for 8-30kHz
> output sample rate")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 0b937924d2e4..5b8adc7fb117 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -282,10 +282,10 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  		return -EINVAL;
>  	}
>  
> -	if ((outrate > 8000 && outrate < 30000) &&
> -	    (outrate/inrate > 24 || inrate/outrate > 8)) {
> -		pair_err("exceed supported ratio range [1/24, 8] for \
> -				inrate/outrate: %d/%d\n", inrate, outrate);
> +	if ((outrate >= 8000 && outrate <= 30000) &&
> +	    (outrate > 24 * inrate || inrate > 8 * outrate)) {
> +		pair_err("exceed supported ratio range (1/24, 8) for inrate/outrate: %d/%d\n",

Using one of the conditions:
	if (inrate > 8 * outrate)
		pair_err();

This means:
	if (inrate <= 8 * outrate)
		/* Everything is fine */

So the supported ratio range is still [1/24, 8] right?

Thanks
