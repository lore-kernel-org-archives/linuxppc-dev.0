Return-Path: <linuxppc-dev+bounces-16779-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19967EA8123
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:50:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9PcN5lY8z2xN5;
	Wed, 11 Feb 2026 01:50:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770735012;
	cv=none; b=YNVyL9U9lhamRJwlc+baq7FotTFmkJ0vYyYwQEQibPvLZ7ktI4EjN0s1AoXOcmshdh/sA0CX8ZfhJgOlFMhiibn5S2R/N1Ytjy6nYn6GKIKYaVYSSQscnU+rRa8N10WODpbg5eFLcyoSIXK1lpe25iTrOzpvypBRv4HaATDPRzoUSNUVtcfUhIAFjPE2vyIAyLrtJv0sBMPmeiid45B/gVunBvznIQffay6p3Zr/DEbO44l/k5tgW6vOOKm+YzA9L5yiLpDgHAAoUthFAisi7eY3hbrFeIZDoLFD1m3BbYj/g8yp5dSN9MIJ3yAzZTqSlVw1XRvNzy43SSHiH55n7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770735012; c=relaxed/relaxed;
	bh=lNcVpZPDjaynUBEKY5imLrK6k82N+f9SqBpbNtp51Eo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hgShUGfZ+P2K9lrAoOB9X50bjW8IxSuhWL5zFolugZCTtXpQ1P0f+iEUBcEVZyu+mNdFphqq3X+4Zm1MWU2jaeO+A2fEBKFNB8JWSDjFVhpGmQ+ByBdevipfj1781P/sTsM+hLC/Jk6lb2qjtlaJCcQIG8Xc54iGNl+avIpbH7TWGxzU0F83xumzImHviUBHFjfjW6pWNPMza3Qg78Q8W3cxgsgAYOEQd4EQ3y2h+XAZIrbiz1/SxU8UaLAJyblBVYw8v4GU6LuzEQHAVTj+amaxsYO/uSyylvPtmO+qB3Kemg+PJExnT8QbBa78uTRKqfNYt+jbJlzYhLJjf/D7IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UEwVTWFL; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UEwVTWFL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9PcN1RnYz2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2026 01:50:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B2A9409C5;
	Tue, 10 Feb 2026 14:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BAFC19421;
	Tue, 10 Feb 2026 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770735010;
	bh=S9sMl+pXFGT4PjtyUpMSEQ44zxWKdkrQgC0O2rcIhBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UEwVTWFLKSt/WhE7OKA1H6UDvD9sAuQ0wZFTRpShCkt6kHPAdM9F9y/h/gI60yv6l
	 v5aL0ED3NwS9BQNNS5vJ8LaZ/F5cxcbRMz4LDNj3KqUOQ7wgJmoMSEZ1NnZPcvCHvZ
	 aeYqdUVX49nvrJ2AGh5qZMWx+KVjd4nhnoZicm/ILvVCC0vse05MJxHGSDf4o7nCJy
	 W+BEZapPZm/J++pcfRaNXhjzUwqCXHjIxikIzmqIIjnL8AJkWI/4NfKEbF7cdkzAAu
	 fqWgZIqh7UjR/qRx5BpIK2TkuuqjVi5ccCycgskBsMYW/x9oFbhaVVyNnpVPGl/1Dn
	 V5xUPDyN5ZJdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C24A639D267E;
	Tue, 10 Feb 2026 14:50:06 +0000 (UTC)
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
Subject: Re: [PATCH net,v2] net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in
 uhdlc_memclean()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177073500558.3540157.14031494476028683223.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 14:50:05 +0000
References: <20260206085334.21195-2-fourier.thomas@gmail.com>
In-Reply-To: <20260206085334.21195-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: chleroy@kernel.org, stable@vger.kernel.org, qiang.zhao@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Feb 2026 09:53:33 +0100 you wrote:
> The priv->rx_buffer and priv->tx_buffer are alloc'd together as
> contiguous buffers in uhdlc_init() but freed as two buffers in
> uhdlc_memclean().
> 
> Change the cleanup to only call dma_free_coherent() once on the whole
> buffer.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in uhdlc_memclean()
    https://git.kernel.org/netdev/net/c/36bd7d5deef9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



