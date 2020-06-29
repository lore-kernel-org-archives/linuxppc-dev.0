Return-Path: <SRS0=PIrw=AK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFECAC433E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2020 19:27:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A957520702
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2020 19:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJockAN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A957520702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49wcvR6M88zDqXt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 05:27:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=rJockAN7; dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49wcrD0VljzDqXt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2020 05:24:41 +1000 (AEST)
Received: by mail-pj1-x1041.google.com with SMTP id q90so7657285pjh.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2020 12:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9dKxVJjlaX8jxkeSh8T6e6YHQEcdayiIxfyFI+zqbOE=;
 b=rJockAN73JAGXobfkev1y93WYQunULGBKvkHTFKad7D/eGF6tMmDd+MraUFMuEk8ni
 uXbBn82EgTam3bfIUAMR/28dBeHDZ2Ju1ZhDVGhwDN9bLMd5ab7IeRqJMfACaETguWjG
 ydJZCKge5IZiRZi904cCLfh2TZuu6KY7ZhfNqBlHwNWPwI9tE1If8SAcbqLmottXPj2z
 dUzUTfjA2PoZRb1dYCcN7cbsFQ9P9PZ563y0ZDe94rzLrXbX9u3EhaD2a4MOmnplChLU
 xAtkHqY2Rt2UHA/D4yO4QtII2iv+pNwVnQmpL1QrBEoRA9UAfEiXm+JN7Dmtiu4oV4ev
 944A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9dKxVJjlaX8jxkeSh8T6e6YHQEcdayiIxfyFI+zqbOE=;
 b=qE5RWEd3+1gTtDY5IfQxG+QfK1NijG57ivYgWGyhJ7iBzrQFF2bwcKzT3sQ0U9Z0I2
 bTkpJkFSGN7APWJGT0Mx1v/Zxh1rU+NLkxrDpjUUTMdyKJ126DMxR4V0s4mLpGdP2Y9b
 92ouDXcoQsNKlel3tjA4phxtr9zeFX1+Odyl7hFJ0DS0MqbYcEoehvHIDWLp0cY+b6+v
 k7sPHmJwuxlcZBDzLfmiUj+D0HGqgwwfmwP0dEO66xDu5wWrPzE7X0Xt54zm+3bkh7DF
 Qrd/KHkGyf1T9GMb0n4c+PaVdOmrHHz8b63w1rXzLQMPgtVAEiAPuio5NEBF2mPDZWFl
 bCNg==
X-Gm-Message-State: AOAM533YqlUlgqVOdNn/2aOMx4PIU9x2OjWtqN99FMWdmYQCCv+Hxpul
 RCyPpRk2BSl2FlDYsrrgLik=
X-Google-Smtp-Source: ABdhPJw2NTojIOVe1N+k9d1UhrBCtTCNAURgml2u7637EWsRsIvR4dZARYK0e7VEMzNZsiIfyPManQ==
X-Received: by 2002:a17:90b:698:: with SMTP id
 m24mr4120032pjz.15.1593458677861; 
 Mon, 29 Jun 2020 12:24:37 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id y8sm278658pju.49.2020.06.29.12.24.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 29 Jun 2020 12:24:37 -0700 (PDT)
Date: Mon, 29 Jun 2020 12:24:03 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Refine regcache usage with pm runtime
Message-ID: <20200629192402.GA27967@Asurada-Nvidia>
References: <1593412953-10897-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593412953-10897-1-git-send-email-shengjiu.wang@nxp.com>
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

On Mon, Jun 29, 2020 at 02:42:33PM +0800, Shengjiu Wang wrote:
> When there is dedicated power domain bound with device, after probing
> the power will be disabled, then registers are not accessible in
> fsl_sai_dai_probe(), so regcache only need to be enabled in end of
> probe() and regcache_mark_dirty should be moved to pm runtime resume
> callback function.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
