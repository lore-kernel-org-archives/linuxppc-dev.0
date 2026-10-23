Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F128606A31D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oTy7gZY4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9mDh3mDBz2yVT;
	Fri, 23 Oct 2026 12:50:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792720212;
	cv=none; b=m6Hs/QeW+fBuQhMJYvFTgn3G4futJy3+PvUBR/MumIVXHKh0PqIq7nRtZei94jNtABgGLkS8BJXd+QtnSw5AuCxZ0woUHIOKHP+Xgqbx1aqLvB3l//qaia3XChRm+vCu1hB/2rLCgyVg5miv+DtjdhwR/RDEGyBFs2VxIxF+cKU8GJ/iJqLtAABx3/AUUjg0caF949BetF0NiSXV1b67khfKFnByGtMknMHrOfferlUpBUAz2Ze+qOD9Q+7z7orKjz1qPw1NdfCxl1VipVVguV8LerQeRjwXahUTfOdX+ytAkEadq/UE+3ZvFzRfzeqE1bQmrjkiOsDk5DOeG9tZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792720212; c=relaxed/relaxed;
	bh=a5VOHmm+k0IBj8x+32bgCpnZFpHRZVbIyYT6tTI+jX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eIoKOiNTluk+E8iqINjkzl9D58SctMdx1s7FU9fjBHQFGcAM9REIdie7OZaBo0WnVyW5Y5lujBfIuCkiPKHtqy+2IH4mbmBbILpURTx2UgCe2Nf4+L+qDFlB47EUWohbrLmFn+7nPTMY+6fx5QKmMfHaUQJ0q/EIc/WuyrRe06cEUJ0SGL6zDQ9+fNiiA5hdlp26lCUBO+ThMfTj9bMNav7Ko30E7MQ73gFmtjKraye/Tvm/N82U2RieJtS5EyuxTPY1i2xESff2L1ZIiPQfCZ2ZsQFXEFGj/fWlKrLjRIJrjKr3qnoOAZZqBIcraJf86AeALXBX1yoOpVpRdOcrzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oTy7gZY4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=odys.yuan@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oTy7gZY4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=odys.yuan@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9mDg4NXVz2xLd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 12:50:11 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-353804b591eso743096eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 18:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792720210; x=1793325010; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a5VOHmm+k0IBj8x+32bgCpnZFpHRZVbIyYT6tTI+jX8=;
        b=oTy7gZY4gA8G6ucbmPQdkAF6gME6mOZLkuibrY3L7bunv2GI/jmipYL0Hh5485YFpm
         1nh85rf/g3xFRml/+/3voRLdIMcS0re2ureXOq4/KW379Pz2TapSjBrPQPhPMtqXqxOa
         AlDbnjrsQFXvtJ1W5b7QICd66949CwFgkBgdJnqueJWyeteDbpIaxJPW4QV8Sxpbm/Pc
         1yuGZZp/jtSMUwLysR5A2P7/wOpVyJUi9CSmK1TWPX1DU6QoSmUFJSfop8oKp4uisSZO
         SsQOwPrQ5FP0gBa7LBM2WpLQ7mVQO4E2T4WzCLaey0AXENVyEG4GlTIX7eL1xWj/jgBp
         vJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792720210; x=1793325010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5VOHmm+k0IBj8x+32bgCpnZFpHRZVbIyYT6tTI+jX8=;
        b=AIgNIbj3/Xi8x4LCYvxueT4y+tpBEfNZj+/LchmTVKa5vcscHpgTvKodp/qBu50QJU
         TUiRpPt0zi/XrUZh2NX1/6alABBcz2NXtoCm3VQ6M40ec5KDMh0gg3Nq5c7jb+wYPhSW
         btEizhwBKLsv1i9Z8Dd+XiUsNqJGmqH2j/wjNQXnLfCQvhIF15ZyWYravaQr3aqpCraJ
         2JhidTCRWJ95hOtqz5SQFGXs9Y0JtqQLJq8c/kfaXiwpM3MEwgsT9pEQL4XToYni5y5c
         N0vzYx57840bjFGsB9in5S5Sr/MuwCSxniF6G+NW8zuK8JNWer5UnW6d15l1tcJN3Vi9
         JBTg==
