Return-Path: <linuxppc-dev+bounces-28953-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F840CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:29:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzXZ616q9z2y2h;
	Tue, 06 Oct 2026 21:29:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1233"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791282590;
	cv=none; b=YAd/JBdmREl1maaME5ns/s3hELe91+NAas/udDnJnrDG1fa4wIXe9cNjZgKnAWLRj8meK6pQjTVGpLYfJbENPuwFta3ZTzfZKehv17KsxvXrlkArD9O9g0iYEhoxNXdBi8NpxndSve7EmcB1SglBFePAHTW1PN/ukgtWTHIPA0/766uokd2X3s8oBuzv9xkVLyNL8snlPJpSJIlDv2Hbv7eNnHI3UeYR8JcznKeSKyb4r4KC98J1G2UsBqDKFAg9hStuoIQF1VOroHZmTFMJMmdKzPNBl0iDjxdbWL97A6DaPmnNUxxSuJuP1wYGhzaYwBnNB0fE/r3+FUS00XGV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791282590; c=relaxed/relaxed;
	bh=05GXKUT/YWkG/6TjV8sM9LD7ngJ6Vk2E269NPbqlb5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GOnACWbmSTIHENakAB1sKngHH5PGsLaYCtJ5Da7bISIbuvQIOYeIdRjIhEx9drzt2IJY3187qY7Uuzfdkeu93eqp2X1p9NODVYWpouHDUQ+opaFjc0HsSHdILKr9PIF4c66h2mlgiKfavmPPW1JMtiB1tw96dgAefokN7DmVKqN3Ykz7yD7nGd5UVypFoqQzyptnnNiwaOyFH20bvZzrtmZYPEq1twnX8XGeKvU74L5fToMYETiwhAWzS+xgULZ9XtIz8JoqusY3elPUswiSBRQf3yRS+V1YIvcB9lDUpqV1zToqz53TPrBLJPRsYkWI6dkjtWuNnNTjDtIkdVKxWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bvo4owB0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bvo4owB0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com [IPv6:2607:f8b0:4864:20::1233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzXZ44vLsz2xwd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 21:29:47 +1100 (AEDT)
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-14fd9dafb0dso661441c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282583; x=1791887383; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=05GXKUT/YWkG/6TjV8sM9LD7ngJ6Vk2E269NPbqlb5Q=;
        b=bvo4owB0lWmlrRgpl8jxY7ReR0i0JAcvRhYVRCbvkAtoqBbHEMRZmuk8xJFO83gJ//
         u6VzJp8TGvqhBtXpJpONqQohvF3yfQ6Rm7YfFqbUlOn2CDxHcEwD8a50GCSIu4nVIX86
         J6aUErah5cM3HNrtNFwwXufKSJVfPV++VK59pD5jNR7broBwBiXkEdDwhOiBFxMe2Nd0
         FY+KNf1Wr3RX4zfeO5DkeU0uukNTANp4pHZBjjEZ4se9Z8w6yMSQnAHyJKK8VdH/oYX1
         RG2CgqS72aMgOMLTnhR/VQxPXi9cgeNHRwQx/U2d5lgbiQxthjRWbivMTJwxbxFPIBME
         8znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282583; x=1791887383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=05GXKUT/YWkG/6TjV8sM9LD7ngJ6Vk2E269NPbqlb5Q=;
        b=JytCW4MIcCyOdXYhnGNf+OWM2Zk3ogG+MOrBZ2CyAvPk7izc3Sl5VHmpYfU+EreQ/9
         53a6WW4sNfCg3w//qDTPt5WiSY+mYFO012My7BeNbxodeH0ZNBeJ0nyW6VabTGaA2Q2f
         9nq9oaLwTpzUjvxKOGzDi4pugy/nK84HOUuPPMbNszYRz99osGn9AqnXDP4zvuJcllvL
         7GWbVpUdV3LQAh3l+iz217A/LE0id20koKmxr+R5wpm8OS8qcvhwrVSdbLJ2jVbL3PLn
         PGtpb29aq19oRj6Bsw+Hv0t+W1bXF4UEmyxa7RiPM8viL9AmDhiyZIPlMJNHn708oVOG
         w5Mw==
X-Forwarded-Encrypted: i=1; AKwUvBxLa4QKyrm50jXL1SDh/gMEKjBAtf4NW7hzO/2oBdMq9TZmdBlDEUrv1wI2s551SbPHI/Yn//fly45oDDw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mRGvLbojYyJJcva1QRgqaByW+Ce1+j5ZJBna0s8qBeF3oEzxoF
	bybGuklF1RSqFgegVq5kUfqxwq1nU2RAV+mCX6yCv64OCmupuxHtvFgK
X-Gm-Gg: AYBFou1qsArX1HKXnQmOTQClpOsQmuMlgBs/AMxmWnlGXJhX0rJHYoXgQiONBgoAQvc
	2Ox0QsLnulqchtLOt5He0Q3UAE7EeLuOWHj1vDgA8iK2VVXjhBm/L1EUW6NEExyjhzZStjUIJBb
	wQThbYI8LLSj7d0w2RNrHFQjfaA/5iRgp4fucgcC+FKOwscNQrh5j7GHUVN2R2o+iUrA/+abFRt
	uMFCAvdmepXCEr+kn+VKT5LLgX9jUBSVmdsqSxax5vKVIod2V07ULUYaf0sRRAQiu5kAfUy2g+0
	UdQBftykZNyVGAVbHyvsvGzrfljJ+0TwdVp591QQBUItLso2H2JqQacjnZ/kMWPz1uN6auVMvzP
	oGhu4MCcKJ03t4tVAbrRMoGJsHyZekWCJDI2IkL7T1BMhC2NqVUQhlVGy9H5P5KMowg5s54ZDaB
	03VVYOs7yhKXSCWjO1nZABu976PlwF3nyuJ44xyeNnGwfZJ8CH8kFBCf8jkqXbtpzkk3OtTyoKC
	tlOv3u9T9Pe1oTAC8pVic4eGwsXioxtKeLxoOjFJDW0WWm6cggFOxodgI01
X-Received: by 2002:a05:7022:5f07:b0:14e:906f:9c8e with SMTP id a92af1059eb24-151c3a9ebf3mr12917648c88.20.1791282583240;
        Tue, 06 Oct 2026 03:29:43 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:29:42 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v7 0/8] KVM: selftests: add powerpc support
