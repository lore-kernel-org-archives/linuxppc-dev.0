Return-Path: <SRS0=cwfL=GH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B567C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Jan 2021 21:33:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C407321919
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Jan 2021 21:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C407321919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D8plP1LkNzDqMv
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Jan 2021 08:33:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=k+JzBVwd; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D8pgl2pQxzDqQk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jan 2021 08:30:11 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id B71D2224F9;
 Mon,  4 Jan 2021 21:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609795808;
 bh=+VIp1fbOslRnEXjmav/oSNMgrzek7YuC7KXDOGeIgvY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=k+JzBVwdepZQVgi2qtp4pO4mRtkbC85HHzefaSm3bVgVdzoucfBrFhavNCFbsNU4e
 lGhkeEHQVG3r3W5VZm1c2wAUjQQ74VpVQaXkNeHE/Gan60/GykIldLRemE4geTmcF8
 DJLl7sTv8OlEuzc8SY1+sW6QU85J4TzeCuwWdotj7S+MnvK1YiQbjiOV/bWpbxByNc
 Wo7C3QPnS90DiIFzZ2ETgN3A6siZPH8YW/sYxMcZp9bswCV6X7XLv/75xhMYkXFvwQ
 bMUD9VtVDI94q3jZy2KDkfB90MsDVhfTgse5pc/g0j+A440DKCnDMe34+G04meBQJt
 jJycRxRyU18xg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ibmvnic: fix: NULL pointer dereference.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <160979580868.407.15154718207027980381.git-patchwork-notify@kernel.org>
Date: Mon, 04 Jan 2021 21:30:08 +0000
References: <1609312994-121032-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1609312994-121032-1-git-send-email-abaci-bugfix@linux.alibaba.com>
To: YANG LI <abaci-bugfix@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ljp@linux.ibm.com,
 drt@linux.ibm.com, kuba@kernel.org, sukadev@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, paulus@samba.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Wed, 30 Dec 2020 15:23:14 +0800 you wrote:
> The error is due to dereference a null pointer in function
> reset_one_sub_crq_queue():
> 
> if (!scrq) {
>     netdev_dbg(adapter->netdev,
>                "Invalid scrq reset. irq (%d) or msgs(%p).\n",
> 		scrq->irq, scrq->msgs);
> 		return -EINVAL;
> }
> 
> [...]

Here is the summary with links:
  - ibmvnic: fix: NULL pointer dereference.
    https://git.kernel.org/netdev/net/c/862aecbd9569

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


