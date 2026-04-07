Return-Path: <linuxppc-dev+bounces-19418-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528B2FB5173
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 02:10:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqV642xG1z2ydq;
	Tue, 07 Apr 2026 12:10:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775527836;
	cv=none; b=D3RtTMEtyDMO15ThpTagKMuX3GqS34JlnHwukqQSqM8Xv0uce7nyOedG54Kl53V6GY7uW8rNc4kHypEi+utfwIEHmxwKNKwbg2yXAZA9F9rYMone0342OYGJF9EmW+oShR6/wglQMJBAVuqU9H4inCBuo17P59G4GnJwCGsDvsZScCkudutopSQzT4Fa5sYe/32FMjxUY064HkIreB9rAGqC37ZS8dezQ1ofEbYW4b0gHWyQVRnmHpJQ0/3UxMX7Ul0CDFduq3KayMDLEWmd1YWqmwcxr8n3K7vZReKDcoBlqcYkYtvPrTjbXca5Cul+j7123ua5k8NfrlqKyarHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775527836; c=relaxed/relaxed;
	bh=eWKBBC3R3FcqfSCywwr0yFfobWXb5ALwuaMaa9oWkgg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o1/YBINd3dcpFKjwCVFtPGcMtk7Nu3oZmLzOLJIKdARKMYFDe8kLWgZ79EOBNOBCRWV/rJFaTXx4E/TwQszF9tnQzZAOEkLgP4+koXOw0iFdCSBGfiBHmbjgkMCGQvZxVm+OAvNdo69PWAuvlJM7Bt4qtT4M6KkfGMM2ipZXqxlFvA1QKfh1IloLRaOfup8hdLq2jmuX5SYg9Hhh/Mjgtt3bPHRAfX5KrcAV+EnUZmsnwEoMUTi0IwTz/8hRmYuMWzA0WwVgoZnh87EhYDUSWDX13bP7o2Kk5Gyvig4thtpDhApKH/VxjXpufoy9X4En1SKGbyf55tskyEj/+XqdmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s2wlu8lJ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s2wlu8lJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqV632MLgz2yZc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 12:10:35 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 22AAF44188;
	Tue,  7 Apr 2026 02:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB12C4CEF7;
	Tue,  7 Apr 2026 02:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775527832;
	bh=NUrupb/CF97DyehgDM1bR3YngtCbCXQcoCVeKQ2GbB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s2wlu8lJlZOw0FDnuFEbb1GIYBBpLFRmBCOwF42KTyNk+9QKJhFGELVg47XWRSkUp
	 VCwBD9vMkxe0JrC3ionEMbNtZ7rcN4qYPiL842Bqon5zJlQS/4MGH42pP0wgzJnulc
	 qUY5dxPpk3U5LtvBnHO5cajhh2Toib8iE/1nK3kqWegr6V6WDqPDANtSlJcNcvZKrt
	 n0BxwclZpplISYN2ZWCorIbmg1+cjijdgDztRpFvfYbKVDh3gm5qTz0uKnaMUUOBlL
	 BLtNwSE51BS7xdRHIoxvwGsTft8alJ6kvE2VZF7s/XEPVVMsiAQXfWcVv3i6HT/PJj
	 cp0Z8SZ36lTUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCB83809A28;
	Tue,  7 Apr 2026 02:10:11 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] eth: remove the driver for acenic / tigon1&2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552781030.3342975.4848886248762600181.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 02:10:10 +0000
References: <20260403220501.2263835-1-kuba@kernel.org>
In-Reply-To: <20260403220501.2263835-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jes@trained-monkey.org, gregkh@linuxfoundation.org, helgaas@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, tsbogend@alpha.franken.de,
 James.Bottomley@HansenPartnership.com, deller@gmx.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, ebiggers@google.com, ardb@kernel.org, tiwai@suse.de,
 tytso@mit.edu, enelsonmoore@gmail.com, martin.petersen@oracle.com,
 jirislaby@kernel.org, geert@linux-m68k.org, vineethr@linux.ibm.com,
 lirongqing@baidu.com, kshk@linux.ibm.com, vadim.fedorenko@linux.dev,
 wangruikang@iscas.ac.cn, dong100@mucse.com, hkallweit1@gmail.com,
 kees@kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Apr 2026 15:05:01 -0700 you wrote:
> The entire git history for this driver looks like tree-wide
> and automated cleanups. There's even more coming now with
> AI, so let's try to delete it instead.
> 
> Acked-by: Jes Sorensen <jes@trained-monkey.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] eth: remove the driver for acenic / tigon1&2
    https://git.kernel.org/netdev/net-next/c/e6b7e1a10cba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



