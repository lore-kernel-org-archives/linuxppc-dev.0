Return-Path: <linuxppc-dev+bounces-28795-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D95CA5FC1
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 03:59:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxX325q5nz30B0;
	Sat, 03 Oct 2026 13:59:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790999966;
	cv=none; b=FLz5aN9BvikLza/2dw9V/x4Fnp3jbtaGAxOsI+EVh3uD3IvgY6WfJo/QkMgJ7nJvt2SQUkr7V5EWOPujqtbSxSbQ+wm/9AjkwHVT38m3YEHaQCl1+Vf1elfb6ftrNdD1XDIzPrZUxWSXfFD3x3laWfrDTK1vgfUAGzHHvk3GhGf4KJiaezAdT13iWii416Vw23iQvRyXl/qE/e1QVhHpm/N+vlGfpz1yltXAgYeJJkrNMmXywOTbUluunulmJ5twaylljzV0udMzXLdlnxIVWLwx/iBJ03as/aSKS22c3iNCmivBonbDnwRrWmiC3CXWGWB6LchvHtz2DK+jKFwKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790999966; c=relaxed/relaxed;
	bh=0Fe4ObO/b/TE5s1PNVsS4XfT/c4N/SLhXa9vwlS3HrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6jeTSt1kEKrwUS5qZzlVBLaMm9QrQHhXhlPb9ztQSW/LsTNKt0ArF4R8/lJYNCGo9YAC2CVBwN8EsYvDsNtLtz7mcnyYErOQo9IUuWoJ5CbWgPa/hdW/XmjUGcHEQ9Oq+CJLaqngfjwDvebxcKZ5BbycX+aiTgIa/7rwmQtLmzmNHU6/fWDe0lUN1w/dbIR/Qm6VGvsNLwvjFLDImTC+HOJ+JoF4b7l3S7S4iLEzuFS18KIcpTwNBaWlzx343Cre2vd/hi7qqphEoew5mGQP9O3OO817KWBaOjJ3cC3YCImSl/pgohgkUegZzdQRGKHtCh1AudXvUS6HKcy7ssAUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ByCS1LCL; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ByCS1LCL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxX312FYLz2xr2
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 13:59:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1A66F4481E;
	Sat,  3 Oct 2026 03:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8445E1F0089A;
	Sat,  3 Oct 2026 03:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790999961;
	bh=0Fe4ObO/b/TE5s1PNVsS4XfT/c4N/SLhXa9vwlS3HrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ByCS1LCLcBddvmSJ5hf+E27JAog96iEpsqpjVu6XSmJ8uHXFNwQscNI3ZAG2i0Hgr
	 ZPqLU8rtDNR+WPFUKts3oC9Lx843S0LF9tT6ECBXN/01B1Z4cASLFwrx+2njxc619N
	 18p3x5zcrPYF2+DZhMhveqieqt3obmjHMESL0q29/gA7HuP5lf8MwEhltNk14oD9tH
	 ztcK+/aRIcFJO5E6b63y3D/rCPl5Oz1p9+KMS1iTXm6nwiK7U2LKjYeihePivKslH4
	 bG0epZtBCdMK6kZThQ0M7n7J46IJ7lp1uH/efqcnrSl6tbhJZ6sv64o3EZJY4ZcBKr
	 Ajd+46zJ0nP+w==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Gow <david@davidgow.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Kosina <jikos@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Ira Weiny <iweiny@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 02/11] seq_buf: Do not pop from an overflowed seq_buf
Date: Fri,  2 Oct 2026 20:59:07 -0700
Message-ID: <20261003035921.1918874-2-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003035906.too.263-kees@kernel.org>
References: <20261003035906.too.263-kees@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4958; i=kees@kernel.org; h=from:subject; bh=Y6zIobaHfAH25spVVd3tRtK22OpsmMUzA9m4akP1URw=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkHaid+l+a8nOyaW1S4ZqJFigZHOvPUFAOre0sWuJa1v f/hGz6ho5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCJmtYwMU7KFzzKfFdjhHlzb dG7GBdFp6xVWn8rszYy5zDTTbXt9GMP/GMPNplcrmn83sEgIHYi84jwzP5Xv1ZNlSjY/dS2WbX3 FBAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a seq_buf has overflowed, its len is size + 1, so seq_buf_pop()
decrements len to size and reads buffer[size], one byte past the end of
the buffer. It also leaves len equal to size, which no longer counts as
overflowed, so a truncated seq_buf then looks like a complete, full one.

