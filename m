Return-Path: <linuxppc-dev+bounces-22399-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EF5CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:47:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5Cf5JT8z2yfD;
	Wed, 10 Jun 2026 22:47:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781095662;
	cv=none; b=fuOp0pGb0tg+tCrcltCBT4/Raji1KMwaUjIYPvjO9XX0DT6e2fFH2phfBgKXiLAZfXzE94a7z2N623Le62ZrWczKGH7Pj8ll4qFMQ1KUw4ajNFDRzFMU6hAFLboirJHeQ74FpXL29E/DqPFGKyXSLzNsUBeeK3Id247ROB18lRTkhd0C0I2IBncAXdIGqvEDI8a18alj0dF+YwoNwe35w90y8V+9ORCBmOQ7KO3eF3u7ifrkb45wkKDDACwGlxXjmSxvtkldYCi7OzMb6BaD6383p4MOZp/FcVKQ61Xv3Mj47cZOMHBBgCqpiL/YDXnWXUX20o4xNYHOC3kRzeXmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781095662; c=relaxed/relaxed;
	bh=RcdeH8OHqrmoZ9G8aHs4z2njcN7/wilme/JI0goiWUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZdniFIRbPUuIeBeZPJ8MmFXVC4y8W0EQkKMRZVVpZYmqlcGo2w1imWWYQAfZHQXZMS6EViJjoJOUYKKedd4j1vdbJwJdJx0AEeTrB7cFoKSmZJg6vBCKVMz/vTlHnRPnqdIUlK+nBOjXigdoNATBvmeeI1THvvaUDr05xwvZm68Kp3YgOWLo3wmyok+/6Me92z2r9o1GToQlqRARR/VgTpNosM17aYPpL2sFPzrQFWt5DUSnd6DYiJ1tRAKYOVFH0w/S57lgEyM/5HHkVCenY35jPQlwAra5NLGoaMjjzZGasioUfHP9dhDtMWg5EMH2Mqv6hSbt93fPvPZ0U7h84A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VUz23nNd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VUz23nNd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb5Cd1qbjz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 22:47:40 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-37474afe908so1472402a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095658; x=1781700458; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RcdeH8OHqrmoZ9G8aHs4z2njcN7/wilme/JI0goiWUg=;
        b=VUz23nNd4Cmst/qBPfNqw3NbEHP8H0XeyYQeu5YfIjwDiDzyVqcGSxjTGfMtuKY7D6
         VV6qgK86AOaLqswWkr03BLeLB0WJ8xZLbd6PBX1SxPPuHg6XhV+1DXIcYzMV4c/EqUQY
         POW/1yvLjQxdhG7S3r/IhHbhEjYWFKIqe2PcdJe47adrs3MJgRbyaEHmZ8SE+Hh4YHtl
         bPVz8MJeqfIIDQTcGh1yqRR3GhKuKPpyhUrXy+Fw6/keVelbrItUFks387UkJPBTHGLe
         jtttPM3MnQ1/nbl9e5Yp4fMNcv6iWky5TyJ8gf38soOYOfBCtwL8/b6MH5paCvxdM4rQ
         QYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095658; x=1781700458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcdeH8OHqrmoZ9G8aHs4z2njcN7/wilme/JI0goiWUg=;
        b=s2W11/pGkss1WEJ4vFhsjqrn31Oqg0eMmDKu0qbkoEly22rG6lAQleEI2IaR/F3c+q
         6hoKfKogtVwJkcNSH21SMQaTDwrgG/PT28At957j7X84oFmLJBagg4xV/5bPRbJBZoRg
         jGdj41RKQFDpfXDtyjihTZf1+wXYXHPbo4N3wLN6IUiawQIJI7B1mpp5AqezJTHyPnmg
         aqBSFbUEi3yL37ofzPpnyT2HyZibTUgPc78agjkT7Q/YN03kZejLvFhFy1B6HlGhFl4W
         dG2W/nkHymKBOYI4VSeiYPQy4k12VKuhp3au3cyPpRKLgx7OLDZmBCS9ICuTiaEEZfvY
         tSSw==
X-Gm-Message-State: AOJu0YzCEgoIRJZuOgOoFbEBCv45T7AfSXD4qcCHeuJXKyEvDIvLCOwN
	4qT21KVD1IyoI8shBCcbVQXrBC2bZhkcyVZvGS4eUnscHQIFUEgDmxeM
X-Gm-Gg: Acq92OEa4CxQOLw5fmsudxjJVsRdvUG1piUfT8JIaDav8qUlNnYvljTEmGBjzFHwpKZ
	prUh63O4seBrnNNEsiqLw/7uXnS45ZWcvWcC38Ub3bzxKAy3Q4JnD+NCMzQ2pGrMtu4Qr2w8gJ0
	3M2DEo3lapnBhJ/jjdb5hQ4XYtC3ky0iY9opG53xTmcpSA5MssMj1DjXtGKaQHmuPnXPJRoZ1b2
	02mKAkmIkYj1MsCyEpIFwKJ808DBnD97UFKvIZsVlm8ABR1Rp/J9p8CqoyhdLxtdCQxWYXCQN2a
	cXrqL4lQhudEqKemOZ2ZccOlgmGGQj86W9Sr2fnWdv74tkz5SGMzGZUpvLWnqzrMx4aI4jEHVE5
	usvmwIyaDCiFM+9t/vcfQRuomX8LM7qVJiWMjyq4mDD/fOsHZjsYfUvlxwwH16I8YKTQ/athou1
	yjZn3elUtLvGQ6hQM/AP0CmgcizAsC968qpW00g7E6pa7M2QSLzDlOtTJrB5n7SA==
