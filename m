Return-Path: <linuxppc-dev+bounces-28804-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52532CA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 04:00:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxX3C2TWHz3by2;
	Sat, 03 Oct 2026 13:59:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790999974;
	cv=none; b=PMN0XgTD7XjS9SWvZp02BxkSj4tdmaaxTdUkwBjlES5iwotkKEl6sRLyOrKPBVHEinRqzobcy2388LF0oYmo4VV7/Mp5/dNy6a+XgdRAUxuUKW+FVM2zpoTJJp6D+xl73iEx675ZcbBXQ1dKHjQNpC9wTGn0XAWDYaZ9Dp/+K5T0On8JYP25HGNH87L5q1p7LvJT3Q7YRvyb76x6fb0Y2gUffnC6xjUU/8LdEeL2mterCVOTz8yUCVCBiERpMr3jviV1OfSLv7KB5cJrPhS3KiOgEPYnRQPcrxuNlfPfnEdRmPaYlxgRDRdTFY/+ZXCctuiOmIAM4whD9H1jLpdH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790999974; c=relaxed/relaxed;
	bh=3OTiHc1/0syaVTh9plxPSwZX9JA+w6f18TNYUs4mWiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUjLrNIhvkBoEfZP1CS0WGqJAS2iEz7JcmD3NcmpvKNbo8tZBuFtpSSpnlUIQkoob7Svz7QYkA65Kv0DFDGVVSUb4N5py+CSazFEW1Xa4RgWZBwoCs8g/ZTtLAumEijYEmMhAysGscA1+PAaVoT8e1D7Q0gSteQ5Ysl1tLIBMOTh03CeLvUPiKGyyX/WgD6wsgJPLruHmAQJsJOCyTv/6OCxmKXEhX14YKxCJwcoPNJq8FYbWJmr5RH7+2w27WZ6J82eXORfoHAGxikA8yD/PEoaS46npZOWeytjvDVtYyAbOP38JwR+AOhxMk9K7BKYEUErH1+67lmAckklTcjaQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esNzDwkF; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esNzDwkF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxX354P12z3bSw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 13:59:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6C41A4485C;
	Sat,  3 Oct 2026 03:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048601F008A2;
	Sat,  3 Oct 2026 03:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790999962;
	bh=3OTiHc1/0syaVTh9plxPSwZX9JA+w6f18TNYUs4mWiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=esNzDwkF/ZPzuVHUwOX/wWg1G8q95GJofpLCNZ8CqjZQ3tSrgZVSe0wl0i/6tgYuB
	 b+Og8ah3xsZ8t9cxtea4sG661YTsOMgK8WVA8wpEoh1BTI8kBHx36q6v+G2wPY7mPx
	 z4I5y1NwZKx3SFzjqzalrK3VNGzGzXi+Mz5t8hh+znJCYY/w/7zYGnJf7LEk0Ev38H
	 z5LVKQGZpj2BeyE843ig3p7wNG9C7eq7HmfrKRy6iuRy1T6I4c49+fSOADaKVkxXWO
	 kl9SSeOeX8e292rsoebDYCW364bXxFepgepHcQXFCiqAipN3wEtdDK2FQylf72d8Ko
	 +8U5XvTRO77ng==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	nvdimm@lists.linux.dev,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Ira Weiny <iweiny@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
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
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 10/11] nvdimm: ndtest: Return the string length from flags_show()
Date: Fri,  2 Oct 2026 20:59:15 -0700
Message-ID: <20261003035921.1918874-10-kees@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=kees@kernel.org; h=from:subject; bh=83ejdE21ZGKoH4IcbNOtIYCWNlvKIrQjgUzARamzwfE=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkHaieLvLjkuOz2nWpmDfsU5q917HcOHpCrm/clZhVX5 dEteh/WdJSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzEo5Thf0HjJa6f2wWCLz5Z ndCTresx5Vpd30Jz8x/NP1assHW/ZMzwT78//eJ0f787O6pSOef+ZToVzRjHcTRt/ZT+eYtmCc4 o4QUA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

flags_show() build their output with a seq_buf and return seq_buf_used(),
which may include the trailing NUL byte when the seq_buf has
overflowed. Use seq_buf_strlen() instead.

The flag names are far shorter than the PAGE_SIZE buffer sysfs
provides, so this cannot overflow today.

Build tested ARCH=x86_64 with GCC 16.2.0, built out of tree with
make M=tools/testing/nvdimm:
tools/testing/nvdimm/test/ndtest.o

Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 tools/testing/nvdimm/test/ndtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 2051ad5d4882..f097f2992966 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -693,7 +693,7 @@ static ssize_t flags_show(struct device *dev,
 	if (seq_buf_used(&s))
 		seq_buf_printf(&s, "\n");
 
-	return seq_buf_used(&s);
+	return seq_buf_strlen(&s);
 }
 static DEVICE_ATTR_RO(flags);
 
-- 
2.55.0


