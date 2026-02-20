Return-Path: <linuxppc-dev+bounces-16974-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3794C531F8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Feb 2026 04:11:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fHGxy6Bt3z3c9j;
	Fri, 20 Feb 2026 15:10:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771560646;
	cv=none; b=dYaa1BuC1gZIAEb/Y9FmFXwwVyMvzZHWFKaUBQ3pdqK/y+YHDEmEYxen8oakkgob2+NhIUC4bH1KXfdQr+fDwRL1k2GcHqdJXYbdJTrqnv7vrFoWBLz3Ibj8GTT8xi26yWL+l0ge4kuPGQWmvudV/EDUp1tuAX2dq/bfcgXeKgT7Q4ln6haxUHKID0z0xm/w6pFFaFQcU5S7CkB6VxzbP4C5I/T3BDKRe5XtSHZ5tBSCnyvmRz76yW3Bk7pWZJxIdy133U9KizbdKMa2QJvlBD5VbP5Cr2PG6yqyWxlobuqu6K1B5RlVn9Xh3mXqLWHiE/plH7DkyU191eWcrDViyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771560646; c=relaxed/relaxed;
	bh=XFlDqmhUmMFjkdXfqdahfH8RQIHDSQFC6boian13vfc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i0Sd687AMyP5Da7b3MCbfLjaLvOTpnWaozd8dL3ne6FgUwLX5UCiLOJbFZkYTWliKHVSIKigSuB5N15yhEyyCAG7MjQGmYzy8h9Y7F7/lmZAYBYsSvpbMKue2zslGVLdlcQW6GoF/37DGzjQZLLWNIW0MV5AyvO4JHpLJ8Js/H6mYcgRvpxKuPeREpIo08b8wOmN3o2RImC76GCcfxpCEXdypPXehSaIn0qbpIaakJbdm5tkPxwPPafOXhoraHIq0NY/H6zMKY/gi+bnZygCnlrWQy4LUTdMH419pkDO611OBLgWeJjB7loiQCrzwUFcMH3iyxRd+V2MPveTuASFkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZfEN0rlH; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZfEN0rlH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fHGxy1z91z3c2R
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2026 15:10:46 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 53AFD6185B;
	Fri, 20 Feb 2026 04:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B127C19424;
	Fri, 20 Feb 2026 04:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560644;
	bh=g09K8+pt8nUze9Hd/5SkOGsluvmQyHLde4mLYIq1BN8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZfEN0rlHPk8mdiuu5VESUrjU/twd6VLsvz/4HRiuTXOLUA0QGdTKOnAWZijQbEGko
	 JR6DJZ5WjmduRBYlCbFS4CxEfJWD19QQfEQQpy6HFbLPFRtsNfpzlrmaR46thV1I8j
	 UdOoZFKthavVmxK7uqAy28sD9HMEMXCOdjPqDiPDEx3Y3X7Xj44bEXYx6JH+HlQzKv
	 c9UK4fwkutBwaCFIjgaZ8E5+sihv5O9Fp/qjCPWPvTIQXqqT7LYjC1vCZaTEPqeA4q
	 zE5QjdDoR5nj4iQSqf1O55yvD9BqvZaCRV0Q8Zi2oM2S6KoYe0NZrJkPstgPyQYwoQ
	 Yme0l22kE7D7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FE13809A88;
	Fri, 20 Feb 2026 04:10:53 +0000 (UTC)
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
Subject: Re: [PATCH 00/14] paravirt: cleanup and reorg
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156065229.189817.8309653371345159867.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:10:52 +0000
References: <20250911063433.13783-1-jgross@suse.com>
In-Reply-To: <20250911063433.13783-1-jgross@suse.com>
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
 npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-arm-kernel@lists.infradead.org,
 pbonzini@redhat.com, vkuznets@redhat.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, daniel.lezcano@linaro.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Borislav Petkov (AMD) <bp@alien8.de>:

On Thu, 11 Sep 2025 08:34:19 +0200 you wrote:
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
  - [05/14] paravirt: remove asm/paravirt_api_clock.h
    https://git.kernel.org/riscv/c/68b10fd40d49
  - [06/14] sched: move clock related paravirt code to kernel/sched
    (no matching commit)
  - [10/14] riscv/paravirt: use common code for paravirt_steal_clock()
    https://git.kernel.org/riscv/c/ee9ffcf99f07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



