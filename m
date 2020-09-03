Return-Path: <SRS0=NZKl=CM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7471EC433E2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 03:42:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24BE12080C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 03:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvyXWN2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BE12080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bhmpm2p9JzDqxq
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 13:42:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::444;
 helo=mail-pf1-x444.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=lvyXWN2O; dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bhmmz3lNCzDqxd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2020 13:41:07 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id o20so1101312pfp.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2020 20:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZBeaj4GslqMe7lBSDn/HfENqDsSeU06fhFfemnqQHrs=;
 b=lvyXWN2OCgC6gJzpb3Z1iQXwUlrghIjBMO3LVlTBotvEtrri2tbmSI+QbAcu9NNk+3
 xD8WkDH7VB8w5fWoJFXkRBzc6PwVWRVy2CJUBQwZYa+AHVfTiful/lvI21qyMGPcvK9M
 fRdJGomPzh9cVQIQcRRGEZqV+JcnfruIZJ3P2I0lLoNGHtL0uSEONY/cCPrIpb/ZMLMr
 fYLJRqg+xeZaD6sTMJmxwfsj5i+S8j0b7uUkgTEuoWYkV32rXAgx8QfhbHwd2EwLMx7R
 FqSaz/cd0d69vDp4XhTzuBrNYbnu0CwDJ7pkkTdVqAWh2TN8FU2N43NAbqKJ9hYpBixf
 YZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZBeaj4GslqMe7lBSDn/HfENqDsSeU06fhFfemnqQHrs=;
 b=f8HoViQLjDS2A7zwPpfhUCMnwy05fl2Hz6RpeuQasttGEWJg+r5Zm2yLGWw6VA8jyR
 pKGxNlQWhSBYbaOikV4UAKVj7ltQ+bxndQWudWKaKb27K3D14XTcza+R13ZEljUabt4n
 kBe4yexZQYAbVLY58HV3C8WWbtlMTN3MvkD4YZLfJ3ej4/dpTfqd8sb29dDBsap8+zyS
 xQ5lkUDClq5cCHN62SMLuEnnjE5sVBHAnaB5C5Fl5lS8vlcDrMpXFAc4eurW8fpsVkCI
 EiduufKc2YfeHiJwpvkJFKJTKWgWVlCNubnBa86q4rPXOFhFeNsxY1l/xFaUY9+Ow/Ft
 NjDg==
X-Gm-Message-State: AOAM5322n5AQtZN3Vae8rVJh8WoDqLVmSxlRTLQuAzOCuSE/YGa07cV0
 rJtyCNiD/t5AmVLKuLxIY8c=
X-Google-Smtp-Source: ABdhPJya4MbfYMPJGamccyeZvWUKTgUg99OxovxOa46VtlzI1OXbxU1wx4FTT7tNScnfNz4lR9HKCg==
X-Received: by 2002:a63:4a09:: with SMTP id x9mr1069530pga.291.1599104463748; 
 Wed, 02 Sep 2020 20:41:03 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id 187sm1067061pfx.174.2020.09.02.20.41.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 02 Sep 2020 20:41:03 -0700 (PDT)
Date: Wed, 2 Sep 2020 20:40:19 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Set SAI Channel Mode to Output Mode
Message-ID: <20200903034018.GC4517@Asurada-Nvidia>
References: <1599102555-17178-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599102555-17178-1-git-send-email-shengjiu.wang@nxp.com>
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
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 perex@perex.cz, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 03, 2020 at 11:09:15AM +0800, Shengjiu Wang wrote:
> Transmit data pins will output zero when slots are masked or channels
> are disabled. In CHMOD TDM mode, transmit data pins are tri-stated when
> slots are masked or channels are disabled. When data pins are tri-stated,
> there is noise on some channels when FS clock value is high and data is
> read while fsclk is transitioning from high to low.
> 
> Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Though one nit inline:

> ---
>  sound/soc/fsl/fsl_sai.c | 12 ++++++++++--
>  sound/soc/fsl/fsl_sai.h |  2 ++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 62c5fdb678fc..33b194a5c1dc 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -486,6 +486,12 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  
>  	val_cr4 |= FSL_SAI_CR4_FRSZ(slots);
>  
> +	/* Output Mode - data pins transmit 0 when slots are masked
> +	 * or channels are disabled
> +	 */

Coding style for multi-line comments. Yet, probably can simplify?

	/* Set to output mode to avoid tri-stated data pins */
