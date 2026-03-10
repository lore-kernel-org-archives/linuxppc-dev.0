Return-Path: <linuxppc-dev+bounces-17954-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A42FF3C27D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:06:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVTzc4K1jz3bjb;
	Tue, 10 Mar 2026 21:06:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773137164;
	cv=none; b=ljMX79/tn7IzgbPX2MB1FhKF17KS4iClNsIcXZFzc6Mll0FkCQymy/sZVgTlz6zgc/lZRhJ9eY4HfzIBTHLnhSV7BEP0vUkFQ1kr4TtlzXUcOfayITVFY8Yza/Gl0ffKCbpX0apFPKT6u7ZcYaWaqx/n7u0jFpnT2WH7HzameyBB42OTLf7lXKssi0PcoYIiMY5CkKyvyoby9HYzzLo5hVpUi/LsVLtiuyAGkWrPRbdWO3Mmp7nSTMffJPrVRYV5u+x/b9a63B2Efxk8rhFMleAs8rQ1o5lDiCk0qK/4xOpXEGIlTTic+JShoGGOLF66ZTHB97sqsEYfMTA+g/CSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773137164; c=relaxed/relaxed;
	bh=px7eofF6K0alRKUSh2jaYAGbXVP1E8PYz55EApOAztk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MvErqaazfGO/wu9I8nIJNJsN/yYXmkZl0iNsWzEYu7oH/uDOeLkPxFq+gsBZS2afSJJglk4mNlXI348rO3szrRwcBxeLF1TBAE2gIqhde8e18USfM2FDueW3/zmJzLLIxnQsvjqYFh2POBBQz36nNYN6TEUiMFoqmxwrmDAjJa4WuJ/HBk0jYdMPnbOjZsaPw8/eGm7RE0DaR+K3m7cCXzLVd90LQTL8+Abg6MEY2/Tm1fZRQNcp7rj9UQVofxA55wi7JcA4FD1MS/BllqbdF0gR05hLxLzQY0clW41DtT35LoMGuDraUSuxiBotW+0MY2xhjkdcCc6+mH13fCYRlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QEXIomXH; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QEXIomXH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVTzb3nN3z2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 21:06:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8A67360097;
	Tue, 10 Mar 2026 10:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67ADFC19423;
	Tue, 10 Mar 2026 10:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773137161;
	bh=ppw/8xwp1YwwQnJfhBLYs/4VlvY8xgS+sm8YKor45qA=;
	h=From:To:Cc:Subject:Date:From;
	b=QEXIomXHcDvmmenDaDW+bWZgZ2cK/EJHXV2lRH712n701DcQFv/pVoSS1VyAFn1kU
	 1d7JA649Tqx6HHO2LkLiLkkfMeKiMBk4pFqYWT6AdnsCoSipa41hk8fSt7ROuKygzo
	 AROSth005/Rc0j62RmTYtY0mYB9YGDedyOAPj5mZZ67spzKjCrgYTCnKWienKR2kp9
	 OwGz2dep2RaASLjKMvVxMw7UTU0zZUCr+CTyShyQXs1MKKaQI1trvupJx2NipAx+tT
	 WD1Ror9vKUWOPIQjEM9RaLT14ZahDbDJykJr+tvB8l6z9ZQODeFOoPM90SrXTpA50m
	 NwtAFjyMEevtg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/net: Inline checksum wrappers and convert to scoped user access
Date: Tue, 10 Mar 2026 11:05:54 +0100
Message-ID: <f44e1b2760dbed35b237040001a91bc8304b726b.1773137098.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4911; i=chleroy@kernel.org; h=from:subject:message-id; bh=ppw/8xwp1YwwQnJfhBLYs/4VlvY8xgS+sm8YKor45qA=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSuf8tk6RwSEXL+/bND27ldbv7lXD8xNiXsE5+f8J6EU Hu5CoO2jlIWBjEuBlkxRZbj/7l3zej6kpo/dZc+zBxWJpAhDFycAjCRFh1GhkOycwQTnKPsZssf +cDU//vJ1qa9/DNWzetd0ujzKcBS/zbD/9xLxgt55FW85Lz7p6Zx8pTFdi9e8NB3+jmBb9NW7Cp oYAcA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Commit 861574d51bbd ("powerpc/uaccess: Implement masked user access")
provides optimised user access by avoiding the cost of access_ok().

