Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D0606F680
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B37CRQpc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHq2N3Rl5z30hg;
	Mon, 02 Nov 2026 09:17:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793571436;
	cv=none; b=GqzyxVXx4WdRDToM9jzn9CarMCGAPWV13GzCjNmvWNc+/D1jW/ke5w4aKDGcTF0uof16KdJWsXFp2Zg/PNuquRCdV12MLxEQbLsx0bGJGJEVSlNlc3c4o97Cvl9lwCZn8pZPHEUfdoMCOvGO87g26a1ffo57Uh2KlRwRkNcfZ0kJFD3G4pQRtPZS0fPk/L+s0LUEcCjDT4msw74rYyheWySYB3Di7hTBG+NiRbpH70RoNAoPyjqaa8OFCAPsFcIsqH72Qv0uNNrgE4KOa1Oj/3vfPRWDmOwJ2+hu0qWsc694CtujOUMaiUnXxco+agBLm35jQfNyi9pOK+/0y5CzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793571436; c=relaxed/relaxed;
	bh=cjatygCmxk8XIyEbtr4pyzKJ6E60G4Tfi3euF78nVXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RknJOPWachFwdCiE2rZiA//3TSpyyuGs3oXIgmB/2NtESlTcrf1DoZPmclwteA1OzgoAhuzjPnnfQI0zf0oquYNInSPigBMe0jp1Oyh6TWLXq4Ew6xsTzlsm0fAeEicsUC8bAmkfEulnBMLNC/T8+gE0RUbLC8cq7KOAlUwI7pilvjE9tVdWnVNSYqzyF9jbAS1p7vrpkPMLhESsxyNGjlh5aH9uXlhIdEowA+I/IAHm6Vuacnye/J8b8c85Cdmtyu3midiAP5eZi8zemV4S9hEek5gZaeUqF/PqLj/WV29+hhDrWT6aW3CmRs6aaTeVrWUAnyKMjUVIvTaHxs1yqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B37CRQpc; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B37CRQpc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHq2M6j2lz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 09:17:15 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6C97643EC5;
	Sun,  1 Nov 2026 22:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF4C1F0093A;
	Sun,  1 Nov 2026 22:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571434;
	bh=cjatygCmxk8XIyEbtr4pyzKJ6E60G4Tfi3euF78nVXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B37CRQpcdmmwCy32vZHgPCWMyUptn49raCX3hJZVcxsEUYOsqHqKCUFeSZMmdrHar
	 P973m1II/ofRE5pnWqeiZvqWMGVRqsLIUP1n1XIX0nFBkKS0IRka2D7KopquB77g6O
	 Mp/unwfBnH0l1eqg07ua7p0Vs/LC2MTS3vGGD6h6owSUEaRNT6q1AXW/x5xBnzEQnc
	 EmKj7qUuyXmc8mBTkvUCHpgFrpk8n5Uq59fpbStEBh5xRF1iBXEyBMchINku/sQN+X
	 GTmMdu6UOejRm4ya75HKvjJSDVBqFLUssCE8lSC7D/wzZYaWR0EmUh/OpuxZjzWe5k
	 ui1FC15h7AaNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 403AC38003B8;
	Sun,  1 Nov 2026 22:17:14 +0000 (UTC)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] sched: Convert paravirt_steal to new static key
 APIs
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357143279.2624073.7781801497885838332.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:17:12 +0000
References: <20260819081207.12150-1-hongyan.xia@transsion.com>
In-Reply-To: <20260819081207.12150-1-hongyan.xia@transsion.com>
To: Hongyan Xia <hongyan.xia@transsion.com>
Cc: linux-riscv@lists.infradead.org, jgross@suse.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 pbonzini@redhat.com, vkuznets@redhat.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 kprateek.nayak@amd.com, jiazi.li@transsion.com,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This patch was applied to riscv/linux.git (fixes)
by Peter Zijlstra <peterz@infradead.org>:

On Wed, 19 Aug 2026 08:12:09 +0000 you wrote:
> From: Hongyan Xia <hongyan.xia@transsion.com>
> 
> paravirt_steal_rq_enabled and paravirt_steal_enabled use raw static_key
> APIs which are now deprecated. Use the new API instead.
> 
> No functional change.
> 
> [...]

Here is the summary with links:
  - [RESEND] sched: Convert paravirt_steal to new static key APIs
    https://git.kernel.org/riscv/c/a5576ebce920

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



