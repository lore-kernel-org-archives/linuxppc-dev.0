Return-Path: <linuxppc-dev+bounces-28703-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02334CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 23:10:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwngm188Rz2yPG;
	Fri, 02 Oct 2026 09:10:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790896212;
	cv=none; b=RwjuQAv/alECzLKXs5Rbb9UCqdIylYOWMhmn/xTMTD8V/6MbaETWGeor7ow/4jxMz/hf5/E6MD3eCpM4i71Kux/h2qq3+ChhULEhdqmc6kAzHdjyl42ghVQ6o3SpU7FO+MkqBird1JWcNVMNiaDdQJ68D8NmYA1520HKffUcAdUSMzEE0Mt29EYde99NTkfS2LtIKboX32YGJYXk8UvADei6vjKaBejMymg4r/1OnNsLpYyV9sjc8RJH//pNrsBkse9CTu0HfosZvvVjQuBYWotpu4EQfJCzCjPvB0f7b3GCj5WicDQrxgC/31kIxdQh33JUkhxUBGoH01mLAR6Sjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790896212; c=relaxed/relaxed;
	bh=jYjG3jjmQl7MkXQdcDTd4nQc+AvoJ033O9MYPxZmAqE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ei+/KXbtJX0QJ7x7jscX5JtFSQGlBgjtwD/RLKwiAFPySAiIwRalNS688kWKpd2y25kvbEyhMOP7xyoSJh0Q9KleQLTdGKpodjQ2KP3+pQkrdzrTkTgU7CXCnWe+8yCuX/c/SEAcD94VhkymAgt4BMl51MYDC/9oyciHEHXpNvxGxc376IeUQxVayXUnRhRDQUpXfuvYoYr6WdrLxykyB5NW5GdMDrdEXh/helYm4Y5kTcJXnh2wZiQ9Ujn/n94CCSXUkGj3MBi+yPXYGgjsv8pVep4R3SeXSs/mM3vlkVKWhLEANfdw17QbliHPYIQPaUacdptWOTQy7h6PHTiutw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgD5e6C3; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgD5e6C3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwngl1jPmz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 09:10:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2B50E4085B;
	Thu,  1 Oct 2026 23:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080911F000FF;
	Thu,  1 Oct 2026 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790896208;
	bh=jYjG3jjmQl7MkXQdcDTd4nQc+AvoJ033O9MYPxZmAqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WgD5e6C37s5AOSTRNSwUPDg4UklkoJc5VFAGqPTsJchaspU3XnVi78uUvEE0XXwLb
	 RUooSpv8ZS1bt4YW3B/G/q/sEISARU7MdpV5hNzzZmsdRSUZT8tAurhi5dyu6Lt4N4
	 inH1GxzLq6yUZ9xRHHLCpzj8dGhEXmggaS0NX3wN0mnOJcOe8H80F5Awp7LEgmxg/t
	 YZzJvTaLutMB579/LjNBh2dNo0n4+wT81Pp3z36LnLSHoojHhtujrzav1uO153HJ+O
	 0yPE5G6WtqLw4kN+nzb45tXkvt1QZlm2MyfXnao8fMkOXRc0j1lYlnJnnrvcmFesU/
	 jfuAYSZS1J3Tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1619381197C;
	Thu,  1 Oct 2026 23:10:07 +0000 (UTC)
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
Subject: Re: [PATCH net 0/2] ibmveth: fix open-fail unwind after LAN
 registration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179089620655.3133874.6118634077996472369.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 23:10:06 +0000
References: <cover.1790357373.git.mmc@linux.ibm.com>
In-Reply-To: <cover.1790357373.git.mmc@linux.ibm.com>
To: mingming cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com, shaik.abdulla1@ibm.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 11:05:28 -0700 you wrote:
> Hi,
> 
> ibmveth_open() has two independent unwind holes after the logical LAN
> is set up. Neither needs the MQ RX series. This posting is against
> current net.git.
> 
> Patch 1 issues h_free_logical_lan() on every post-register failure.
> A pool allocation failure jumped to out_free_buffer_pools without
> the hypercall, so PHYP still owned the buffer-list page when it was
> unmapped. request_irq() failure already issued H_FREE before taking
> the same label.
> 
> [...]

Here is the summary with links:
  - [net,1/2] ibmveth: h_free logical LAN on open-fail after register
    https://git.kernel.org/netdev/net/c/af0524bf4ce1
  - [net,2/2] ibmveth: fix TX LTB and filter unwind on open-fail
    https://git.kernel.org/netdev/net/c/84bec0bf0352

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



