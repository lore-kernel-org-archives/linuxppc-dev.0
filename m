Return-Path: <linuxppc-dev+bounces-29682-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2225CCF2DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 07:31:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7Rzr073jz2yFk;
	Mon, 19 Oct 2026 18:31:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792375113;
	cv=none; b=BNqLdkr51/fHMzAsSkE2Ec6WFSAcXjYWYVz6gJROze5RvuXgRfUr1GiBbKGpwPVNrDRN8+LHLbvsAm+Cwqh6BIRjYJd5EUcXPFRQS0/MNTaO0t8H5mFMsI6qALaZA1qUN0Px8fJd9ypgjUnD/XifaThL8RxeaHradPFG0MI+yTBw7op22NK+Qf+JorrE2X+RzZgNtWhBHcOD9/KZrwizODFY0ciYrKqmqqjS1CLwKXpQtrYFI2o9f/YTADi/DNgrF30fLjD1Ga7sepe9ow2aB7LDQsoDz7J0j+5Ikgly7rMcYTm768SGzHAw9jJCWufXNHSvrf/MeLuX3SQMdENfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792375113; c=relaxed/relaxed;
	bh=wabN2RpcS9yTy4X+yFbisN0o21RKH0fyf1fEhCrMYgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h6rYoabf0RHt7bsxHk5oLNtv6aHDHJVqkMzOEVevDoa/UHe4rKv/CLX2PHyzprJC1oXBfBkWUydaXueTiypcDP3V4UiIwZbHUpGnjBH67Faj+SX6DDhiegwNEw7QrzyuCcVoqGn5Us5OQC6bCA5XFRe2S0snhrn0oSxGFDwIK23eaXTW2bXjOR6n9bHGeTysH0FwFvb4VyDP7BFEkJEe67VGb2pU5rA2rhHTdEWCnnPvKW6kGefgsRM7pt84AiMzwz3cSUdYP3c3MCLhOG5coEVjscKCXzFhwWmtuDsi/TyXrSFhMrJeoNb7ZllmIDNljLFwvBXFMDRGiKvQ1LT/TQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FvcacO5T; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=odys.yuan@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FvcacO5T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=odys.yuan@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7Jc90LSjz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 12:58:32 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-35943f55c06so2369988eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 18:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375111; x=1792979911; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wabN2RpcS9yTy4X+yFbisN0o21RKH0fyf1fEhCrMYgc=;
        b=FvcacO5T+mjH88KsQlxv5UDL3wOmfwod5M/uHbHuSm+kqi1DeO7vByCqZa+4mNB8ni
         PvJwp92ZvcbbPalL22ohGMMnL72AOTxVi+zhcMaHG4CTn68QmmwbKayaiSU6YtWzo98c
         eaF1rMtmhDOMoMqc9oN0erEah81UcpkNya8IA3yaSejnj5AJ79SiChlKtIo/DkucG2GN
         OXKMEqeH0kn3K+AN41tq1AAgYj/N1t6PT44f4s0APfJI5HG/Hklqurck5Iinlf7mDkOh
         0eRG43GsGjaayhGxZTBt+XC0Pl3+mjR6dYaXU6ZhbZMja/sIQq5nfpZAmBISp8QgtbpG
         2c8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375111; x=1792979911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wabN2RpcS9yTy4X+yFbisN0o21RKH0fyf1fEhCrMYgc=;
        b=lSLNcbofCm+TYaNYhfi24+qKk+rTWuRRMue6cZbIeKMdtSFfG9EJ7TwvK+v7jpSuGa
         WX3/touLgXyxT6mM9X18sdTBi2WpNShBf7BgBpRFDr6qgYqndkciH+I4Ns0vHRjST/ST
         8DbvbjBAW7TT7wsTgPd2DAQpd2ELVl6MEdXo+OgtwS0Ch/BUioU+9Wk3wFsQFVAUD2pu
         nHIplKvjtfrVy28tXHeJF8EIP2W+kK279JdfgIM64gqpIvVcePtHxXN+Rljhq1SwyQVI
         DmGV8QK8+2i8+XjVM7x4Ri0WO0/gx69wxFiYyeMTY1ECFSpglv8go/nvdRbWnTvk6Dv6
         l2hA==
