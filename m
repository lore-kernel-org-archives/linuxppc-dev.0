Return-Path: <SRS0=Exvj=A3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3652CC433E4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 19:55:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A30206F4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 19:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A30206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B74jc6mjTzDqMV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2020 05:55:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.166.194;
 helo=mail-il1-f194.google.com; envelope-from=robherring2@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B74gY5Q3bzDqLx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2020 05:53:27 +1000 (AEST)
Received: by mail-il1-f194.google.com with SMTP id s21so6143435ilk.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2020 12:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xPJI5AUNc3GLpKlOl9E8pVIu2DWZ+nUPV7c3Fd1fTW8=;
 b=s8MeAKmMFiirZz8GGtS25G7F7daOOV1GBvgmnMo9udBksxmxR0sYcLpn112RD2VUYm
 VLGxhjEjnzAVthzvHS3NW/Bw0cIY3n54dUhCgsThp6XHsu6yo6tBeuStWqfXCXrzG2st
 SkWoHAbQAhERIbyRH1B1Xtl80IQWjFnm6tFacIHFzLXWMN6TOB/cLy0Gj+RnsDaRmyBI
 pZGrp/JJMk7HjrTT4dF6tWN1gP6yVdIINu1lG7ysY1y+MieL9Blm+DiE3gLiXq6Dx0aK
 gY9grwTZkqyEJ3SA/6BZxERERs0dD5XvKGIsn6geM6zodUQrlvPjg/1oNk72Edu+R2bl
 35Hg==
X-Gm-Message-State: AOAM533IyuhwzK4T9M0yyI9srbkvGumfZMWwDf+XOAyoDD8NcIriQKJo
 r5KzcpSgeKu1N0upWmWcPQ==
X-Google-Smtp-Source: ABdhPJwbtrb2hzcyMrDtMJ8lQQG2F77dP0WpMBde2WE/BUG6j0yjkG7KFC7V4dHYMGHTHGdG0n/9rA==
X-Received: by 2002:a92:d186:: with SMTP id z6mr6614069ilz.227.1594929204916; 
 Thu, 16 Jul 2020 12:53:24 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id a5sm3219354ilt.71.2020.07.16.12.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 12:53:24 -0700 (PDT)
Received: (nullmailer pid 2739233 invoked by uid 1000);
 Thu, 16 Jul 2020 19:53:23 -0000
Date: Thu, 16 Jul 2020 13:53:23 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 2/3] ASoC: bindings: fsl-asoc-card: Support
 hp-det-gpio and mic-det-gpio
Message-ID: <20200716195323.GA2739158@bogus>
References: <1594822179-1849-1-git-send-email-shengjiu.wang@nxp.com>
 <1594822179-1849-3-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594822179-1849-3-git-send-email-shengjiu.wang@nxp.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@kernel.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com,
 tiwai@suse.com, robh+dt@kernel.org, perex@perex.cz, nicoleotsuka@gmail.com,
 broonie@kernel.org, festevam@gmail.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 15 Jul 2020 22:09:38 +0800, Shengjiu Wang wrote:
> Add headphone and microphone detection GPIO support.
> These properties are optional.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