X-Forwarded-Encrypted: i=1; AKwUvBwrB7g08ANjQRZ4bUoCV9K4tcb2QzIjth/hMtJ8oOCM4SplJCkxOyEg8gmk7j0J9/tv+Ldh8LmOL+ZTgoc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJetc8+qLOs3AwQG6E6fgx0V9f2aDhO8qrZtfvt5HCL9vZ6pKWA
	OpSJhNFObm5478tlY6xqotRgkePTVd3rf2GrNNjUafeFciR0A4n1tXgH
X-Gm-Gg: AYBFou2pVWPbTA/mmV/EZDp1/nmsPXlCQ/Iq8yNul8ZOiHCW+g8UJdPs41K4h5id72H
	DPofBYBoJ+efAL8acOCO8gTSIYIdhmlDWea32FgVs+8pNHNYi8I1Kl0e08+vuB4laIC9Jxny+7k
	SZLpfOnF4UAfmcvRhLToFxs7KQdtcciY+rWZ9Eq7e1VahhKzxth/BTHmUI/d8bM409UjaHmRPdT
	D8FxPdamITbIuO7vvVguZGa7drGlPrIEglqFwKdGNA+GSBY5TtHO8G2Pq91nHRpCc1JIRtEfKKZ
	UA4U7ns86j6ZI6OrFe1a90zuj6JQM1ewns/Ett48hHBe9DIOxNRS7hq2cGTErXGh2AtgDdyvsk1
	Ir10vhQw8L/I/qOyvK9IDAsLg2gDu10GVzmnfHAEsn0bjGhWcORZKX/MLyDyQPLZ3xOtc1/nncW
	ZO6y3lthMKr2KUm82TcyjQOuKd5iBkWqpo8bWVo3l1edsbTRqVQMJJgtobOIgRXesWVzSUQKzrs
	KgCcYfGyj3yLj1gO+EjgajR1sls5O6bx6RD1flLEa79i+bgHGLE
X-Received: by 2002:a05:7300:fe81:b0:33c:e74:4624 with SMTP id 5a478bee46e88-369d977beeamr1247908eec.27.1792720209507;
        Thu, 22 Oct 2026 18:50:09 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9c0e60dsm1971091eec.2.2026.10.22.18.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:50:09 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 23 Oct 2026 09:49:48 +0800
Subject: [PATCH v2 1/2] word-at-a-time: check the first byte in
 load_unaligned_zeropad()
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
Message-Id: <20261023-bug-word-at-a-time-zeropad-kasan-v2-1-be0ecfbae847@gmail.com>
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
 Qiliang Yuan <odys.yuan@gmail.com>, Peter Collingbourne <peter@pcc.me.uk>
X-Mailer: b4 0.13.0
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

load_unaligned_zeropad() reads a word that may run into an unmapped
page and recovers through an exception fixup. It does the word loads of
sized_strscpy() and of the name compare in dentry_string_cmp(), path
components in hash_name() and hashlen_string(), and the trailing bytes
in x86's csum_partial().

It is inline assembly on every architecture that implements it, so
KASAN and KCSAN never see these loads, while read_word_at_a_time() at
least checks the first byte of each word. A use-after-free or
out-of-bounds read of a name handed to path lookup goes unreported, and
so does strscpy() reading from a bad source, which the kasan_strings
KUnit case expects to be reported. On x86_64 with generic KASAN:

  KASAN and string KUnit suites      failures
                                  before    after
  CONFIG_FORTIFY_SOURCE=n              1        0
  CONFIG_FORTIFY_SOURCE=y              1        0

Check the first byte with instrument_read() at the start of
load_unaligned_zeropad() on every architecture, as read_word_at_a_time()
does. All callers only load a word whose first byte belongs to the
string or buffer they read, so the check does not flag their intended
reads past the end. Add a no-op instrument_read() for the powerpc
selftest that builds the header in user space.

Suggested-by: Peter Collingbourne <peter@pcc.me.uk>
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Reviewed-by: Marco Elver <elver@google.com>
---
 arch/arm/include/asm/word-at-a-time.h                           | 5 +++++
 arch/arm64/include/asm/word-at-a-time.h                         | 4 ++++
 arch/powerpc/include/asm/word-at-a-time.h                       | 4 ++++
 arch/riscv/include/asm/word-at-a-time.h                         | 4 ++++
 arch/s390/include/asm/word-at-a-time.h                          | 4 ++++
 arch/x86/include/asm/word-at-a-time.h                           | 4 ++++
 tools/testing/selftests/powerpc/primitives/linux/instrumented.h | 3 +++
 7 files changed, 28 insertions(+)

diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
index 5023f98d8293d..361771f178699 100644
--- a/arch/arm/include/asm/word-at-a-time.h
+++ b/arch/arm/include/asm/word-at-a-time.h
@@ -56,6 +56,8 @@ static inline unsigned long find_zero(unsigned long mask)
 #include <asm-generic/word-at-a-time.h>
 #endif
 
+#include <linux/instrumented.h>
+
 #ifdef CONFIG_DCACHE_WORD_ACCESS
 
 /*
@@ -69,6 +71,9 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret, tmp;
 
+	/* Check only the first byte, the rest may lie past the object */
+	instrument_read(addr, 1);
+
 	/* Load word from unaligned pointer addr */
 	asm(
 	"1:	ldr	%0, [%2]\n"
diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
index d7a3b69dc8c6f..37d45e716c11a 100644
--- a/arch/arm64/include/asm/word-at-a-time.h
+++ b/arch/arm64/include/asm/word-at-a-time.h
@@ -8,6 +8,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
 #include <linux/wordpart.h>
 
 struct word_at_a_time {
@@ -45,6 +46,9 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret;
 
+	/* Check only the first byte, the rest may lie past the object */
+	instrument_read(addr, 1);
+
 	__mte_enable_tco_async();
 
 	/* Load word from unaligned pointer addr */
diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 54653a8634149..1660b2e3e3a8f 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -5,6 +5,7 @@
  * Word-at-a-time interfaces for PowerPC.
  */
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
 #include <linux/wordpart.h>
 #include <asm/asm-compat.h>
 #include <asm/extable.h>
@@ -168,6 +169,9 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret, offset, tmp;
 
+	/* Check only the first byte, the rest may lie past the object */
+	instrument_read(addr, 1);
+
 	asm(
 	"1:	" PPC_LL "%[ret], 0(%[addr])\n"
 	"2:\n"
diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
index 3802cda71ab7e..761fa2734b7f5 100644
--- a/arch/riscv/include/asm/word-at-a-time.h
+++ b/arch/riscv/include/asm/word-at-a-time.h
@@ -11,6 +11,7 @@
 
 #include <asm/asm-extable.h>
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
 #include <linux/wordpart.h>
 
 struct word_at_a_time {
@@ -60,6 +61,9 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret;
 
+	/* Check only the first byte, the rest may lie past the object */
+	instrument_read(addr, 1);
+
 	/* Load word from unaligned pointer addr */
 	asm(
 	"1:	" REG_L " %0, %2\n"
diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
index 0b7779c8d5a4e..f3caa4959cc87 100644
--- a/arch/s390/include/asm/word-at-a-time.h
+++ b/arch/s390/include/asm/word-at-a-time.h
@@ -3,6 +3,7 @@
 #define _ASM_WORD_AT_A_TIME_H
 
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
 #include <linux/wordpart.h>
 #include <asm/asm-extable.h>
 #include <asm/bitsperlong.h>
@@ -52,6 +53,9 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long data;
 
+	/* Check only the first byte, the rest may lie past the object */
+	instrument_read(addr, 1);
+
 	asm_inline volatile(
 		"0:	lg	%[data],0(%[addr])\n"
 		"1:\n"
diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
index 422a47746657a..5374e08372253 100644
--- a/arch/x86/include/asm/word-at-a-time.h
+++ b/arch/x86/include/asm/word-at-a-time.h
@@ -3,6 +3,7 @@
 #define _ASM_WORD_AT_A_TIME_H
 
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
 #include <linux/wordpart.h>
 
 struct word_at_a_time {
@@ -71,6 +72,9 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret;
 
+	/* Check only the first byte, the rest may lie past the object */
+	instrument_read(addr, 1);
+
 	asm volatile(
 		"1:	mov %[mem], %[ret]\n"
 		"2:\n"
diff --git a/tools/testing/selftests/powerpc/primitives/linux/instrumented.h b/tools/testing/selftests/powerpc/primitives/linux/instrumented.h
new file mode 100644
index 0000000000000..114ef9284f69b
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/linux/instrumented.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* There is nothing for KASAN or KCSAN to check in user space. */
+#define instrument_read(p, size)	((void)(p), (void)(size))

-- 
2.43.0


