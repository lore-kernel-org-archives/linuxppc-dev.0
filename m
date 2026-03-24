Return-Path: <linuxppc-dev+bounces-18663-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A557BF532DD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 06:07:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg02B0Ts7z2yj3;
	Tue, 24 Mar 2026 17:07:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774332465;
	cv=none; b=MRXKu5wu2L/jlAxa2+6Mu6egVg09P1mMJUpsvkKo2R5EBjZ+tS1Dwr0dFZVZLREHdEWcOOe2uV9EhchdEso6R0dJRxwgjrwNRklffoGz9h6E+evEoIIXuzsXXSAh5vM3iC53bUuxklVI+TFcc9k1W3K2VIPof4tSTTKDEbVYqp+dyqqwSiLAjnX1IppZr3YCO058ByFOFfZg/pDS4b+V4qbKkR/Xt+OOfs0lzWCJ1ZNQpt7m8//WJt0aj0eHajtWkaxGtTPlh44IXf9NRxTGcoKAFHy9PLBGRPZ4dn/eyh96+mcwpmC8NmU3xTMYmqbXVNvk915tEkeyJLKofntY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774332465; c=relaxed/relaxed;
	bh=dXpko5GwTyBS4/QPa5Hu8dVzEEkgR8sHL7mRRu2t+sY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FGVF8Uj2pMqF2X4t8k3AAypbmHwtRSn9s7a5ZEodd/s2MzGJR303P7BWP/Y/3Cb8I40C59TpIm2fHdzvX3f0rtWdX8VVVamgIWPZab38KbwIQTZOye1U6EBaEjU82nVw3N2NpMeEQUnvRNIiU6f/rNKFuFkgoXnPqhPDevHkJffxoDJagAUM9YdV86+zXts2mpB4RbJzpiI4kKtjDYpxLFTEBIOMH6J2AFZ0lcpSHPmiCogRIdDbyvLhYuEEg/s2GVfrvou4HQ//IEn9826wyXDoYX6tcBTmLsXKpDTcE5fiMrsy0rywn/H0q3IEMfKLLcZquvOGzEQ5ydTQaHM4vQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UbNGnKO/; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UbNGnKO/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg0290djWz2yhv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 17:07:44 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1E4056013A;
	Tue, 24 Mar 2026 06:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10D0C2BCB2;
	Tue, 24 Mar 2026 06:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774332460;
	bh=JP9ahby6Ly1VVw7RxM4srHWXaEIozlGHAWmdpUP2jJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UbNGnKO/tp6ai6834ydA1lQ5PukSdo9guTKRu0aT7uQ94/PBq34Vo08i3GzwU1a7R
	 Cjj86a0rKtbPKnF+oVKFGyOV87WahqlGOu4eDV+h+S5j7x4aPhqGuz+E/DJGQoXOGA
	 wBe47f8pbr/WXEHhTZzzJBCJP9XHj+6UqfGOLICI3RcjHw+35Cz5SRZZcw7k7C/zYj
	 XUieDNECgaPKML2nc7pDk7PgesQln2TdJXIciFo+QXEQm2NonZFnC2+3B6gKw1+DHm
	 Z40BPILv5vYzesqn1zNeeb326JjYakJK+jDAuKVLcvEKgQfH7daPPDxWve9mnoaYbH
	 fSR6hO6kwysDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE5D3808200;
	Tue, 24 Mar 2026 06:07:30 +0000 (UTC)
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
Subject: Re: [PATCH] KVM: Remove subtle "struct kvm_stats_desc" pseudo-overlay
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177433244873.469836.2501898935183219197.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 06:07:28 +0000
References: <20251205232655.445294-1-seanjc@google.com>
In-Reply-To: <20251205232655.445294-1-seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-riscv@lists.infradead.org, maz@kernel.org, oupton@kernel.org,
 zhaotianrui@loongson.cn, maobibo@loongson.cn, chenhuacai@kernel.org,
 maddy@linux.ibm.com, anup@brainfault.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
 imbrenda@linux.ibm.com, pbonzini@redhat.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, gustavoars@kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Sean Christopherson <seanjc@google.com>:

On Fri,  5 Dec 2025 15:26:55 -0800 you wrote:
> Remove KVM's internal pseudo-overlay of kvm_stats_desc, which subtly
> aliases the flexible name[] in the uAPI definition with a fixed-size array
> of the same name.  The unusual embedded structure results in compiler
> warnings due to -Wflex-array-member-not-at-end, and also necessitates an
> extra level of dereferencing in KVM.  To avoid the "overlay", define the
> uAPI structure to have a fixed-size name when building for the kernel.
> 
> [...]

Here is the summary with links:
  - KVM: Remove subtle "struct kvm_stats_desc" pseudo-overlay
    https://git.kernel.org/riscv/c/da142f3d373a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



