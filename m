Return-Path: <linuxppc-dev+bounces-29683-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1A0CCF2DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 07:31:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7Rzz6v8Sz2xjN;
	Mon, 19 Oct 2026 18:31:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792375123;
	cv=none; b=FVrO9Zoy9UOE1HpR0uOpKmnaYL6W8hznYjll2BHlblo7mAXB3yWeJw62tEysl+94S5MPdewDw+2UPjgMJNCtmSMW5UE6S7nXeBEzVNU1poqJCSVMhW6Kks0Is7A5deavF6HcC/sQus8Q6MAAWs3rR3xXCqFoJwYBJCK4Mm4S5z1aNp+ElyB+EhA0aXTXiWTx2EWPLTW/1+favry8pijbWXAYhnq5Kh5B9hA8V4dpkIwcsoYmoNipEUiBv9LLUN6a86SdG6lciAYZzpMKGXwJ1aaJZdhOS4ici/SUnkjk4bSUFh/37msvCZ16OIbFcH4D0qB3MeSd5GwmA8AOyWQOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792375123; c=relaxed/relaxed;
	bh=eX3gFXGtK0qFC1+jmqNQ0ZBmFVgyc6CU75RzS6mT9B0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i9FdAKTJeIepu6gF/vmwT2/XaYP1FfZTaNJeh2LWAu4vE0BCmw3758gDLy7XNQY0jfMRPuwJwPqWWAEtXDSjscB3qU+Ke9T9mTvcUT4xBYZ2X2+XG0CHeZD5FVwBUzbaF+wyG9HfZbvhtyzkUUR4cQ+5+X8OsnVv5G+AE1enyqfq4jA9U6ou52VuDCDro7JFg/37qVYWUZumLxT9SI0guw1PBkXP9qcGijjCNwdvywVEUezuFjnOkDg2Ah1SzK4P9PN3HdjZaxpVrnmsqrh5c6oHCCk8akS1iqaqco/VmtG5R1+ytGMeaNv9zZxMSo7phoLkiLoTFdNcFZxJawpi7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=snOgOO86; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=odys.yuan@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=snOgOO86;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=odys.yuan@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7JcL2F7kz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 12:58:42 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so3275640eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 18:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375120; x=1792979920; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eX3gFXGtK0qFC1+jmqNQ0ZBmFVgyc6CU75RzS6mT9B0=;
        b=snOgOO86iZTrXqnaVwLEl2rM8VCjF/nZ+ieX9ja6mdh0bU9n5NT0T3eE/V5hCRE9C3
         d+MDgP8mIC9NmdX7VJnRgoj+Qp5430s0G5QuJnUjEIfc/XlKBjCK6yYaO4e4fZV82DlA
         GVcOFeEsXFoF4UCWelr+gliVPwJxA44SqswaAi+8qUozkxyfZc7CbgtHTEuSGbO9iCC+
         yzDBw4O08dAHv8wuGxWtEZOYMtkFmOCQnyPrK3QiQrpPZuf91ASRcv0NDVdfHegBp0W6
         Gjw7xHIRhZGNA7oVL3KNKDJcO9i84ysVszChoohqwAtpszsJBfyalN5ZmSTsWwv4RtKs
         tZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375120; x=1792979920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eX3gFXGtK0qFC1+jmqNQ0ZBmFVgyc6CU75RzS6mT9B0=;
        b=1eZMvoME+RdYpD0M/xBaedi3+vdOKnbiGTC6GHGKa5Dtwvu3xE1EGRBSEb69kyRHVS
         x40MtpfJgNTA5U5m5p10TBFCyQ1ZM/VVd9tUX+l2BeaQf/zQCJHh//Elhmk8tXLNGPzV
         kzb9GXxNwDH54QdxHanqRWgKN2cMhSYDp2YyTKcg0TA43BxVRFHSCcES92DmHcNIxw95
         TnIige3s4M3s8QldHrijwELJKNPhYgwjVBuHVODQmeB3Tsb8D08TPvhC2ClkYCWZqEGh
         nvy/Z7TqltcUrXvgSQ4OZhOWGgCFJtdEctcsslHj30D+jjfdd8cOdAs4R7clxNlSCKOA
         NE6A==
