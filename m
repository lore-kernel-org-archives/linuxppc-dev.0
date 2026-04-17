Return-Path: <linuxppc-dev+bounces-19819-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C41F8E499
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 02:40:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxfJQ37MRz2xpt;
	Fri, 17 Apr 2026 12:40:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776393654;
	cv=none; b=g50f5GAURDzQWw3XrE9xA7IUP7bO2QZqnS3ZviSQUwB4e+HsydwVMG1mMxILABhoMFyA59STJ6ZELLNxDZlIjHqKIMooCqwg5+8luTjl834hTW5V4MSk6qnqf3w7OVlsejpb2RKmLUiDHyViIfefvUWbSprDyoLyavntnj+RPre1gE1eC+6RnttL/5Rmi+0W0Irr88RZdwfkWP7PbMsd5lcBGHAjBi1/B8QL303JyyrpytIwL46b0j899ZWqKKParYAukU7sda1Tcpz/fPalLl0osAblbukPXVkXASUhloLEuFo3upbQgNd2hoyol2C/YynAi7/B6npqc+M6zB8dLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776393654; c=relaxed/relaxed;
	bh=H+Jlkw2DzxGDVPjkTh09CfTkIC7dU4fvOK8TwWJLXqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eY6aBOWl7opvCL1K7AMyCur6fUEQzV1hgH2S1nSvbH5H70cbJRX7e3A5rTjQIZbWzBbnu1h8mOLJ6B4vGFhtOk07r6OFvc9r6ZQEc04erfdNSmqxlgp/1QlKCQYMpXlDQlO2UEb7BtrrVSl8ifB+6DZxMinswC4lSeF3HN4KghTxzwoESvgwGzbRDpdvTi+VtdGmVvZtFfF5ER9LV5NC1jojqBiucQShlQua9eGWtKiekGZAGa2Dav0qtfSr8Wb7jwheVLnNAMKU1Nup77tg6FMVLfruuTPPECFHHir4q+4WSxUzpbOzG/WK51H74lifjjiumWQAaqCI6RMFDu/WmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nziXgXAE; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nziXgXAE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxfJP3864z2xlk
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 12:40:53 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D5DD944599;
	Fri, 17 Apr 2026 02:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8597C2BCB3;
	Fri, 17 Apr 2026 02:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776393650;
	bh=RE8pXUNFnXrfp8k86oykmMdq+NuDocEHXqwp95teTlA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nziXgXAEDrvVDkLZpvE+XxCZTTZKH/M0cgCTyVUSO2ln2j+DlzcbyJsIwyuZpEsDG
	 vcgOQCkJO2fjQFNwe5nJ1v/9IAxyVfVAfW4M9mu2CiDbNdVUDR4T+dZwoE/H70UgNG
	 mYC7Zy6zrfRPTI0J+S65v+riyW9x20dQKieQc4KgHT2t1BUOjmfSG/ibHXyuciyc9+
	 peqUsTXW95O8TlCI783Pmcvmgh6OHrgpE6u/kkCz/vpfAA7c5fOpxX07BCI/8d5/TF
	 pLH1TcwabVr46cyJb2FzLu75ShiMqGTXUjgSdulYkca5q/GJwwuA1cWX6NvjxgoBUi
	 hvPtDEWqVDNAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CE6380AA76;
	Fri, 17 Apr 2026 02:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] net: enetc: fix command BD ring issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177639361854.3490984.12957233652551599024.git-patchwork-notify@kernel.org>
Date: Fri, 17 Apr 2026 02:40:18 +0000
References: <20260415060833.2303846-1-wei.fang@nxp.com>
In-Reply-To: <20260415060833.2303846-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, chleroy@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Apr 2026 14:08:31 +0800 you wrote:
> Currently, the implementation of command BD ring has two issues, one is
> that the driver may obtain wrong consumer index of the ring, because the
> driver does not mask out the SBE bit of the CIR value, so a wrong index
> will be obtained when a SBE error ouccrs. The other one is that the DMA
> buffer may be used after free. If netc_xmit_ntmp_cmd() times out and
> returns an error, the pending command is not explicitly aborted, while
> ntmp_free_data_mem() unconditionally frees the DMA buffer. If the buffer
> has already been reallocated elsewhere, this may lead to silent memory
> corruption. Because the hardware eventually processes the pending command
> and perform a DMA write of the response to the physical address of the
> freed buffer. So this patch set is to fix these two issues.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: enetc: correct the command BD ring consumer index
    https://git.kernel.org/netdev/net/c/759a32900b6f
  - [v2,net,2/2] net: enetc: fix NTMP DMA use-after-free issue
    https://git.kernel.org/netdev/net/c/3cade698881e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



