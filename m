Return-Path: <linuxppc-dev+bounces-27936-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586C9C982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 18:29:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq7sq0CZBz2yvy;
	Wed, 23 Sep 2026 04:29:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790101758;
	cv=none; b=NrPBszuC+RdDWUFXQX5mA0nGz399zreaJZY+dVbLkcv2gSDATsn5J/gPaDWEr62Oxkc9CmfO2Kqh60EswgjKhjo8qAXZInLqXUlTHUEXymxIMF9ja/d4eNA42kGDDTYxyqrvQg29KdCMjVGsOYJyserJOJznfndEybKB3aEOmJTIiF2BDVg7d4C7jugOm+8yk3NGRGZMWgNP+PkoJqeTd3paru4CJhkgwXIvUNisVufJl+oAJo2s+D/xiYc213Rts93uwvM+2SUZC1MrHvo0ZyojsHy2Xy+YaaQO7FLHu4qyuDLEyrKNLK3/WHVLHFxYwJaCW048SPiGGeaDYexyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790101758; c=relaxed/relaxed;
	bh=boc46Sj1HOU4tKyVBAaYU0tHsUhuDqMurhOITlCOjEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QeMSu/PGT1jZruUeDlT2lL26NkhUsNtszx+6XD2KKzCSdbvARsYFa2WWQyRPVw30G/SI6AX5e+OYYiORG9+yMMy/LhHA/f+Ni7EcTH1o6kGRKPbACczrO8IWLpnvuCCaTmMVB2pfYdvEUoGP4x/PtWvB+BAnQspHh4MbNtbeA7N6izkWVo9vTc03jILy6IzI9HPCZl/bxsQq+fmyl8AvgN2PBx941fSHvj9h/v2cFBHB4Ehy12EiYjrmq3++HhI+uWv/F2b1vZtSQBmlyKntNi2XVECRsy1f9NJomUz0C6FWzJAyK5+5rv3oWJUwZ7y1L9ZjIoMlETPMD8i7HJ7qPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LKmmiUUb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LKmmiUUb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq7sn6WKwz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 04:29:17 +1000 (AEST)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-33e456e7869so58345eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101755; x=1790706555; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=boc46Sj1HOU4tKyVBAaYU0tHsUhuDqMurhOITlCOjEQ=;
        b=LKmmiUUbAss3STHfaQNVm8++tp4dEZnZgm7pMjIVRmB/ekPhC0GYwVE86TSslm8mx8
         rivISfKYM/WoFfIOHiMaKlHZtaTmSuCAwf4GPlfWAyIYWQhrOCqSanDdoV0MoW2X89z9
         4h8DsACoFtk8HcjSM7SCl98N//cmtCQkXn90MAKfBfqx3tlGnPaakau/NzFyADtTu989
         4KA+YOcLI3cHN/0UWMJZiuIItW3m3DzUbOMJabfpr7gyraY76Qb8UlEqy2Re/w0E4R8r
         lBNk+WJEK+fi9Rfw2PM/HAdCDXEq68stk8hOZH7HkgxNmWzm+/cXB/arU12KMNv5o80x
         9kJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101755; x=1790706555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=boc46Sj1HOU4tKyVBAaYU0tHsUhuDqMurhOITlCOjEQ=;
        b=oyOGfRIpYK1tudSNu9WAcjxsMkLi3FT5RZSWbyG9kjAphXKeX03WqqsFOH+iRuMUWB
         xrDSG72z+dfvNlwUp+tgi+CPfCLCUqH5Dcwz/+m3jkyKzrwj7DMqBCeCw7G1OPXia8nV
         UDDwpYT8UvOrV6qFi49/UMtjmK3fTCeEejbPeQdKkyFDWP2w0j2w0IBjC3RUQuJfX4gN
         RHep1HfiYAEoE+EPZAGGJkjdY4NMZznNKY/tWYzdW1LbGHf41qGu/1w3MuI0a2bfIetF
         rEyWMFFUcP4MPkIDzT5qTngE4LjuIwq5MB9ePyC8QyMeMurjFtQ/4KiB0cUYcdBgVgIa
         NyWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPFEuBb1/N8JMXY4n8EgDd9h+Wrkifox/+R5ZMOs7W4NT57z/81RYV7FPnC72T/+D4HVopPPgltvs5mRo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m4rS4WJ0PqeOLiJJGFOkblYQ6xzLAe93O8ba5dTYAZno2e9HG7
	u80qNdVD9FH4kEi19bd7FfPLYHlMHVe6+7GPU5QKPwYtqmNNrTmVVs9p
