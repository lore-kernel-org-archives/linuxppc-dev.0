Return-Path: <linuxppc-dev+bounces-28807-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F60CA5FE3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 04:34:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxXq11byqz2xwM;
	Sat, 03 Oct 2026 14:34:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791002045;
	cv=none; b=IPmjN3sDt/65OsUiOkWwFCZ0ep0FqK3OXfT2fJEcFCW/+YZ7JZ4RrYqUiY9KvVo/a/XRFmb0wLUUYD0v/8eaKYNfhQYrq71eJJvyxKePUosh8o7wtCg/Z5ajQAT58X9yjblu8jh+cAInJ1El/ijIxG7i7YKbeNmu/856xmj+ZEW8GSzNi3ci5fWs5gZ3GK36cTCg35nKNeaTX5R0n9dwFW2HT2wTIYt0NNo2epE7WkAJ32iLVGPIX2mv8HTyw9EQ4Tt/t6OgcC0FAA+WAt+Z4fwMRvWOT/uZzvR+lYytNUJgtucO0S3oa96J88X0wRdZy/5i+H1tHRiZvLwmAoJM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791002045; c=relaxed/relaxed;
	bh=T5WqpPkABYIUr+bdw9uNCeIvTTslukdoECjwAYUP7k8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YrW1DvpTHEe7bwTW7Bfc/v37sd5odZyJbaT3WXQl7taV+BSp7A2/8LiBTtvmM8uPfZAVUX7Xhuux4vq2JZKpp0q6gQRyZMnYAsi5PG1br8pIYZt44xylUsA040yVQSs5yKw0u1QT1IMA/kZzYQtuwuTqyS1i0huAZobHNCskwTZb+MCkDPzuQPU0LX3hPwisPhs/0LhCMI9q8yNqfIxShfaHcty6qaDoY9OUKPSisq6/EjsTHaa0vbrh7Y94+IznlKyD8UT7AZ649dFUIaYSYiSMLkZQYTsJjPwyiQU9khAiYujQHq6cF279xeYStU3neuRoGZSlnmhwQiINCVrn8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMZBO/0C reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMZBO/0C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxXq01JlGz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 14:34:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B7015439ED;
	Sat,  3 Oct 2026 04:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2089C1F000FF;
	Sat,  3 Oct 2026 04:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791002041;
	bh=T5WqpPkABYIUr+bdw9uNCeIvTTslukdoECjwAYUP7k8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CMZBO/0C5xeumMuL3ncSkFagppcPpT5dOBjyZc+U25dEpLF/06r0ZRaHPXYDLuqD6
	 SNcQRLrq+gVgrsRiZKbdWdUuby/voNjj10L7uz5SMzAVj3vpKVOtP/p6BjKY5bgDGa
	 mKbfI1DXTb4RaywucblX8VTCk2IVBVBv32LzbGlrHmPLImUMnup8WdULwUFxyR7b3S
	 xU4XPlOThF3RXjVJfDS3SprBoad763bLCItuU1Wu1M6MngY1qY3pbifawvQrozhrgG
	 Dzz5fuCF0GcT9b6O5AIJJsItZDm/UXZINp0EBqrWEbp2sT4jVzKo5EYUNgCqDGWxqH
	 8sGRvF90o/fvg==
Content-Type: multipart/mixed; boundary="===============0675329118283778615=="
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
Message-Id: <f3b5a05404cc45b59981e869a0203ed07497f6f6942e6d72cee63b37612b7cda@mail.kernel.org>
In-Reply-To: <20261003035921.1918874-8-kees@kernel.org>
References: <20261003035921.1918874-8-kees@kernel.org>
Subject: Re: [PATCH v4 08/11] seq_buf: Add seq_buf_init_append()
From: bot+bpf-ci@kernel.org
To: kees@kernel.org,morbo@google.com
Cc: kees@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
	andriy.shevchenko@linux.intel.com, david@davidgow.net,
	pmladek@suse.com, shuvampandey1@gmail.com, rostedt@goodmis.org,
	corbet@lwn.net, senozhatsky@chromium.org, gnoack@google.com,
	mic@digikod.net, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	jikos@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
	chleroy@kernel.org, u.kleine-koenig@baylibre.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	sbhat@linux.ibm.com, blum@kernel.org, alison.schofield@intel.com,
	dave.jiang@intel.com, gregkh@linuxfoundation.org,
	lgs201920130244@gmail.com, iweiny@kernel.org,
	u.kleine-koenig@pengutronix.de, vishal.l.verma@intel.com,
	rdunlap@infradead.org, skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-k@lists.ozlabs.org, ernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
	mason@kernel.org, ihor.solodrai@linux.dev
Date: Sat,  3 Oct 2026 04:33:59 +0000 (UTC)

--===============0675329118283778615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> seq_buf: Add seq_buf_init_append()

TL;DR: Commit message only: it says seq_buf_init() sets the buffer size to 0
via seq_buf_clear(), but it resets the length, not the size. The code is not
reported as buggy.

> seq_buf: Add seq_buf_init_append()
>
> Several strlcat() call sites being converted to seq_buf need behavior
> seq_buf doesn't currently provide. The normal seq_buf_init() always
> sets the new buffer size to 0 via seq_buf_clear(). Code migrating from
> strlcat(buf, ...), which appends to whatever buf already contains,
> can't use seq_buf_init() without discarding that existing content. Add
> seq_buf_init_append(), which preserves the existing contents and positions
> the seq_buf to append after it. A buffer with no NUL within its size
> starts out overflowed, as strlcat() treats it as already truncated.
> Add KUnit tests for behavior coverage.
>
> Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
> and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.2.0.
>
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Co-developed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>

This isn't a bug in the code, but is the changelog accurate when it says
seq_buf_init() "always sets the new buffer size to 0 via seq_buf_clear()"?

seq_buf_init() stores the size it was given in s->size, and seq_buf_clear()
leaves s->size alone.  It only resets the length and terminates the first
byte:

    static inline void seq_buf_clear(struct seq_buf *s)
    {
    	s->len = 0;
    	if (s->size)
    		s->buffer[0] = '\0';
    }

Should the sentence say that seq_buf_init() always sets the length (s->len)
to 0 via seq_buf_clear(), rather than the buffer size?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37096036516
--===============0675329118283778615==--

