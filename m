Return-Path: <linuxppc-dev+bounces-28799-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB83CA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 04:00:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxX390pm1z3bs2;
	Sat, 03 Oct 2026 13:59:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790999973;
	cv=none; b=F3RpjkL99y36q/1rY82X8ihu70hOidDvlKpGYx9hor5mJImXirBIgPFV+eIa3fvzGV+g296jUSZ6cdQIKUZnTeFzSm1yVvwATZ76EwJJ8cNOMgRhkLs3YmZ7E/YIcC7YgU+QwBnezcEBlVhQGwLfe2gL/4PUTL2Igf1bDM8bIE6S87HPrpjEJnS8C+RN30squq5ZfGiEtUbg9QTyIGgWO3AlB0Q63IhDpMf8spEMOx3R6anP2HITGMj6DOrEB4QI/jD5OlzQb4CCnFdCUuWnCRtmWlq9mMacWZ6+83b15qvfCFn6eNSy0mL+gAKg43UR7WF6VquQfvwIwx8aY/dTyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790999973; c=relaxed/relaxed;
	bh=mC6dHxw1pOUqNW1nnxwI4BpnLFEsUsTuLesrpNzuFhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2SxPFEJi9uB+xWuIF4SdhiovlN+rqaeJmf5B/V0R0j+xUNhMzpVCpKJExru/Bf7u4DI/JMwRD6oAF7n2mu/tkz1t+M9oJtOL47YYCj70CdYZQj3OWPT3SvC4u9cOz2KR6qfB45cnx9xUwzuFWuXpDtoFThB8B7lkxxOQo72UrzMDw/4d0Tjc0302Y+MoUKttYDL4VsqswrFftS/EFMI7F7+5VKCJxkpt/zx0YWhCbKBHFTvV/652RCV/JWzSLvBHrc5DKo8ETtdo3kmXvhSRmHwnseSnBNUGD6V+9utky/FlPsEtrOKxyx7R8DxWOBCdZmJTfbugAvF42aEhgSQpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msrv8ok5; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msrv8ok5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxX34541Mz30WJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 13:59:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 64A0B44850;
	Sat,  3 Oct 2026 03:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35F21F00A15;
	Sat,  3 Oct 2026 03:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790999962;
	bh=mC6dHxw1pOUqNW1nnxwI4BpnLFEsUsTuLesrpNzuFhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=msrv8ok5FH2lTCp2BGiWsX10+tYH0ru2WnMTKy5875bfUKKHYe/QHLPSoFtDdQXcw
	 8Se2QEhqXFPIZBvBVscKSLCOR1p1Je8EeP9IcnXCQmOD+efKswKqsBcDMdMA7xfRzF
	 5I3gM1tlITHElf5GzOsaJ4Yd+lmwRBWOfDl0qT/ucbsYLAB5xiYLUDa7U+yJWxf4ak
	 4g4NIA/taNMv1Yb7M4/KcQKPhl5TFR3ir/we6riKpLengSQTn4YWraAI5nfHvQvmLz
	 Bf4avvGybjASEONCDj0zVEkO85yg1g/ZaRvDdBcJjLVj3PCsmPyaHS6nCrt4M8Uzq/
	 f6p9Ak/T5rP8A==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
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
	bpf@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jiri Kosina <jikos@kernel.org>,
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
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 07/11] bpf: Remove dead newline stripping from format_disasm_line()
Date: Fri,  2 Oct 2026 20:59:12 -0700
Message-ID: <20261003035921.1918874-7-kees@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=kees@kernel.org; h=from:subject; bh=tYtJBPCbYKrDY1/4C+iFSjZyb4Osu+ipCw0uLrfs3C4=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkHaifJPs0wfri16NSJV6+2135v/Xc/XnDpq/jgeTNfM Ybd2pxxq6OUhUGMi0FWTJElyM49zsXjbXu4+1xFmDmsTCBDGLg4BWAiETcZGY73s3jOzv2p6FUt Y9P+WflkyjMva3H/XQpPKlqWZkSI72T4X1pqyLfu+O4DG0TOlhhazMuQ8BT4fII18u3rt1N3/TD 6wwIA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

format_disasm_line() strips trailing newlines from the disassembly it
stores, as diag_print_insn_context() adds its own. Since
commit 483a1bb0b6cf8 ("bpf: Do not print a newline after disassembly in
bpf_verbose_insn()"), print_bpf_insn() does not emit one, so there is
nothing left to strip.

The strnlen() resync of the seq_buf length only existed so the loop
could index the buffer safely after an overflow, and the second
termination only restored the NUL that seq_buf_pop() does not write.
Remove all of it, keeping a single seq_buf_terminate().

Build tested ARCH=x86_64 defconfig with GCC 16.2.0 and
CONFIG_BPF_SYSCALL=y.

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
 kernel/bpf/diagnostics.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 594cf3c8b74c..8f64bfd9afee 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -632,10 +632,6 @@ static void format_disasm_line(struct bpf_verifier_env *env, int insn_idx,
 
 	print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
 	seq_buf_terminate(&ctx.seq);
-	ctx.seq.len = strnlen(line->text, sizeof(line->text));
-	while (ctx.seq.len && line->text[ctx.seq.len - 1] == '\n')
-		seq_buf_pop(&ctx.seq);
-	seq_buf_terminate(&ctx.seq);
 
 	line->valid = true;
 }
-- 
2.55.0