X-Forwarded-Encrypted: i=1; AKwUvBwHavmbwQOr7p7qHRPV2KMYmVbr3MwEmp/YnBW4ihCndB8xED6wJ0PIj3Le5uN+Gxke0j7Z/03/KxRUPqE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJOsJNvHAufX+MDjbho7Nt9XuEf+VzUdfcIQl5NhcSv/UOOKmXn
	VQJMe5Jm1fVBJBRIpndhyNQ7ogpf9UJ6SdBvP56J5Yf8AC6oCRUCF4l9
X-Gm-Gg: AYBFou0++eon4jxR89x4KmOaKv4mAq6EvdOuKCQKJhs+RUHrX8+is/mZf1C8GrVOXEI
	G7xtO2eG3IakJqzZbzsxfQHJcQ3D7E15RLBKT2IiZJv9MXD8sR7knPLLzsFcYNsU/oQyJhcH3Ho
	j/Ov2YnixWG2eQEul2hkVQw6zDAo8UjA0Sw/ObHJMB05X3rNfzNd7O3Mja8ju1fCSS6yOLNv/yW
	MiwTjdBdh9w2/l8l4d5K7QojSJGJVyuvZchK54vcGOSJLbMmbCL6ZdJISHBMsBKgOEO+ttsNrFI
	/lsdN6L8XWQEyFzck3bVu5GOb8xw+ZBZ6Ei38mp0+NPuthFiTvR5hN1g1J4TVmkXnev57scq/bE
	hajKqlD5jxywwxpXLArhdUlZrglaLDqg+ghL9nH57PHOTtOA0mz0NlRxeYpPBHP/HkPMXErPFo8
	K17UVtAOE5A+V9kskhBygxTa2oL7oGse8wbPNCCWGO1xqCgAncnp8Gh/6CBscsy86p/g==
X-Received: by 2002:a05:7022:b057:20b0:18a:d0b5:fa42 with SMTP id a92af1059eb24-18ad0b5ffc8mr1432273c88.19.1792375119985;
        Sun, 18 Oct 2026 18:58:39 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm24177311c88.17.2026.10.18.18.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:58:39 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 19 Oct 2026 09:58:10 +0800
Subject: [PATCH 2/2] kasan/test: cover load_unaligned_zeropad()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-bug-word-at-a-time-zeropad-kasan-v1-2-f21a3ed6a477@gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
In-Reply-To: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
To: Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, 
 Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

On architectures with CONFIG_DCACHE_WORD_ACCESS, load_unaligned_zeropad()
does the word loads of the dcache name compare and of path name
hashing.

None of the KASAN test cases reads memory through it, so nothing
noticed that KASAN did not check these loads at all.

Add a case that reads a freed object through load_unaligned_zeropad()
and expects a report. Skip it with hardware tag-based KASAN, since
arm64 turns tag checking off for this load:

  kasan_load_unaligned_zeropad, x86_64, generic KASAN
  without "word-at-a-time: check the first byte in
  load_unaligned_zeropad()"                                 FAILED
  with it                                                   PASSED

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 mm/kasan/kasan_test_c.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index b9e167ed5be32..c791512f6fc49 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -28,6 +28,9 @@
 #include <trace/events/printk.h>
 
 #include <asm/page.h>
+#ifdef CONFIG_DCACHE_WORD_ACCESS
+#include <asm/word-at-a-time.h>
+#endif
 
 #include "kasan.h"
 
@@ -1673,6 +1676,26 @@ static void kasan_memcmp(struct kunit *test)
 	kfree(ptr);
 }
 
+static void kasan_load_unaligned_zeropad(struct kunit *test)
+{
+#ifdef CONFIG_DCACHE_WORD_ACCESS
+	char *ptr;
+
+	/* The tag check is turned off for this load on arm64 with MTE. */
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
+
+	ptr = kmalloc(64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	kfree(ptr);
+
+	OPTIMIZER_HIDE_VAR(ptr);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test,
+		kasan_int_result = load_unaligned_zeropad(ptr));
+#else
+	kunit_skip(test, "Test requires CONFIG_DCACHE_WORD_ACCESS=y");
+#endif
+}
+
 static void kasan_strings(struct kunit *test)
 {
 	char *ptr;
@@ -2264,6 +2287,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kasan_alloca_oob_right),
 	KUNIT_CASE(kasan_memchr),
 	KUNIT_CASE(kasan_memcmp),
+	KUNIT_CASE(kasan_load_unaligned_zeropad),
 	KUNIT_CASE(kasan_strings),
 	KUNIT_CASE(kasan_bitops_generic),
 	KUNIT_CASE(kasan_bitops_tags),

-- 
2.43.0