Convert csum_and_copy_to_user() and csum_and_copy_from_user() to
scoped user access to benefit from masked user access.

csum_and_copy_to_user() and csum_and_copy_from_user() are only
called respectively by csum_and_copy_to_iter() and
csum_and_copy_from_iter_full() and they are only called twice.

Those functions used to be large but they were first reduced by
commit c693cc4676a0 ("saner calling conventions for
csum_and_copy_..._user()") then commit 70d65cd555c5 ("ppc: propagate
the calling conventions change down to csum_partial_copy_generic()").
With the additional size reduction provided by conversion to scoped
user access they are not worth being kept out of line.

  $ ./scripts/bloat-o-meter vmlinux.0 vmlinux.1
  add/remove: 0/2 grow/shrink: 2/0 up/down: 136/-176 (-40)
  Function                                     old     new   delta
  csum_and_copy_to_iter                       2416    2488     +72
  csum_and_copy_from_iter_full                2272    2336     +64
  csum_and_copy_to_user                         88       -     -88
  csum_and_copy_from_user                       88       -     -88
  Total: Before=11514471, After=11514431, chg -0.00%

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
This patch applies on top of v7.0-rc3, it requires commit af4e9ef3d784 ("uaccess: Fix scoped_user_read_access() for 'pointer to const'")
---
 arch/powerpc/include/asm/checksum.h  | 22 +++++++++++++---
 arch/powerpc/lib/Makefile            |  3 +--
 arch/powerpc/lib/checksum_wrappers.c | 39 ----------------------------
 3 files changed, 19 insertions(+), 45 deletions(-)
 delete mode 100644 arch/powerpc/lib/checksum_wrappers.c

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 4b573a3b7e17..52921ea2494a 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -8,6 +8,7 @@
 
 #include <linux/bitops.h>
 #include <linux/in6.h>
+#include <linux/uaccess.h>
 /*
  * Computes the checksum of a memory block at src, length len,
  * and adds in "sum" (32-bit), while copying the block to dst.
@@ -21,11 +22,24 @@
 extern __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
-extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
-				      int len);
+static inline __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
+{
+	scoped_user_read_access_size(src, len, efault)
+		return csum_partial_copy_generic((void __force *)src, dst, len);
+
+efault:
+	return 0;
+}
+
 #define HAVE_CSUM_COPY_USER
-extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
-				    int len);
+static inline __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
+{
+	scoped_user_write_access_size(dst, len, efault)
+		return csum_partial_copy_generic(src, (void __force *)dst, len);
+
+efault:
+	return 0;
+}
 
 #define _HAVE_ARCH_CSUM_AND_COPY
 #define csum_partial_copy_nocheck(src, dst, len)   \
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index f14ecab674a3..bcdf387f3998 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -62,8 +62,7 @@ obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
 obj64-$(CONFIG_KPROBES_SANITY_TEST)	+= test_emulate_step.o \
 					   test_emulate_step_exec_instr.o
 
-obj-y			+= checksum_$(BITS).o checksum_wrappers.o \
-			   string_$(BITS).o
+obj-y			+= checksum_$(BITS).o string_$(BITS).o
 
 obj-y			+= sstep.o
 obj-$(CONFIG_PPC_FPU)	+= ldstfp.o
diff --git a/arch/powerpc/lib/checksum_wrappers.c b/arch/powerpc/lib/checksum_wrappers.c
deleted file mode 100644
index 1a14c8780278..000000000000
--- a/arch/powerpc/lib/checksum_wrappers.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *
- * Copyright (C) IBM Corporation, 2010
- *
- * Author: Anton Blanchard <anton@au.ibm.com>
- */
-#include <linux/export.h>
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <asm/checksum.h>
-#include <linux/uaccess.h>
-
-__wsum csum_and_copy_from_user(const void __user *src, void *dst,
-			       int len)
-{
-	__wsum csum;
-
-	if (unlikely(!user_read_access_begin(src, len)))
-		return 0;
-
-	csum = csum_partial_copy_generic((void __force *)src, dst, len);
-
-	user_read_access_end();
-	return csum;
-}
-
-__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
-{
-	__wsum csum;
-
-	if (unlikely(!user_write_access_begin(dst, len)))
-		return 0;
-
-	csum = csum_partial_copy_generic(src, (void __force *)dst, len);
-
-	user_write_access_end();
-	return csum;
-}
-- 
2.49.0


