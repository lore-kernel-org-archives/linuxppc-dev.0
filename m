Return-Path: <linuxppc-dev+bounces-20385-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E132CD13DA
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 May 2026 17:21:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g7F6y74X0z2xpn;
	Sun, 03 May 2026 03:20:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777742458;
	cv=none; b=YHzmwpmTwK+vxIFXZ0z+I2OVHCEZA9c8xmfy/6ElFYqDB0xlPk161v5WeyVWiNxv8J1xdQy8dyRed9P492Om+OM1Q8PfajHOv8NYhou25sTaAUNEPAXKJqWQQ0FPaFr9WtjyGxnKYgDHWFk04ziaWK5LFRXKlv71rW8xGLaS7dELjbsLnhVXYUdrzR9KOjp+Lt+Wnbv5q+Swc4747pj/jjMq0FRXsYIwLRXksB/GmsHfCOhPbiwJx9UTlYmRSCBxOL76cUQyxyHmKOa/lKjZNx9VlEO7BA8yJsz8JJn+UZiNq418BjWej9/tOB9Ysr855LKEXsUF0ChA1DuzCj8DMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777742458; c=relaxed/relaxed;
	bh=gHb86Y7VGPf3aOD5kr63OE5gNVCJXSmS6M9U3DWzpqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J1ZZC4YOx3HROcwJapH39l5tqwd2l4QQRowVGaPROkgpQzHJu6EpgB1a2B3xXkm8d8Y94VDk+SR2co9oH1nqALaAEHcDchorHRoBWMOmuVhpuWNbVY/foLDKCmNnAHoajGRKfALNMQAOv8DZpHa8pYObOXSxu+Dqee8Te1qDwGgotapvPake5jYccMXmw1rm1Aw4ZHYiXYyeR+2zpGhA+07jOSeFoh+P26pEzzo3E4b3ACg1zdfTox+SgIEfhC+0LGtaRxfk8tfBCJ1EzMv/zvsYF40r8IYY322eKiAsbVaby+OzvktEwY1DQvKFQrao02JffJ1At2BldVcrMy4G9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tVIVDJzB; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tVIVDJzB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g7F6y2JCPz2xnk
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 May 2026 03:20:58 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 79A0260123;
	Sat,  2 May 2026 17:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9B0C19425;
	Sat,  2 May 2026 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777742455;
	bh=fJMB9rpalVmvEP0NZbvjq+09U7J9jbfyWWNlpFKbOuM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tVIVDJzBSrHYgrbj6fMqiz8mGotRv51gwLZQ2iYwAsZIq0LNpaiPJ/MUY4QeVtTOt
	 pL/mhL1qHxvhoqLyu9Buyz9yUZAIg0Ay4MJpdekYhIEbVdA/dpE1pYwHaHCHL8QeTg
	 cujzzke1rBoL2mTkLqg1gwZWyesz1X7sAtSkS6spUDOEfk7KaMpaLcUni83GnfeBdf
	 cE6+y4DE6/avSoZe0PXjBJI27LU3AFsErBKJJlMKjbBlTYODSKId2OcgbbACQdSW58
	 fqkvsHh+U+67+ssDzt3tCMANTsIoNazqRRONvejXV0xKeBIrshAKTqbaRoGn8TM59F
	 pEa6AAY9w0mGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D69380CEFF;
	Sat,  2 May 2026 17:20:08 +0000 (UTC)
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
Subject: Re: [PATCH 1/2] net: wan: fsl_ucc_hdlc: fix uhdlc_memclean
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177774240731.3889878.18027662275547205090.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 17:20:07 +0000
References: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
In-Reply-To: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 andrew+netdev@lunn.ch, chleroy@kernel.org, qiang.zhao@nxp.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 13:42:07 +0200 you wrote:
> Unmapping of uf_regs is done from ucc_fast_free and doesn't need to be
> done explicitly. If already unmapped ucc_fast_free will crash.
> 
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> ---
>  drivers/net/wan/fsl_ucc_hdlc.c | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [1/2] net: wan: fsl_ucc_hdlc: fix uhdlc_memclean
    https://git.kernel.org/netdev/net/c/1a57efe250a1
  - [2/2] net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove
    https://git.kernel.org/netdev/net/c/851bba8068d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



