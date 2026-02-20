Return-Path: <linuxppc-dev+bounces-16977-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5F4C531F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Feb 2026 04:11:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fHGy33zMRz30Lv;
	Fri, 20 Feb 2026 15:10:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771560651;
	cv=none; b=UW3a/Kvz5BwqUcJ1VnYtI+VYpt3tDpA/DJKr95dVTcKbItzFF2u5iCf9zfyLRpOsG1HNdLlBArSASBgSO1XfaVmMB/e3vsGFOx0P88EqmTwj6KlD1b2nCFarxreMt7kYnEDNMODlrGlRIFObVt770kblOMa/QJjjURu6QrqXuRUG11WNvMmc2u5CspYviZkwWzxj2kUjpo+Vdgvu28KrS05hHGmnXSuwFcMZAqly+GviGkRxF8ZRDxsZ6hkeCa7dHG3FbBcYtkOaDD/Rb4fExGEPVGk+qpSQ3fV7NYLGWJ5DCVitPllOjbvoC1qmUDpTSIuK/LB2PsvvmEQ87Zz7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771560651; c=relaxed/relaxed;
	bh=hEuOIOFl+OXtTAi2wvB7QvE0SEEnhMLEIyOpRWgzlTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I8rl98g3U+rBtgrhSasTuTRpLvZIeW7/lmmcBIjLatEsc00n3cmUXCs+TF7xE07JdWN/dnO0Zwf1fddz1nECRm0Cok/DrmvH2WLkL82fxx+vrWYBdm60EGP2MShI3O5aHspXzCpJURLWhQ0AH5PjZMk6JggWhgtKqcSQJT+aj+P6Ay+pWNAqpSMYBuks+9xsU8koXQd2X4mPxXwJ1CudNGsfh1RxzL6EhBAszFAjSM2atmVTI3H5WBbobOverALOPsbiWof0Jvfv7ZWrmuF7nZihqeCcRZBe0VKyA7Ep3IY1++aKFqfiy10mBeIh9ygRojcWIuMPBTgGkpYC5G+qTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YQ0aOCCb; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YQ0aOCCb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fHGy25Kk5z3cFm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2026 15:10:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CC5606184F;
	Fri, 20 Feb 2026 04:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94005C116D0;
	Fri, 20 Feb 2026 04:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560648;
	bh=PDGCDysOegPLK/FytUAeu19yfLdHed/5Qq2CJVsDdvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YQ0aOCCbuBRr/Aj8Xu6A2nQTmM3iuzSUGERzFgZbv6JdPxvdz+pC4pQ7N+j3/AeDI
	 ZR1+txPjQ18ja/OqZDa5/Nv4iP8tYkbr0J5tyqjvHLDgH87Rd2ShE1YzmIdowzD/RD
	 CsPYoHLNtIYdNoA3PjI4oImf1wHzn1ACCU1aY4WmuUFHjoSbr1VEqO81cRnWBfE1Fl
	 DtF5oGuWhKxoo/nfAA+KyC/Cal3t7yAW3TFJKawNjmzwjn3ZBgsbHgfplzpD3KNJeR
	 8FbCY63LhQSnD4N4iCdVyw9b+7gQBNb4B3wZrehtaZVPNIMqMLJEjzFqPXwYkXzjTS
	 NlPxhLiM8yB3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD393809A88;
	Fri, 20 Feb 2026 04:10:58 +0000 (UTC)
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
Subject: Re: [PATCH v4 00/21] paravirt: cleanup and reorg
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156065679.189817.6221298327341838079.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:10:56 +0000
References: <20251127070844.21919-1-jgross@suse.com>
In-Reply-To: <20251127070844.21919-1-jgross@suse.com>
To: =?utf-8?b?SsO8cmdlbiBHcm/DnyA8amdyb3NzQHN1c2UuY29tPg==?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 peterz@infradead.org, will@kernel.org, boqun.feng@gmail.com,
 longman@redhat.com, jikos@kernel.org, jpoimboe@kernel.org,
 pawan.kumar.gupta@linux.intel.com, boris.ostrovsky@oracle.com,
 xen-devel@lists.xenproject.org, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux@armlinux.org.uk, catalin.marinas@arm.com, chenhuacai@kernel.org,
 kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-arm-kernel@lists.infradead.org,
 pbonzini@redhat.com, vkuznets@redhat.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, daniel.lezcano@linaro.org, oleg@redhat.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Borislav Petkov (AMD) <bp@alien8.de>:

On Thu, 27 Nov 2025 08:08:23 +0100 you wrote:
> Some cleanups and reorg of paravirt code and headers:
> 
> - The first 2 patches should be not controversial at all, as they
>   remove just some no longer needed #include and struct forward
>   declarations.
> 
> - The 3rd patch is removing CONFIG_PARAVIRT_DEBUG, which IMO has
>   no real value, as it just changes a crash to a BUG() (the stack
>   trace will basically be the same). As the maintainer of the main
>   paravirt user (Xen) I have never seen this crash/BUG() to happen.
> 
> [...]

Here is the summary with links:
  - [v4,05/21] paravirt: Remove asm/paravirt_api_clock.h
    https://git.kernel.org/riscv/c/68b10fd40d49
  - [v4,06/21] sched: Move clock related paravirt code to kernel/sched
    (no matching commit)
  - [v4,10/21] riscv/paravirt: Use common code for paravirt_steal_clock()
    https://git.kernel.org/riscv/c/ee9ffcf99f07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



