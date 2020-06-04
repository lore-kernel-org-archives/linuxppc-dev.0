Return-Path: <SRS0=7wTx=7R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3A9C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 00:09:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF122067B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 00:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbRusUEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF122067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49cmNy5f7czDqgZ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 10:09:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641;
 helo=mail-pl1-x641.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=hbRusUEB; dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49cmL50Wq3zDqgf
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2020 10:07:08 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id x11so1399941plv.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2020 17:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wW9z6dg9gtAyJMDZbmTtIDy0Zz6R5BIjGsT/C/EraEE=;
 b=hbRusUEBEuXE43+h8g3Pvw81RsDWZKa0dvCSbxNYz78B1eNTcn2Pnq05G3QMZd5gzx
 70P3CSV0FOq+qRA076Tlw61da/eYYkgLKinDK4FfLSA4JeKaOSz5+ojszcktpXRtI34y
 GdgQbxNrr+wMFg9z9z9KVx7xyCoHDnkAg41ewHMrMeFmQvH433MmUryuwVTZxzTpHmT7
 nXCFnvpCkBeS2EUM4oRMqrworUamYwAajGO52p67jp+y8DJ7PDk1h2xoH5Ck3XIJH3BN
 YdZRpVQej+qKFERrZ0PH+nyJAvnZJbRPetvr/UssZd8jOBchORcWXDFyRMwLd+5Msjq6
 7GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wW9z6dg9gtAyJMDZbmTtIDy0Zz6R5BIjGsT/C/EraEE=;
 b=EZLk4jKKHQFuTYAGK7XUiBTy6LHqAsXRDqy7fg3VRPlj59V3Ga9bIp3FAS2V/BWhD4
 wFFvgfPT0xJR3itSsU1bJ2+Sjhs5cgqi9mlQ5vlUCeVows2y6+8tmY+WtVJwQWYTQDLx
 SllHCgELZa0IihO9GBr8oUX6BSQXg7u6Bv+dIEAja1FRovhXr7eEQ+vgI/bzK7991sCq
 lUo6LF7cOzL9+4WFvw5+qyXInKS+EhNbkwpNyKbxMERp+hlA5xV7TlusSgp3+YN7JIjY
 6C7lTWBXSNNV8sIEtaeEJS2EmfP5M83QUh7GtTWBiQTg8PsbxPW33E1MWJ/72jVndkSj
 7ftQ==
X-Gm-Message-State: AOAM531aiI8zqCiF2OegVeaDz+xBXdsfuzsFsFhAOA/RHhSY9OSIN5FJ
 Y6vW1joZ9hJeuKSHs+96ZBA=
X-Google-Smtp-Source: ABdhPJySQ1XeZeT8TPYoiRNFfTzkpxUVKzVYueW0EDHFb2AOz5sAtiVyA6sIuTRIpxdg2f6zYH/GCA==
X-Received: by 2002:a17:90b:193:: with SMTP id
 t19mr2899534pjs.47.1591229225665; 
 Wed, 03 Jun 2020 17:07:05 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id f136sm2691842pfa.59.2020.06.03.17.07.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 03 Jun 2020 17:07:05 -0700 (PDT)
Date: Wed, 3 Jun 2020 17:07:02 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 2/3] ASoC: fsl_easrc: Fix -Wunused-but-set-variable
Message-ID: <20200604000701.GB17364@Asurada-Nvidia>
References: <cover.1591155860.git.shengjiu.wang@nxp.com>
 <91ceb59e3bce31c9e93abba06f5156692ff5c71e.1591155860.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ceb59e3bce31c9e93abba06f5156692ff5c71e.1591155860.git.shengjiu.wang@nxp.com>
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
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 perex@perex.cz, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jun 03, 2020 at 11:39:40AM +0800, Shengjiu Wang wrote:
> Obtained with:
> $ make W=1
> 
> sound/soc/fsl/fsl_easrc.c: In function 'fsl_easrc_set_rs_ratio':
> sound/soc/fsl/fsl_easrc.c:182:15: warning: variable 'int_bits' set but not used [-Wunused-but-set-variable]
>   unsigned int int_bits;
>                ^
> sound/soc/fsl/fsl_easrc.c: In function 'fsl_easrc_set_ctx_organziation':
> sound/soc/fsl/fsl_easrc.c:1204:17: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
>   struct device *dev;
>                  ^
> sound/soc/fsl/fsl_easrc.c: In function 'fsl_easrc_release_context':
> sound/soc/fsl/fsl_easrc.c:1294:17: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
>   struct device *dev;
>                  ^
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reported-by: kbuild test robot <lkp@intel.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
