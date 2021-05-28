Return-Path: <SRS0=g7Ik=KX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095F2C2B9F7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 May 2021 16:25:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3411E613E5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 May 2021 16:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3411E613E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fs9554HNjz3077
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 May 2021 02:24:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk header.a=rsa-sha256 header.s=20170815-heliosphere header.b=mPigJKvX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=sirena.org.uk
 (client-ip=172.104.155.198; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.a=rsa-sha256 header.s=20170815-heliosphere header.b=mPigJKvX; 
 dkim-atps=neutral
X-Greylist: delayed 1195 seconds by postgrey-1.36 at boromir;
 Sat, 29 May 2021 02:24:32 AEST
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fs94c1n1Hz2yYc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 May 2021 02:24:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KzzFPtff8C3fnoTl9yAoy/DCOeliRPzlP12hZcFeAbY=; b=mPigJKvXnGHtR76JofQqxFL8R5
 R+HpY9AzYQ55Ksszd1fhY4jHoKY3snnHjI85ATJYtpfB0+sojgv8O0zFVI/n2tJfNDW3KrEN9X1ct
 +YU1aTJhGJcf8u4+I0IRzf7t7JR+9OQ0a81oElo4o7oTz6wbeEUaPcz/y4zHlQW02XWk=;
Received: from cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 ([92.233.91.117] helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <broonie@sirena.org.uk>)
 id 1lmeyE-006czZ-0k; Fri, 28 May 2021 16:04:22 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 59E2CD07903; Fri, 28 May 2021 17:04:21 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: shawnguo@kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
 kernel@pengutronix.de, perex@perex.cz, nicoleotsuka@gmail.com,
 Zou Wei <zou_wei@huawei.com>, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
 s.hauer@pengutronix.de, linux-imx@nxp.com, timur@kernel.org,
 festevam@gmail.com
Subject: Re: [PATCH -next] ASoC: imx-rpmsg: fix platform_no_drv_owner.cocci
 warnings
Date: Fri, 28 May 2021 17:04:19 +0100
Message-Id: <162221783191.3504698.10167150315447743271.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1622113652-56646-1-git-send-email-zou_wei@huawei.com>
References: <1622113652-56646-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: Brown@sirena.org.uk, linux-kernel@vger.kernel.org, broonie@kernel.org,
 Mark@sirena.org.uk, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Mark Brown,,, <broonie@kernel.org>

On Thu, 27 May 2021 19:07:32 +0800, Zou Wei wrote:
> ./sound/soc/fsl/imx-rpmsg.c:140:3-8: No need to set .owner here. The core will do it.
> 
>  Remove .owner field if calls are used which set it automatically
> 
> Generated by: scripts/coccinelle/api/platform_no_drv_owner.cocci

Applied, thanks!

[1/1] ASoC: imx-rpmsg: fix platform_no_drv_owner.cocci warnings
      commit: 47c0d825b926856d86685a48c82f693f56ca3f6f

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>
