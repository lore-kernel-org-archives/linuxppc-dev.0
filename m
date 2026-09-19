Return-Path: <linuxppc-dev+bounces-27758-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A458C982D8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2026 00:27:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmr0l44Pfz3bnq;
	Sat, 19 Sep 2026 10:27:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789777639;
	cv=none; b=cr1sDv3vlB1QSgjsSlzzBcvGyO9vSL7Pc+De4IauiU3bhD+3gkZjrrOvdlhse6GDx+hP5/sqheNr/dPbqGG3UxeVdR+BAK6tlTV4wXgE4Sg0I6Z5HjAjioSsSE77H72R7ut/2tPylo8i85j7Jb2gZgiG7ElZykSU4V8fq1Tr81tX+Fbqg5P2UMCQ4LMEefkpnnc1Uhmjgn3h176EXXDne+S0d4bos43jcWz+FEP42eZBlKN374n4xZvSfksC4HiqsTdYLA0P8yXVKToHFIItf4kkUZp6Wc0u754p1CZhc3SlwL5z0JwthdxI2XoJeZUdkirPRpBlJjGDE6uieo1xAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789777639; c=relaxed/relaxed;
	bh=ftDDqlFj8bU4K3fZAI2KjolyAI1cAmHP/993JbsJZpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kn7oVm5QLB8brY+Pwojc+XU2/zsbCOZX+unqaVysL4674hwsrotYvfQgWtHdqo0n8+Tt66/6tSulgo/KZH5rPWn4/VmqY2gxQeaHsCaVXIEtCefdjDvPWtGEaE5v1k2dxn2TBwty+NklIvsSdHxUxpDJefZR8UoqlGjuUxlzWH2mjEoFwajmWw7dL9PAXdLjH6e4xXEEy0PrFlsbLM7uGFAHbkyx7+F/dTSavDd5NCWK78eYuLQMlIM50GDTEFZGTteG0V3N8GFGifHLbVHZkiePvHIuXqDsk+RA/Myx5CPezz25pfohS4/gJsR3UOm/z5+W3225TnsCk1UdAgUONw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNPJ9uuR; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNPJ9uuR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmr0k4rs7z3bnm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 10:27:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EF8A443C49;
	Sat, 19 Sep 2026 00:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC581F008A3;
	Sat, 19 Sep 2026 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777634;
	bh=ftDDqlFj8bU4K3fZAI2KjolyAI1cAmHP/993JbsJZpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XNPJ9uuRW7nHkAe0zYCwlX2SunjF2FSmGpgZdg1DSUad6q05ouhfyh5UiNpDupU63
	 3vo8uZexVw01RHe/7NfbrnrfMzfFQb1VHrk+I39LUsK+Cd8zR46JHcPR7VM8Mxfm4C
	 2OrUgqs7MqHrrf65btj9O1uonyEhtrQthpoOL39X+xWcdvk+rAqB7mw8Bsy7YhQ7Nt
	 viBoT/KJCfByM4CqQkiRfCCgPlVjVPm6VH6akheW5Qk5YGpjc4OqmlIV07IJ1ujzBw
	 WqqIC3/dJpdB4rnusCfV7E6L15lu4xOI12IFKX8WlMefIUOoKyYWe/ZeZnRBfonxRQ
	 4b4s40OiOBPgA==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	nikitash.mariiaw@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 7/9] powerpc/papr_scm: Return the string length from the sysfs show functions
Date: Fri, 18 Sep 2026 17:27:05 -0700
Message-Id: <20260919002714.4060307-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260919002658.stay.929-kees@kernel.org>
References: <20260919002658.stay.929-kees@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=kees@kernel.org; h=from:subject; bh=bM8pfQZ+WNZUIhOsBdyOBh8XaXJCdRjSK82ONfe5d+M=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrr91q4EzZaveH25A94nRu1Y5jMxliT9oIzu2cXTjz9 JlPP39rd5SyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEyEo42R4ediE7YbL1Y3Lbw4 OeOHcKbwygMm7Svur7ikccVfnLFgrhEjw5R7kbH2bSXNa2cXqrzpX6b/OYTvoNXjS17vJQrMFc0 mcAEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

perf_stats_show() and flags_show() build their output with a seq_buf
and return seq_buf_used(), which may include the trailing NUL byte
when the seq_buf has overflowed. Use seq_buf_strlen() instead.

Build tested ARCH=powerpc ppc64_defconfig with GCC powerpc64-linux-gnu
16.1.0:
arch/powerpc/platforms/pseries/papr_scm.o

Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@baylibre.com>
Cc: <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 75da96c08cdd..b03cfd8528f5 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -1108,7 +1108,7 @@ static ssize_t perf_stats_show(struct device *dev,
 
 free_stats:
 	kfree(stats);
-	return rc ? rc : (ssize_t)seq_buf_used(&s);
+	return rc ?: (ssize_t)seq_buf_strlen(&s);
 }
 static DEVICE_ATTR_ADMIN_RO(perf_stats);
 
@@ -1150,7 +1150,7 @@ static ssize_t flags_show(struct device *dev,
 	if (seq_buf_used(&s))
 		seq_buf_printf(&s, "\n");
 
-	return seq_buf_used(&s);
+	return seq_buf_strlen(&s);
 }
 DEVICE_ATTR_RO(flags);
 
-- 
2.34.1


