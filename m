Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE78C10F14
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 03:55:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B27B2133D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 03:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7NQmHJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B27B2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44f9LJ6xwfzDqLn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 13:55:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="I7NQmHJ5"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44f9HS3FXgzDqKq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 13:53:24 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id e6so676887pgc.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 20:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=SM/5AXLtk6i3bXXmIIAUc0/yewscEgZXSH8t8uZkP7o=;
 b=I7NQmHJ5FdABMQ+ZwFSbnd9HwRWd4cpYBkr7F+gpasN3zZk4aKbj3FTIlpp9ZtJhM8
 a6Tr0sNYeBQNG1dwHDSJeVW8LWsl+3DuIgMfNl099AELCJaksJLN2reB8vhXZPP0vf3n
 UvZWD2qudssu1IfJokC6IbfPY8cTZRl6YwS7Gh8bFICONG7yBHM9XNn9aTSq9k2LxKPJ
 PCZPNtD5Xp2+e4writDoR+iIrTmmzvZEEZgAuxWs9p4Y8VaW2pmTZBW+b8YS/kiI3AoR
 /KiBluPQ9V3XFPRszNg/GQqkTxkfbQHcTIIuzGHt/OnbEtLXQistQEncQrefw5UlNjrL
 stxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SM/5AXLtk6i3bXXmIIAUc0/yewscEgZXSH8t8uZkP7o=;
 b=W1cnqYArHNNoy2KTYby7P/4Sln3HkkHIgHyoWXWNh3Pe/6Xhbzx/pZBo1h8Uv0far7
 m6VLSvJZ845s4vv3ajjTZeZSYLBvYU25OT3VfKM79z0GbhZHII+IrNg7aXxQJXvjwcVu
 it094LcrueDxZDmNPBEIieqSYZ0ZE4SG8O47Cez9gFNEni07uiipmPFHt8GvMEfHdcGl
 ESNpmWraueO0uRvufgfnUSQz6OuFwVWL6Q25mLJK7kzqJbh6RxjM8T9t7tTLNhC1sULM
 7Zc8wSlqnophrMsukTEfDbvlvRmnQ65byW5WvTIfqVQKmK82BHNJq8MOEJlOSFPoa19M
 +ktg==
X-Gm-Message-State: APjAAAUl+XcdVF6QhkPUnMnIg3DUkjm1PWB8WmEPWS51FZttjeahiiFQ
 OXYmMKM593d9/rTUV6RDhpM=
X-Google-Smtp-Source: APXvYqwHRrxpwnl6K2dwprX6/aL00qQ/7kQZB2nwpEtQxSw/arQ/BLT5PqPZXThq4lafxInzc3hG5A==
X-Received: by 2002:a63:618d:: with SMTP id v135mr38412200pgb.2.1554868402041; 
 Tue, 09 Apr 2019 20:53:22 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 d20sm51766531pfo.77.2019.04.09.20.53.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Apr 2019 20:53:21 -0700 (PDT)
Date: Tue, 9 Apr 2019 20:53:17 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2] ASoC: fsl_esai: replace fall-through with break
Message-ID: <20190410035317.GA3032@Asurada>
References: <46e9b55edb223894392a90c7cdb6241a43cb9cff.1554864022.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46e9b55edb223894392a90c7cdb6241a43cb9cff.1554864022.git.shengjiu.wang@nxp.com>
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
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 10, 2019 at 02:42:45AM +0000, S.j. Wang wrote:
> case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be independent of
> each other, so replace fall-through with break.
> 
> Fixes: 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
> Changes in v2
> - fix the fixes tag.
> 
>  sound/soc/fsl/fsl_esai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index c7410bbfd2af..bad0dfed6b68 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -251,7 +251,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
>  		break;
>  	case ESAI_HCKT_EXTAL:
>  		ecr |= ESAI_ECR_ETI;
> -		/* fall through */
> +		break;
>  	case ESAI_HCKR_EXTAL:
>  		ecr |= esai_priv->synchronous ? ESAI_ECR_ETI : ESAI_ECR_ERI;
>  		break;
> -- 
> 1.9.1
> 
