Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BE1C2BB84
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 01:51:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FD12072E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 01:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRj0knLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FD12072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BsKgZ3DYyzDrPx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 11:51:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.216.66; helo=mail-pj1-f66.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=BRj0knLs; dkim-atps=neutral
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsKcq5NfDzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 11:48:42 +1000 (AEST)
Received: by mail-pj1-f66.google.com with SMTP id o16so418556pjr.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2020 18:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=IAe9YrO2c2nTBXJ+6AECIPfq5RqNfakgD6ec87G1lRc=;
 b=BRj0knLsGJxxYLXBhVmfZKGmxujjz+/Hmqi/qEwMX//OJvKf9yyDeEixQBGPd4wts4
 6a1NAlBUMJK+9HsT0tHExIiIBY51fBoIN1yU3XQ8O9EkJj//97LGtCL11Pe5o+QJ+bcS
 et0sT0lWTzye+QnNs4WZa5DghwevjSdMMaI9tIfXsfOrCJHnbGucKLqyBveNCMYoqf3A
 9t6u+brl3mB9g4hGos+8dgLT0f8ElY0zna3yl8gzeOh5Pr+C5judrj0NmF4GGrl6ENI7
 ParWAThpX6/xse3rOFEo2Qr7eC6Z7XHGuVFMsX8cwQuJ1jtwBxjW95ySSrHiGJABu2XO
 wuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IAe9YrO2c2nTBXJ+6AECIPfq5RqNfakgD6ec87G1lRc=;
 b=K6RyBPyhedeqR/sDX9WZ07eW7+iEJKhCUNKp3VfAu/YPCjWhDVKSMa9jOYTM+92rwp
 YOHJhRUr0jO9rIZ5n1VpE5hFC3Qpf7jAWb3SBY/aFxRpvDgmwsR8fuHhJ24ba/6CRfzU
 RWbmjZnCpF+NXTGYC0Kajuq8S857Wxi8FUJq/wgnRmyWVqBYWqv+sqARvbS41k924sLI
 GFMZ+ZjxWO59b01rWtUkFfmQc0nFxHjhLIelWGkH4OjBG/Vla1BRCG11D4AN7hUUedzf
 IuWhR3VpeoSqvOo55tlZkckaOiHDsdVU3kQgO9JgCKx4AyMQfvLqddFcEwPbNsNm5EO3
 NZSg==
X-Gm-Message-State: AOAM533oyT4d/MVxxdhcCZ0SQPSGAivjEl9N7M1dYHSHzFBfUNs8BOTL
 E/KsxlkIgxmlRkUdoymjsys=
X-Google-Smtp-Source: ABdhPJxQrmqIyoEdGAwBvg6EW9yUh/vXTcfWc6Q0cRa/d1a/exrU70dlGhePTvzfeLRNM6mxTIWJgA==
X-Received: by 2002:a17:902:8605:b029:d0:cbe1:e773 with SMTP id
 f5-20020a1709028605b02900d0cbe1e773mr27020490plo.26.1600307259038; 
 Wed, 16 Sep 2020 18:47:39 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id u2sm3883917pji.50.2020.09.16.18.47.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Sep 2020 18:47:38 -0700 (PDT)
Date: Wed, 16 Sep 2020 18:44:27 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/3] ASoC: fsl_sai: Add new added registers and new bit
 definition
Message-ID: <20200917014426.GB22566@Asurada-Nvidia>
References: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com>
 <1600251387-1863-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600251387-1863-2-git-send-email-shengjiu.wang@nxp.com>
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

On Wed, Sep 16, 2020 at 06:16:25PM +0800, Shengjiu Wang wrote:
> On i.MX850/i.MX815/i.MX845 platform, the sai IP is upgraded.
> There are some new registers and new bit definition. This
> patch is to complete the register list.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Change itself looks good.

Can add once fixing the commit message:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
