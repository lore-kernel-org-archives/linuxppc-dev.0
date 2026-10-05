Return-Path: <linuxppc-dev+bounces-28902-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B70CA5FE2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 03:48:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hylj627cKz30Tf;
	Mon, 05 Oct 2026 14:48:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791172090;
	cv=none; b=Ov2Xn4suUY6E29Cex4sr9LLLQPsw7kkQYInMkeNteeaZxCD/BqGbnraz1lgaYMNZpHUixq2XD418UIxzlAvkNcMEruQqgSPlinIkRTuW81HQC6TaZAT457+pjFYa0F6sUznBFm84KRtCd11ImRE9ge8uQGnjo2860QfJhVFfTlIXfU+ltNusnDRR06cBxIY/ilJqn5MMeIvu+fYyvMkj7Q9nJSUwY3/4bG7ULOnE4WG1TtgXSnW5irX5GPC7adQh6DPQhJh7/Lyf7nUatHGaAYGKcf2M4lvLPxvZSGeTf565bC0Er2HwFH9M4wJZHHEL+6R+FBhrlzaTICt0NWKaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791172090; c=relaxed/relaxed;
	bh=We84JRc/bHqMhmFuiHMoH3sRnXvkHgWbYpO/4GVf6wY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WmCvKRaw0tIAbDhPXnnDN53TNDCP120UmcLxylnWYUvuA7JL4vD8mU6ZP7eoYISjaOS5t3u6vWFwCmgJjbGFPkPCLH37pnuepv1beLAIsx4h24n7op5eXJr+Ooi407dPTrPKiDImRsCBUwkEj1MKA2vx54dz6PJ0ZQK73pNoUYV18z8mo/YWf9csWtVAcxEYOeOl9u40dcGXT63pK6hk6HEqBIMqrt/YKjRUWEkOu267VQtOuUyJ1AEdLA7sQk/0hyZkj7JvzXrVgw1cRaW0jLIfki+l+M6p3ccn0L5QMsPrbgCWt+NHUe/6nzM+A9gkDnGttfVWcRLt6qnhlKtDUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ddxERqrW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ddxERqrW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hylj54GN2z2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 14:48:09 +1100 (AEDT)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-33e46a15703so1580632eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 20:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791172088; x=1791776888; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=We84JRc/bHqMhmFuiHMoH3sRnXvkHgWbYpO/4GVf6wY=;
        b=ddxERqrWPTaxMdSMIHzm7yP4Hg2ylW2yHJEgbrsAAmOgBH7d4A+5jH7A6vZCgWmjYq
         wh06MA4k3cMRCrRtGuO5RbT7163sE8XuxGWVRiDE8QMkK0EnEA1pfUXo/5Shyhs/925t
         n7V6v/f4iS/Ei13myPPG6WJF+20I+Tx2xRXlO7TsqZ5wcuXLM76yj8WhCfn3KaQFTT1x
         CfWtYt43dpBHIHWtHYNNfpRHB/dpC9ztDUcO8n8FnfzKS7dNJgptDGi3wRTcxetlWr0k
         GlozVhtPVaLYKHAPA8dLw4yLxbCu+XMgnvhFrNoncg6ZX/T1+YGRYyY5+59fMmmzVca7
         dqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791172088; x=1791776888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=We84JRc/bHqMhmFuiHMoH3sRnXvkHgWbYpO/4GVf6wY=;
        b=PZj93n7JME4Z4R52fZKJoWg4l5aHYWV4laAWvisIWQdItsNHJWpMe1Ibhtja919GuC
         8kmvx3nWCINPQ5cdOnQuKikgYu1xU5M/Xhww2ZXsUJkGvN+wCkXt1z6PlPbPoBab8DTH
         eqaIl3vBxmfKXM6ywyd7GnQi1d06WlOpsDNHG20EuJy6izEWutfH8I3NKaaNaIacZYxo
         vyQ9dSLZOyMutSgNDt/EdObFMGij+zQ07hXI9AGYEmdzA8WW3fDeAMfyaP2sSaufcz0W
         0etnBumsdqSCJslaTVQzbbS3IeT3FAI4cTmJo20EFhQ3Oh9YX8ulTrPaYDZZWa/LLiOc
         d9hw==
