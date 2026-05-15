Return-Path: <linuxppc-dev+bounces-20986-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E1ECD343F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 16:04:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gHBpx0Kzwz2xnH;
	Sat, 16 May 2026 02:04:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778861081;
	cv=none; b=lkJC37L7oTVWru4B4/XKPkUhVWCJWRCNa7cBYmmefu5tvpQ3WWJteZsTbRmafzUl9cZEGPsLxfkAlt3Xyea6yLAgLK4sd0PdAGB7YM0FeB1lan1nA/GyRPmE392twk8FYEam1T52o/kBP/64bH0mxOYIvPaVgUFBw9j7bVXFwViZwCKChwErwN5UlVzz2cKmSHsZmWrneFPB088kUtyR1gR/JcewyZfu4S3AzSLDDGamLdACb67RQFqCycrngymuA6O6jmEskFtqY2khTyIwibyiX3C5lms7fvnpP2E7Jsv1rl37ESClLhm9FTYrLXWmsMTYYz+OUDjc3JBfavWfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778861081; c=relaxed/relaxed;
	bh=/qI88RwCNnWnFb4fjGmxbgcnIrnRtogWwTEfP7LNxqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ejJKImM3p4A2V0dFBAsWmk18V+cAxk9X76mVIQtuZOfMxmQdRZIberb2EEwj+X5Ue8a+qWTAenmgLzuHGLcuDf7gHS1J9MH1qVHOBadjM9K/6ypstlISvQNZMcnl8Lrc0kNBb/RbqMo9Es/mFUsIaPDFk/zLGVjF8moZgzO8nWv+Z6e3SEjrRJwRfGS/hiGREpy1h+t3eSdW4gu4KzSRJhKo47qIZCrExx8ve1HSpe+hlH1tp/ynbNvNaXxhQspxVtEnWyd/9UDwmMjuSOwPcNAwjnkvTNpY85Tt7Mk5AeUbmUnp51WJmxcRzX/2HUgZC1S2nA9zVAiNBelxyVHPGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i2qwBvff; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i2qwBvff;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gHBpv1TxFz2xTl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 02:04:38 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-83975e992e1so4685413b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861076; x=1779465876; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/qI88RwCNnWnFb4fjGmxbgcnIrnRtogWwTEfP7LNxqs=;
        b=i2qwBvffUS2OhkygztUfAllPKK5RbHx8+fuI2Hd/A2dcxBynmk8sws3ccyWIpbwk+d
         5cWXAUT/g9gqvjYxHG7aOk/8R9fa958xUApmbji8zHFdixnPt3x+UNkNlxxc5Sw3sUci
         9pdIlx0DcoozQNxl3iOReeHZwBiNUhFbAIENaLTPl3Tlv20jsxdMN6/Wi/1EvMR7UKEP
         q1vupU54TVeMdwQim/Recv5ao+j00sTeQbesNyOmwP3WdA828avETUyvg7tjpteeXZYb
         4/S4lE6bbHW6ptO2jKMFs0uWTdX1ZzS7GssqDFVfMCqrkCTSvm3C2VhZXuw6sEaNjjzp
         Fl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861076; x=1779465876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qI88RwCNnWnFb4fjGmxbgcnIrnRtogWwTEfP7LNxqs=;
        b=jsstP0VPt0GyAFPl1XxhvpV6M3okm3wSMfT4jAirPk/Q9Mdas8QyzDXlt3IFKSjLYs
         aD0kflrAjbzj+vnz5nq7twtf53uJareCXD9YDt9a8mjL+OTSIiEulhAK3oA3qpQ0vA6H
         3OEbjhO8ibes3qchO5HEwJi4T6rjlGOvdU5L4xOUeAzhc+hQla9JXKxtssit7qDVMmKi
         JlTyZ0yyj+IVKwKUASRCzzMQ1rHxhp3xm9F+Vm1GVlZN1P7yrk72iR4XwQ4U30ECryRN
         urpw/Yrtn4mXkq2KRDH/78uUL5ZnfA1I7wqAtZJ9nYtsCIm9v8MOGf5xtQ2OdgADcE+Y
         JspQ==
