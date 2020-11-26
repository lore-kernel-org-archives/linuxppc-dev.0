Return-Path: <SRS0=1PmZ=FA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7E8C63697
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 13:27:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927BD21D40
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 13:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="FYnfiLqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927BD21D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Chdq75q8BzDqr6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2020 00:27:47 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ChdQy3RX7zDqmC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2020 00:10:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=FYnfiLqT; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4ChdQv5dslz9sVV; Fri, 27 Nov 2020 00:10:15 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4ChdQv30X1z9sVk; Fri, 27 Nov 2020 00:10:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1606396215;
 bh=eCylbq+Oc1JiXsGrdJ/4AvGNSKVFaASkoKSDYCaL2RU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FYnfiLqTUZSjSWRbuOmL27BiiQ9Q6/ple97R5l2tD/Tyeuqi6SifHImePlmZ8Irdj
 OI64qKxIzxSXIKjuHZ6mJ/cFxyUA/KGKroAKh6gCdDabyJx6XgYiiJdgfLQ+6JlAS5
 mtXaX1vCDBpPf8fIQryJ1jT79SA1DJ7ZP6gzE4jV2C8+gSTpsYaI30lzVNsBzBgHzQ
 wu619w4duKiiOuBHzwRGyXIevzWUcV5FMKxHzDpB7lVsfIYRjuP4k8Q1hm/aeyJ+Sg
 DyKUUmAbg9tku9ytwq5UOBuniIk1Jt98ZFLhF4exHOZFWrbb13rGHkyay8WsGfLsT7
 zj3Ag5At62Xvw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v14 2/9] powerpc/processor: Move cpu_relax() into
 asm/vdso/processor.h
Date: Fri, 27 Nov 2020 00:09:59 +1100
Message-Id: <20201126131006.2431205-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126131006.2431205-1-mpe@ellerman.id.au>
References: <20201126131006.2431205-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@csgroup.eu>

cpu_relax() need to be in asm/vdso/processor.h to be used by
the C VDSO generic library.

Move it there.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
[mpe: Tweak include guards to match our usual formatting]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/3747db2c50eb98a86088871bef7ed7c593e336bb.1604426550.git.christophe.leroy@csgroup.eu
---
 arch/powerpc/include/asm/processor.h      | 13 ++-----------
 arch/powerpc/include/asm/vdso/processor.h | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 11 deletions(-)
 create mode 100644 arch/powerpc/include/asm/vdso/processor.h

v14: mpe: Tweak include guards to match our usual formatting

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index c61c859b51a8..333e3b6c76fb 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -6,6 +6,8 @@
  * Copyright (C) 2001 PPC 64 Team, IBM Corp
  */
 
+#include <vdso/processor.h>
+
 #include <asm/reg.h>
 
 #ifdef CONFIG_VSX
@@ -63,14 +65,6 @@ extern int _chrp_type;
 
 #endif /* defined(__KERNEL__) && defined(CONFIG_PPC32) */
 
-/* Macros for adjusting thread priority (hardware multi-threading) */
-#define HMT_very_low()   asm volatile("or 31,31,31   # very low priority")
-#define HMT_low()	 asm volatile("or 1,1,1	     # low priority")
-#define HMT_medium_low() asm volatile("or 6,6,6      # medium low priority")
-#define HMT_medium()	 asm volatile("or 2,2,2	     # medium priority")
-#define HMT_medium_high() asm volatile("or 5,5,5      # medium high priority")
-#define HMT_high()	 asm volatile("or 3,3,3	     # high priority")
-
 #ifdef __KERNEL__
 
 #ifdef CONFIG_PPC64
@@ -344,7 +338,6 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 }
 
 #ifdef CONFIG_PPC64
-#define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
 
 #define spin_begin()	HMT_low()
 
@@ -363,8 +356,6 @@ do {								\
 	}							\
 } while (0)
 
-#else
-#define cpu_relax()	barrier()
 #endif
 
 /* Check that a certain kernel stack pointer is valid in task_struct p */
diff --git a/arch/powerpc/include/asm/vdso/processor.h b/arch/powerpc/include/asm/vdso/processor.h
new file mode 100644
index 000000000000..e072577bc7c0
--- /dev/null
+++ b/arch/powerpc/include/asm/vdso/processor.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_POWERPC_VDSO_PROCESSOR_H
+#define _ASM_POWERPC_VDSO_PROCESSOR_H
+
+#ifndef __ASSEMBLY__
+
+/* Macros for adjusting thread priority (hardware multi-threading) */
+#define HMT_very_low()		asm volatile("or 31, 31, 31	# very low priority")
+#define HMT_low()		asm volatile("or 1, 1, 1	# low priority")
+#define HMT_medium_low()	asm volatile("or 6, 6, 6	# medium low priority")
+#define HMT_medium()		asm volatile("or 2, 2, 2	# medium priority")
+#define HMT_medium_high()	asm volatile("or 5, 5, 5	# medium high priority")
+#define HMT_high()		asm volatile("or 3, 3, 3	# high priority")
+
+#ifdef CONFIG_PPC64
+#define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
+#else
+#define cpu_relax()	barrier()
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_POWERPC_VDSO_PROCESSOR_H */
-- 
2.25.1

