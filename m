Return-Path: <linuxppc-dev+bounces-21425-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F054FCD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2026 11:14:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gN00r5rFJz2y81;
	Sat, 23 May 2026 21:14:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779534892;
	cv=none; b=m09r2OTfVCvIHWlv+p9nrhL6Cqq1WU+xbOsjmYFHk7voQyoZMlXDrVP2Kqf30dKdRlI3MQxwqrA173qQsLcu9Wyi9Cv9ZXnwWUzZKhD178TYy16Wn3d/LbNC650Cx7Daq/o1nNuB5Iq4q7MVuRwX2/3GNq6IM0xHP+4QVKYUJsx1fbyk/VhoaOCE56qWXdtB2yHSjRcKv56goLIYHtMkhdmT0H1DW+hc9XAFSLml8zokFf0EuwLeowVBBwV+ozKXJA8o7rH01m/ZSsv03qvMh98oxkgkbhSAmoP9aL2HJ7beO32eQtMRKhUeH30cfnOTBvsI7ZXpQZUow4JpVx8GHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779534892; c=relaxed/relaxed;
	bh=NaXtD7iMykhT9quBtXIhBa6cc/VFPDrkai+sBLm7a98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ATeq8W3eOUYVKC/npKWG9svV3zHAv4vvCQCQfX4rwn679gnYg93AeqyhA0MqovGaR9T/UQM8bWkzaMbNQMfkk0stmm++SJ3lv1FUpydl9kGms77dWZyNGHdQYgphSbpsZaUznzu27wYaXF//DDRvgt20oIC9jSNHK7J4Yh5JlnzrEwakAEct7IICAxxbhai1qqaOfkbpdo6L4ZQCTklIKczeii3ks/xaO+nwbBPkIOyOwB7hGsL6AtfcjA6D+2TxvqdBMwN8Y3YEQfMDaZXPBA9TeH0TaxyBGuKWcZh8rKoj0FI1UMC/zoEG7fwFJfMDlhKphOvr11RZuty0Q7ZWrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jN009as3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jN009as3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gN00q4v3nz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 21:14:50 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-835b78c3797so3617383b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534888; x=1780139688; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NaXtD7iMykhT9quBtXIhBa6cc/VFPDrkai+sBLm7a98=;
        b=jN009as3FiA61kWIiR9jv04bzkqN9niXDM/+FeJknOThNhwCq8uE50udpbiNkIHjkT
         aniX2DSo2oNH2H/TCKaGlWEEbu2uY5E3S1/hLDnYldikTetzvE2nHI1cfB4d1ZkfhL2J
         77A5riNn+q19SWjUTYlJ3lvSpz5Qezwscs1B4Qcya4VxK3d9Ph9WRy3IRu9ee1+ptzfK
         Q1QEmfdXLfpcUJoIjWzqHqCLb4oO8Li/NmisY9yX2Z+a5P81GKNq2uY2f9uz/gf2TgfZ
         kBFU8wZve/e9p7lGsGGXdSa+aRJrH/jP5y/cpPTdvdA3QXfAwjdb5sGU+sw5bbqTi0y9
         wEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534888; x=1780139688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaXtD7iMykhT9quBtXIhBa6cc/VFPDrkai+sBLm7a98=;
        b=DX7M/RfaOK0sEgInKLM6cFgYlozk4KNLCjLHKaFX1ALRNT10aBXRnQeXxphnzdrrpD
         QUIqy6e2ALrtG2Zh74HrEq3+HX52QWYaF7erKhNuIrH/GCMQaX1789Uo1lztFV1fsHxu
         JFVUZngP1rV6h4fSjt2nskSYejCiDMVgwiwMzAmT/qSo2c+gFZ2yRYEQEPWCDc4rmEtV
         CgtdAg0f1oQOBgphtjnJPMiubQKNeSrstHX3/MknyH3c9vb2shTjbsC67uYzsoKD0sjH
         hdOljDziR/Y6PvqKNSOy6dOjgMK5dLfZdGA3iiCGcJmS4hkmnZbd4Wo8oyd1djuO+AeK
         dxmg==
X-Gm-Message-State: AOJu0YweZex1d6ghFf8nw0W2aO0KjDbWA8a32s2vB41AWOkjdo69/3p5
	oH8XsCRnacmNCE8iBjJhodOG39iXqkoCu5Q3fL3PzOAGTs2hIfm//jQn
X-Gm-Gg: Acq92OEgEE3vN+bZb6T1y3Fu9N33Qq5XmFIrvLthQWX5qW8weJGSxIHf2xTKrn1DRWd
	xidrFPMGRLk6319TsFyEX8nlsnrPH7NZTL8YJHxhfGXLXR8oCRVZJCUuwyoB1oVQoFQGLskBvuf
	d8nrWaOjw1KRRQbLv7woiwbOs02egg12z3VDgDrBFNqDoWo+IHSeWevsFT0MTp7hWEJrOYYBZfs
	UQ13HRmnCbNiD79RfMg/8VBdk7rFUMx5NErn3rXoYGZ5mANDlXfpeM7gA1srdCigthV8Q2dkvjD
	4BldEKi/U7Vn0ml+qj/6DQsUpuIJSvTyC4a8gWIEWbDFHe9halv4MSmNrVG13elUq+Ltw3eaSF8
	p3EWkoQsJhJbLi534yARR6XD3BB03wKDUC73t6bB/soYLnxOGH5BtiYiVsrtFULEdZyr4x973Cm
	o4aibr7TYsTsJRW9CmB2UZU9SZ9znImygIhQGlqp2hSHINp2yYcQ==
X-Received: by 2002:a05:6a00:1312:b0:83e:eeab:aff8 with SMTP id d2e1a72fcca58-8415f306c6bmr7193042b3a.25.1779534887953;
        Sat, 23 May 2026 04:14:47 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9c77sm5249140b3a.2.2026.05.23.04.14.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 04:14:47 -0700 (PDT)
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
Subject: [RFC v2 0/5] KVM: selftests: add powerpc support
Date: Sat, 23 May 2026 16:44:19 +0530
Message-ID: <cover.1779524962.git.ritesh.list@gmail.com>
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
   can fail in __vm_vcpu_add(). This failure needs to be handled seperately,
   mostly as fix in kernel.
3. Tested these selftests changes inside x86 kvm guest  - no new failures seen.


RFC v1 -> RFC v2
================
(mostly Sashiko review comments)
1. Fixed x86's stage-2 mmu handling in patch-1 - commit msg has more description
2. Added "cc" into the clobber list for hcalls in patch-3
3. Fixed the size calculation in kvm_arch_vm_post_create in patch-3 for
   allocating 2 pages for 4K pagesize
4. Added patch-5 which prints vcpu_id in case of an error

[RFCv1]: https://lore.kernel.org/linuxppc-dev/cover.1778857539.git.ritesh.list@gmail.com/
[1]: https://lore.kernel.org/all/20231120122920.293076-1-npiggin@gmail.com/

Nicholas Piggin (4):
  KVM: selftests: Move pgd_created check into virt_pgd_alloc
  KVM: selftests: Add aligned guest physical page allocator
  KVM: PPC: selftests: add support for powerpc
  KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test

Ritesh Harjani (IBM) (1):
  KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails

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
 tools/testing/selftests/kvm/lib/kvm_util.c    |  44 +-
 .../selftests/kvm/lib/loongarch/processor.c   |   4 -
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 484 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 .../selftests/kvm/lib/riscv/processor.c       |   4 -
 .../selftests/kvm/lib/s390/processor.c        |   4 -
 20 files changed, 872 insertions(+), 39 deletions(-)
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


