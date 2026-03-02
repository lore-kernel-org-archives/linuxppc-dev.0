Return-Path: <linuxppc-dev+bounces-17514-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0877AE9B371
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2026 12:25:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPdSb2vRbz3bkL;
	Mon, 02 Mar 2026 23:25:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772454351;
	cv=none; b=nABvZ9wvS6qNWoMVbOWJX8S+45qnGHiC86ELHHNhPte1HY5ilmzxCksgXzo0579Fb/3aGx57F6nnLO87rrs+G0lvY1IoQO+4g+INw2d/47o2z+Kt1j5FAd4HUrpvTNn+T2cI2XjU7xTb1IB+7WY9Rfzi5ZY0lLJaXRvXJgx2b/Bcz4yaCmRAtsi4i/Jt7kBLkeg6zrCt1rpJ0qRpQkd4fphP2DpSORjmiRfZ4tmEwrq3gbgCi0omeR1pQ/fsUZiyFTPnQpRalKz1cNMQdOz8kAet8Kgyip91GrdATNM8WGznLh98YTGMqA+4AKMlRjBfL0aFGkrWPBwMenBnLR6EhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772454351; c=relaxed/relaxed;
	bh=wgXUWuBQc37HPqUBgBljEt4K1lGTSpiCtiKFdFvnpEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHxCc1M8+C7QgtS37sBOs6A3+AN16tKON00JLnADDjdHjQpk5/EUXAbQbLjlAeJkUs4XAbpiVlXnzlZoF8L9OYgKcJJLSmLoHIpS+oNXOMoufx90uDMXOnb7FYdzIhpQQZm9tv6IIjaqyz7aEG4iGLUNh7SSW1hh91XHd74oIaZG7wuhLIoIhajymEfNmhaPil6uYsb7BV5OZePSEpeDNYsKPRsayvPSjoaQX08KEKrmm7ltunYT4fN4+wOSEwAJMrfP3GzYt7uEyHEHuBM6ZDqwf2V5BGNYRvospniv0SsyhcFt12ZaYeL0x2hcYlDCMm2Jxzv29oYg+okLqrKkIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ZRJF2/RI; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0RhC5Fte; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ZRJF2/RI;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0RhC5Fte;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPdSZ4K5Xz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2026 23:25:50 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772454345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgXUWuBQc37HPqUBgBljEt4K1lGTSpiCtiKFdFvnpEo=;
	b=ZRJF2/RIYlZzXdvvP4EyC5ziS1eYTGNaiCpGWGAlhlhh6WP8XJtMwKY10FScMfkRk07Kpn
	WAm0HrLrPe3V8GufiCyKFmoR+hIoDakEwVJRmOfrOG1vTfDvZthRNy9j1FqSQDBSumosRb
	lSJyQo7Ek9W6Irxwps/fZr6+32MXQ1g940bY7aUn2wgzoOpTYYGfSmYo1TtUi2eNGBzDXQ
	HoOKG9XkKlO6Lsynm5IwDc/mDANODBHa3D+7XWmQ4jr8Z4GRPHRxNIFyYedKVrZJWzUsgn
	Xi/TXpXkeaoOKoyyrYw2RkYIhmbqg4P5rd78zu1pTPRTbMW07FzruR62fY8Dzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772454345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgXUWuBQc37HPqUBgBljEt4K1lGTSpiCtiKFdFvnpEo=;
	b=0RhC5Fte5zjulHI4Ol2L/ovJ2Kd9lvvPGCNYvwBDoFq6AG8nEkIzJV8ldugwY4YHFGhnle
	Y1e4YJBTshKAKTBQ==
Date: Mon, 02 Mar 2026 13:25:26 +0100
Subject: [PATCH 02/15] auxvec.h: Move AT_VECTOR_SIZE definitions to
 linux/auxvec.h
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
Message-Id: <20260302-at-vector-size-arch-v1-2-a11f03ba2ca8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772454343; l=1267;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=R6dPuK9hTEu2wzxXNEaPtc8TE7i9ikP4nTJiTP9bZT8=;
 b=ZulijLjkAtvEzMGw3cQEKThTnvyrB3XWkn02AB0dxIROztyb5g4HrOCwXizPScG4JZMtRLaOM
 3hiDIzMjiB4ARdfLbg+OTnHYu6B/6h5UxzpDiSphCOmDSpy2QygkNcG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The auxvec.h header is a more fitting place for these definitions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/auxvec.h   | 7 +++++++
 include/linux/mm_types.h | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index 407f7005e6d6..943e8b80b41e 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -6,4 +6,11 @@
 
 #define AT_VECTOR_SIZE_BASE 22 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
+
+#ifndef AT_VECTOR_SIZE_ARCH
+#define AT_VECTOR_SIZE_ARCH 0
+#endif
+
+#define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
+
 #endif /* _LINUX_AUXVEC_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3cc8ae722886..64019dc29f4c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -25,12 +25,6 @@
 
 #include <asm/mmu.h>
 
-#ifndef AT_VECTOR_SIZE_ARCH
-#define AT_VECTOR_SIZE_ARCH 0
-#endif
-#define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
-
-
 struct address_space;
 struct futex_private_hash;
 struct mem_cgroup;

-- 
2.53.0


