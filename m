Return-Path: <linuxppc-dev+bounces-28809-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D5FCA5FC1
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 04:51:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxYBW4gYmz30V1;
	Sat, 03 Oct 2026 14:50:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791003059;
	cv=none; b=GQcYjEgd7aXDN1qfjxcC1JEga9oRALlPyZaeax3U02WkCoTfGcoAdnBg0QjBRL6TbWgQncrjzGl/24Vw9WfstU+k8Q0MMsr4sjC3n2nFz+XCYxByV3MTsaIIEmq9veKS5QDwisJFYGHphQHgAZ+FV7g+2fC3S6Hbsa9YaLqgEF6A7J/Z3dGvrfQPIcECyu7qma0II8rzlSUmaCHXHTDWtMSCb4u00cEbQDqIREtN+ZbEOJIaf2ZesNbYJjmGy8UQlqVAruaAjBt7JjeeNyWfn7R9zg6vy+GgeDycGAeW1zzBgjf0Ybm5hJ4l8xxAfDe7BoZUVpvjePK/DWydUiWmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791003059; c=relaxed/relaxed;
	bh=PenZzKVUsHBQAUk3JLxySRbntReL+52z92vu5QXeViY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QYLF+oATD12jhPDJpFQMz6Lcnx5etife64eNFxeyjXJVDEIpd5QEcuZDIniDDGLFROpb9+4JxA2r+YNGXwGCD1iQI9TWUcPRUwXnkmPPiaaSe2bffg5ZnoS5sHSLVp1AHMUZhN48rJ0qpYdKo1GH7pJBfXUN0lgDJ7NYXKPnxWzL4PltTGBQJKb5dVX9rojHB9dDEMBrD0J4GC8HK5MQutJWl/LgX3oMxmviZTqBz/UbjCeA9zq5/nNsm4gVARNjN1onrJyBqCT6Z5bUPZilDp9wOGE/mPV4yiL4NrQJKV9pchQ6e2CobKBAPw+4TRR3u7S3IBRht3hrXfRjYjQnYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUnyV3QB reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUnyV3QB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxYBV6KG3z2xnv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 14:50:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E3FD160AB0;
	Sat,  3 Oct 2026 04:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BAF1F00893;
	Sat,  3 Oct 2026 04:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791003056;
	bh=PenZzKVUsHBQAUk3JLxySRbntReL+52z92vu5QXeViY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EUnyV3QBRImlT9jgI8l+Fggx3kguPA3dB3ANstZiR7khV/HS2WoMeSStsst26peZo
	 saWaacobxVr582dbUJMXxH6kzsLGZGdMoIebKAdBoiTF7twxb/GoIKrwAbWcLSAHlL
	 1eWrUuxT8NKxJ82cP2wbmhHFmYbOuOH7vp69m6i60zd2BJL0BQ6VPWSYnXcBbAudP0
	 fmymmFTOcrMCXo1JOd720RW28g2rIhyKlpWuN9SYQrqp7IRAa1Jp7LYw5IzZXuScDu
	 LpoW2FuuXVL4lUBJRX8hUuCXn9yfwGDhcYz3FvPZ7hhVegClaszA6bHJCKwW6hkwC3
	 qnbLuXdFem5uQ==
Content-Type: multipart/mixed; boundary="===============8462905022815828821=="
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
Message-Id: <16e533b0eaa776887626c8ca1358b674b82640913706d4dfeb957de5f90de91b@mail.kernel.org>
In-Reply-To: <20261003035921.1918874-4-kees@kernel.org>
References: <20261003035921.1918874-4-kees@kernel.org>
Subject: Re: [PATCH v4 04/11] seq_buf: Clear what a writer did not claim when a seq_buf overflows
From: bot+bpf-ci@kernel.org
To: kees@kernel.org,morbo@google.com
Cc: kees@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
	andriy.shevchenko@linux.intel.com, david@davidgow.net,
	jikos@kernel.org, pmladek@suse.com, shuvampandey1@gmail.com,
	rostedt@goodmis.org, corbet@lwn.net, senozhatsky@chromium.org,
	gnoack@google.com, mic@digikod.net, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, ast@kernel.org, daniel@iogearbox.net,
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
Date: Sat,  3 Oct 2026 04:50:54 +0000 (UTC)

--===============8462905022815828821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> seq_buf: Clear what a writer did not claim when a seq_buf overflows

TL;DR: Commit message only: the claim that seq_buf_path() was "never exported,
unlike the other writers" looks inaccurate, since several other writers are
also unexported. The code and export look correct.

>     seq_buf: Clear what a writer did not claim when a seq_buf overflows
>
>     Using seq_buf_set_overflow() would leave the bytes between "len"
>     and "size" untouched, so if seq_buf_str() is used on an overflowed
>     seq_buf, those bytes may be exposed. For any paths that don't claim
>     partially written bytes, by setting "len = size" before calling
>     seq_buf_set_overflow(), wipe the unclaimed bytes. The seq_buf_puts()
>     and related APIs already claim those bytes now, so only the unclaimed
>     cases remain. A specific example of this was seq_buf_path() which uses
>     d_path() and would write to the tail before discovering it was out
>     of space, and would correctly mark a seq_buf as overflowed, but the
>     path fragment would be left over.
>
>     Clear from len to the end of the buffer in seq_buf_set_overflow(), which
>     every overflow goes through, including seq_buf_commit() with a negative
>     count.
>
>     Add a test that fills a seq_buf, leaves it too little room for a path, and
>     checks that nothing of the path is left in the buffer. The tests run before
>     anything writable is mounted, so it takes its file from shmem.
>
>     seq_buf_path() was never exported, unlike the other writers, so the
>     test failed to link as a module. Export it.
>
>     Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
>     and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.2.0, and the
>     test builds as a module (CONFIG_SEQ_BUF_KUNIT_TEST=m).
>
>     Assisted-by: LLM
>     Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     Signed-off-by: Kees Cook <kees@kernel.org>

This isn't a bug, but is the comparison in "seq_buf_path() was never
exported, unlike the other writers" accurate?

In lib/seq_buf.c the only writers with an export are seq_buf_printf(),
seq_buf_puts(), seq_buf_putc(), seq_buf_putmem() and seq_buf_putmem_hex()
(plus seq_buf_do_printk(), which is not a writer).  seq_buf_vprintf(),
seq_buf_bprintf() and seq_buf_hex_dump() also write into a seq_buf and have
no EXPORT_SYMBOL_GPL().

The reason for the export, that the new KUnit test calls seq_buf_path() and
has to link with CONFIG_SEQ_BUF_KUNIT_TEST=m, looks correct.  Could the
sentence drop the "unlike the other writers" part, for example:

  seq_buf_path() was not exported, so the test failed to link as a module.
  Export it.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37096036516
--===============8462905022815828821==--

