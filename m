Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C34606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H6VUGaRs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZHSC6sMTz2xjN;
	Wed, 25 Nov 2026 22:26:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795605979;
	cv=none; b=d1cIvUZiLMdBZ3P59CJoV6qLGKfnRRkdQ4OJEKAQdC247VylrbGG9ZUnNl8A6pSG0dz1JUsJ6jS5unjKjUhPO7qgr601ewOCh8eJsrwquN5+2rH7vbGJdts1sr3b/8Mzx/t8nmY5QLS8aUJUIsaVNjrCgdVDQRaTui1+pcQPhYdbmRkln6oSJ+sWVYamrCJL4yvGRQfz8n5HIh3kgeWtu0CYYJLS0JQaJsZhRCOxt5wGftSYGdyWoOLHZCvrHRzo1gAKT4n30TJJ2a41ZGmID2EPT+aM6mE2ls2lK1GLgUIBovZqYL3EEn1MsCLjHJRE9ap/0Jy5QK+wyIzQD6IJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795605979; c=relaxed/relaxed;
	bh=OC4Q2zWXuivKEV3m6bSW+hewTlyeDz+wr0tU5oJTBu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=drWI1j249XYHlCTdi7TxHeVldlFK3+aPdBq2UC1B0SFjZ/ABDOdB+/KTwLdJ/2h+nnuQ1jDk07EPMHMMyksVaXR3GQMiEO1XzbhDnymUnXJcR+WKsJG6uUaLvoAoqRQfuqCiQ2/Z94AFudico0sr4ysdkNy2WH5o8jQAbanP2LkP6imribz6xF4Kjc7H5JOMtDRV8dq0P7Rn/duuyx29muRLL4u/KzrXz/sMv2tAQiDSyIGBncWTh8Kq9R2Y/D+S2hnc/K+9Q0DVHTYKnVtb2TkbzCelcFt18U4syHoKLBncYBjAHoS8FIVv1imp6XZEX3DGBYCpd661eUVqZNDgrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H6VUGaRs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H6VUGaRs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com [IPv6:2607:f8b0:4864:20::122b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZHSB6P55z2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 22:26:17 +1100 (AEDT)
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso7434663c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 03:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605976; x=1796210776; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OC4Q2zWXuivKEV3m6bSW+hewTlyeDz+wr0tU5oJTBu4=;
        b=H6VUGaRsoiOBYDzc366rdfIIYQlqFWo4Wtm2z2X0Wcee3M5AMe/nQYWHlY9dNmI7Zn
         s6TU7/IT2MXJ45NYrFEyHosHGqvEGguCAH7zWWvxdC0pkx3n5ArxcwSbNtFZCmjTjBGX
         1ghNS0PLsDsuUIK2zBBmuxH/WMqBhPRjC/bF8rQ70y9R0Tqrh1aIvm+LlzYIcPtZvAD2
         O3n9kv+oPPz/EkcrKkENSRgVbdJGK5SjaXiuxxLoV7wQn9r9kKWLGYJ96dELvUkhvOEq
         co/9eOMtG5I4bG2Xf5eupoUfe/8mAPtWsf/w3HW5RGEl+qqw5qaeevR05XmXDAkFl2UZ
         f4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605976; x=1796210776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OC4Q2zWXuivKEV3m6bSW+hewTlyeDz+wr0tU5oJTBu4=;
        b=Kcq6mBpT0knzGd7Qc70ytchLMUIKLanjpXUYn9rfm9gEu2dT8NsfH4gi02NiG4vJWO
         g4xWVJ7XrczSJf0gGfJWTcW2pGUt3aq2bZpEs5dfy/sGh/cVhVD3ZHNBQSfl+mGc5cbM
         Y4Z3PU7o/SgPMeI1IC2Of06AN9fgDRH+8gZo+lJbJZdEbAc0YKoI0scLE25pLPYZ+rpL
         LXCqVNePuEHJds662MrFnAubNJikbxKI+eBjof5W97rwZm3sHPBmCfY55SB/nQMQyq4z
         9IM8GGBcogKo7QDdOI/vxhs4FCVCa1zkt8z8zIkmIly0dgluYw3QVheIc5UxehkSK3+r
         NAiQ==
X-Gm-Message-State: APuU4Z/ZOjvNeFGYcFeDWOoe68O88NOEzRGRDuSA1zGAuYOsNslaxQIp
	KiSEKb8Bu+Z4Z+0zlrr5DSz0r0x6pNWsVRuVhj69h4CvnReGyyk8NZhBAAQAJw==
X-Gm-Gg: AZFdTZfZ+4q5/c/4018Vz6AAzIV0O6HlPinHbVcZZK7LwPsmxWJ/L2KN4WBF6nhnvo3
	WtCcKvuKlA8qijOYdA/aJlj5JzvWg9FzDMVoZ/oqUhhwES35f8tcDUOJyEZU3HlJvK7SkgCJXjR
	DwKl+nXgoZkoW02S3fKbQwho34YHFljQY1FY+7kC7QaE5+LeINA6o/hY/+MtEoUGKAM1XeK+Zc1
	J2BuNau5r4bLdL3wvnq5eWnI3HKp+vc3s1dCQpR3pGg0n0kkKR0sQK3f7TmH0T49pMLzlkcDNPx
	HcPjwXAyPLbmiD09uLJoEJBYMsMQ7N3LrABArE0Q9jHyy9JMLcCGtnjmBFowy36MapEcRhOENG2
	YLKT+z1bRYndsFO43mzAbEj6RzILYYa6IFg657RFDfNWql+cy5ITF+CEoXx8FOXLBgbUek/6FVP
	dm7WYWAj47De4Kh75YJla7NpUyA5Z6mQJRRlFgPU4L5DtVXoucVLIOaidLOlo6794RsMn7tZjkZ
	NioGP0Y3jXTgt+/4iAMkmM9Lns2Ad3VwRhSCTux7q2JojKyt8PHqistvxEeL+8ygP3b1hDd8b/v
	/LN/8gQofpfuD44rZnRHlPGVXmm1lWwhrw==
X-Received: by 2002:a05:693c:87c8:20b0:386:ac97:f661 with SMTP id 5a478bee46e88-386ac97f9cdmr9061603eec.9.1795605975654;
        Wed, 25 Nov 2026 03:26:15 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm11778380eec.17.2026.11.25.03.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:26:15 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv4 0/4] powerpc: Misc fixes for debug kernel splats
