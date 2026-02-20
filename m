Return-Path: <linuxppc-dev+bounces-16976-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15680C531F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Feb 2026 04:11:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fHGy17078z30M0;
	Fri, 20 Feb 2026 15:10:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771560649;
	cv=none; b=dVWCxWmctOhweSa6wAkp8MYGE1uubvYjc5wiFmUlgQiQc6wLg94HVa6aMA+8wgLjs8vEKIv7wZCjeZiFhP8tg4N/aQnG9bbT60KCgPuUBK9YjQlpzhr2FZSA3GklUg4PzR1xZG6GIu1fbganpFckV5wEQ1O8dzK63AANEkMMI4RMM7uDk+nTrIOKZ1NqFmh3KZfP8Y1RMN+OBGRCWxVBT5tQiUZBr9b1DT7Xp4X3HF6zgvFxzGJLCeT8DgoyUufZlV47LrsYs17a+84QKHNgRw3YdNOcKI6yMLWnugfUkbl54NWuTDPycYDrxx03rExdQSRDUNDin1eRJ85dCunG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771560649; c=relaxed/relaxed;
	bh=85X6LrlIRj2s7TciepaBOqaUuq8laeZOb3hjpVqdg8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hef5o6Vh2ZMaNIbNUmRp4OEfnVLFhH/pQo/FE5FXhi7FeTTiPKrKPoqYIlv2LWD+X/mQOUpwwrojolvkyI2oMY7SbXZkzL1mjSQl7usxnJQdMXKR6oOcnE06O1MXfj8O1SR8x82+J5VV/+m4A2WyFMRB4ZXdc2/PkGDoWghQa+6cGoZ4iGWuLA47ax/JPqE46Z4Xq2MksBPcNsK7pCWzGw1PlLr1XtV4iWPUsZ7Nekxu4Bdy/0ictB416N9e83Y/UgDa++faG4f+5FO4PrGyPn3qTXuZ2o4AYDbr7t3kLzpnm1PbnklzN1Px0gzyhiYqlDUZyJWvFM8yVyLoBEjCYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UDXlT4Na; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UDXlT4Na;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fHGy1259kz3cD7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2026 15:10:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 570116187C;
	Fri, 20 Feb 2026 04:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4F7C116D0;
	Fri, 20 Feb 2026 04:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560647;
	bh=DjnngyKQ6dmi0gCTo1xCIRCHL1ludrKw3TKGvuwo0Ug=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UDXlT4NaQgzahQOt/dvMDQ39sYRD52/c4qNbvdVS19EyX+doX2VR1jGpM6fKTK5hg
	 rCFmqTKrXa0b5vcg1CKJuJbKtS2lu3bnOvOY1ZcjS8kyszRsQ2ihER7WY0j0/TjBVf
	 ESR58G8Wv5UXiZfVQgBBL/VOfCL/cCWmW3eJdCd7YiiZjvIc5PshOYVmUb7FMpdqCZ
	 VR22LNGw4/8tgtnLSks4YTRJWofn1TLmsJ8G9rz+7byiQ7KQhujWiVq++1aXqr5MNK
	 QsNQ2UwnhyOvc9Xw93nbkQEhuN5Pu9Vx+F7bxbEBDe/gC+mfrfvQgRuyWi/5t61Vpf
	 lawUTNXKdiYlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1363809A88;
	Fri, 20 Feb 2026 04:10:56 +0000 (UTC)
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
Subject: Re: [PATCH v3 00/21] paravirt: cleanup and reorg
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156065529.189817.17016822219300820690.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:10:55 +0000
References: <20251006074606.1266-1-jgross@suse.com>
In-Reply-To: <20251006074606.1266-1-jgross@suse.com>
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

On Mon,  6 Oct 2025 09:45:45 +0200 you wrote:
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
  - [v3,05/21] paravirt: Remove asm/paravirt_api_clock.h
    https://git.kernel.org/riscv/c/68b10fd40d49
  - [v3,06/21] sched: Move clock related paravirt code to kernel/sched
    (no matching commit)
  - [v3,10/21] riscv/paravirt: Use common code for paravirt_steal_clock()
    https://git.kernel.org/riscv/c/ee9ffcf99f07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



