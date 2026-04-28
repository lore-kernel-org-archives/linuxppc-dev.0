Return-Path: <linuxppc-dev+bounces-20201-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52042FF8867
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 02:20:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4PLC5pTdz2yqt;
	Tue, 28 Apr 2026 12:20:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777342851;
	cv=none; b=m3XnZk7GUktC4bsnmadDtYf5MQF+mZb+seYv5arczqigLaIPsF2fWBxvbYERj/2dr+jhkVbPNDy2UqGxAQ8YUXy3eOVHRCui8HXLI3to55D5ZJk88fuIRGqUoYPXCPft8dFa6aN8IqNEtmPs3VplohYDICfW/I+55dHOLN7bzpXT8c7up6evxEJnsPU2I8/fzTZQXDITzGOXJYjipvq9NrzD9DUbU4MFxtFnryZHR2Iuq+lVpTg+gUJ4jcwdjRp+p/crGTOFhFqDN8mAE0/SFfxlLCY0ecM2zpc2Jm/1twZSCLrk0QtRbaAN8c9FujUYARijUyuMe0vjmZPOvP/jbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777342851; c=relaxed/relaxed;
	bh=x/kOQZlwyg+XKdliciGOfRcGi+7hgfHcV61P7wnQEko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ff7N9Z62ObV8XxW9TJNZeQ878gUy5ph9aI3N4lfJMZQC/QoiyCtP4/1fNCwNBjTfOf/V87Z6L8YQOtvaUXBbhZsXUr2lEOQkYGfz8GP9ITCTHg5/ijYwt03z9UpSGZualJHQSDN5DHApc2SDFQjx0TvQAOBB1PeTsMMGS4quD8rcKzIFfxo1Fqmin2T/bDZ+yRRUlOhpPobGf7iyqnPCg2M38w0jUMJLv/rAq/i8nlEVzRq29KTJhcZxojPFe5yFpORtA/GZYdB65q7c9kFCajP740bHiqy1trT+6gzAsIn020HQMHP43++b53C5wzGFF1sie+wtarf4SUI1KtPFeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BNPJukUJ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BNPJukUJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4PLB6K3zz2ySj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 12:20:50 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9FB0260128;
	Tue, 28 Apr 2026 02:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E22EC19425;
	Tue, 28 Apr 2026 02:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777342848;
	bh=Gu6KcT5kMSGfIXHS8LsPjrLPCL3C4f6PCQ+8/Bvo0KE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BNPJukUJ1g1XKPobe0KiW0gzD+pJ4qyPNDFq8O1825Xop64UkXBtcUaoaqQbMjNW6
	 8OuOUwOjLtMJP+G0GUptpR2+iuMiH/rIMfzCrERSc71UALUUKKp3IXt7kve+brdfji
	 ras4Sey0KGO8DJYUc5CLBafYKOUxFIFBnkBeevvjHVd5IMLfVTAZIsZ2ekivqCo7i/
	 Fubps5DV/i+wawOveF7MRR5sMvr5kS1cbYIGF4slJZU43ft3i5kKrvfea6zJUgsHOa
	 r3Z4C2h6ePeA4x8XioCZCSKl6b5T9FgqRy2bmrCot2zc/UJrONMz4k1IM49KWul811
	 CdvvYAGRidjfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E7D392FFDF;
	Tue, 28 Apr 2026 02:20:06 +0000 (UTC)
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
Subject: Re: [PATCH v3] ibmveth: Disable GSO for packets with small MSS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177734280556.205517.1747939663275050652.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 02:20:05 +0000
References: <20260424162917.65725-1-mmc@linux.ibm.com>
In-Reply-To: <20260424162917.65725-1-mmc@linux.ibm.com>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bjking1@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 shaik.abdulla1@ibm.com, naveedaus@in.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Apr 2026 09:29:17 -0700 you wrote:
> Some physical adapters on Power systems do not support segmentation
> offload when the MSS is less than 224 bytes. Attempting to send such
> packets causes the adapter to freeze, stopping all traffic until
> manually reset.
> 
> Implement ndo_features_check to disable GSO for packets with small MSS
> values. The network stack will perform software segmentation instead.
> 
> [...]

Here is the summary with links:
  - [v3] ibmveth: Disable GSO for packets with small MSS
    https://git.kernel.org/netdev/net/c/cc427d24ac64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



