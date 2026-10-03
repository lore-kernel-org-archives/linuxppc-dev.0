Return-Path: <linuxppc-dev+bounces-28805-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE10CA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 04:00:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxX3D6dp0z30WJ;
	Sat, 03 Oct 2026 13:59:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790999975;
	cv=none; b=OozPq0wZFHbFOZ6nu3CC2uPoRQQZGdDIalcqCRvwyJVCJdOmy1K4WfEp8bcLm+zIYMgon0kFC+bStCXTV2TCJgmyYoqIjXJHAruCmMAU+ClLeRwOKJniyfgGp2NTvj/vgJVmg1zf+KCgLVm1Hckmo6bPsXs+Z58Num6RboKD+hJKWOq3CQfJb6DH0G92RU3w+JJ5gdC5ypSGTlQ2yfvL63j3Lx3jMW924jqGC0sj4dyNUntziWUDirndNs47U79m4R95yAmr8q+xf168d/JvOHyrUWJOFDvVBP9wOvY8J0lBUNtEqYH5LqcxBRmjRsFPOTjlO2C0juZ/Jz0jaz1MIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790999975; c=relaxed/relaxed;
	bh=sf8U9e/P/Ck4Sty1kLYW5Wh5J9iqRhQrRMwhuEB4BRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f09rMRH/kEN4Rw8536tGok90hwBrBXiekDjcQutlDoqa1VANrME3NUCdiKqUMzgd+ELu/PYJweVKw1L9YVoYYJHI9pHVkbigDHFyJo8jJxVUSRCc/rUzdLkON4OIHvf47C3+4drJsbAu89kRy/Yfu3uTetskJIVXHLhu0EG60YvmtvfNv9fRuvlAOlg6RTb2hb5uLlBEmXrWvWXptDp6CDi2SID3H5EUHgsI7dlJ/JqSZwJsTO5ItYCYu9mIVrzQOuxZY4gqTht3WwQPlqr89PnD79lOuAtNFFrq67yPctDSiIlstRFm2C2YEjgw0Ongdjpa+Iu8T/U6ifXciDWgJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LytJtbRz; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LytJtbRz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxX371QLZz3br5
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 13:59:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7280D44865;
	Sat,  3 Oct 2026 03:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C111F008A1;
	Sat,  3 Oct 2026 03:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790999962;
	bh=sf8U9e/P/Ck4Sty1kLYW5Wh5J9iqRhQrRMwhuEB4BRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LytJtbRzVGJ2gB5rSYpjnUmcJ+xxGWASCXwMhF3wA5XiUuOMEkosCvymJLQhlFNfs
	 1TTMLD2EK/4S/cHbZyE5se6S1k+tYmdqOTdG2KAtOgWR+pXYqlexmSa8twP9rvVvrt
	 VYu+wXvwJJuwtvWiyTtwZ3qW/eev//6u22fX9HGF16AjZKB1faH96j/7wcoiaWx8x0
	 kD75F0NM30qpfaoxE96GTf6M9S157++2HP8TF/dajR0TXvzEXzjAeytHg4X4Ti/dI0
	 eV7823ZdWPtTDiZlWPOrzqEaJlwWMudWokHz5vbMcturB6i3ZZySAhMtrnVWhfdGCi
	 uGewx4IfggbDg==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 09/11] powerpc/papr_scm: Return the string length from the sysfs show functions
Date: Fri,  2 Oct 2026 20:59:14 -0700
Message-ID: <20261003035921.1918874-9-kees@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=kees@kernel.org; h=from:subject; bh=QMqRTQphegL+YGqZELWHP3PitTraEh7YCZhUt0ueL+o=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkHaieba/YzTix0net+z9FNczWD3xSL6Bmfjz+/LZl7o m+b04tNHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPpfsLI8G+xe2b7uYcnTsoy RjS9/G+lccnp4Baxyqrb+yyP7PS+MZvhr6zjr/+rN3Fs+Hxk+RzO+Ca90weOZTT+Dj607E7Dcs5 4M1YA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

perf_stats_show() and flags_show() build their output with a seq_buf
and return seq_buf_used(), which may include the trailing NUL byte
when the seq_buf has overflowed. Use seq_buf_strlen() instead. As
suggested in review, use it as well for flags_show()'s check whether
any flag was printed.

Build tested ARCH=powerpc ppc64_defconfig with GCC powerpc64-linux-gnu
16.2.0:
arch/powerpc/platforms/pseries/papr_scm.o

Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 75da96c08cdd..5c3bf06bb59b 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -1108,7 +1108,7 @@ static ssize_t perf_stats_show(struct device *dev,
 
 free_stats:
 	kfree(stats);
-	return rc ? rc : (ssize_t)seq_buf_used(&s);
+	return rc ?: (ssize_t)seq_buf_strlen(&s);
 }
 static DEVICE_ATTR_ADMIN_RO(perf_stats);
 
@@ -1147,10 +1147,10 @@ static ssize_t flags_show(struct device *dev,
 	if (health & PAPR_PMEM_SCRUBBED_AND_LOCKED)
 		seq_buf_printf(&s, "scrubbed locked ");
 
-	if (seq_buf_used(&s))
+	if (seq_buf_strlen(&s))
 		seq_buf_printf(&s, "\n");
 
-	return seq_buf_used(&s);
+	return seq_buf_strlen(&s);
 }
 DEVICE_ATTR_RO(flags);
 
-- 
2.55.0


