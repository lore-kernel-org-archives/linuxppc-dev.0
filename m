Return-Path: <linuxppc-dev+bounces-28935-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497DCCA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:57:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hz3tW4gZMz2xwd;
	Tue, 06 Oct 2026 02:57:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791215843;
	cv=none; b=Rfs2/Q1Q08zCce928Prml1BJbEyzqxrTBlxxd+wrIsEnppBcZtlFUtKfYu9iLF9SrYEub+Mnrl+K512Qglv0XHIgfA90FB93qoAi3yHT/lzCX1oZPOuZ4apNrmUQ7sBIiMvjLvXWgL5X6ky5egsmHQtJsQOw9R34+pTlq5Hvc5nP6Q4PLgsFXGYi+dpXFTi/zHQl8DDFQwUws7P7Wabvhy7YYMsCthm9Rd5YmUHvv466IvPjqBrfNjBbAqYD9ikYfVDOPYRyIem4pNuQ1XYvITkDDh494+7T9bRCcdArR8DTRrxjHjvtg7v8low1n6U0YseKWD60d6CoCKgmgwbS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791215843; c=relaxed/relaxed;
	bh=sf8U9e/P/Ck4Sty1kLYW5Wh5J9iqRhQrRMwhuEB4BRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCb1/kFqE3afTti0HEX3KzVX0MipgcnA29m6xRNNtSE9kD+ihXUVOVzTYZ7KsmQcBER8kT62pISdkMlJ/R+5B5kiO+WNif0rjHdz19ibHKgFIKzP2oRGm5Dcw+6tBPZFfEfeKojbiesIoGSxgVpXRnEhHsYXxV3CsqvSpgX1+3QcCRadGFCR+m1xYBAv5UNL9OZ/GA7Tl+L2J+igCK3/Vx4WyiWcAVvlrUQSg0IJzvmsVH5G8X17dKwkLY+TvsM2Sh90j3gEWxAyczwJxuGszQQKDMh3ucFJPQ6f1XnJbvjW24IrPknOM8ENkogX+jF/QUOwALmVhom5n1ti1PL92Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GzoDJ0Gj; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GzoDJ0Gj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hz3tV25J8z2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 02:57:22 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 12423447C9;
	Mon,  5 Oct 2026 15:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6891F008A2;
	Mon,  5 Oct 2026 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215839;
	bh=sf8U9e/P/Ck4Sty1kLYW5Wh5J9iqRhQrRMwhuEB4BRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GzoDJ0GjAM3eRzHs8BIN+4iEUm/L0zKHa4gLtaRR5+K9eQc2N9kAVn7BkxyJQJ0Cp
	 C1tV9tncXEdAWc0o8xDhhLY7O7qbldHb7aH7F3Sb8FHYqjr1DudTRjoFYVedSzt/l7
	 BzT7LLQxbgq1FI2F/ZlVBJE7cI5hbWqVPuJSGJ33sSUTo7wirqqepxIe+sBSFl9Cof
	 yCoG9Mh+qkzYzRxEzNtYNyrTz3gGqRxWgT0UMljYwt5yqpgFq9RsKw7FIXLkx7sWNl
	 SxlalYI6iepxEcxWxHZJJ1IF3MGYU04IVDMGZcXcRgTZSdLzSe6MjozBJ1fvXcSgsd
	 HvlCKS/eSSifg==
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
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 10/12] powerpc/papr_scm: Return the string length from the sysfs show functions
Date: Mon,  5 Oct 2026 08:57:00 -0700
Message-ID: <20261005155708.1471260-10-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005155653.late.426-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=kees@kernel.org; h=from:subject; bh=QMqRTQphegL+YGqZELWHP3PitTraEh7YCZhUt0ueL+o=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmHT5w11+xnnFjoOtf9nqOb5moGvykW0TM+H39+WzL3R N82pxebOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACbiaMPwV8g17Ur1+dBdb//M ZeeQzuq3sZy7v+botN2rYnZslCwXr2X4nxr+XqntQN9iTWPjbQnPu3mDeTcz5S/7Hizor/XtV04 8HwA=
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


