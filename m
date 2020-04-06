Return-Path: <SRS0=i/4Y=5W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F53C2BA2B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 22:45:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16CC62072A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 22:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLJPEGqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CC62072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48x5Gp5sD5zDqgk
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 08:45:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kLJPEGqk; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48x5Dq3xtGzDqXL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2020 08:43:54 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id s23so437046plq.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2020 15:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=TU6zRlp6bLsLQvuU0UNh0Rjs9SMeCJnn8DHzXq3NahA=;
 b=kLJPEGqkkgLnVbzA/I1nZdwcgddzzL+2wXZ5Xp1wnWMMVjFPOf3YQaOQy8TL1M0v26
 3zVTMY9m62NSg/FwiRYeADQhn6OD90JCaiQOoLGTOSfHSyRH98rGuTU4k3wUihHLgnoM
 3slUwXsnIbL3ONy473/bh2JtTR12Aj8f9DfVhCGwBDD35ya2UJbjieo3M0XuSZONcaLe
 4NTBLpfwm38kvCsf9/fDWgJlbf9SsZEMzZfQdD7zeT5JZ+/AmrdHAqboOvL2/ycAgkdx
 OmtkjNNiJAORPFexNi771zvXl40gfTZ8znTbAE9+pChnRuB1o2OtQonZU9tDWIsYHnrx
 lLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TU6zRlp6bLsLQvuU0UNh0Rjs9SMeCJnn8DHzXq3NahA=;
 b=Mcbxcd/I9V5LDBX17+tiD1ezmyKWMSY7qh9P9vT98RzHhXiul2F3Cc2747cuGdYZmy
 3cBOFrRHyK8075irZu2IC4Ol8KdaazkdokhJ6pg7nsK8wu0CF81VlTfe0Mf3bMmwPedO
 RvWyaqrlKC5TaA2NiDDJYhsiMVdC+V+YIancF01M/bXHKwAvUcHmR+VW8femOoITp1AW
 /rGpL1NI9e2AkFiQ1WLVJF4eIEWUXpcFZ508t01LAMjGgaw2FhaozI/4ZHFW3v0nwfdw
 Eknkc4AQvmziVBkVzPb0WBzV4yasXQXUVi7Sz9wj8/hLLPlx4mMjDVCiMq2IqbUDqsm0
 V7/Q==
X-Gm-Message-State: AGi0PuZYZ87ubRBvgV6e30s666AX2bIybZXk2eJZ5ayGhEh8TJ7fIXfp
 QTv08AbSb8bE2eydxCSP278=
X-Google-Smtp-Source: APiQypLOSynrL78ItHLA268DR9LFHq6YzYF0pLnuY2yHwnMr2DJQM0F4Xmt3tudbtp848HtDy2ffOQ==
X-Received: by 2002:a17:90a:1911:: with SMTP id
 17mr1755900pjg.65.1586213030402; 
 Mon, 06 Apr 2020 15:43:50 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id l7sm12590717pfl.171.2020.04.06.15.43.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 06 Apr 2020 15:43:50 -0700 (PDT)
Date: Mon, 6 Apr 2020 15:43:52 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v6 2/7] ASoC: dt-bindings: fsl_asrc: Add new property
 fsl,asrc-format
Message-ID: <20200406224352.GA20891@Asurada-Nvidia.nvidia.com>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <47fcf06689d1a086141ce4d80f7ea7af7958dc89.1585726761.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47fcf06689d1a086141ce4d80f7ea7af7958dc89.1585726761.git.shengjiu.wang@nxp.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, perex@perex.cz, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 01, 2020 at 04:45:35PM +0800, Shengjiu Wang wrote:
> In order to support new EASRC and simplify the code structure,
> We decide to share the common structure between them. This bring
> a problem that EASRC accept format directly from devicetree, but
> ASRC accept width from devicetree.
> 
> In order to align with new ESARC, we add new property fsl,asrc-format.
> The fsl,asrc-format can replace the fsl,asrc-width, then driver
> can accept format from devicetree, don't need to convert it to
> format through width.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Once Rob has no objection:
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> index cb9a25165503..998b4c8a7f78 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> @@ -51,6 +51,10 @@ Optional properties:
>  			  will be in use as default. Otherwise, the big endian
>  			  mode will be in use for all the device registers.
>  
> +   - fsl,asrc-format	: Defines a mutual sample format used by DPCM Back
> +			  Ends, which can replace the fsl,asrc-width.
> +			  The value is 2 (S16_LE), or 6 (S24_LE).
> +
>  Example:
>  
>  asrc: asrc@2034000 {
> -- 
> 2.21.0
> 
