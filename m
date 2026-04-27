Return-Path: <linuxppc-dev+bounces-20136-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7BEFF8850
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 00:37:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3l5j1gZ8z2xdL;
	Mon, 27 Apr 2026 10:37:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777250265;
	cv=none; b=cqm/qw+13v8P6IZNYij9/6te+v364/Ivo4saOMzQESUfst61nhjvtWxwD3B2tRd5RYNHzy/PQFUolPIMgXcYjTsquniKrj9C4Ipx4w6pAibIjQp2bWh+A0wnG/651LKMWN4EEAFpTzM/ME6Rf4uUM89HN+sK4vNX8Mz88Zmcu7/CNZvnFEMAIpnOgzW5JPWPTAgnMeg3mOfR/AV6diuB1RZCYxW99r+hoqjt4tB8pU029OSQEkcX/wPEA2W1pX0+9+vfBQWfGkzfzaAZO7jaY9bEemWW/7pmHRjNHGanC1J3gS18+saudNQ99pgusXH+KonqaBorM5JQs/SqFYf79A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777250265; c=relaxed/relaxed;
	bh=7zuBBV/dz4sp6l3/YdMrIJgSVVO4HfbMbU9orCnV4ZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yj1BGghzNRNeG49ozkkQIlIPlJz2loxjAIbfUwSqOj/lT+Y68lgDy/skkXZZXf8S6VTDetQp8vhYLRJmQykKBm3Vls8QVsf9r4w6qsI4Ism/pFFXJvQdQBtMci5qlLRmgHRozSByiFflxGXVLXsYRc0rhA2Mp+2Q9UswEOjSLFaHCR9KnnSI9OOp/n8pQWhylEA6Yzy7U919+Gc1e/GmCa6xhfP1iV44Kqu8tPrxXbUlMVgseR3V3tHFbXMnQ0nzVapasjo5ILxxdh1ZkrD+ngywVFFcQz9oBcZ3Ge+2bL9gJHgmyn1HEt7QWxbBOAHYBDYsKn9tvcHFv7N/km5ksQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FJk7is+H; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FJk7is+H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3l5h2g9zz2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 10:37:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 69FD64325A;
	Mon, 27 Apr 2026 00:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406E3C2BCAF;
	Mon, 27 Apr 2026 00:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777250261;
	bh=/KQyIIXxBANDbJVbULlbyLCLd8t/G3HnMy/6KaTpJyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FJk7is+Hy5OEaY3cjP+TfeQwamOc2VwogBDAIxZ6TLjWHWxV8gH6fwuHp/PoxRk2o
	 oi2tIu9jDq9Jdq3ufB6mAx61Z8FkICyEXZ/lO31S38fUgQN4cbtQmLVhXhcaX6/iM+
	 IYBbWSWoOUQtVg9Jg8Aa23MXfOA2RDhAPpnmY+A0J5lEZA9Fa+PDIM8n9pWiMEmO97
	 BQzoIUM8aN6wXZCYhBaoRzEPVIccJ3G7xdcrdnN1dQplAFc7fYwz6i9ME2VIqvrtti
	 V5DlYGI3OnZIrysDCAa8OJDUlXkLM/wE1BHbCnTf8MbKXVzq2Af3ntEnfcNWt3RRHD
	 FZ55/2fAgDeug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA06A38119E5;
	Mon, 27 Apr 2026 00:37:00 +0000 (UTC)
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
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy
 ATM device drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177725021958.2839245.12173011555079376914.git-patchwork-notify@kernel.org>
Date: Mon, 27 Apr 2026 00:36:59 +0000
References: <20260422041846.2035118-1-kuba@kernel.org>
In-Reply-To: <20260422041846.2035118-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, linux@armlinux.org.uk, tsbogend@alpha.franken.de,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, 3chas3@gmail.com, razor@blackwall.org, idosch@nvidia.com,
 jani.nikula@intel.com, mchehab+huawei@kernel.org, tytso@mit.edu,
 herbert@gondor.apana.org.au, geert@linux-m68k.org, ebiggers@kernel.org,
 johannes.berg@intel.com, jonathan.cameron@huawei.com, kees@kernel.org,
 kuniyu@google.com, fourier.thomas@gmail.com, andriy.shevchenko@intel.com,
 rdunlap@infradead.org, akpm@linux-foundation.org, linux-doc@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bridge@lists.linux.dev, dwmw2@infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 21:18:44 -0700 you wrote:
> Remove the ATM protocol modules and PCI/SBUS ATM device drivers
> that are no longer in active use.
> 
> The ATM core protocol stack, PPPoATM, BR2684, and USB DSL modem
> drivers (drivers/usb/atm/) are retained in-tree to maintain PPP
> over ATM (PPPoA) and PPPoE-over-BR2684 support for DSL connections.
> 
> [...]

Here is the summary with links:
  - [net-deletions,v2] net: remove unused ATM protocols and legacy ATM device drivers
    https://git.kernel.org/netdev/net/c/6deb53595092

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



