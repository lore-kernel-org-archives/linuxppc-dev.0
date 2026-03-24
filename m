Return-Path: <linuxppc-dev+bounces-18718-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D54F54AAD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 13:11:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg9Qg2Xsfz2yVB;
	Wed, 25 Mar 2026 00:11:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774357867;
	cv=none; b=OplXqzBFnRsrilBZbYkokSrB0XcyOnz0IzfzOK8JNPx1rhSKpkwyPNUXYZ02uiosksJyWqzd3YxImyZRvHXhp9fN+eYTDriitznBsc+7i7iMERi3cK+948NDS0tW8fGZSkZA1F/v51e9g79n/SwyXZJPAIaemGOdYlU7Gz7MRVye93kNAnHWOILkGEjgN3LiYLgHhAF2PCWXI0WG4udPhCWWY5nc3Vrmf6AB8hmcbxfMj6w3fiYh3+QUIK9Nv+mlqLn/7BbdTR2k4lW7E0QPMYhVC+9vjLYXA4BaLyMbLxrgLsDbtrd0L6HbHFcGabNZ5u8AdQwCXQXlpSLCSZMXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774357867; c=relaxed/relaxed;
	bh=DdTgT159JIe5UsGVZxZU4fNilugQ76lhx23zs8voJ/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJsIaMBuyGOUDnSc1m5qi9YKcG6t33dSE1VRUq9JRr372/6YjjlszTcJD1XQ9/C//wwDqVpgwAXjXEfnZzjKcjsr6UP8DUfvSZUUHa6hKDLJfL7V78iVjm/pGy+h+0uWVGPK4qxMXky2m/DIeNmiwQm6IaG1NxHQcqjYq8qOIFiiho/F/ddXaBX45u9fAtCYXBrJ41fWPzI+5u+o+6GmryAzaqNZsrYL6ZHwYuc9I/wOq9Hmyi94DWD7VAOtTYLjY7qDSB2yQ62vvV4M6i104OioshZDAHeX31oq9lf6YoVKa8rqN3C9MguzOl/mrt3400S9xFdwmJMN8vFfBfn/lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Uc81pgK0; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Uc81pgK0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg9QY6b6vz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 00:11:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9960C60132;
	Tue, 24 Mar 2026 13:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006FEC19424;
	Tue, 24 Mar 2026 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774357858;
	bh=QO0kpvVAgh/Hgzc5tsHrgKKHwBcJIs6GYao8LJCWqfc=;
	h=From:To:Cc:Subject:Date:From;
	b=Uc81pgK0e0HX6zMdOOYn0AkUePzJSAW6bE1lrPByz95zERpZU1tP25lnUcx8GUuQP
	 ihuqJhCcu7+ipc2aHQ8p1uiAcwijlxs0VIi7+4m2N4mZNPzxvtQdmFIerLS1f33LPb
	 U0t4dYXYiixLW+W8Mi4+e/9WNAsUlY8kC1XZ5VCZBUbqWpHt+zNlWuZXfPxqjaVj3R
	 haH4k5UiLhtOF40aJTZ1a0Ra394c3tQOeSh6Qpj2TQy30DZ4E340LDd+fFiQpB5KNF
	 e7dXUCk2KsAMiC8Al22ER4jmLte5UdtuQT7FgxVu0RKe2ULXiuiBf+jdguC2VZdwOB
	 CtioSUkB5nV0Q==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: David Laight <david.laight.linux@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] powerpc: Simplify access_ok()
Date: Tue, 24 Mar 2026 14:10:17 +0100
Message-ID: <fb2f064d402da446dcddec4137d8a8f9e66762f4.1774357807.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2532; i=chleroy@kernel.org; h=from:subject:message-id; bh=QO0kpvVAgh/Hgzc5tsHrgKKHwBcJIs6GYao8LJCWqfc=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQe6g2Ym7df+1WTXqZSSPJhk1A2zh+bDutsLVE+v+D7X CX3On75jlIWBjEuBlkxRZbj/7l3zej6kpo/dZc+zBxWJpAhDFycAjCR/VoM/3SbV8cWL8re9joj sP6vc3XFiQ+3r6xj1BZV0p2xvO6nIhPDX+ETC3am/1Rw8F3yP0vb5DC7S53cvaJTqzx2+tcUSAq eYgEA
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
---
 arch/powerpc/include/asm/uaccess.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 570b3d91e2e4..5921d5a7ffcd 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -15,8 +15,34 @@
 #define TASK_SIZE_MAX		TASK_SIZE_USER64
 #endif
 
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
2.49.0


