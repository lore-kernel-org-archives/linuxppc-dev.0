Return-Path: <SRS0=Lnkm=BC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB903C433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 05:34:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E38820768
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 05:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWSfNpBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E38820768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BC1H30qlVzDr7k
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 15:34:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=YWSfNpBy; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BC1Dv5wD3zDr7Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2020 15:32:31 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id o1so2052692plk.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 22:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Azbmlb+o4Fr+IIKuyAGgLbUxH3riL3SrFDqan1+Q4+M=;
 b=YWSfNpBy8DiSuE3KFCrrd51VFavpYZSf4IehxS6pt8vfV3qMCkCsreyShiAT+R6fLD
 6qcazoBPEvtCcEetZPDLBMsmAkp/v04ZW2cFFN/fKnHjv5h5IrzMocedHYgsxY0o/h1B
 uPSIU/Hf/OjdnrB+uczzCWgglf1A18DgHCT2oE2nzSi0LbZfLC+RYMLZWZnHPXRkklNE
 Z4lYNPZPXOTM5HoPTmTowANjCDl5E8vWiEVQkrN2qXyWmD5lNLX6pdb9HBxeuqsKshjL
 Ap/eOsPLMJZ5hTQECt33KdoA71jPCi+qMVdRx97wTmDFnSSjPPqn8LGMYYaU17giriRU
 Q8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Azbmlb+o4Fr+IIKuyAGgLbUxH3riL3SrFDqan1+Q4+M=;
 b=cPvMX8uLDM90nL9cnpYhM5QQnehGPda+x4RitTYRC34/YfjAmwzD0EJeQN+eYqxFHj
 a9LS8Mv+9OAnDB2I29Uev+SE6PtcD6aoElxtIEc70kVaQnk6+G2/beIvNBgVKT/e2sQS
 sAvrdCG26w+v5XBT9eWm0wOozy76HWBUSXPlYayM1cwacaq6zjI2kvEIKRQLAfz6dTZX
 wd8aH8WC1cvjeT56uRhRzOaait6Vhqjqb2BISpGxLRLAVqeY0rPtygK2x3T0pLGVj1pn
 ZtRFYkG/7usrIjJU8DsJRxNrBb6c7hXjb7UfuYIrY884EXcMCfIF2uenmHT9zkUDan5s
 IVig==
X-Gm-Message-State: AOAM530fJU7qFFTpS+bXZFTXJAvyR+ZtC5Yyi31Xk/lBkT8V5px/9XYx
 cyHzgYGwwzOTE/IWYLi9pMQ=
X-Google-Smtp-Source: ABdhPJy3Ixe5NDssWl2gkYZjneUuDd6lti+TH8cvo414EnOoMUuOEVvaFkXJt4jj5434vavQPR0Wcg==
X-Received: by 2002:a17:90b:3715:: with SMTP id
 mg21mr2603075pjb.113.1595482345592; 
 Wed, 22 Jul 2020 22:32:25 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id y65sm1438245pfb.75.2020.07.22.22.32.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 22 Jul 2020 22:32:25 -0700 (PDT)
Date: Wed, 22 Jul 2020 22:31:50 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_esai: add IRQF_SHARED for devm_request_irq
Message-ID: <20200723053150.GA5476@Asurada-Nvidia>
References: <1595476808-28927-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595476808-28927-1-git-send-email-shengjiu.wang@nxp.com>
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
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, perex@perex.cz,
 broonie@kernel.org, festevam@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jul 23, 2020 at 12:00:08PM +0800, Shengjiu Wang wrote:
> ESAI interfaces may share same interrupt line with EDMA on
> some platforms (e.g. i.MX8QXP, i.MX8QM).
> Add IRQF_SHARED flag to allow sharing the irq among several
> devices
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