An overflowed seq_buf logically has no last character to pop: the
length of what was written has been lost, and the last byte of the
buffer may be the NUL written by vsnprintf() or bytes that were never
committed. Return -1 for an overflowed seq_buf, as for an empty one,
and leave it overflowed, as the rest of the seq_buf API does until
seq_buf_clear() or seq_buf_init().

The current callers do not reach this, e.g. trace_syscalls only calls
trace_seq_pop() when the trace_seq it pops from has not overflowed, and
kernel/bpf/diagnostics.c sets the length from strnlen() before popping.

Add tests for the pop corner cases.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.1.0.

Fixes: 32e0f607ac6a2 ("tracing: Add trace_seq_pop() and seq_buf_pop()")
Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/seq_buf.h   |  4 ++--
 include/linux/trace_seq.h |  5 ++++-
 lib/tests/seq_buf_kunit.c | 42 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 9f2839e73f8a..f5a350347bc5 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -155,11 +155,11 @@ static inline void seq_buf_commit(struct seq_buf *s, int num)
  *
  * Removes the last written character to the seq_buf @s.
  *
- * Returns the last character or -1 if it is empty.
+ * Returns the last character, or -1 if @s is empty or has overflowed.
  */
 static inline int seq_buf_pop(struct seq_buf *s)
 {
-	if (!s->len)
+	if (!s->len || seq_buf_has_overflowed(s))
 		return -1;
 
 	s->len--;
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 697d619aafdc..7174ebf3f015 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -86,7 +86,10 @@ static inline bool trace_seq_has_overflowed(struct trace_seq *s)
  *
  * Removes the last written character to the trace_seq @s.
  *
- * Returns the last character or -1 if it is empty.
+ * Returns the last character, or -1 if the underlying seq_buf is empty or
+ * has overflowed. Note that only that buffer is consulted: a @s marked
+ * full by a write that did not fit, which trace_seq_has_overflowed()
+ * reports as overflowed, still pops the last character written.
  */
 static inline int trace_seq_pop(struct trace_seq *s)
 {
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index 0934dfb602ff..de491f96c1ac 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -115,6 +115,47 @@ static void seq_buf_putc_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
 }
 
+static void seq_buf_pop_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 8);
+	struct seq_buf t;
+	char *buf;
+
+	/* Nothing to pop. */
+	KUNIT_EXPECT_EQ(test, seq_buf_pop(&s), -1);
+	KUNIT_EXPECT_EQ(test, s.len, 0);
+
+	seq_buf_puts(&s, "hello");
+	KUNIT_EXPECT_EQ(test, seq_buf_pop(&s), 'o');
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hell");
+
+	/* A 0xff byte must not be mistaken for an empty buffer. */
+	seq_buf_putc(&s, 0xff);
+	KUNIT_EXPECT_EQ(test, seq_buf_pop(&s), 0xff);
+
+	/* A full buffer pops its last byte. */
+	seq_buf_puts(&s, "abc");
+	seq_buf_putc(&s, 'd');
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 8);
+	KUNIT_EXPECT_EQ(test, seq_buf_pop(&s), 'd');
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 7);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hellabc");
+
+	/*
+	 * An overflowed buffer has nothing to pop, and stays overflowed. Use
+	 * a buffer allocated at its exact size, so that KASAN reports any
+	 * read past its end.
+	 */
+	buf = kunit_kmalloc(test, 16, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	seq_buf_init(&t, buf, 16);
+	KUNIT_EXPECT_EQ(test, seq_buf_printf(&t, "%s", "longer than sixteen"), -1);
+	KUNIT_EXPECT_EQ(test, seq_buf_pop(&t), -1);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&t));
+}
+
 static void seq_buf_printf_test(struct kunit *test)
 {
 	DECLARE_SEQ_BUF(s, 32);
@@ -354,6 +395,7 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_puts_test),
 	KUNIT_CASE(seq_buf_puts_overflow_test),
 	KUNIT_CASE(seq_buf_putc_test),
+	KUNIT_CASE(seq_buf_pop_test),
 	KUNIT_CASE(seq_buf_printf_test),
 	KUNIT_CASE(seq_buf_printf_overflow_test),
 	KUNIT_CASE(seq_buf_get_buf_commit_test),
-- 
2.55.0