X-Forwarded-Encrypted: i=1; AKwUvBxgEvNjSIhQJOjH7/K36wT34xQE3b47m3eXMJ0d8nPx+wn90K7V7fSYLWVCZHaswk39rvPB8we7tBKbMf8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI4a5H5XUVjChWcCPqNKyr+0Qi5V1xN0ZoqBGHASfObrSzXcJgD
	/unIVlnu+nmHYpA+vM6efhLrR0csuRyOq+ad5N0X1xvNDJYpr0H1f4ug
X-Gm-Gg: AYBFou2beK+bUl8koYxGd1fx9jWmqqLqVYZdIbjDYsX6VfT1QLAQtPSySYF7gimKbXC
	2S9Us6LJBTzCcmqSWRJbwvl9W9LU+jQmrcIUFqjhgKK+1B7JCRZdeeiSBSYkU7cp2my0w0W+FM0
	Y0Sxyj8fiigURu+JCLb19TRl4Vm12UmoZYx+WS5tw8A3QrevR7PDb5uI2/CZ+CmTh/uDfN8oKU9
	SzfNvIWMYxC/39jmihLZaSgftB/sLZIsNFw/jYdD+CCp4gy0/WZfvM5G2xdy4IQRnMBEht0WLxn
	zC3Tl4ist7HTJVhaXtYSd4qDU0g53tEwoHLkDSuKH4J3gpgG3cxg4ryMMe/82oxXs8g7tI5qVWE
	J/VOuxGu0c2/zPMOlCJ1livVjRliDM/nYP8WFIqZBwQJs/bkXR9+gTP7a3i8KfgRBfSkqcAbKez
	O28kC7Pwi53pOhNdjMDtJpyYYkf4TkVd6SR/LjiFgviQ6WkREE7Yq54nh01q+XW3xw/24k1Iupx
	TvMunVBHt0PFpFvAY6nQwvQz5dR1ua5C3FdQvs7EBIg3YDzbHBCe+Gzy6Y0
X-Received: by 2002:a05:7301:707:b0:34a:e4f6:4a4b with SMTP id 5a478bee46e88-34f150c3c64mr10761322eec.21.1791172087608;
        Sun, 04 Oct 2026 20:48:07 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512718a18esm10840958eec.17.2026.10.04.20.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:48:07 -0700 (PDT)
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
Subject: [PATCH v6 5/5] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
Date: Mon,  5 Oct 2026 09:17:28 +0530
Message-Id: <0c3cf7d492acb9da38bcdd0331cb69929c947c30.1791014924.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791014923.git.ritesh.list@gmail.com>
References: <cover.1791014923.git.ritesh.list@gmail.com>
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

dirty_log_test already has BITOP_LE_SWIZZLE helpers, but they were
compiled in only for s390x, so every other big-endian host used native
test_bit().

The test fails on big-endian powerpc because it treated dirty host pages
as clean (because of the endianness issue)

w/o the fix the test fails with:
  Clear page 1 value (1) >= iteration (1)

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm     |  1 +
 tools/testing/selftests/kvm/dirty_log_test.c | 12 ++++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 57d1bf994fe8..38c350c5b5e3 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -264,6 +264,7 @@ TEST_GEN_PROGS_powerpc += set_memory_region_test
 TEST_GEN_PROGS_powerpc += memslot_modification_stress_test
 TEST_GEN_PROGS_powerpc += memslot_perf_test
 TEST_GEN_PROGS_powerpc += access_tracking_perf_test
+TEST_GEN_PROGS_powerpc += dirty_log_test

 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index af5eb0334a74..8189eaac713c 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -44,8 +44,11 @@
 #define TEST_MIN_WRITES_PER_ITERATION	0x100

 /* Dirty bitmaps are always little endian, so we need to swap on big endian */
-#if defined(__s390x__)
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 # define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
+#else
+# define BITOP_LE_SWIZZLE	0
+#endif
 # define test_bit_le(nr, addr) \
 	test_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
 # define __set_bit_le(nr, addr) \
@@ -56,13 +59,6 @@
 	__test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
 # define __test_and_clear_bit_le(nr, addr) \
 	__test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
-#else
-# define test_bit_le			test_bit
-# define __set_bit_le			__set_bit
-# define __clear_bit_le			__clear_bit
-# define __test_and_set_bit_le		__test_and_set_bit
-# define __test_and_clear_bit_le	__test_and_clear_bit
-#endif

 #define TEST_DIRTY_RING_COUNT		65536

--
2.39.5


