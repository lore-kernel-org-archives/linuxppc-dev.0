Return-Path: <SRS0=rclJ=QA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D82C282C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 16:27:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92314218A2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 16:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="BX3vaHuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92314218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lnc14ycWzDqJf
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 03:26:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="BX3vaHuR"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lnRZ5Yc4zDqHL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 03:19:38 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43lnRV0J3wz9v01f;
 Thu, 24 Jan 2019 17:19:34 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=BX3vaHuR; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 1H5-H1tr053d; Thu, 24 Jan 2019 17:19:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43lnRT6KT9z9v01Z;
 Thu, 24 Jan 2019 17:19:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548346773; bh=xyvLxwhycTRV+1O9vMF302jxBSYvcLHr7jcTQSTvAjM=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=BX3vaHuR4uJAtBGxKVWu8QCXIkI7OYQ8hcSr+zzZai8qwNu4KKRlX6rzLVm78bKzn
 XAXG/0Ry2XJpXNgXmrJD1kpB4n1F5u6Ja5PmWduVjIP+SjukJVddt0F93e7z62Pxr1
 tCmN8aeWItWaiMY3vfJk7xu1EUlmZHGjBapAvB58=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7248C8B863;
 Thu, 24 Jan 2019 17:19:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id VBvGK--lXvMz; Thu, 24 Jan 2019 17:19:35 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 33A648B850;
 Thu, 24 Jan 2019 17:19:35 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 0BB6A72D88; Thu, 24 Jan 2019 16:19:35 +0000 (UTC)
Message-Id: <a20ac2ff7b1497b388535f0b4045936927dbe273.1548346225.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548346225.git.christophe.leroy@c-s.fr>
References: <cover.1548346225.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v14 03/12] book3s/64: avoid circular header inclusion in
 mmu-hash.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>
Date: Thu, 24 Jan 2019 16:19:35 +0000 (UTC)
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
Cc: Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When activating CONFIG_THREAD_INFO_IN_TASK, linux/sched.h
includes asm/current.h. This generates a circular dependency.
To avoid that, asm/processor.h shall not be included in mmu-hash.h

In order to do that, this patch moves into a new header called
asm/task_size_user64.h the information from asm/processor.h required
by mmu-hash.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
 arch/powerpc/include/asm/processor.h          | 34 +---------------------
 arch/powerpc/include/asm/task_size_user64.h   | 42 +++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_hmi.c              |  1 +
 4 files changed, 45 insertions(+), 34 deletions(-)
 create mode 100644 arch/powerpc/include/asm/task_size_user64.h

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 12e522807f9f..b2aba048301e 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -23,7 +23,7 @@
  */
 #include <asm/book3s/64/pgtable.h>
 #include <asm/bug.h>
-#include <asm/processor.h>
+#include <asm/task_size_user64.h>
 #include <asm/cpu_has_feature.h>
 
 /*
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ee58526cb6c2..692f7383d461 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -95,40 +95,8 @@ void release_thread(struct task_struct *);
 #endif
 
 #ifdef CONFIG_PPC64
-/*
- * 64-bit user address space can have multiple limits
- * For now supported values are:
- */
-#define TASK_SIZE_64TB  (0x0000400000000000UL)
-#define TASK_SIZE_128TB (0x0000800000000000UL)
-#define TASK_SIZE_512TB (0x0002000000000000UL)
-#define TASK_SIZE_1PB   (0x0004000000000000UL)
-#define TASK_SIZE_2PB   (0x0008000000000000UL)
-/*
- * With 52 bits in the address we can support
- * upto 4PB of range.
- */
-#define TASK_SIZE_4PB   (0x0010000000000000UL)
 
-/*
- * For now 512TB is only supported with book3s and 64K linux page size.
- */
-#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
-/*
- * Max value currently used:
- */
-#define TASK_SIZE_USER64		TASK_SIZE_4PB
-#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
-#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
-#else
-#define TASK_SIZE_USER64		TASK_SIZE_64TB
-#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
-/*
- * We don't need to allocate extended context ids for 4K page size, because
- * we limit the max effective address on this config to 64TB.
- */
-#define TASK_CONTEXT_SIZE		TASK_SIZE_64TB
-#endif
+#include <asm/task_size_user64.h>
 
 /*
  * 32-bit user address space is 4GB - 1 page
diff --git a/arch/powerpc/include/asm/task_size_user64.h b/arch/powerpc/include/asm/task_size_user64.h
new file mode 100644
index 000000000000..a4043075864b
--- /dev/null
+++ b/arch/powerpc/include/asm/task_size_user64.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_TASK_SIZE_USER64_H
+#define _ASM_POWERPC_TASK_SIZE_USER64_H
+
+#ifdef CONFIG_PPC64
+/*
+ * 64-bit user address space can have multiple limits
+ * For now supported values are:
+ */
+#define TASK_SIZE_64TB  (0x0000400000000000UL)
+#define TASK_SIZE_128TB (0x0000800000000000UL)
+#define TASK_SIZE_512TB (0x0002000000000000UL)
+#define TASK_SIZE_1PB   (0x0004000000000000UL)
+#define TASK_SIZE_2PB   (0x0008000000000000UL)
+/*
+ * With 52 bits in the address we can support
+ * upto 4PB of range.
+ */
+#define TASK_SIZE_4PB   (0x0010000000000000UL)
+
+/*
+ * For now 512TB is only supported with book3s and 64K linux page size.
+ */
+#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
+/*
+ * Max value currently used:
+ */
+#define TASK_SIZE_USER64		TASK_SIZE_4PB
+#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
+#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
+#else
+#define TASK_SIZE_USER64		TASK_SIZE_64TB
+#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
+/*
+ * We don't need to allocate extended context ids for 4K page size, because
+ * we limit the max effective address on this config to 64TB.
+ */
+#define TASK_CONTEXT_SIZE		TASK_SIZE_64TB
+#endif
+
+#endif /* CONFIG_PPC64 */
+#endif /* _ASM_POWERPC_TASK_SIZE_USER64_H */
diff --git a/arch/powerpc/kvm/book3s_hv_hmi.c b/arch/powerpc/kvm/book3s_hv_hmi.c
index e3f738eb1cac..64b5011475c7 100644
--- a/arch/powerpc/kvm/book3s_hv_hmi.c
+++ b/arch/powerpc/kvm/book3s_hv_hmi.c
@@ -24,6 +24,7 @@
 #include <linux/compiler.h>
 #include <asm/paca.h>
 #include <asm/hmi.h>
+#include <asm/processor.h>
 
 void wait_for_subcore_guest_exit(void)
 {
-- 
2.13.3

