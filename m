Return-Path: <SRS0=JxsT=JO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60CEC433ED
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 00:00:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E206115B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 00:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E206115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FMYBG4rf4z3brT
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 10:00:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KVM+yGwG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=KVM+yGwG; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FMY9p6hjxz3bSy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Apr 2021 10:00:14 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id 8E9C3611AF;
 Sat, 17 Apr 2021 00:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618617611;
 bh=UWmFFH882qEW+CCAJckvBlwDzQC97jt9sn5omLp/nJU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=KVM+yGwGRBmURy5VWDyQXu+V9popEVx1XvqtDvPT7YrOlE9bTsqYkn8w5iRMxXWTp
 /slAbjCx1j2mQV6UJTq64xC/pLg0+ZXPT6ZbEdSr9mfWV5rImZepH3NVtUYraZEtI8
 IEWSnh5FHx7dW1Ebv1nhubxzrq5f+aq9c3BLI0akTW6Ecfu+I2RiT3Xsm++Kra3xlU
 wFY0/vk9MvsNKh9XaCD8pHKKVOZo0j6rHKlJwZzLpZYYKOHtfWlCKieWd2v+XQ6XC9
 uF7FffvkBf2LtULVZvIpDHuGcUbpfd6E+2b8NTFDTdAe9jjSbsx0Y7TJUkg5Z8yAYU
 tT1WbQQ6Gwr6A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: gianfar: Drop GFAR_MQ_POLLING support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161861761151.26880.8323384757169074141.git-patchwork-notify@kernel.org>
Date: Sat, 17 Apr 2021 00:00:11 +0000
References: <20210416171123.22969-1-claudiu.manoil@nxp.com>
In-Reply-To: <20210416171123.22969-1-claudiu.manoil@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
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
Cc: devicetree@vger.kernel.org, vladimir.oltean@nxp.com, robh+dt@kernel.org,
 netdev@vger.kernel.org, kuba@kernel.org, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Fri, 16 Apr 2021 20:11:21 +0300 you wrote:
> Drop long time obsolete "per NAPI multi-queue" support in gianfar,
> and related (and undocumented) device tree properties.
> 
> Claudiu Manoil (2):
>   gianfar: Drop GFAR_MQ_POLLING support
>   powerpc: dts: fsl: Drop obsolete fsl,rx-bit-map and fsl,tx-bit-map
>     properties
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] gianfar: Drop GFAR_MQ_POLLING support
    https://git.kernel.org/netdev/net-next/c/8eda54c5e6c4
  - [net-next,2/2] powerpc: dts: fsl: Drop obsolete fsl,rx-bit-map and fsl,tx-bit-map properties
    https://git.kernel.org/netdev/net-next/c/221e8c126b78

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


