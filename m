Return-Path: <linuxppc-dev+bounces-16972-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E825DC531FC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Feb 2026 04:11:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fHGxt5Rd7z3bsC;
	Fri, 20 Feb 2026 15:10:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771560642;
	cv=none; b=kbctFNToHdebOpaH0+w56ubJ/gMKDkwIz5W9PAGHhosbogNKamHi7pvxj4dJTEi4MsUbYuRpDye+F0Kq19jC0WczNDWMbBVK4CI22Ndw6fYy+hazMuR1WzZRya5uz/y/u8NoNTzBy76WYkbObjizmNGDm/HEghGMIaLiGaZ3BTG+eN4/L6EHePi+b9zfxX/pcuYdFrdT/6asGcb4MN0uhZkpXdoq6TPddK2VmAAdEHbEZrtLao2ZcNSfZdpaxsfJYtsWwtRqWKEXS+DMICE+GT9nMvW4bf8tJoaD8sccu2tyxSNL0gmci3ZrDiRfLOBiJzjm/2ylGiIDz3RQJxDEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771560642; c=relaxed/relaxed;
	bh=BGGbY5rm+PValxQh45K67FA4WURimnqNKigpk6LpFDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lx7LKsXLPUk4o8oKBtbk8ApDRnG3brxbpFFWlSwSRuluRt0LPzRbfWzioaYIIVEEgN5dO/lOs836QrN80YdjoPwfPmkbq6tyX/5ivCc7evVHZwNjLvift1ga2gkv92ub1zoMgi9fHPgr+btdX1nA5Ozx4wEmhVBWE2x7zTZjO9yI4CL4d5wzGd8EI+a6fxBF6AkU7k76uUdhMKzcabScZ6AIlRG7qBN+3EXdjj5BPA29D/Ge9Sc3j0hUT70Z6Dl2/1Mq6v/u0qSk3TgeKQ3onAbYfi9fWctT0egigGdyvJbBABA0GgdikEJl2iqGp3+d9ajoeIf/WHX69DZD0aefzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IVx2kUNS; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IVx2kUNS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fHGxs74PZz3bZm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2026 15:10:41 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D938E61887;
	Fri, 20 Feb 2026 04:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B270C2BCB0;
	Fri, 20 Feb 2026 04:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560639;
	bh=0PM3EvHMCr8BvaAe9tsZy3ke/nSbfi2Vm8wcUfyZoLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IVx2kUNSxwdn74f3azX658a2kTXvhnAo2uYJ0bpEMr+c6aO+cz8pL8626VIS81zgm
	 Hm3ohw27VvABIpU01I09pS6tpRkCKzGBFkizfiQXloXkQcFj535JY1NtJlcUUz/yQz
	 zI76CKiCR6bQjllggKkYdueNsdTPXwg+xKkV36RH19CiBgxQu7xPPz0+xBQu5qw0M6
	 vwGsQ+XlvFXFuRYrufowmz9SeyWMjUvTD8CENbNArppvg1nbNfcMdcv3TryDcEhFlz
	 q/Og6P925mDm6YJX8HiVuSIqJEiyiW79umNtOcgxrYOC5QBWJMXHsx+jot4W3TOkKB
	 m8Y5bX+jeVa3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE3B3809A88;
	Fri, 20 Feb 2026 04:10:49 +0000 (UTC)
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
Subject: Re: [PATCH v2 00/10] kbuild: userprogs: introduce
 architecture-specific CC_CAN_LINK and userprog flags
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156064779.189817.8600732238018283033.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:10:47 +0000
References: <20251014-kbuild-userprogs-bits-v2-0-faeec46e887a@linutronix.de>
In-Reply-To: <20251014-kbuild-userprogs-bits-v2-0-faeec46e887a@linutronix.de>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Cthomas=2Eweissschuh=40linutronix=2Ede=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-riscv@lists.infradead.org, nathan@kernel.org,
 nicolas.schier@linux.dev, nsc@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, tsbogend@alpha.franken.de, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, davem@davemloft.net, andreas@gaisler.com,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 masahiroy@kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 sparclinux@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andreas Larsson <andreas@gaisler.com>:

On Tue, 14 Oct 2025 15:05:15 +0200 you wrote:
> The current logic to inherit -m32/-m64 from the kernel build only works
> for a few architectures. It does not handle byte order differences,
> architectures using different compiler flags or different kinds of ABIs.
> 
> Introduce a per-architecture override mechanism to set CC_CAN_LINK and
> the flags used for userprogs.
> 
> [...]

Here is the summary with links:
  - [v2,01/10] kbuild: don't enable CC_CAN_LINK if the dummy program generates warnings
    (no matching commit)
  - [v2,02/10] init: deduplicate cc-can-link.sh invocations
    (no matching commit)
  - [v2,03/10] kbuild: allow architectures to override CC_CAN_LINK
    (no matching commit)
  - [v2,04/10] riscv: Implement custom CC_CAN_LINK
    (no matching commit)
  - [v2,05/10] s390: Implement custom CC_CAN_LINK
    (no matching commit)
  - [v2,06/10] powerpc: Implement custom CC_CAN_LINK
    (no matching commit)
  - [v2,07/10] MIPS: Implement custom CC_CAN_LINK
    (no matching commit)
  - [v2,08/10] x86/Kconfig: Implement custom CC_CAN_LINK
    (no matching commit)
  - [v2,09/10] sparc: Implement custom CC_CAN_LINK
    https://git.kernel.org/riscv/c/dc2f4d41a6b6
  - [v2,10/10] kbuild: simplify CC_CAN_LINK
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



