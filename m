Return-Path: <linuxppc-dev+bounces-17525-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D321CE9B371
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2026 12:27:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPdSl0Mzpz3cLj;
	Mon, 02 Mar 2026 23:25:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772454358;
	cv=none; b=gzfRqOiHyxi7TPSb5XINx65q9uEPYu7pLPmTdkAcgy54j6YnvQnT3ulJUy5hKtH5O7bBWZPLcEN7HxQuGtrtprFEeLNzZZ0iXHMdHHz7clCfxh3eYs5i7iqbb2cYNZ+GtggEm6RjAr4Ku6lhbjadCVc19wIhkC12MDcbMLyuAxwtmM5gFNCyRTaGtIuFu7VLoevusn+fdz8+GyTei/nyCWnj0RRt1OQrDnukkbun3WRB2fxLGaXMEb06bPHZBN0a6gtv523Ce6mxKF/m7gafxO9YVPvCwvzzNw4Ipo3DRQdOZ906RL5dQ8Jr3M42dPPz3gJiszMHzZCsttKYCtwOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772454358; c=relaxed/relaxed;
	bh=cGu4YUonqtswtsX27rVZnBUBJm/UklEpSAAXy65RzL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V8bUx5504m3RcKTOawxX+nT++FaSaLHA4sGatFFUeyd297eqWInnRuOSEC5Ltmpwj6uFWLiqYC8uHuIELMOp2huDeKudZxA4fKAsW8EGF8Yl0w56xWwpd7V79XQ/xXrXufCjCzdP6z/A+T2+LEntrepaPxOZTPPCc1zagNUPFWRJnv3apq/eCLYbexSKy1yab7o/al3IlSOz+rv6Zbwvjc2bIguL48gDnyGhdr5L6UWu9gCTzmZhPDFULuJFj1KtIKkhtej6wr8fCJLxiggrISSvA3V5yxWdUY3eXj4PCN6qtw6otnDql2WRcAdoEB+PphJLF0EENuVyGWulz6Q9BA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=NHM8ly0i; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=M5bdRgSQ; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=NHM8ly0i;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=M5bdRgSQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPdSj695wz3cHN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2026 23:25:57 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772454350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGu4YUonqtswtsX27rVZnBUBJm/UklEpSAAXy65RzL4=;
	b=NHM8ly0iuYcuh7E4eVeKeGXpReTprXhsGXJI+WYqlEaUf/lJYOUtBGH2QJnSAmI3I5QAPW
	LY468YWc+wcltpXurLXAtczrS3GRRs7ErvM61alrkPsKE3X9qmMsWKbpRyDz62q6oE5QGd
	Cw8Ohv3wtKFFpU4zvThVjA5RvZbBiw4fuurA+7UNWmQxvsskDaVVA4bfSSZgB12N/2TAie
	0omDMNnN9zOIOVB7ao1DehqzId2upP6OirsIQL+gbHRxhanTRwW23vCB34naWTWXi9Htpn
	0i4DmvsTWUtmu8SNg8v9pArAePWhRXG5bmVWZWSE0NmChST4B+21+gbeLT8M7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772454350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGu4YUonqtswtsX27rVZnBUBJm/UklEpSAAXy65RzL4=;
	b=M5bdRgSQ3QlnfcfTl+A8OeDFC/IW8uhkG1G/LEw+Ak1w+mPEMp7EWeeSHFb/e7QgJ7ScQS
	t/VtnQymro8BskCg==
Date: Mon, 02 Mar 2026 13:25:33 +0100
Subject: [PATCH 09/15] s390: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-at-vector-size-arch-v1-9-a11f03ba2ca8@linutronix.de>
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772454343; l=1408;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=wSV5J7HzEFuS3KJbZLwjne1zxmW3zDPxdBoyG55t7aA=;
 b=DiL9Q3q9a2OSCTrfhnV8gNkfPXzhPZlr/JwJIjpZtjcaaAF6eqOl6SEEE9FmY9unQs6qSC3IS
 Tt2RIf9FHBFC64LLNTZGUWGPwKnIoYVR6wJCeubfkDRjuZzU3F/usem
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/s390/include/asm/auxvec.h      | 7 +++++++
 arch/s390/include/uapi/asm/auxvec.h | 6 ++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/auxvec.h b/arch/s390/include/asm/auxvec.h
new file mode 100644
index 000000000000..beaaefe12a84
--- /dev/null
+++ b/arch/s390/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASMS390_AUXVEC_H
+#define __ASMS390_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
+#endif
diff --git a/arch/s390/include/uapi/asm/auxvec.h b/arch/s390/include/uapi/asm/auxvec.h
index a056c4637ffc..54bbfd68d709 100644
--- a/arch/s390/include/uapi/asm/auxvec.h
+++ b/arch/s390/include/uapi/asm/auxvec.h
@@ -1,9 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASMS390_AUXVEC_H
-#define __ASMS390_AUXVEC_H
+#ifndef __ASMS390_UAPI_AUXVEC_H
+#define __ASMS390_UAPI_AUXVEC_H
 
 #define AT_SYSINFO_EHDR		33
 
-#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
-
 #endif

-- 
2.53.0


