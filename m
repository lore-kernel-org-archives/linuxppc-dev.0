Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F22606A332
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWOLNQrQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPNL3h0Sz2xlk;
	Thu, 19 Nov 2026 14:39:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059570;
	cv=none; b=gv+8eT8HvUUOwlOXKkjUBkK5zE6mi4dg16PL4ZcIYc3v/n24BEHs4TRVv15DJ2StiOgjFE/UxqVzRE/ykyxaK7dCzh80aSgsxIZoY+nfG5mIyJ6kEnpxCcFBxZJqMzmvWi1dhttyabDmzTBVAEL17cxlfDi6mdBmZqD2JGOZgeZMFHYvJg3JzeNlFO89iytFAn+6MzHeW98jPg7AwIhJ+FlIZRm2AVEnvX4YcsNOb1no8U43txLCXSRRZ2op/B+pMQqLXbJjQc3Bp1JsVbUu2y4Wak9u+XZ9uD4SdMok5K8+JL5JcLQiDHg9Mg8rIuECupYwAN1XUd1kFBoLFiKcrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059570; c=relaxed/relaxed;
	bh=RTEugiXeVDB7kvXI871yYwSSBbfkJE4r1t14Xfi0eHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TAhWMgqARhhCIZ0SvKiqPeDb2XUocvNywLgvZt23mwGR/Dh5qHN9SHSZLlAmidUjpPgTdGG2C/hcMCtmjCZSeZ5egOvTyBPZc+aOyOwh4uS9u0t7DrTO3KDQHDcE0mhHPvtCUbu3Nrvoz/EcJi+V2zhAC77JsA8tBKsgGDU/cbxhDb6ppptbcSiBlUb3Sp9kTI4eT2EJoS/iOSZdFcrDDUxMB3DAFdhEKkkCSpAqPj+D4RywR87lS5AhH8iCFA8mfDdwCPMmaspnCm7AmCGfz/kRwYfA1vIpEBJsZU9NJUZiJi/RUsfe/k+SUO7YsFHfEEW33RQa1r3+1S7j6DuahQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWOLNQrQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWOLNQrQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPNK4JsSz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:39:28 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-38318d69173so2092719eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059566; x=1795664366; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RTEugiXeVDB7kvXI871yYwSSBbfkJE4r1t14Xfi0eHA=;
        b=qWOLNQrQ8WqDpAcMTg7KYcELn7iXceKcKflmPFfn8JNV63HjPEHYJu9NFV+ISc+nTl
         2dQB81aNkoWawG1Bxl+igxcHWYq08Za3IKv5GM0VB3rwks6fdaUvLbN3kdvJhme7VZhT
         vK9+Bt3xDjeQZQNuiF/WE8j/3jZNPXyH4wrwZ1UZX9fsnZqOSo+lWAinw32USGgyQfEP
         /1dQAIHdIVqQv5HPayuNM9U9KJpewd9FPDuc9QmDGhEs3UBl4IfLT6HI//gQpfpzE8Vs
         VjEwyzN+Gd5hY+NtsQC31Q20YdHQcLxTE9XkHEIXs3pb5rPXv6sBvW79Qs3RXRYf/HT5
         zKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059566; x=1795664366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RTEugiXeVDB7kvXI871yYwSSBbfkJE4r1t14Xfi0eHA=;
        b=1chzf+3a3Xd1fWOob8IwjGS1Hy6idglbrnL1jl+X9alB6z26yBQ3Cwnec5eLnEG+w4
         DT0xfJfCvbACpOnR0SlyVKfqzbXSC2PkW6SFr8xxXWCFwLqiM0ThYGpi6BX4++1z3Aw+
         Eg7Xio1MvAZnBxQmO+LkZq5rY8L+unwxzsg2H4RNge/dUgHsq1/TT/GpJMpP/hdLFvGr
         PZSdbzkBjJVjgPBhvt75BqR6N/8Yly2N0kqebxsapPecjd1QsjE2kuVdbRLTqqkkdqC/
         lRzca63m0K9BvIALuhnKmqLiPumglPf6OlqvC2eCUk7JC1XMMKSowTD0mQoExrDtVcYN
         3FIQ==
X-Gm-Message-State: APuU4Z8XJJw2fWMXUuRLhLkJitWfrAgMmAjDT7m524NomeTwh5tkyOGh
	V4mGt158tOr9M05JDI1pDQxSCGVz6GC8H7wfdjRkqIAO56kFV0JLTC+fmUvhIA==
