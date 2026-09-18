Return-Path: <linuxppc-dev+bounces-27756-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4CEC982D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 22:51:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmnt94b6pz3bX3;
	Sat, 19 Sep 2026 08:51:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789771889;
	cv=none; b=OH7SnwVvU9iMAOU1CHVCuEtQhKwLS80iGLbY/LcVI2yJg1+7Rmatic/ZkfY3IhC58CJPRrq30hCXxOqlXIyyx6h3OKjWLuv1x4sHYtehWPeYViyiKsAsGvQBRBizq+JO15DeOA6hq/2qj3FY4br/ECOZTf52GxoW4/1OveEBdcwv/O4agWaq/u7iSDTw4+dvCmWFDy5Eq0vX8c2lckbDdhqMDtTNK0fdJ9tMeURCo7D7FRYZzkkZJYnvwZ54k/3S3EvxK3UNr3eJeoRiTlcBD4xlr/T6OI+2JZWlXexaKByAndXBqEJXbkdQ61wz0FunZ8RzgZuL+3NUjaHTaBz1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789771889; c=relaxed/relaxed;
	bh=731a6XXeceztXL+ac+gkERlPUJ3cREl5p8bl8/NcrVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oGhituKNLRjCndcSv5n0r2USrh7c4f4qF1E9cQP66qcUP+v74XM1iQlg8IzFPB4ylaw+c5dFyUPjOUkjryShCbv0G1U+za+pkk0nrgxY18Czl711fVLdOc1ZAhj1ptgoH0Lymd2Uw/u90ENxpA0Rbo4wmgPSQSgNr9c39jgNzvU4N5VGU07IXN4xPvBXfQBKurGdoxhMXuVVe45+ov5FwsS40fSrEr6NiS4Fn4SBMRBdAVn4Tdn9C5pkuFu8vUiADWmNdYuGIpUfz8a3VIDBaVObUbBQjR4l3RNaN8QGAEZHL9yI3SL/B+xHuIAg0hq6f4x9HGV+/lUTdOBRZuV/3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLzl0m4Y; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLzl0m4Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmnt766Rbz3bWn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 08:51:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E85F360A52;
	Fri, 18 Sep 2026 22:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5C91F000FF;
	Fri, 18 Sep 2026 22:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789771884;
	bh=731a6XXeceztXL+ac+gkERlPUJ3cREl5p8bl8/NcrVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hLzl0m4YKl6hlT7zNLemKa+uY5mMBThfRbfwb7wkVXmNUKHb+pX1HgD/Sgt1d9+zy
	 5TMFya3Ly67PVe3CXn+Idn2AsOTZ60ko7pYgrUU7cHGjb+ersmoqxa1MmKpt1lP4b2
	 rZqVkLmog2qVjeZ1Y20RI8EaXzouyqCMh6CJks37wIwARZGqIvP18OeTFJEemhgf40
	 y/ouYmzNitzaOLqrx4UK0uyu3pvldpaQM4rPN5f2zHariYPvZidnosS6n/Xa9Y8SBb
	 hoDoq6COg2Ab4+iy36+peVot1ObiWIf5dyr6a1+HraDejHUmA7RBbzzEv15/b9oyGw
	 kGO6ieWT2bI9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A02381196A;
	Fri, 18 Sep 2026 22:50:18 +0000 (UTC)
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
Subject: Re: [PATCH] net: fs_enet: fix platform info memory leak on remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977181739.1178488.919668465552936249.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 22:50:17 +0000
References: <20260916031414.2875022-1-lgs201920130244@gmail.com>
In-Reply-To: <20260916031414.2875022-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: pantelis.antoniou@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, jeff@garzik.org, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 11:14:14 +0800 you wrote:
> fs_enet_probe() allocates the platform information structure with
> kzalloc_obj() and stores it in fep->fpi.
> 
> The probe failure paths release this allocation with kfree(). However,
> after a successful probe, fs_enet_remove() tears down the network
> device without freeing fep->fpi, leaving the platform information
> structure allocated after driver removal.
> 
> [...]

Here is the summary with links:
  - net: fs_enet: fix platform info memory leak on remove
    https://git.kernel.org/netdev/net-next/c/4a6764900678

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