Date: Tue,  6 Oct 2026 15:58:34 +0530
Message-Id: <cover.1791280439.git.ritesh.list@gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch v5 -> v7:
================
(Suggestions from Sean):
1. Added kvm_is_ppc_pseries_lpar() helper in kvm_util.h to avoid sprinkling
   multiple #ifdef __powerpc64__ checks.
2. Enable all tests via TEST_GEN_PROGS_COMMON for powerpc
3. Enable hardware_disable_test and skip when running on powerpc pseries LPAR
   (nested).
4. Re-arranged the fixes in appropriate order.

This is based off v2 of Sean PPC pre-enablement series [1].
[1]: https://lore.kernel.org/kvm/20260902164123.2546762-1-seanjc@google.com/

Patch v4 -> v5:
==============
- Fixed the issues reported by Anushree while running on kvm on powervm
  (nested).
- Fixed memslot_perf_test on powerpc.

PATCH v3 -> PATCH v4:
==================
- Rebased on top of Sean's new page allocator patch series v2 [1]
  This allowed to drop and patch-2 since it will now come from Sean's
  v2.
- Addressed review comments from Sean - squashed patches 6-10 in patch-1 of
  this.
- Dropped patch-5 to print vcpu_id when KVM_CREATE_VCPU ioctl fails.
- Added additional patch-3 to this series to allow dirty_log_test to run on all
  big-endian machines.

[1]: https://lore.kernel.org/kvm/20260902164123.2546762-1-seanjc@google.com/
[v3]: https://lore.kernel.org/linuxppc-dev/2d2c46be7f051c7f1c645afaec67f57067d37a81.1781093720.git.ritesh.list@gmail.com/

Testing updates:
================
I have done some fair amount of testing of the selftests both on real HW and
using various combinations on qemu (powernv+LE (default), pseries+cap-nested-hv,
pseries+cap-nested-papr, powernv+BE). There were few powerpc kvm kernel fixes
which were identified as part of this work. I will send those patches separately
as those anyway needs to go in separately.

<pasted snippet of cover letter from previous versions>
=======================================================

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


Nicholas Piggin (1):
  KVM: PPC: selftests: add support for powerpc

Ritesh Harjani (IBM) (7):
  KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
  KVM: selftests: Move memslot_perf_test off the 256M ELF load address
  KVM: selftests: Skip the max vCPU ID test when KVM_CAP_PPC_SMT is set
  KVM: selftests: Add helper for checking if running on powerpc pseries LPAR
  KVM: selftests: Skip kvm_create_max_vcpus on powerpc pseries LPAR
  KVM: selftests: Only warn for idle-page checks on powerpc pseries LPAR
  KVM: selftests: Skip hardware_disable_test on powerpc pseries LPAR

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   9 +
 .../selftests/kvm/access_tracking_perf_test.c |  10 +
 tools/testing/selftests/kvm/dirty_log_test.c  |  12 +-
 .../selftests/kvm/hardware_disable_test.c     |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |  26 +
 .../selftests/kvm/include/powerpc/hcall.h     |  17 +
 .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  39 ++
 .../selftests/kvm/include/powerpc/ucall.h     |  21 +
 .../selftests/kvm/kvm_create_max_vcpus.c      |  14 +-
 tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 512 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 .../testing/selftests/kvm/memslot_perf_test.c |   2 +-
 20 files changed, 898 insertions(+), 13 deletions(-)
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


