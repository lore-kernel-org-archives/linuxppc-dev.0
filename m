Return-Path: <linuxppc-dev+bounces-21578-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B76CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:50:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQTx71l1Cz2ydq;
	Wed, 27 May 2026 22:50:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779886219;
	cv=none; b=isANzLgeJNFwDq6aEICAMuMlTEZ//Td464zJkezDt8h+z0Um3+A705XdMn+GIzu0lqxdCYv0ce39hyU8e5BSWHHLw7ZSxiX4ne0eKdj+191//fpBdnCJJy3ESL59EL/t0wu10hQySD9tqKVO5ebsYoZLwAMA58EeBzPA0UtH9WBGdCLCn+H63QbvVVPd1Z6upDycRIBTD1g2Qt3M1GwiA6vZSHYxe0oGiNmKIZUOt1R7wiSPbKU5oxVX7A8gGD1O/mKnfubuOzLrgslgqq9lOjqsSBq/+8Nrmvc0FimD/qaVntOjJUKMLv9tKQTCPNr90AzeFybZyp5gJhsSMLL7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779886219; c=relaxed/relaxed;
	bh=MgRAhqYKkBvWITllYhRchMYpKWP7IS+SkRga7Dolm/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=An7cOb7pq2hPL5ln4cszH8AJ8rmfv29gac3714GRJ6ngvaoKL1wl5WwVXuztS/L33UohYnOppke8mhevH0hG6E/5ODIsRVIULMn+5A8BE4bH0tOTKf01NWSShgRNtAeimm1TwMbNygB9FXL6JL7rYfoCpApgUVALsHY4oQTYXYWj8xGDRr1t16EVF7+xRT+zNPNk+Fg0TUmyuFHbXTdXM+Ff+h/kflPzg6ORGmQxVljWtoeQha7wGCpMGur0PvJVhy6tw8rSsNt9qdJXrOWml130aHcTDcJt55wJcQWnkPdoRe3bBbbVtXBhjCtOhywurp2y+Etl3I8yYU2zokXmcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SvxJqvUA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SvxJqvUA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQTx54xQVz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 22:50:17 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2b45cb89f7eso78500485ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886213; x=1780491013; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MgRAhqYKkBvWITllYhRchMYpKWP7IS+SkRga7Dolm/U=;
        b=SvxJqvUAi4kX13rF6PNJgzrJQDeDJZJ6IkPLXjXlnZ/DqhW1CDmWyldHdDkH+Fu9Tn
         5sNUrpA5QcA+pQkFp9PS/iF3wkhNyaQwZrRF4JxM0CX+y4fL1Q7tWtme9fWKvLC8xkvS
         khd/YjiTVpkTPnpiab9Ipin3sqIOPCWUBSe269hf7NwL4sDXf8+T9Zp2DSKYTmepfluD
         NuOxqIregK7Sflbry3X8vtDFf+aLB8WOdGynhz7uMP6cp6oUvJgJF7W1Pnc/nPPvnCJo
         876mw3OWTY8VAsRPCNmN2yZQX8+iOmOJfF0vVhOuWtO87FsaT8I0pWed+NaISmlyY4Lf
         cZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886213; x=1780491013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgRAhqYKkBvWITllYhRchMYpKWP7IS+SkRga7Dolm/U=;
        b=MKxJXFMpEnGSJItvdk6fvpWfRwG2QvPFbDMYbozxvICxRlP1vPa5b/4Fe51hzNI5Xa
         6GPi0r48hji02yT5HCs4zxbN2zapC4cLz6tD4fl9lCenMtz/AXAAnmpLP2urdV0JY4u3
         QrCA70Ap4KsfrRmVYRokGFF4i296tguec/CFjxpy9UUozrRXhGEQuRUryfbb4nPKH8e+
         ZIfEbt07OPLEXJnl2Yup//2DlrTasNYOlGwwDm9F2JW0QQDVZUxL9+feJU27O2uBS0uM
         B836ADUVom/A9Lbs7HBdUw47fYFI7Cb9niLTomsORB4wNnuszsVwIwg1ta63ErD73lt+
         Kjeg==
X-Gm-Message-State: AOJu0YyNUgPVdE0MPULHZZKMHZzFl7NSkisFitpKEuM5kNooXEGfxRZi
	+0R9SZMvsum9yuPqgDC+2t6Ja/cCHnPXdxlvohCc+aYbbuizLYqwq0Nt
X-Gm-Gg: Acq92OHUDiaSPRJGadDrhfZZ+45cNGTWaft6UcdjOV28ttqJJPTDJFQsmhyl1Pvy0BR
	Er+bHQHm3OVf4NBQLwedY/oN9LdG/Po6NUqsLDGwf2PWH9psA9VDcRmv6JNJ2FAytIVav5w1HhV
	pnH3126UCFEgAFOAVWsF/07RgXJsx8wdvW/GiDKUs4J5FaQvbLH4I0smlyfoCwJhwqL79kmGZri
	exqKhHlP/KywIN3HFiT6bIpklRZGY/6zvJN2bP+jHKu46yuCuhxjJ65HbADphLCOtO/YRlaseKk
	Rw/SCMEPFLyuS2OW/GJ8/itS1mDR9Gb7vIcK4OTw6j/nxK8r73jyPyiUTrGfnNNhaelSfIg1Bsf
	XiJwhZS/BQERimhObQYOQ/VngOIcFwK9avVZFENHpfi6q26jIVz6HiTm+Q2XQ67PHGTnrzGEEcN
	8XGJctybRj1QXC7Alu+hhphgMTVOuj0M1bEBR4s60lfr0NPZOhyQ==
X-Received: by 2002:a17:903:2a8f:b0:2b9:e82f:bfef with SMTP id d9443c01a7336-2beb05b5133mr252771035ad.21.1779886212801;
        Wed, 27 May 2026 05:50:12 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:12 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v3 00/10] KVM: selftests: add powerpc support
Date: Wed, 27 May 2026 18:19:49 +0530
Message-ID: <cover.1779885589.git.ritesh.list@gmail.com>
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
  KVM: PPC: selftests: Replace u64 gpa, u64 gva|vaddr with gpa_t and gva_t

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
2.39.5