X-Gm-Gg: AZFdTZfGI+2a0njrXHefT25bwdTWDieK3/2ho+fBT/cGQ17WlYrrHz83PGqLWYb/wfx
	QoG5QrycyW534Qr5Tz5KoieZolFCpzPdedOte9mE6N539dJS5dHIa1iTxr0MEz8FOwlQ7PHFE3o
	eIKNYXU+Z6sYogXeC1RFJH7cu3RWRjfJCn2JXEZ+T5C2fxkfWROK0IN/RdfUA/9KYuGYnKUbOxf
	1kqvYZgj6rCvL4leC/DdYVt/lJmXqoiM82OWymnzX/K5KS9eXS5qiMraHFHjn94p7iWmtDuySK1
	23KgtK1DbjxaL6KhkoSUW0AXsWacpWTiCWCQYE/DPvwPEiTN0WoEX5x8wMHjwCTsjCEc2crZAiZ
	1Z0Y4dKejrxduxTxFWR4U9dF+ZXUmwf8RxE70nwCyCo3cJUSNMtzOsRKPHj7Pv8gxRQRF9sYcLH
	QPKIuGrE3KXQQVtNKDI6bcvGBiNd+cIqmiGUxfKhIRRJH+lCQezEMlPKo+tgjkUF72rYEBwixMJ
	tbwswnLJ1+GoJfFwKlcSlmxJdAiOMRhYpG0wVTrrbPObgUtIV6UmBqYM1tc67z9X0D9d9HFap42
	NCvGcNFwCp4joaL/TNUn8SxCB8UGTbRFQjtqH/QSiIYF0BXZ2ZjdFD4=
X-Received: by 2002:a05:7301:18aa:b0:36c:9afe:fcd8 with SMTP id 5a478bee46e88-38281813bc6mr4014262eec.30.1795059566086;
        Wed, 18 Nov 2026 19:39:26 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:39:25 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 00/18] powerpc/mm, pseries, powernv: Enable clang context analysis
Date: Thu, 19 Nov 2026 09:08:55 +0530
Message-Id: <cover.1795058683.git.ritesh.list@gmail.com>
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

Enable Clang context analysis checking for most of powerpc/mm, pseries & powernv
platforms.

Lock acquire and release checking used to be done with Sparse. That support was
removed [1] and replaced with Clang context analysis [2].

Note that enabling this caught a real locking rcu bug in arch/powerpc/mm
(Patch-1). Note, more invasive checkers to check what each lock protects
is deferred for later enablement.

The series was build tested with LLVM/Clang 23.x

[1] 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse support")
[2] 3269701cb256 ("compiler-context-analysis: Add infrastructure for Context Analysis with Clang")


v1 -> v2:
===========
1. Dropped RFC tag, since this series is looking in shape to be included for
   v7.5
2. Clubbed both RFC series {pseries|powernv} and mm into one.
2. Patch-3 changed the type of i from "unsigned long i" to "int i"
3. Fixed commit msg for patch-14 - as pointed by Sashiko


Ritesh Harjani (IBM) (18):
  powerpc/mm/book3s64: unlock RCU before returning from mm_iommu_is_devmem()
  powerpc/mm/book3s64: Rework tlbie() to remove conditional locking
  powerpc/mm/book3s64: Rework native_flush_hash_range() to remove conditional locking
  powerpc/mm/book3s64: Annotate the subpage-protection PTE lock
  powerpc/mm: Rework nohash TLB broadcast locking
  powerpc/mm: Enable context analysis
  powerpc/pseries: Drop inline from hugepage invalidate
  powerpc/pseries: Rework hugepage invalidate to remove conditional locking
  powerpc/pseries: Rework hash flush to remove conditional locking
  powerpc/pseries: Add context annotations for the DTL worker lock
  powerpc/pseries: Annotate the VPD sequence lock context
  powerpc/pseries: Annotate the RTAS indices sequence lock context
  powerpc/pseries: Annotate the RTAS physical-attestation sequence lock context
  powerpc/pseries: Annotate the DTL debugfs read lock context
  powerpc/pseries: Disable context analysis for the CMM hotplug notifier
  powerpc/pseries: Enable context analysis
  powerpc/powernv: Rework OPAL console write to remove conditional locking
  powerpc/powernv: Enable context analysis

 arch/powerpc/mm/Makefile                      |   2 +
 arch/powerpc/mm/book3s32/Makefile             |   2 +
 arch/powerpc/mm/book3s64/Makefile             |   2 +
 arch/powerpc/mm/book3s64/hash_native.c        | 122 +++++++++++-------
 arch/powerpc/mm/book3s64/iommu_api.c          |   6 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |   2 +
 arch/powerpc/mm/nohash/Makefile               |   2 +
 arch/powerpc/mm/nohash/mmu_context.c          |   1 +
 arch/powerpc/mm/nohash/tlb.c                  |   8 +-
 arch/powerpc/platforms/powernv/Makefile       |   2 +
 arch/powerpc/platforms/powernv/opal.c         |  30 +++--
 arch/powerpc/platforms/pseries/Makefile       |   3 +
 arch/powerpc/platforms/pseries/cmm.c          |   1 +
 arch/powerpc/platforms/pseries/dtl.c          |   8 ++
 arch/powerpc/platforms/pseries/lpar.c         |  59 +++++----
 arch/powerpc/platforms/pseries/papr-indices.c |   3 +
 .../platforms/pseries/papr-phy-attest.c       |   4 +
 arch/powerpc/platforms/pseries/papr-vpd.c     |   3 +
 18 files changed, 179 insertions(+), 81 deletions(-)

--
2.39.5