Date: Wed, 25 Nov 2026 16:56:02 +0530
Message-Id: <cover.1795603946.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enabling debug options like PROVE_LOCKING, DEBUG_PREEMPT and
DEBUG_ATOMIC_SLEEP on powerpc64 showed these warnings.

Main motivation for me to look into this was - many folks internally reported
that after generic entry/exit feature, they aren't able to use lockdep because
of the warning splat it generates during boot, after which lockdep gets
disabled.

Therefore this series is an attempt to fix the warnings which are generated
- when we enable these various debug config options.

v3 -> v4:
=========
1. Dropped notrace in patch-2 - Mukesh
2. Collected RB tags in rest of the 3 patches.

v2 -> v3:
=========
1. Instead of calling lockdep_hardirq_exit() 5 times, consolidated that once
   for the entire duration of __replay_soft_interrupts(). - (Christophe)

v1 -> v2:
========
1. Patch-4 fixes a pre-exiting issue pointed out by Sashiko.
2. Patch-2 and patch-3 from previous revision is re-arranged.
3. Patch-2 change smp_processor_id() to raw_smp_processor_id() since preemption
   is already off - (From Shrikanth)


[v3]: https://lore.kernel.org/linuxppc-dev/cover.1795441238.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (4):
  powerpc/64: Leave lockdep hardirq context around replayed interrupts
  powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
  powerpc/kvm-hv-pmu: Don't allocate gsm/gsb GFP_KERNEL allocations under spinlock
  powerpc/kvm-hv-pmu: Free hostwide stats buffers if perf_pmu_register() fails

 arch/powerpc/kernel/irq_64.c   | 19 +++++++---
 arch/powerpc/kernel/watchdog.c |  6 ++-
 arch/powerpc/perf/kvm-hv-pmu.c | 69 ++++++++++++++++------------------
 3 files changed, 52 insertions(+), 42 deletions(-)

--
2.39.5


