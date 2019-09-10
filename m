Return-Path: <SRS0=Blre=XF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86457C3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 09:38:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0483B2081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 09:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="S7mFrYdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0483B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46SKjH0zyMzDrP6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 19:38:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="S7mFrYdv"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46SKDh1Ts2zDr0w
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2019 19:17:23 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 46SKDV1D6Hz9txW9;
 Tue, 10 Sep 2019 11:17:14 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=S7mFrYdv; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 6jDuEqSCV0Ej; Tue, 10 Sep 2019 11:17:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 46SKDT73zHz9txW4;
 Tue, 10 Sep 2019 11:17:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1568107034; bh=jNmfqUiR6RqXmiQTG6K5uIMb23KSAJSDA4eXKm1fAe0=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=S7mFrYdvpN19TBxqJAGQ0Jg5uesInBi+v54y7dUc63yBH45Q9Bahy/qdTq8sLIxF4
 4dKn40ZEVKFF0BR5idGxftsdjDdTVYHD9/1886DIe+5bZNp7ZqbgKaNRVb3H2o9D5p
 GllL15yizzvZstSlb4dmpinkKYSeQe14s26uKwJA=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BF68F8B87D;
 Tue, 10 Sep 2019 11:17:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id dbBywxEym2uK; Tue, 10 Sep 2019 11:17:14 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 88A178B890;
 Tue, 10 Sep 2019 11:16:26 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 2E8106B739; Tue, 10 Sep 2019 09:16:26 +0000 (UTC)
Message-Id: <4ddb131f8a1db7eb01b65dc057234c824e889dd3.1568106758.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1568106758.git.christophe.leroy@c-s.fr>
References: <cover.1568106758.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 07/15] powerpc: align stack to 2 * THREAD_SIZE with
 VMAP_STACK
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 npiggin@gmail.com, dja@axtens.net
Date: Tue, 10 Sep 2019 09:16:26 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In order to ease stack overflow detection, align
stack to 2 * THREAD_SIZE when using VMAP_STACK.
This allows overflow detection using a single bit check.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/thread_info.h | 13 +++++++++++++
 arch/powerpc/kernel/setup_32.c         |  2 +-
 arch/powerpc/kernel/setup_64.c         |  2 +-
 arch/powerpc/kernel/vmlinux.lds.S      |  2 +-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 488d5c4670ff..a2270749b282 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -22,6 +22,19 @@
 
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
+/*
+ * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
+ * checking sp & (1 << THREAD_SHIFT), which we can do cheaply in the entry
+ * assembly.
+ */
+#ifdef CONFIG_VMAP_STACK
+#define THREAD_ALIGN_SHIFT	(THREAD_SHIFT + 1)
+#else
+#define THREAD_ALIGN_SHIFT	THREAD_SHIFT
+#endif
+
+#define THREAD_ALIGN		(1 << THREAD_ALIGN_SHIFT)
+
 #ifndef __ASSEMBLY__
 #include <linux/cache.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index a7541edf0cdb..180e658c1a6b 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -137,7 +137,7 @@ arch_initcall(ppc_init);
 
 static void *__init alloc_stack(void)
 {
-	void *ptr = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
+	void *ptr = memblock_alloc(THREAD_SIZE, THREAD_ALIGN);
 
 	if (!ptr)
 		panic("cannot allocate %d bytes for stack at %pS\n",
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 44b4c432a273..f630fe4d36a8 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -644,7 +644,7 @@ static void *__init alloc_stack(unsigned long limit, int cpu)
 
 	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
 
-	ptr = memblock_alloc_try_nid(THREAD_SIZE, THREAD_SIZE,
+	ptr = memblock_alloc_try_nid(THREAD_SIZE, THREAD_ALIGN,
 				     MEMBLOCK_LOW_LIMIT, limit,
 				     early_cpu_to_node(cpu));
 	if (!ptr)
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 060a1acd7c6d..d38335129c06 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -346,7 +346,7 @@ SECTIONS
 #endif
 
 	/* The initial task and kernel stack */
-	INIT_TASK_DATA_SECTION(THREAD_SIZE)
+	INIT_TASK_DATA_SECTION(THREAD_ALIGN)
 
 	.data..page_aligned : AT(ADDR(.data..page_aligned) - LOAD_OFFSET) {
 		PAGE_ALIGNED_DATA(PAGE_SIZE)
-- 
2.13.3