X-Gm-Message-State: AOJu0YyrdHnDQg3s9391kf8fZRIajaFTQfF0pl8e/n4DoiOHQX1NYRXg
	zGY8i8ZiL8J+ww2fM8bJ+aXUJuE18LDAvJt7+Kk451OL6GTpULmqn54K
X-Gm-Gg: Acq92OGYiIXIuWg+OPmh5i73bEDUebgrAO0rFRdTOScbpenIGcb6V1G5u+8B7zVr9uB
	lp9syXLrGCL5aDo9nhwlnrFhPcJVvlqQkQNGKm1V+XWIZ8xX5xybPT3tQGbavJkTj92iPxWlbO7
	IWg7TfSPcluia/ELopsfzHubXN/UHFo0T2rB/uF4ve/huwJwdLQCFd2jagp63+he3rI3ynw0R76
	0IrIZ3vcbNHBSBiZP0S6F1c91AA0ISJhLwR7pLPMQyKRTdYcC7929l+87sDobfgMzsLN2rSIVy7
	RNwangU+oTS1M1aF3svC7WZGiunB08rxQ644oXYSXO3xo18rcwgtF1UuV46CxmFXF8Ka9d0X552
	qXSG6tc7RGoeka34CYwMX7AGRoBr1j6hw32KgcI9PbfuFI2NpRI6Xvm5tmbh3for0veBd1MYQhl
	MsT2845IYjvxS9uok6Lvjwgwy8rQ7FTI3v7dmlo22em/Xw+by1YHkKmxesNunqsNg=
X-Received: by 2002:a05:6a00:cd4:b0:82f:b0:28f0 with SMTP id d2e1a72fcca58-83f33cbc0fcmr5625295b3a.34.1778861075925;
        Fri, 15 May 2026 09:04:35 -0700 (PDT)
Received: from localhost.localdomain ([171.76.86.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7c74fsm7920262b3a.49.2026.05.15.09.04.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 May 2026 09:04:35 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 0/4] KVM: selftests: add powerpc support
Date: Fri, 15 May 2026 21:34:19 +0530
Message-ID: <cover.1778857539.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
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

Hi All,

This series primarly adds KVM selftests support for powerpc (64-bit, BookS,
radix MMU).

This patch series is originally Nick's work. I have mainly only rebased it on
the latest upstream tree. Since the rebase required few changes to all four
patches, I have dropped the earlier Acked-by from Michael Ellerman.

Since the last series was posted three years ago [1], I am resetting the
version to RFC and posting an early version (few tests still pending) for
getting any early review comments. BTW, I ran this on P9 (PowerNV) with radix
and haven't found any regressions so far. 

Note that I am planning to run this selftests with different configurations as
well on PowerPC and will share the test results soon. This rebase was done as
part of a larger effort to improve the selftests infrastructure for Linux on
PowerPC tree. Thanks to Harsh and Maddy for their help on this.
 
[1]: https://lore.kernel.org/all/20231120122920.293076-1-npiggin@gmail.com/

Nicholas Piggin (4):
  KVM: selftests: Move pgd_created check into virt_pgd_alloc
  KVM: selftests: Add aligned guest physical page allocator
  KVM: PPC: selftests: add support for powerpc
  KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |  10 +
 .../testing/selftests/kvm/include/kvm_util.h  |  34 +-
 .../selftests/kvm/include/powerpc/hcall.h     |  17 +
 .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  38 ++
 .../selftests/kvm/include/powerpc/ucall.h     |  21 +
 .../selftests/kvm/kvm_create_max_vcpus.c      |   9 +
 .../selftests/kvm/lib/arm64/processor.c       |   4 -
 tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  41 +-
 .../selftests/kvm/lib/loongarch/processor.c   |   4 -
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 481 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 .../selftests/kvm/lib/riscv/processor.c       |   4 -
 .../selftests/kvm/lib/s390/processor.c        |   4 -
 .../testing/selftests/kvm/lib/x86/processor.c |   9 +-
 21 files changed, 869 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ucall.h
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c

--
2.39.5


