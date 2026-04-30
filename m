Return-Path: <linuxppc-dev+bounces-20323-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAD1FF8875
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 03:26:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5fhY3d7Jz2xl5;
	Thu, 30 Apr 2026 13:26:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777519565;
	cv=none; b=lKl6ceUaTX63zFjSUjszQDyuMNVeLUo3e7lc1lFtySTzW/uZYEIaPcaDI/mIA5c/NU3+AinGD8xUa0detpVvtDx6PuNMl+SPH//3u9lqgSdhc1169hnU/lDOQ505znxTCqmSTG1ma7pMdP4lzBtzZl1daBpdXCkhA6+E3gWUc6PTuaW/Q7CnupQyY5K/DFU7PJ+D0FU1mGsP48p0jN3PLX5PxZ0xqiFeZILM3eVtYiXUcQRPbGN2E17ObcSNIOi4PiTrwYfi7Iib4aY4lykeuBeFZ6dyfdzuG8eCYuWpdkqB9l/tIP8oCWh3u/JeCRZrW1Dz4YI3rNIC/zBHiwPhqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777519565; c=relaxed/relaxed;
	bh=xtZvvFsn7ntOWmU+f+LKjcOxYAtpK4lZ2ZorwARbkMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CkKXk4j+npa57iz714sn6fFKbzTYgnqp+hKkVjEbadtl6VO7CR5phGA9kLLbSHDDRUOkaNnoL3jKp+CdAcRjn88akSuvN7xDums7gCPmXR5aaR7wzjtjiZw02AAQgRjSlUkym4U+jY1Od0Bjz8k8YgDj91F9VUQ+G9G76fUk0I6pivVDzyXZJHo8BTfmv+X670iwuWgnc8KT11xRG0OtfpwF1oyK5Mi4vjMf+CfE/vEk74xP/IEXPQ07L0kDi6vUnowLSMejekDYll1pyRFdF66C2Z9by/2mGuyoMtDNleusYDQKnimgFSq39L4JPMGoAj7uMKGe3dnn/TUqGDnx1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V2/IHGrf; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V2/IHGrf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5fhX6sPgz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 13:26:04 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 40E9243B2D;
	Thu, 30 Apr 2026 03:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2178CC2BCC6;
	Thu, 30 Apr 2026 03:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519563;
	bh=uKdK5DO8u2N0tp/g6YrMeqTyIWEtsNmEtR2OQZOamME=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V2/IHGrfyciCnZ68jtYyLcCX+9M7ThJMZaRbPHBvBmKoRk+K76qcgOuTXYyo/kQf/
	 h5OTplRTliCc4X63Y6FlfrVyvAdg5KYdnsvxSXwm9hkZAf8pdGxkdX/t+wSKmPKykm
	 3o2z+7QFO6wUIvvg+B0mdIk+nx1z6uoJGIDFvup9VAMO4drdvfxfJ8iFN05E11UcZy
	 rOwhunXd1D1ig0KRo5uu1vq5DA20gcZZ1Y5ckR+SNFRn+SNJ3mB2LionwukPg6k1ck
	 b3Kp9ZgtCTOh6fyut2FuoH+jqJa7iiIMSyJ3HPmYm6RuG1wUntuJYtMYTQhd5hUjoS
	 OIP4lynLo8F1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFE43809A07;
	Thu, 30 Apr 2026 03:25:19 +0000 (UTC)
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
Subject: Re: [PATCH v2 0/6] change young flag check functions to return bool
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751951805.2274119.14382362682727203864.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:18 +0000
References: <cover.1774075004.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1774075004.git.baolin.wang@linux.alibaba.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Sat, 21 Mar 2026 14:42:48 +0800 you wrote:
> This is a cleanup patchset to change all young flag check functions to
> return bool, as discussed with David in the previous thread[1]. Since
> callers only care about whether the young flag was set, returning bool
> makes the intention clearer. No functional changes intended.
> 
> Ran mm selftests on Arm64 and x86 machines, and no issues were found.
> 
> [...]

Here is the summary with links:
  - [v2,1/6] mm: change to return bool for ptep_test_and_clear_young()
    https://git.kernel.org/riscv/c/a62ca3f40fea
  - [v2,2/6] mm: change to return bool for ptep_clear_flush_young()/clear_flush_young_ptes()
    https://git.kernel.org/riscv/c/06c4dfa3ced6
  - [v2,3/6] mm: change to return bool for pmdp_test_and_clear_young()
    https://git.kernel.org/riscv/c/42e26354c4ef
  - [v2,4/6] mm: change to return bool for pmdp_clear_flush_young()
    https://git.kernel.org/riscv/c/2d46a3974721
  - [v2,5/6] mm: change to return bool for pudp_test_and_clear_young()
    https://git.kernel.org/riscv/c/fb87c8827297
  - [v2,6/6] mm: change to return bool for the MMU notifier's young flag check
    https://git.kernel.org/riscv/c/1fc7dc675e26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