X-Received: by 2002:a17:90b:6c3:b0:36d:6308:12fa with SMTP id 98e67ed59e1d1-370f0386f18mr26940920a91.18.1781095657850;
        Wed, 10 Jun 2026 05:47:37 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.47.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:47:36 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 00/10] KVM: selftests: add powerpc support
Date: Wed, 10 Jun 2026 18:17:16 +0530
Message-ID: <cover.1781093720.git.ritesh.list@gmail.com>
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

RFCv3 -> PATCH v3:
==================
- resend and dropped RFC tag.


Hi All,

This series primarly adds KVM selftests support for powerpc (64-bit, BookS,
radix MMU).

This patch series is originally Nick's work. I have mainly only rebased it on
the latest upstream tree. Since the rebase required few changes to all the four
patches (Patch 1-4), I have dropped the earlier Acked-by from Michael Ellerman.

Since the last series was posted three years ago [1], I am resetting the version
to RFC. This rebase was done as part of a larger effort to improve the selftests
infrastructure for Linux on PowerPC tree. Thanks to Harsh and Maddy for their
help on this.


Testing Updates:
================
1. Tested this on PowerNV P9 with Radix mode. (all selftests passes)
2. Tested this on LPAR (KVM on PowerVM) case. (all selftests except-1 passes).
   The failed testcase (kvm_create_max_vcpus) is because H_GUEST_CREATE_VCPU
   (PAPR HCALL) only supports vcpu_ids 0-2047 i.e. max 2048 vcpus.
   However, kernel always returns NR_CPUS for the KVM_CAP_MAX_VCPUS extension.
   So if the LPAR kernel is built using NR_CPUS=8192, then kvm_create_max_vcpus
   can fail in __vm_vcpu_add(). This failure needs to be handled separately,
   mostly as fix in kernel.
3. Tested these selftests changes inside x86 kvm guest  - no new failures seen.


RFCv2 -> RFC v3:
===============
1. Relaxed strict pte permission checking in patch-3 (Sashiko)
2. Fixed errno from getting clobbered in patch-5 (Sashiko)
3. Added PATCH 6-9 to handle the type conversion (e.g. uint64_t to u64) as was
   done earlier with other kvm selftests. Kept these patches separate to keep
   the review & changelog simpler.
4. Added PATCH 10, which replaces u64 gpa/gva to use gpa_t and gva_t and
   converts the vaddr variable to gva as done by some previous commits for other
   kvm selftests. Kept this patch separate to keep the review & changelog
   simpler.


RFC v1 -> RFC v2
================
(mostly Sashiko review comments)
1. Fixed x86's stage-2 mmu handling in patch-1 - commit msg has more description
2. Added "cc" into the clobber list for hcalls in patch-3
3. Fixed the size calculation in kvm_arch_vm_post_create in patch-3 for
   allocating 2 pages for 4K pagesize
4. Added patch-5 which prints vcpu_id in case of an error

[RFCv2]: https://lore.kernel.org/all/cover.1779524962.git.ritesh.list@gmail.com/
[RFCv1]: https://lore.kernel.org/linuxppc-dev/cover.1778857539.git.ritesh.list@gmail.com/
[1]: https://lore.kernel.org/all/20231120122920.293076-1-npiggin@gmail.com/


Nicholas Piggin (4):
  KVM: selftests: Move pgd_created check into virt_pgd_alloc
  KVM: selftests: Add aligned guest physical page allocator
  KVM: PPC: selftests: add support for powerpc
  KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test

Ritesh Harjani (IBM) (6):
  KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails
  KVM: PPC: selftests: Use u64 instead of uint64_t
  KVM: PPC: selftests: Use s64 instead of int64_t
  KVM: PPC: selftests: Use u32 instead of uint32_t
  KVM: PPC: selftests: Use u8 instead of uint8_t
  KVM: PPC: selftests: Replace u64 gpa, u64 gva|vaddr with gpa_t and
    gva_t

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |  10 +
 .../testing/selftests/kvm/include/kvm_util.h  |  34 +-
 .../selftests/kvm/include/powerpc/hcall.h     |  17 +
 .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  39 ++
 .../selftests/kvm/include/powerpc/ucall.h     |  21 +
 .../selftests/kvm/kvm_create_max_vcpus.c      |   9 +
 .../selftests/kvm/lib/arm64/processor.c       |   4 -
 tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  48 +-
 .../selftests/kvm/lib/loongarch/processor.c   |   4 -
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 483 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 .../selftests/kvm/lib/riscv/processor.c       |   4 -
 .../selftests/kvm/lib/s390/processor.c        |   4 -
 20 files changed, 876 insertions(+), 39 deletions(-)
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
2.50.1 (Apple Git-155)


