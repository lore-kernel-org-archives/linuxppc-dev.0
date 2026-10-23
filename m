Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B743606A323
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XTtBenvH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9mDs5QnTz2xlZ;
	Fri, 23 Oct 2026 12:50:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792720221;
	cv=none; b=JKBoqIBm9G/nzBo8mpWk9GB9N2cp1DFTj2cx7wzHQg/yhDrHZLfUejMbVC2FCrOnwln/ibyaM1i19V5TYQTU4SCmieScktLoR6BPePUAULzxf21YRLlQvHTCCG4HdfJFb+t0t0x2TvLVFkfYpmY5gFBCIq4eUx+byWBj84cf93Mqxod0fnMpGozRf1K3EtqHqX4vAMghgCMIPJduppHmVTJWZRDpDCrFQVt2XzztMrOGAfboKWhSXpWl+ZBs0J22vfHUGLz1GEJ4S0vlWgpxm3/d1ksSVmj+kPcuZkUazKdz7Ol8KZDckSTxsamZGqd5jp3zLf28jjGFJk10+ZE8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792720221; c=relaxed/relaxed;
	bh=X468p48PfOB0WmzJ6kNGiEZKtoooeWVaYKhSdbR2LN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e6AiOK/Sfe5h/FcUnBqH5CyJNTMWkjMzzcjRFqMD1txpXWKC8exCVhhQgET4o9/OWo0mQjmRrVJE6w5d/zr1IRTI/7HLpfqYTXTkRT6htJU/GKhjqX/n/wZjbT/8MVAIk9E+XOBKDuh35wD3yffEd0BPSRJT95yEJrZ5xQv806MN7fwplw42Lj8MZ/82G60dFROU73bchej6+V0seZSabpvD8p+s2EE2ilv7e2m/v1eedrGFTOHsFYOnotsosMl4jmo8KXPpfVS0ca/TocbeH9r4YETTsJOWND6C7u73Jtp2Cw8QQLMt88/si7r4MJyHwnjmIbVaQB5TeDZglKXiGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XTtBenvH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=odys.yuan@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XTtBenvH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=odys.yuan@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9mDr6cMsz2xLd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 12:50:20 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-368581df789so369536eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 18:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792720218; x=1793325018; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X468p48PfOB0WmzJ6kNGiEZKtoooeWVaYKhSdbR2LN8=;
        b=XTtBenvHG7SOrN+kbPiQQ7DL51neC66HgLQbIyPuTDG/iGAwYvX46Mc9RQEDGVr8HG
         ys8WehTkc1VlDN3yInuqQ57rfbAtHw9nxFzUsKVvVK1Tu5YOFV4WXtOn1NFbFlRsr09y
         X9C41m6Qtw6iqWV1arJZEZ5F45neL0KolNNAwvmgKTN2VoPy/uHYNI7K9tIlRIdngnoR
         9aO7GDdmopG9a671C9VyCziEb758lTgGUkFgcjcsRr4GnsLOdl++XudimZVAeuRnKLZZ
         rlmLMIZdOuJxCvsrOEKitGGtrYmPzGLMfDCjM4G6n18YPkhMthbjCP/wI9AvSrWkQQV+
         J6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792720218; x=1793325018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X468p48PfOB0WmzJ6kNGiEZKtoooeWVaYKhSdbR2LN8=;
        b=C2XT7kCywu/qg67z7nR3zve7M8JTS5jZeeoTAYyV/CEtTdRc3g3IyN92s+PXLytSrs
         KjyuaIfIeLigGgYAW9wgvMCfUzuHYgj+10EXR33IBuLiHT6yHnMPH3acQRZUYEBCJnH6
         9qByJQmnVj6j4n3OC6mA1AMVmPaap9enay0JA0g+9EbKCv0EJCbissUhn2V2YIuX7DBe
         0AalqAm4A7FZ0tRwZZQFHKlu879qerctmc4cUlPMZIYzVwpYf/9kr89bCAlree829gWc
         Um8SelviAQsGW+q6yCtYSRzBIKVcmRz/x64J/8ZvYCR2qw/taF66m53p91zbOllZ5QvC
         D4AA==
X-Forwarded-Encrypted: i=1; AKwUvByOiCCodcIrlcZyIHc2A3aVpVZ/iAIawJTU2ylDVeeytgTV6Hlh1aJ8h6LXt/eOacjsn9HNP7FPEeS2nOQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKUBbu9dNpRwuAZ8dGA7MWvsBzjI0IBg/YIHnSe83ewSQeS5JlQ
	VfTV/zudCRMAf775uZhrMbcIuLqqrxOI5g8gI866Bz8zmXCojCsrYueV
X-Gm-Gg: AYBFou3HZAQXA5e2vxy0efaS0DXR+UTfKfP6coRLYSNZEGY/KAWBJzLzgU3OmyPI+GV
	i3UKP6JHhwXaKcnm3WtoMCkHEfR2/iNhHPHT2u69t3MSwZyraneCLkM5385I/RnG7GH7eNGbe6T
	DLeej9rHDeJ/soaeJIr6jJXtkzLtd8RvmPpe9ScQBGoqdrD7bNvD18ZTTkCwjxcdhAfjeT8FzY+
	ODi/0Nfm1Tm0hoxRbeX9XZq/FWxmKXEtnrqYcTN0kYuZ72Du6+SGCcGesr144L7/gWpXGCpLVRl
	KqudKStT50eCkV8K2ykO33wW288wxwXF9GCLLVs0trydZMdUo5eRgisGtwdGFguLXZuDBTBUxh6
	9tUksIwfXU2r9GStS99mHTqrHJ1kfuIZMajFmTA84ChrXhwu1fUj4YBcOonfeXRvFXRzHCx0rRT
	0PgbDMAtk0rXf6RsTzpflEM7W93h7CbDml2/fzpKl8SsTQpX3FvdeQX/PUIiLj2uC6XnjNrqfGm
	9T/tXSCcZqZ+7GNnVb3TqG8vC+3pzJnD+a3i+ZOJJZ5BFVDqYY=
X-Received: by 2002:a05:693c:69c3:b0:368:2c6d:ddfe with SMTP id 5a478bee46e88-368afd86765mr4796119eec.9.1792720218428;
        Thu, 22 Oct 2026 18:50:18 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9c0e60dsm1971091eec.2.2026.10.22.18.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:50:18 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 23 Oct 2026 09:49:49 +0800
Subject: [PATCH v2 2/2] kasan/test: cover load_unaligned_zeropad()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-bug-word-at-a-time-zeropad-kasan-v2-2-be0ecfbae847@gmail.com>
References: <20261023-bug-word-at-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com>
In-Reply-To: <20261023-bug-word-at-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
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


