Return-Path: <linuxppc-dev+bounces-16973-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA19C531FC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Feb 2026 04:11:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fHGxw1ss4z30GV;
	Fri, 20 Feb 2026 15:10:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771560644;
	cv=none; b=gWBr/BDNs0ckY4k+WtC/EW5jII6najkYoYGKFFjrNOq/LoD43UYrPNvWaVUD9d46UATb1pafHm7wrgb8gP2NZYONtxGwIhOehvftPA17qyxK2WR1fTd189cUxhY7AJkzycSWk7Qhsg9XD7VBm+npPtwHCLMnPnpR8Tc4gj77SN6E+wblohu/f6LUtpY1Jyq88Ejt9fOiu/bMaC3S3MbsMemORlDjARWNPgyPBztg5hIQZjSqSUCgA1qtReqR3U9pFpxVeRygHQ8lqinjcbbMb3RTjwC1UUY6fOT1X5NxpSPI65Yp00X9gGrLpOZpPVCrbAwFcxgUrqOzDDHBuo8u5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771560644; c=relaxed/relaxed;
	bh=t1i6GfbQSWWiz3DIIdRXLB6UoHfhO8cTiXogFCF4Vmc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c4wmox35H7xa8oImwPYr6GTdhNbX5NYeAASCTrXkS5FudrU0hc1Q1nKoUbsE2IHs7ETS7s7yeMM+uzHREsr3fOMT66FhXAcDszoC026kVfy4mZn73S6E8URdxsZh7LTX/HALLCu7WSogXLNdsfv8+pZuRJ+KRIRsXgBs73qbH+4xdbqfnK1cCIs/U11j1PESFApXt0ocXx/a3n5skI1vuLuW9X0PeWwZk6Q7/lJS8KVVqW7EQSJYTlrXVQSsllnhI+pySxHmJiG3eBorSn4xPMYbgosWNCcO3TTnUKJkUEdJ6Hbssv/OmQpe5+t9+AqJVQKGeu8HzV7CjKIPk/0YnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oMaFyqG2; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oMaFyqG2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fHGxv32CQz3c2R
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2026 15:10:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5787661881;
	Fri, 20 Feb 2026 04:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D73AC19421;
	Fri, 20 Feb 2026 04:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560641;
	bh=fHDGQg8Y8I31uG+H3itYMHO1lNQuNdbaHv3s+w2VA9E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oMaFyqG2bTps/8USOYgV6sHoWWaZWkyD8fr7yLmY5l7usrVYWzQZzpzEhFrj5oIso
	 JsHHbdcmGWZfgObZBMrrGYnYu32BPlMnnVgwwSDA1ys0qiJ1qOLadxN3JSuLSdLeIV
	 tnZk2pdJNKsAWT931GvGXNP4fol0h+61TmknQ8GSGiCMQCV6UL7UDupsNR66mU84jY
	 Uf0+Fkd9Pj07dGm9AzWla0qfC5/ONLfwGajcUnLXdYT+BVuNcuJZmO6sBygjchoA7g
	 hhSIJI8pnZDmIXMjKC9Jz5/fJyymINQf46MMxuBF/t5nZ792GREhqQxlQeEORgXYm7
	 E3Z2SpOIzWr4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0853809A88;
	Fri, 20 Feb 2026 04:10:50 +0000 (UTC)
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
Subject: Re: [PATCH v5 00/21] paravirt: cleanup and reorg
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156064929.189817.13253801870624912064.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:10:49 +0000
References: <20260105110520.21356-1-jgross@suse.com>
In-Reply-To: <20260105110520.21356-1-jgross@suse.com>
To: =?utf-8?b?SsO8cmdlbiBHcm/DnyA8amdyb3NzQHN1c2UuY29tPg==?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, peterz@infradead.org, will@kernel.org,
 boqun.feng@gmail.com, longman@redhat.com, jikos@kernel.org,
 jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 boris.ostrovsky@oracle.com, xen-devel@lists.xenproject.org,
 ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, linux@armlinux.org.uk,
 catalin.marinas@arm.com, chenhuacai@kernel.org, kernel@xen0n.name,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-arm-kernel@lists.infradead.org, pbonzini@redhat.com,
 vkuznets@redhat.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 daniel.lezcano@linaro.org, oleg@redhat.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Borislav Petkov (AMD) <bp@alien8.de>:

On Mon,  5 Jan 2026 12:04:59 +0100 you wrote:
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
  - [v5,05/21] paravirt: Remove asm/paravirt_api_clock.h
    https://git.kernel.org/riscv/c/68b10fd40d49
  - [v5,06/21] sched: Move clock related paravirt code to kernel/sched
    https://git.kernel.org/riscv/c/e6b2aa6d4004
  - [v5,10/21] riscv/paravirt: Use common code for paravirt_steal_clock()
    https://git.kernel.org/riscv/c/ee9ffcf99f07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



