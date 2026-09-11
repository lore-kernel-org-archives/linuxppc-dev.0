Return-Path: <linuxppc-dev+bounces-27081-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFEBC79FA1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 04:49:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2Bd13NLz2yd7;
	Fri, 11 Sep 2026 14:49:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789102153;
	cv=none; b=czogpCoIkrq+8jpx9bLlVyO9GhvXmf7vaGJsTtEc4+T/D+jcdZMn6PQ9pJq16JnNaPbeBWrXTld5PgEkP5Ctcncr6Zu/VhmVINPU5cWHkDje0qxFFt6WvbbWXGS7UkrCUJs2xYqwQ6JE8cNtyxQ7GnT+Cmt5BAGuW2olvXxSvWwZoQ/5dPTo44/fIsBDgfU7mkY1veYAbCgOCySura6yZ0UGWd0benL/R/vMu2Up7/HIEhLkHBrZ2hDFwcTq0pa4j+hDBCY3+b8EMFWMDlrj+G3o8rCLmsfL8bWBu6MkBaOtEo6idQDi1lcYLIqH3yJZMnp3MT7dB2h1MIgklIME4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789102153; c=relaxed/relaxed;
	bh=1rljTI1Abbl24POJ+IsSXHYVg7wGa229jkDx+f0b6sA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TIHdFeTzzUwzvaTPzxhg8aVBL89n3q69vU/Kgk3U1mRfROEyfofDIqnP4Ri/qxfIynHVJFHRXabYZMoYjbKRgTrg14zrzOvgSI9ahaHFToVNVpBfF4Of1nHW+NUixgHyfwsfXK36opYl4GucHNSYZjj3oTVjC5tsA82FoZ6ewt6UQpS/P/lg0++pa6S3JhI/hyI8ZVT/Uy5Z7awb58LahH+5va19cfOc4MJd0/tEbXZMB9OfPVgds5x/6zkDkRd4CtAUZlR8xI0Uuwsy3/bjcltgsJ4X11eGiNZhMYrzuTnNfBhOM5Qj4BzdNaDPxePDsaPAtG87nYfktMtBHsTTwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gEN7ETw5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gEN7ETw5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2Bc2RR6z2yFj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 14:49:10 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4bdf8acd6so456935a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 21:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102148; x=1789706948; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1rljTI1Abbl24POJ+IsSXHYVg7wGa229jkDx+f0b6sA=;
        b=gEN7ETw5YNEyGSSGpszO+NGbWpGM1fYwCph1wjUdY4+/jEYYhyfT4TZiT8xs2+K9vK
         dGT910+ieqVzX86bDbuCUiSOgLi+VqBZC71q6qtBkvFalZNaYMsz34nq4uSgNvKOOBGq
         ATBH1QPjDTwMsW2bpWRN6QujkCoaPrE40HDbrcaKmhil5AhVJHQVOTrVYiPVSF9H4mWx
         oWWN7dgT/HJuMe625G6rb9ZCfuYr59bt7ySJLfiWKdB9MAZ05rA+PnNQbETNPiyMxIih
         bcS9s/J8becmjx3+fRKcPvDighPGf8OYYB6iATT/nLiBdBmJjcVmS3gC4mR604Hjw3ep
         wRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102148; x=1789706948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1rljTI1Abbl24POJ+IsSXHYVg7wGa229jkDx+f0b6sA=;
        b=nbQTixPmALukLcUrhf8UL6QnK9sKH3YhbQiLp2jIYBsDbAvadSf5/WFEbInC1ilRSH
         9vcRRCGQtSfxZLs026LnyMElgMZ7LA/ggz1gwEb65c5BdVqaLKCa1nTu0//wUxqmdr7q
         8GrrXrThWqLZHuSmOXP0CksqCiraX3V1lD9BCjyrSln+p3PyfBNMTw58w4yaFme44M9a
         ipb8YHimF46uMmN00Qba13h65qJB0me5aOeaFpwZlGwrnKqbzryP5lOlrbuyskUu7bqZ
         jFQSWf31eKWZnTBIxr1K+FNor3Fn36EMSOTjr/f9AaNKgtcZnTgFdhiaiRbv2/eL5Gek
         /UqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzc6J6WnYtSR8fFI2uhT33Btt7zo8sxO2GHFqq79IIjC9P+o0Ia16D61IEmqvkM7AD2citIdhHnOCgqZEo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lP1yntAB/jhJEqSDrD5Z2UzfXEMP2u+l0fQau+hmAwhimfJzgg
	PwbiWGbwWZXds6uGoz0kFTbQ5s3jrgJ4M6BnMQfEaTNYG2RAAs+uRlC6
X-Gm-Gg: AYBFou3WulYx/3hsaHy72MndYIYVHFMlALWwKuhaCKe1JCQbFVdwZu9Ps2if+3EezM8
	5AgWUv1wYfbimqb8fMnYVIyefLcuEU0X7UJQYl5+nGldg48hd5SP4HaLUYVQC8Hqhqv/XjtdO9W
	M5KPlH/cg1mKhwNo+Guiq7VUo1SdWLszemCIB+DklAXaOvRVNfdIaIsoXsUTq3jbQQI23yl39QX
	XDfQaVYLsWUJljXUsDu3pQ6l67vfGhA3bvQ74m5dbM5fuU2raDiZBZqxSicoso/WLBvsHvtp9RB
	5LIdrOCB4wapK0E2kOeDS2dVTPo9FxKU2PZF+C+V3DDgGnuAEPa5Zow88lFw5E/biYqTOFGYigX
	PS7fhiCGObGT2A9euKndZWnUFutq4iKr+MJbqFiy96m1pGsV4uwPhXDV2XLL4HF8gYd+9efGsua
	3x4ZAysi93dygyj3LYX+n1izDnUxu4U11NuaB1PhgOmB1Hbe5M+nqyoV5xLpshTrNRAh6RMp+Ez
	C2g/O6R0ig0hYouoxh0/pp97xY7ucoDN5B58M4AaXmCntgVLQOPh28pECDpLA==
X-Received: by 2002:a05:6a20:9f92:b0:3d3:af44:ee12 with SMTP id adf61e73a8af0-3daed51e280mr4405652637.27.1789102148350;
        Thu, 10 Sep 2026 21:49:08 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f1e434sm2883077eec.22.2026.09.10.21.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:49:07 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 0/3] KVM: selftests: add powerpc support
Date: Fri, 11 Sep 2026 10:18:51 +0530
Message-Id: <cover.1789097569.git.ritesh.list@gmail.com>
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

Ritesh Harjani (IBM) (2):
  KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
  KVM: selftests: Use LE bitops for dirty bitmaps on all big-endian
    hosts

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |  10 +
 tools/testing/selftests/kvm/dirty_log_test.c  |  12 +-
 .../testing/selftests/kvm/include/kvm_util.h  |   9 +
 .../selftests/kvm/include/powerpc/hcall.h     |  17 +
 .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  39 ++
 .../selftests/kvm/include/powerpc/ucall.h     |  21 +
 .../selftests/kvm/kvm_create_max_vcpus.c      |   8 +-
 tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 512 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 17 files changed, 862 insertions(+), 12 deletions(-)
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


