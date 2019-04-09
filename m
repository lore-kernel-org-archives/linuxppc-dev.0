Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B137C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 03:56:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904CD20883
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 03:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJTJoE0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904CD20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dYPp6zgyzDqMG
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 13:56:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VJTJoE0s"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dYMw2Rd2zDqDY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 13:55:05 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id 10so8873881pfo.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 20:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=n+jzgnswJB1EM35MwPR/p9vjyc/f03FdncL7xqboCFk=;
 b=VJTJoE0s4WNwfXLSIzSbZeKT11Ww2b6z765LFojyA1sI5J+GiHDofbKqbDJXlOz2h4
 uq4AM6qj93GKZb4xwQdR/fjdj672DXReqKAJBxzbAcGXPXQ0AmlsqeF8WNEYeWGCwD6v
 RsVbGubag4xlJSL6idx5vvO9wGqByqEJucCTN7fbhCZ4/aeG0SZYP8mH5pZowBOCyxll
 FTCqBFCEezMF+rRhisHcXr+p8gguj9IjoRXxlDizzEBxe3LdKDVX742dQRNNO4tNg7C5
 4aVnFI+5u0xzv80U7xgBwGzVOE2y5bwFKiW9bjVBZdvBGy5JuCs9M/kEQlmvt7qko0Za
 A9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=n+jzgnswJB1EM35MwPR/p9vjyc/f03FdncL7xqboCFk=;
 b=snXep0FJsHTc6uZgORbUeqggeALF4shC2IJMfFyr39qW6FxQG/OsbHgMYHbGMitwB2
 3VkVhCLJ9NRq0HD/Ai+loN7tsCAvD5D/82uFnrNY1LV1eagsaINGI6pDW344GqMx5PLO
 6vt8lgu4ODjHgXDTB6R2HWEWwXPDlSPtxRAKKiY8RpH/JtV3A+AAZzE63Ijm+8W38kTW
 EYc7Fl6BHixi0CGk6Ap288aNeXeYOGacBRwtN2q5bFMj5tXaPXPScaYZ3o0lNIvJgWjI
 Z/47K/157I0yOWe4bTAbPoD+OAcimDBR1e0zeZ3Q0kxXQ+k5hcfnVcqqfWQDeSGnNEmZ
 j9rw==
X-Gm-Message-State: APjAAAVHYLwml9+ERJwlK6pb5vI3jBvYwPKEACXvAmxIwWqTFjlI8OUv
 pKKIF1zT/fa02BrYpVLlFdLS3JYe
X-Google-Smtp-Source: APXvYqxtVROGvD0nPuFWl2J9Ypnb1Lgavzr71Kpx8SdYMGkiQrHZzd5y5gl/w1FXuFrkcNAkeHF/QA==
X-Received: by 2002:a63:ac12:: with SMTP id v18mr30626530pge.111.1554782101626; 
 Mon, 08 Apr 2019 20:55:01 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 p128sm75039321pfp.30.2019.04.08.20.55.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Apr 2019 20:55:01 -0700 (PDT)
Date: Mon, 8 Apr 2019 20:54:52 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [EXT] Re: [PATCH V1] ASoC: fsl_esai: replace fall-through with
 break
Message-ID: <20190409035450.GA8476@Asurada>
References: <66c117128f300b0ec5f278f538412789c78b60a6.1554715589.git.shengjiu.wang@nxp.com>
 <38a6d36e-0f8e-fe3d-202b-30371042e248@embeddedor.com>
 <VE1PR04MB6479C16BB1C92E1AE291BB12E32D0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <eba6372b-618c-4633-f0a9-06c034cf2f9c@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba6372b-618c-4633-f0a9-06c034cf2f9c@embeddedor.com>
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
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Gustavo,

On Mon, Apr 08, 2019 at 10:20:25PM -0500, Gustavo A. R. Silva wrote:
> >>> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c index
> >>> c7410bbfd2af..bad0dfed6b68 100644
> >>> --- a/sound/soc/fsl/fsl_esai.c
> >>> +++ b/sound/soc/fsl/fsl_esai.c
> >>> @@ -251,7 +251,7 @@ static int fsl_esai_set_dai_sysclk(struct
> >> snd_soc_dai *dai, int clk_id,
> >>>               break;
> >>>       case ESAI_HCKT_EXTAL:
> >>>               ecr |= ESAI_ECR_ETI;
> >>
> >> Also, you should use a simple assignment operator "=" instead of "|=" in
> >> both cases.
> > 
> > The result is same for "=" and "|=", because there is "ecr = 0" in beginning of
> > This function. 
> > 
> 
> Following that same logic, then why not use "+=" instead?
> 
> The point is: is "|=" or any other assignment operator other than "=" necessary?
> The answer in this case is: no, it is not.  So, go for the simple one and avoid
> any unnecessary confusion.

I would like to keep "|=" here, just in case that someday it'd be easier
to insert something to ecr before this chunk. So please get easy on this
one.

Thanks
Nicolin
