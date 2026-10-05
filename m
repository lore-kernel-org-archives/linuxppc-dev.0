Return-Path: <linuxppc-dev+bounces-28897-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01211CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 03:47:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hylhc41Pdz2yf9;
	Mon, 05 Oct 2026 14:47:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791172064;
	cv=none; b=f0vQdtiKmnQQEz9KPeBvvZgRH8JQfWiSHS5gwy8ckt57sKTo/WmuvSW/+rMYigZQysAISdKlzRIFwgZPThg7nEhhuG9o8mjijzEBGergF8NDrOiKZvBP1vMK0K1NN+/7xMKVzTkVqwYcP60javuFJPyDwLIvdFw5qgAjTg5/MqwQmuMMoZC7V7zfyAPbj1obWJRHKM0kbOnvg5N1OVoQJfpXolDU9Qea7f3/KHSzg2SFW3h5wYYc52BJgRtaa4JZVMq3ZtvELdaZYvIlvojARWpjqrHaGdgusBUDXIfHq42AKT3b2cDVF2xXOML6xqoHOEbsO7oGg57/yvgB91kT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791172064; c=relaxed/relaxed;
	bh=uw6WYwed2JfK8m0vFjl2cwW4PACl3pWVaZ2CPggu3Es=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MwbCas9CJyB2g4cvyLEPbIx3WSBXZ2v8AQQtW1Dr/JO0dHO+WV2yrPwiMQ3D2xyWsyhbJahn7+PTFvFb1GHPzKg8aSIYg42ExGHsfPGASAcNwTSbM2KJ2oFjVmqnZ2Nvj/H+WYrbm/2nVyGcrqNMRs9KudCy94OMzKAJ+ooJ84Auy5BA94Si6HGAzxzdEZO0yJlsjf7RVy9diRz09Hf/iaq7zVFuurLxey0DIkc5LhlnigykL+BNZitoFXwIDr77MV6Ex7ZAEuXb8efXSMMwM1+1xpS3/iZVedVVHq5rDYNEOY12b7dyGQelS8KbCnQJVej0p45X60A2if3WgrV7RA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ADm936gN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ADm936gN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hylhb6HZhz2yMD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 14:47:43 +1100 (AEDT)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-3511e727e66so465574eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 20:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791172061; x=1791776861; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uw6WYwed2JfK8m0vFjl2cwW4PACl3pWVaZ2CPggu3Es=;
        b=ADm936gNY8vFZrMnDq9IuPciu3Z7LcK2hIrazC5M6+peU03qX6XFwG1o84vGA8GXF4
         d0RjT6uku3Ly6LbREdogrLJGnUO2DQtj3pAEbzSGyuQ4V9JAY1w6bF+YqL8ejm2mUkUy
         /YJ7hz//AM3FlXZ6rfRJc1x9iOlxGZKbCH5tRCaqikJSm+LRWkthJxRvfIn5jKtkKhND
         Ac4B+nB3CMUqb8b5M7hk11ZbHziqpQwZ2XleNS+J8ZKWkbIS51mV17El2wqVIMkDCw14
         VtPFQarFeXmrojSuC74xFd4exhAwq134LOYzqAumhRF4aKp97peLFA4tF06IzpUJxJLf
         9pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791172061; x=1791776861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uw6WYwed2JfK8m0vFjl2cwW4PACl3pWVaZ2CPggu3Es=;
        b=CkbPSZeImjbszmTEy0ch4hozuj2kYMdaSf3oGQaMo6sXZiqgRQo0ZXlHIcDDwrpt5V
         bOCinJApPSQjsQCrrAvTu142fGfPHbO3TocfQj0mee0uVS053uAl/clCd7yKRdK5LER1
         AXd5Bu2ziAIMBTaOv/SDXOA8sEc3Il2K9+62WjGMcImrd24U6Mj1GZH7/JxfTIYKWnTv
         0IX1fDplD/MCnFVNDFCK3SxJajqa0TUPSJTqFb70KDhUe6QboWdIDXz+2RDcxitRIt+R
         Me/N6Me1OhhOLxBo0cGjK47FUCFoGGOfJjxaFq3rqzev0jVZY0hdxxym/sRcdhuAKS/8
         i1aw==
