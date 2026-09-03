Return-Path: <linuxppc-dev+bounces-26474-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22451C624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 07:52:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbBcy0r1pz3bgQ;
	Thu, 03 Sep 2026 17:51:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788421906;
	cv=none; b=Y8roP7YFDOE02NCWE7/yt2gF/66nO6ui7QwL0yL1j+VfPJ1yaGFK61rpu4Z6Fw9z/BIsS2HtKAP3tykVz/LzF753ujfRuuJOCaUraeY9hAPhu2b//h1ZLVnjOOyIXd4yeXsU913HxXlvpczCrhA3R/QJhH/q2fVYdpF+LLMteLeS4djuvAMvldviteom+jo4Eb9sUCtQQoGOZgCwXDvGsN9XBVb6XlvWNTST9EKkcSNx2LAyMxKsQ/36K07jlLDPoxvCx7f37PgHQlIxSYBdqmZBFPYgANOYY9IVlLSLgr0p2BhIIZRv2bpLPrbs7BbQQrWsSo08KFQRGax2c0rY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788421906; c=relaxed/relaxed;
	bh=elVYzhuCvmXJBPRZ3gCfrokksTC2QjbDZG7uOX6NqdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GhNNLj6O14onIt4UO71KQieMHmnYqddq3r30z3i977PKvC8gVcK3ParAM3FdLy71vWm6ODKAYpVOlF9majW1kKWwQzLl2VLPaFxF8Prm/FX1idA+Y1lYR/CHEu5teMELcW51B4Nqj5o5r/D5eCD7j0tnoI3miL7a8v010/dSdJ9HumpxR2vvFqaT3fDTzIVpJcu/Rf1fwfqq3kPFbGeNU6iggZvul1tjB5aYE00qm0vsdEr9XIat8TNBLT5p8eLbvLW1YoBs7brOsBF5GgkDALfmnyt2lO4Aetbr5kWek+BoIQmcAPME0gLkk4ffgKEh277G9OVKE016NZg2OvQj7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=x98/uR++; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=16lypqC7; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=x98/uR++;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=16lypqC7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbBct4B8zz307v
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 17:51:42 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elVYzhuCvmXJBPRZ3gCfrokksTC2QjbDZG7uOX6NqdE=;
	b=x98/uR++5TGb1kE9DatfjBc7vccpt9Tv6Ybqo6Jpm1/OJSJD5KyNHVs69DNPs/A+utplx1
	kfB4ZZcdBUdFM9kNfHH3RmU8srMZxawE9tJ81+G0De8/k90wTz77UrJ/ZA5huABZSnoy1W
	8xIHZGOtgbMGRjdhG/MspxM5XvQ4jhFgE4/OvO5PFuyRioaV0ToxHelPuUjUoJCxVs1jmi
	a7XdgCUGnmhgYMH5GlU6reqy7m0j89/Z9cAyKN5l/lKlSrtK7RD4b4rQQwaWdRJ7D8nqy/
	x1IhVuGARBmfGfthpyoY88Qljhzj8StgQwCNy0bgCdFb3X+pqYUiWXjLOXJGQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elVYzhuCvmXJBPRZ3gCfrokksTC2QjbDZG7uOX6NqdE=;
	b=16lypqC7rW9J+MkVv+rFbiDQP8PUbNH9MQTLL3JpXOtqRwqdnyUyndlvLnhpDqwpWve5tX
	0DkewKfU+GC6NTBA==
Date: Thu, 03 Sep 2026 09:41:25 +0200
Subject: [PATCH v2 10/15] powerpc: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20260903-at-vector-size-arch-v2-10-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
In-Reply-To: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1614;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=YIjNA9GHIeGKIog+4ZRlNVoTyE7Q6c9+vbExkNBbN7U=;
 b=tzh2nu86F+qh+b32xMEyYGMszxVH1qArmLc3sUe8halsMjfnsH1mlrvaUFUosJPsV2OmaGV3H
 9t4yw1mYDMtDty4LZwJAm85bi7LB7ZA/JDYQ5/xehieYzIxhOCKT4g4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/powerpc/include/asm/auxvec.h      | 7 +++++++
 arch/powerpc/include/uapi/asm/auxvec.h | 6 ++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/auxvec.h b/arch/powerpc/include/asm/auxvec.h
new file mode 100644
index 000000000000..d6c180e9ac2c
--- /dev/null
+++ b/arch/powerpc/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_AUXVEC_H
+#define _ASM_POWERPC_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH	15 /* entries in ARCH_DLINFO */
+
+#endif
diff --git a/arch/powerpc/include/uapi/asm/auxvec.h b/arch/powerpc/include/uapi/asm/auxvec.h
index aa7c16215453..9ab5b6d17929 100644
--- a/arch/powerpc/include/uapi/asm/auxvec.h
+++ b/arch/powerpc/include/uapi/asm/auxvec.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_POWERPC_AUXVEC_H
-#define _ASM_POWERPC_AUXVEC_H
+#ifndef _UAPI_ASM_POWERPC_AUXVEC_H
+#define _UAPI_ASM_POWERPC_AUXVEC_H
 
 /*
  * We need to put in some extra aux table entries to tell glibc what
@@ -50,6 +50,4 @@
 
 #define AT_MINSIGSTKSZ		51      /* stack needed for signal delivery */
 
-#define AT_VECTOR_SIZE_ARCH	15 /* entries in ARCH_DLINFO */
-
 #endif

-- 
2.55.0


