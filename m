Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4C606A31B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcAX47z9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8V6Q6n4Mz2yK7;
	Wed, 21 Oct 2026 11:10:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792541422;
	cv=none; b=mVOQUgn8Uip1qj3EBR5I5VQvdMIAZo1fdweVqX+ByKmSr1DX1Ftk96Kg84/iizPWEgwuMyTbVlgTe3E2LNkB9dQ9NBIoQ21gv97PaEKrO9YbaZ8yoGaYYgrpcG1i6Qm0Zg6LHh828kQQIr0rsWuht1Gxx2KnBrD5dBrhBng/WmvuaWE4PW4R+wdQNqGSVjgvurGdhYUKYgBYqyixnXsgJdwu7Q3dtt7pcl9sWhahrudW7tqWcoAXNT3jAEcGN11D+0MAj4h1ulU301GcCE88D46CclhcZsQie+/aFu+ZmuW9FG7JxR+OVB8FiblanUHmnlz0m7Re+U42gKwZXHgJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792541422; c=relaxed/relaxed;
	bh=NGYSqtXY1AnVivlpLbxLyPsD8hcsGkwLrPVEx+GFj5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NArSMNNzYoiLDZUgA7G8TGBmW3dFezxGqKSCftLm5HbyT/2aDkg7D3o0p+eMlkQKX364tEXAuXUIfM/p9+cfSKV1fUgYOOftCyJdqEwxpwEBwluqHzvJrNuNaeeuzaWf2W+IvWBfKAZ8e0Vx5ivZVQqs/1L1d3jGnAGXgClo7lx/sH6o3ao2Z5h5Z0BTl16gJXUb9IhPNKttcLjEExU+g9JE4bHMibr+elRQCxduxY45Gu+yc//eAwcDMGiTXifFHxnUBDXH9u7FnzMzaLOMlIWlD9dFgKLEV7ltWIgWh5TqcW4CB8e3Nmnz4i1uGUDiYNmLooLMmQ+Rt7Nlg2DN/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcAX47z9; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcAX47z9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8V6P6JhGz2xRm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 11:10:21 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1554460A7A;
	Wed, 21 Oct 2026 00:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCE01F000CB;
	Wed, 21 Oct 2026 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792541413;
	bh=NGYSqtXY1AnVivlpLbxLyPsD8hcsGkwLrPVEx+GFj5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VcAX47z9k7GWrd/eSc2up9vu944al3uDVkygRfWUNLbU5fkHaD426ue+potyRqfak
	 BjMlKHV2En4OFIzDzbrpUMrzzAbqSjH0FxI+w9rFzWYFE2hjNuEOfp8CYJHQoO5P49
	 Yo4cdi0mvzgxvYYw6IvrvZIDKKpzQOY5Bgp505LqFv7x53LvSMtddbgy11OL2R1/tj
	 k42TfQZh6LJlJ7FfxUtvOEjhd06VWxQDw18FbPWl4piugolsoUJfkPZtVAaH9Dsxgm
	 PijBYD1WhZsmyo0BlsVAZ2LNYMdpfe9KYTA2RkOQwZozHcJfb0KcBANyDkeMNE8yTA
	 x9PXIMCC2eYSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B449A3809A0C;
	Wed, 21 Oct 2026 00:10:13 +0000 (UTC)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/9] ibmveth: fix hangs,
 use-after-frees and netpoll races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179254141226.280032.2437128299395048724.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 00:10:12 +0000
References: <20261013182926.30417-1-mmc@linux.ibm.com>
In-Reply-To: <20261013182926.30417-1-mmc@linux.ibm.com>
To: mingming cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 11:29:17 -0700 you wrote:
> Hi,
> 
> Nine fixes for serious bugs in the ibmveth driver: two hang the
> system, four are use-after-frees, one corrupts memory, one lets a
> frame from another partition stall or oops the receiver, and one makes
> ethtool -L report success when it failed.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/9] ibmveth: fix netpoll races with RX replenish
    https://git.kernel.org/netdev/net-next/c/8d9ecac6b96e
  - [net-next,v5,2/9] ibmveth: do not close twice after a failed reopen
    https://git.kernel.org/netdev/net-next/c/95811c873d1b
  - [net-next,v5,3/9] ibmveth: disable the reset work before unregister in remove
    https://git.kernel.org/netdev/net-next/c/141223544786
  - [net-next,v5,4/9] ibmveth: step past bad RX correlators instead of spinning or oopsing
    https://git.kernel.org/netdev/net-next/c/c9b95adc755f
  - [net-next,v5,5/9] ibmveth: release the pool kobjects when probe fails
    https://git.kernel.org/netdev/net-next/c/fd052c6823b3
  - [net-next,v5,6/9] ibmveth: return the error when set_channels cannot add TX queues
    https://git.kernel.org/netdev/net-next/c/16abfa871dc8
  - [net-next,v5,7/9] ibmveth: wait for in-flight transmits in ibmveth_close()
    https://git.kernel.org/netdev/net-next/c/c807573ea58e
  - [net-next,v5,8/9] ibmveth: wait for the RX poll to return before freeing the RX queue
    https://git.kernel.org/netdev/net-next/c/3f872b34368c
  - [net-next,v5,9/9] ibmveth: check headers in the RX large send and checksum helpers
    https://git.kernel.org/netdev/net-next/c/9486c89a8e15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



