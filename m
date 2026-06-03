Return-Path: <linuxppc-dev+bounces-21966-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E4ECD6E64
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 10:20:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVkHD755Bz2ybQ;
	Wed, 03 Jun 2026 20:20:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780482040;
	cv=none; b=HvIN37ImMWwNXdHZkqaM4vKoL3wo7IgvPw+hbASH9jzAFIF8O6xQJQEp3Kkt4/3tiFsuBpgDIAftzkQgI26yhsOfNDQvDeF2JaR3e3+tOX/r9gH5MQwQJpiqVUOoOoL0biHUHeh+XOMiGb/BkMz+3DSUJJzQO+pL6ZnCp7wrcXUWXTNBkt2e6aavyu5LAeGqJKmRXjw4AsBlwgJFaQ5FIa6xDv6shGkmGz8IOd6reokqwvvyUCuQwvFiw+HnFzHE9CSlIhfk5Z9973Gk+XQRjO3GKwZvon01F1phmgbhtgtIFbEXE1pHas0BPG5JUYb1CT37q0YToSLBHwiCCsODQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780482040; c=relaxed/relaxed;
	bh=oR/k1mVyyfu6WyTJCC0me1TnDDk1gSjioq9kNyproS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnIynustxcar6YDwQmdQDL8UqCpxx38xZACPb0sz3BkEbT8U0rsTktm91pBNsGU3xIEsnur8U9x125Pb7rQau/Z2WeJfhE/dqDq6JVxoGlJpx4zVtRPvI59+XA8YlD1ct+/SRJ6i+wdiOp3PFQvneyRGdGJc9ACMbZGA4Hp5xk9ZPxZnbpF43zj0T+c2diVG8jF+m+EeCpZAXzDz4JsXijlX6T2pmD3iyyU3Yg1vLpCfePErqJqud1n2wEBCQ9WALdz6ucKd31CyfJIGjDVxPXGf6qpasDZqt+A5BtyShdU0VmxsH37SChoO4rvwhTvxRgfiTyinQ61QeX0IekKLuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ix9CYaI5; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ix9CYaI5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVkHD0Mmrz2y8W
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 20:20:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8C6286021C;
	Wed,  3 Jun 2026 10:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E681F00893;
	Wed,  3 Jun 2026 10:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780482037;
	bh=oR/k1mVyyfu6WyTJCC0me1TnDDk1gSjioq9kNyproS4=;
	h=From:To:Cc:Subject:Date;
	b=Ix9CYaI5S2BEqTLsfDrNc/2TI9ZoY1r1vbNrc5JX+DpaSyOpGMyESjqcO5r9r6Sid
	 3aIVwjGPzfgGQwyXr/O7E5qkTafepGTna/0NSSZov0IQuRyw9zRqdv2ZEJ5ybKQYiy
	 HgszeYCKhtYkYMyRNUo4TmUm3vGp8pRdAeprTwekzG8P4wo6g2/5TU3WsCi35AzhTv
	 QhWquJgREAu6acdiMr/STUDpJJfnC/3jsC90qUVpIUMIVr26Zv9tlUa2EE4zgiv/sP
	 oEH/Oc7FlMSvIXuj1qG63yvh8Now+Mv0ccK3f9jTV/8U7SujDupjTz2viGKdPOzV43
	 vgj7qZMtI6O0g==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4] powerpc: Simplify access_ok()
Date: Wed,  3 Jun 2026 12:20:14 +0200
Message-ID: <f496ba4f309a2fb9fd0d8811e941bbcaf5d196cf.1780482002.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2694; i=chleroy@kernel.org; h=from:subject:message-id; bh=AFmg1cR5zKlOZUDdLC9Yafo7y1A+dPJ/ppORVoEg91Q=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTJ/3/UUz5b9bB0j3tNYuCnwjcCvDlej6y3PfwxpyhVh iPe56xaRykLgxgXg6yYIsvx/9y7ZnR9Sc2fuksfZg4rE8gQBi5OAZhIlxkjw+yFu7U3Ckd4tKmp iz83lWlWNfNKbHqfff35ns13ar8crmFk2MjQevp20sq+l2LXwlLNuqP2Luid2RypuKnA7u4+Zfd CDgA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

With the implementation of masked user access, we always have a memory
gap between user memory space and kernel memory space, so use it to
simplify access_ok() by relying on access fault in case of an access
in the gap.

Most of the time the size is known at build time.

On powerpc64, the kernel space starts at 0x8000000000000000 which is
always more than two times TASK_USER_MAX so when the size is known at
build time and lower than TASK_USER_MAX, only the address needs to be
verified. If not, a binary or of address and size must be lower than
TASK_USER_MAX. As TASK_USER_MAX is a power of 2, just check that
there is no bit set outside of TASK_USER_MAX - 1 mask.

On powerpc32, there is a garanteed gap of 128KB so when the size is
known at build time and not greater than 128KB, just check that the
address is below TASK_SIZE. Otherwise use the original formula.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
v2: Fix build failure following untested last minute change :(

v3: Using statically_true() following comment from David.

v4: Rebased on top of today's powerpc/merge branch 3af068d1f05b ("Automatic merge of 'next' into merge (2026-05-22 09:59)")
---
 arch/powerpc/include/asm/uaccess.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index e98c628e3899..7b8c56962c31 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -18,8 +18,34 @@
 /* Threshold above which VMX copy path is used */
 #define VMX_COPY_THRESHOLD 3328
 
+#define __access_ok __access_ok
+
 #include <asm-generic/access_ok.h>
 
+/*
+ * On powerpc64, TASK_SIZE_MAX is 0x0010000000000000 then even if both ptr and size
+ * are TASK_SIZE_MAX we are still inside the memory gap. So make it simple.
+ */
+static __always_inline int __access_ok(const void __user *ptr, unsigned long size)
+{
+	unsigned long addr = (unsigned long)ptr;
+
+	if (IS_ENABLED(CONFIG_PPC64)) {
+		BUILD_BUG_ON(!is_power_of_2(TASK_SIZE_MAX));
+		BUILD_BUG_ON(TASK_SIZE_MAX > 0x0010000000000000);
+
+		if (statically_true(size > TASK_SIZE_MAX))
+			return false;
+		if (statically_true(size <= TASK_SIZE_MAX))
+			return !(addr & ~(TASK_SIZE_MAX - 1));
+		return !((size | addr) & ~(TASK_SIZE_MAX - 1));
+	} else {
+		if (statically_true(size <= SZ_128K))
+			return addr < TASK_SIZE;
+		return size <= TASK_SIZE && addr <= TASK_SIZE - size;
+	}
+}
+
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
-- 
2.54.0