X-Gm-Gg: AYBFou0J6YCUCJArvb5HD58MGdxaEJqwoV861QDSj57suOMrbku2q3TF2aTce7vbhRX
	osH6vE7Hjc5Gfsd/54WPnlmURV51mN0UNPEX1/xYRbD1uaMXcMq15V3GI5NNih0m7BEbRchRPkI
	q1lVsXm5rQAFIhXrxU6aGqYZcfMxCcsnrgKcxxr1HHdO35+NH7ba5ZFoJgx7UQGJ9+6ngjiq1dQ
	FsC8u/RHaxxuRxu+AJHDlnvK4OAvl7AVdIIDjKkFYmmY/ECWUilZWPiacEJWmGfbxawOCuKgzvh
	+vu0Xs8RrNVXK2fCwRLbG/SAQ3eP6n3bNldUU5I19gm8gS3FrPvD+UY0l2HxLfGF0LJSKnbId8N
	wWSq96J1cxApDkyx1tq8hN6fPCO0hc3jHTxyWICy4yHJ3OD49ypWgTgMYmG3Q0GZ/pLpF/DSJhp
	J3EGANJp038vdZqmXuB2KKMFX1K97XkCYePlrTIu3vzPrOKNppcglsun8PyFHK6uvVOeFrEHWdT
	69JwE1qMISzvnQRsp8Lgbc766MhhoLu8mBoAHR8qbVOwWwEUGKTa7r7v0m6
X-Received: by 2002:a05:693c:8201:b0:332:946c:477a with SMTP id 5a478bee46e88-33e5ca9fe0cmr241891eec.16.1790101753804;
        Tue, 22 Sep 2026 11:29:13 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:12 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: [PATCH v5 0/9] KVM: selftests: add powerpc support
Date: Tue, 22 Sep 2026 23:58:44 +0530
Message-Id: <cover.1790101179.git.ritesh.list@gmail.com>
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

Ritesh Harjani (IBM) (8):
  KVM: selftests: Enable kvm_create_max_vcpus test for powerpc
  KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
  KVM: selftests: Split out a KVM_CREATE_VCPU helper that can fail
  KVM: selftests: Make kvm_create_max_vcpus tolerate ENOMEM
  KVM: selftests: Limit the number of VM creates in hardware_disable_test
  KVM: PPC: selftests: Make nested case on pseries LPARs as resource constrained
  KVM: PPC: selftests: Skip idle-page check when running nested on pseries LPAR
  KVM: selftests: Move memslot_perf_test off the 256M ELF load address

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |  10 +
 .../selftests/kvm/access_tracking_perf_test.c |  11 +
 tools/testing/selftests/kvm/dirty_log_test.c  |  12 +-
 .../selftests/kvm/hardware_disable_test.c     |   7 +-
 .../testing/selftests/kvm/include/kvm_util.h  |  13 +
 .../selftests/kvm/include/powerpc/hcall.h     |  17 +
 .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  46 ++
 .../selftests/kvm/include/powerpc/ucall.h     |  21 +
 .../selftests/kvm/kvm_create_max_vcpus.c      |  29 +-
 tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  39 +-
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 522 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 .../testing/selftests/kvm/memslot_perf_test.c |   2 +-
 20 files changed, 942 insertions(+), 25 deletions(-)
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