X-Forwarded-Encrypted: i=1; AKwUvByf5DSzyxRBd91Bj8l3mlwpeh7rcA/A3OqMGadGY6SjXilirK94uhqJn2Enl+/rqLgagQWSXO4x/BonCSA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLDWIqFZvvkKORUGgcz2snjyjoBmX2a/alL4NK6zeRKQdusiML/
	hdPeYcYk5mGrNaAL8FsmBMR3Ss3lKm8iwuk1Q0zU63Mm0zBebRFIK70k
X-Gm-Gg: AYBFou2TbmqtK1tOrQfoz6Tu672TH1C/AAoNL7tfSAXRMd2ox3yGpvdLmt21NoDaSIX
	maoKg7CMNdFPLb0+NzbfSU8xPhjHbILYIH6ucS67jynBLDYnzwvJqexe+jISIy2GWynvuYPEu7P
	CTMIoL/yjsxZudOAPL5Hp/brTY1ut5OLFyVox5xH4ahB7MeMW0n+bAZllOLADxLni1I9pDowtDp
	fBcN5+SyQ+I/ic780mUVQWta9vGZN1gNclr9H95UyLdEJj07NLYvMoF/fVeIUicMayhQ9fuKjxT
	1IAwC7PPT13QeK3chDoHyUbZMjyTt1r65aqtuvVKWNq6OPyrceNeIkGzLcJtVOmlUf2BPgrK2sv
	h95WIoBP6hsC+rJMFF6uOMyD6b4fHwyAegK4GJXAAcHO3yTtC2gkZbJyIf8FGTEfRql37pyA/7c
	Q2nlvEAavKuUH7U9kA+OMmevc68bl+DnyUixTyk5jSn88ohmscotQFW2B8XTohNWaROjhgqTiAs
	gCogySCaAfp/z/73hpCla6yp61tPECBfbZTPYnQ4fvdeg48CCPDYFeJ4prRVg==
X-Received: by 2002:a05:7301:928:b0:34b:3230:5cda with SMTP id 5a478bee46e88-34f21858da7mr11358827eec.26.1791172061374;
        Sun, 04 Oct 2026 20:47:41 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512718a18esm10840958eec.17.2026.10.04.20.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:47:40 -0700 (PDT)
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
Subject: [PATCH v6 0/5] KVM: selftests: add powerpc support
Date: Mon,  5 Oct 2026 09:17:23 +0530
Message-Id: <cover.1791014923.git.ritesh.list@gmail.com>
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

Patch v5 -> v6:
================
(Suggestions from Sean):
1. Dropped kvm_create_max_vcpu, hardware_disable_test and their respective
   plumbing.
2. Bundled the enablement and the fixes for few of the tests together to avoid
   the ordering issues.


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

Ritesh Harjani (IBM) (4):
  KVM: selftests: Move memslot_perf_test off the 256M ELF load address
  KVM: PPC: selftests: Add helper for checking if running nested
  KVM: PPC: selftests: Skip idle-page check when running nested on pseries LPAR
  KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |  15 +
 .../selftests/kvm/access_tracking_perf_test.c |  11 +
 tools/testing/selftests/kvm/dirty_log_test.c  |  12 +-
 .../testing/selftests/kvm/include/kvm_util.h  |   9 +
 .../selftests/kvm/include/powerpc/hcall.h     |  17 +
 .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  46 ++
 .../selftests/kvm/include/powerpc/ucall.h     |  21 +
 tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 512 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 .../testing/selftests/kvm/memslot_perf_test.c |   2 +-
 18 files changed, 879 insertions(+), 12 deletions(-)
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


