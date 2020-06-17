Return-Path: <SRS0=OkvJ=76=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA0AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2020 06:33:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7E02098B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2020 06:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6Sgeh2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7E02098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49mwHV6bdPzDqCM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2020 16:33:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=a6Sgeh2B; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49mwDs0BBrzDqBM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2020 16:30:52 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id e18so766618pgn.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2020 23:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=IuEEwJ04EBGcVHdnYAuzzOkyntyIEkeUlotMcthbmkc=;
 b=a6Sgeh2Bm1vazQsOfe1eW9TwV0e7aO28v2HKFX7lXlSDMjM2Sm6ez2eo8Td94zie2x
 sLzmCPgLe+ugdhipeAo/JCl2PPh+epJPllLKKjKUF25kWvk+SMbv00SZ1cof1R/vFUHu
 VP2UwX084+Q6tXIPO6Y3OvK22yTWg0qHERGRfQ9mLAB2bvJk3Au6ZxMn9vX0gwKGR/Aa
 PSWrCVRSdjxE2rxB3xKIVdMryqWo0LtQw/4u2FtePnA8rsZq7uwgpqi9XEYfAgfOBRFl
 foVFSSvacYmHtXCSzndCe+5i13eIvuR4dGj0xcFBhiklDGgXKB6jBbjYOM5mO6rWu3lT
 3KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IuEEwJ04EBGcVHdnYAuzzOkyntyIEkeUlotMcthbmkc=;
 b=PHaNZqCqWtapqOSyyua4/dFgTj4QErKAb1jq77o8qrQF5rf7Ms/zDo2XooWG7ItRkd
 nj62vAG+xB9AnSLPR+0lx7SxkjdNSgs6/rB9R3e/65pEEpIAz8Z1NBYHaKMV3U5QeKfP
 FP8PmN/D7pCHulKZl8QY9OmtbLx5+0kDpLXTIiicpYRvIkjYIaZQTCtpoojZB//q5+HY
 NoKLKuThOhHtqjSuzDwV3RZLiPEMfxyqmVtEWpIVdJnVvo660rUUCTAYaKZs741Z8UFC
 zIiwQgTWv+qguMQBlWxT8Hu5K2KVyGMWcnl/3bZYUA7qpJQpKHGAOBkIddzH9BpcH1YD
 r5NA==
X-Gm-Message-State: AOAM533LTMCkoGhcn83snLeHrQyzJjsC5q5FsxOJTLuMVKDa0a/tYjaR
 Blt+IHZrFT34aUjT0WAGXNo=
X-Google-Smtp-Source: ABdhPJxFKo5k6eMIrz7WX/mVTR86nWQvTVi0bPtFQJ1sYGqHcR+gLGs6ETf3H4OPj/RJCTNuyvo53w==
X-Received: by 2002:aa7:952d:: with SMTP id c13mr5315206pfp.125.1592375448136; 
 Tue, 16 Jun 2020 23:30:48 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id x3sm18976602pfi.57.2020.06.16.23.30.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 23:30:47 -0700 (PDT)
Date: Tue, 16 Jun 2020 23:30:32 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl-asoc-card: Add MQS support
Message-ID: <20200617063031.GB6411@Asurada-Nvidia>
References: <2185a3ec866bc59f82d93b73d1a732a896fd8f48.1592369271.git.shengjiu.wang@nxp.com>
 <918505decb7f757f12c38059c590984f28d2f3a4.1592369271.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <918505decb7f757f12c38059c590984f28d2f3a4.1592369271.git.shengjiu.wang@nxp.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@kernel.org,
 Xiubo.Lee@gmail.com, lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org,
 tiwai@suse.com, robh+dt@kernel.org, perex@perex.cz, broonie@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jun 17, 2020 at 12:48:25PM +0800, Shengjiu Wang wrote:
> The MQS codec isn't an i2c device, so use of_find_device_by_node
> to get platform device pointer.
> 
> Because MQS only support playback, then add a new audio map.
> 
> And there maybe "model" property or no "audio-routing" property in
> devicetree, so add some enhancement for these two property.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
