Return-Path: <linuxppc-dev+bounces-27085-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82189C88E41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 04:57:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2Mj67D0z2yd7;
	Fri, 11 Sep 2026 14:57:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789102625;
	cv=none; b=RcsmYhgmJrn7CUwL/pgqm8IZX2nbjCVF2173qvKKUF/A5sViiltcz/SS0/RjxPXAgrCKFYSpp150Wh0dCAJoT4pTR2WFq0O0mFkOujCtTmymbRdBQpX0J4qh9CQnhrwJXn6UjEKelNQpWheSZwuK41mP5wS/38tzYPGvkKUOX8K4sQmfqaRpVnhjNDdLW2dRNi51pGEmDSy9ETCUQ7yg64o7PWW2Q46GDHmDdDNJjaxrbbjUjv2AxnFOzINboELV16SMLX/634eoHKGCftk4Wya1s6pb+Pmo5hKAzK/GsOue/F4ltLmv+je4BOeORY4fYBH7RT6W5casvmg3FX6kEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789102625; c=relaxed/relaxed;
	bh=sS+NnjQVu7GC8limcyn1Ri+jiI6RVFD9z3vzk1/dCDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KlpDujkALk9gGLt2hTfhssJXIhSK9jIfHxAmhXspg7pBR2xKbKB/sSRf2c1JT+BgruzH1TnGD7eBeXfQ3y3wBLmuqv0uUgMAM7d6UK+o/vZvsO37RU4Ny0rZq8OoD2skrUDfepKVppATtv4G1FPpwL7Zy200mrYhpKw+iKtLSvlzWZwjNq20H5lgttHLvW2T3xlMmYHcjJzpXeLO3YfD+8ff2hQDr3dKa+rGWHkHDWoTxftqIghRKmuUzSKv/2kM9PUC4VR0jPpJozjkUPcTBhHlvVZCY2MS44XvHjDoR8St36FT8Wgkzm7TrsIhv37jv5G3q1nLDDXFQHqSXSmDmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GfuDVk4l; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GfuDVk4l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2Mh6YX0z2yFj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 14:57:04 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so518329a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 21:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102622; x=1789707422; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sS+NnjQVu7GC8limcyn1Ri+jiI6RVFD9z3vzk1/dCDI=;
        b=GfuDVk4lPRzvXT0UkwWFrnojWS2Hs6iBN+tXSkhBhwgbASBW1/t90x0/pOkunlZj0K
         fEiRI0EIGzwNQkR7n/fohq/xEwob5AbPJ5Vtk8nr9BqPtCK4WLoB6476q7ijJ726Z5Mv
         Ru+fogvCTejbIId+tZ18z1e3dFDtgjdyFeVjCSx9j5dz5L3tD5tRWdUXPrxB8lY9KC4E
         svYAiGJD9gymnouNp5xjnSkJ3HGz2COyhtAvkR5cvPva1tVHnXgFT3Kntv/q36013b1i
         UddxMBI9cN9QZqq7JytwaCynvHHX4An3iPQerZhogI/abhfu/zjC0y+yVK2n1JTW0Gb+
         juOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102622; x=1789707422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sS+NnjQVu7GC8limcyn1Ri+jiI6RVFD9z3vzk1/dCDI=;
        b=Ae2tcZ8JmyAmx/tb2HlLKT4evq1sbrvmM/ciBc+NQfIB+gwDSnrQvvKV+/C5wm1ajQ
         jq2O/YaJlYrb9JC5mOgNkLK/D4HXgzvybAmpHFqtR+jbIJXJt7C1uAKt2NoBdEvWB7yc
         MDCqHRvS+G4XxQ90jTDNIzvIta7V0q/G/UuxqquPL5XSCe8r6ciT4yVEiOEAWRk7x2hT
         1XQHYqB/kpDq0ooZA6YIQPSUGbaW1tTMiOgwcIRuYobm6lkpOySfNJmiRnlxXoQGRMWO
         aWe6iJ+6U00tBfpxsI8End3w/XmixjVg4Du2Bocd2j+HGBhRMUoknMV1RrltZIwGcmFu
         ygDA==
X-Gm-Message-State: AFuF++l6KGrj4sUixzYVINBf5H4fUQ/LV5TW7P47IfLifNeuQ+/RNUTo
	uHjTNOrCIIt74ENXuVhUW0ZhX2eVkvolTP7sHyMVo4PEP38A50L1b2CBBQpTlZoN
X-Gm-Gg: AYBFou16X6T3PH0GrR61hpGWxo6rT8gzMkMGZYWNNCxK+6+XZR4352D8oMXRwH/FVZ5
	onnA5ad+ZP4i8TCd2sQVZJWEi5l1yrHTKdvTctTgNYnOQTo/OB6NzK11AOShKUfk3/+PECufcYi
	u/jsuoje7Ix5MlucwaxBMlRxg4myt66UECiE3tYCGO/Dd64KulPtPaurlKtue2rmxdEZaRl2Egv
	t9SrdKhdEB9ZimNyKjOgooR++pBU22Jpn/IPYm8WXh7RmT3aPHJFbbbLpGmV8+/M/1SjCTBeaYh
	7T0n+DrJn2uv+/nzsW7lq8V2OroEeSwN/ioDLcPOAoG62VJQHAs33I9uWhWB4iGeKHi3EHKEOTk
	frzg002iqa38SS2tjXsW5gf+31toWlyRY771UM9WHkoqE9+4XCp0Wh8qMn9x9v+cb4GH+Yf1tR8
	RwcGsnJkCrepoqAJZIDn6FCxkesaabHpNByO0lAJeqBXSZ+/7+KRVIqr/6By689DDmjZfKgkzQJ
	2utkhifwmm0N2FhNz5tCVt8QiQblFp9Q2c2pvhDnzTsdFIaCMaSsVGQUHvfp7bal6Em7iY/
X-Received: by 2002:a05:6a21:6f88:b0:3c3:6f6c:aa21 with SMTP id adf61e73a8af0-3daed20aeabmr4999468637.11.1789102621767;
        Thu, 10 Sep 2026 21:57:01 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a3casm2837953eec.12.2026.09.10.21.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:57:01 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 0/3] KVM: PPC: BE guest-exit fixes and nestedv2 vCPU limit
Date: Fri, 11 Sep 2026 10:26:44 +0530
Message-Id: <cover.1789099725.git.ritesh.list@gmail.com>
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

These issues were identified while adding kvm powerpc selftests infrastructure
support [1]. Patch-1 and Patch-2 were identified while running the selftests on
Qemu+TCG+powernv+BE, while Patch-3 can also be reproduced on a real pseries LPAR
with nestedv2 capabilities.

[1]: https://lore.kernel.org/linuxppc-dev/cover.1789097569.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (3):
  KVM: PPC: Book3S HV: Read EX_DSISR as a 32-bit field on guest exit
  KVM: PPC: Don't call __ffs() on an empty pending_exceptions bitmap
  KVM: PPC: Book3S HV nestedv2: cap max vcpus to PAPR limit

 arch/powerpc/include/asm/kvm_host.h   |  1 +
 arch/powerpc/kvm/book3s.c             | 22 ++++++++++++----------
 arch/powerpc/kvm/book3s_hv_p9_entry.c | 13 +++++++++++--
 arch/powerpc/kvm/powerpc.c            |  6 ++++++
 4 files changed, 30 insertions(+), 12 deletions(-)

--
2.39.5