X-Forwarded-Encrypted: i=1; AKwUvBxS330s8urfBhnIbZOgjOgZKG213P7SxNchPqZPSBZCmVzRNjUmqYmRZCBPP0A36wCfo8CBA0oNWwScGkU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKAWruvpTjx0ys36w9BZC2zJ5/pjAZkj5owJgQKaDPnWYXvrm/j
	3tDMa0tKiogIQ+QPdPMZQGm77qyDGGQEv54hXYYCgBUcwzjm+N1UhbL7
X-Gm-Gg: AYBFou3qH9VYmt6xxy5gAw5PYB3tYPmzZLwEQzJG214Op5VmOXOPjNZ5EXoAlBw+8DH
	1CxSce/VcLQ7mnJ23Oss8c8SIEp0EjTTxEvb0ERoYasFGG168wRw/PIK5UGdu4vzOk2mOvGyl++
	2vYhADQe35Lv2TV3XjPNrp2YOHJDfrJNc2blwK6GRgU/aaCzpZ53UHaIesMJDAtYo0RJabycVHE
	G9oosfp2Y2T3sAXVriCT+6EEsA87a1Sfdz7dtptUwwgmKP8IR9EFQRprYPCVKrn+0255bnx3Mi8
	lruEFVWBjB8IHq36GVNK3C1CQWXboWJiCJ7dMd1dqBTCVoYiYArrkAGis7U1hYatTQjDgIwAamc
	7BPNpnkBqab1Rb4ARx2kxSW6iu7riP5g44qXv+uqaNNsnIxLv1vZh9Weqm6ZA2KQ8U2g9vRtcYW
	XPEc0nf6XzEg5+xYuEx6N5eDaZttLZbIaMv+dwUoSPs/Pv1TvEmFKK62r4iY5iTJEtWE46ancre
	B/S
X-Received: by 2002:a05:701b:4202:20b0:146:5f73:d45b with SMTP id a92af1059eb24-1850be495b5mr8924712c88.3.1792375110248;
        Sun, 18 Oct 2026 18:58:30 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm24177311c88.17.2026.10.18.18.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:58:29 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 19 Oct 2026 09:58:09 +0800
Subject: [PATCH 1/2] word-at-a-time: check the first byte in
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
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
 Qiliang Yuan <odys.yuan@gmail.com>, Peter Collingbourne <peter@pcc.me.uk>
X-Mailer: b4 0.13.0

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

Check the first byte at the start of load_unaligned_zeropad() on every
architecture, as read_word_at_a_time() does. All callers only load a
word whose first byte belongs to the string or buffer they read, so
the check does not flag their intended reads past the end. Add no-op
stubs for the powerpc selftest that builds the header in user space.

Suggested-by: Peter Collingbourne <peter@pcc.me.uk>
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 arch/arm/include/asm/word-at-a-time.h                           | 7 +++++++
 arch/arm64/include/asm/word-at-a-time.h                         | 7 +++++++
 arch/powerpc/include/asm/word-at-a-time.h                       | 6 ++++++
 arch/riscv/include/asm/word-at-a-time.h                         | 6 ++++++
 arch/s390/include/asm/word-at-a-time.h                          | 6 ++++++
 arch/x86/include/asm/word-at-a-time.h                           | 6 ++++++
 tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h | 3 +++
 tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h | 3 +++
 8 files changed, 44 insertions(+)

diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
index 5023f98d8293d..f672aad2e30e6 100644
--- a/arch/arm/include/asm/word-at-a-time.h
+++ b/arch/arm/include/asm/word-at-a-time.h
@@ -56,6 +56,9 @@ static inline unsigned long find_zero(unsigned long mask)
 #include <asm-generic/word-at-a-time.h>
 #endif
 
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
+
 #ifdef CONFIG_DCACHE_WORD_ACCESS
 
 /*
@@ -69,6 +72,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret, tmp;
 
+	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
+	kasan_check_read(addr, 1);
+	kcsan_check_read(addr, 1);
+
 	/* Load word from unaligned pointer addr */
 	asm(
 	"1:	ldr	%0, [%2]\n"
diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
index 824ca6987a516..11ecca99057aa 100644
--- a/arch/arm64/include/asm/word-at-a-time.h
+++ b/arch/arm64/include/asm/word-at-a-time.h
@@ -40,6 +40,9 @@ static inline unsigned long zero_bytemask(unsigned long bits)
 #include <asm-generic/word-at-a-time.h>
 #endif
 
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
+
 /*
  * Load an unaligned word from kernel space.
  *
@@ -51,6 +54,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret;
 
+	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
+	kasan_check_read(addr, 1);
+	kcsan_check_read(addr, 1);
+
 	__mte_enable_tco_async();
 
 	/* Load word from unaligned pointer addr */
diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 54653a8634149..49c6a1f65c493 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -5,6 +5,8 @@
  * Word-at-a-time interfaces for PowerPC.
  */
 #include <linux/bitops.h>
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 #include <linux/wordpart.h>
 #include <asm/asm-compat.h>
 #include <asm/extable.h>
@@ -168,6 +170,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret, offset, tmp;
 
+	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
+	kasan_check_read(addr, 1);
+	kcsan_check_read(addr, 1);
+
 	asm(
 	"1:	" PPC_LL "%[ret], 0(%[addr])\n"
 	"2:\n"
diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
index 3802cda71ab7e..fb7e2904dd7fd 100644
--- a/arch/riscv/include/asm/word-at-a-time.h
+++ b/arch/riscv/include/asm/word-at-a-time.h
@@ -11,6 +11,8 @@
 
 #include <asm/asm-extable.h>
 #include <linux/bitops.h>
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 #include <linux/wordpart.h>
 
 struct word_at_a_time {
@@ -60,6 +62,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret;
 
+	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
+	kasan_check_read(addr, 1);
+	kcsan_check_read(addr, 1);
+
 	/* Load word from unaligned pointer addr */
 	asm(
 	"1:	" REG_L " %0, %2\n"
diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
index eaa19dee76994..59393cf065964 100644
--- a/arch/s390/include/asm/word-at-a-time.h
+++ b/arch/s390/include/asm/word-at-a-time.h
@@ -3,6 +3,8 @@
 #define _ASM_WORD_AT_A_TIME_H
 
 #include <linux/bitops.h>
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 #include <linux/wordpart.h>
 #include <asm/asm-extable.h>
 #include <asm/bitsperlong.h>
@@ -52,6 +54,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long data;
 
+	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
+	kasan_check_read(addr, 1);
+	kcsan_check_read(addr, 1);
+
 	asm_inline volatile(
 		"0:	lg	%[data],0(%[addr])\n"
 		"1:	nopr	%%r7\n"
diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
index 422a47746657a..1319e1d87a9c4 100644
--- a/arch/x86/include/asm/word-at-a-time.h
+++ b/arch/x86/include/asm/word-at-a-time.h
@@ -3,6 +3,8 @@
 #define _ASM_WORD_AT_A_TIME_H
 
 #include <linux/bitops.h>
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 #include <linux/wordpart.h>
 
 struct word_at_a_time {
@@ -71,6 +73,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret;
 
+	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
+	kasan_check_read(addr, 1);
+	kcsan_check_read(addr, 1);
+
 	asm volatile(
 		"1:	mov %[mem], %[ret]\n"
 		"2:\n"
diff --git a/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h b/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h
new file mode 100644
index 0000000000000..000c92de6baf2
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* There is nothing for KASAN to check in user space. */
+#define kasan_check_read(p, size)	((void)(p), (void)(size))
diff --git a/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h b/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h
new file mode 100644
index 0000000000000..39c97bc15531e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* There is nothing for KCSAN to check in user space. */
+#define kcsan_check_read(p, size)	((void)(p), (void)(size))

-- 
2.43.0


