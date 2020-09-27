Return-Path: <SRS0=BKCT=DE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D46C4346E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2020 09:47:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7B023899
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2020 09:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7B023899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BzgmR6F1pzDqS5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2020 19:47:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bzg540zmtzDq5n
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2020 19:16:40 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4Bzg4w5Hqxz9vCxx;
 Sun, 27 Sep 2020 11:16:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 98xO3UJsOvUN; Sun, 27 Sep 2020 11:16:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4Bzg4w4Zcsz9vCxw;
 Sun, 27 Sep 2020 11:16:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C2748B771;
 Sun, 27 Sep 2020 11:16:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id RSYJzFYVn4nn; Sun, 27 Sep 2020 11:16:37 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DDF2C8B75B;
 Sun, 27 Sep 2020 11:16:36 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id B4B3E65DE8; Sun, 27 Sep 2020 09:16:36 +0000 (UTC)
Message-Id: <bce021f616cbaf39dfb5766cf7ef114adcb918d9.1601197618.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1601197618.git.christophe.leroy@csgroup.eu>
References: <cover.1601197618.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 19/30] powerpc/vdso: Remove vdso32_pages and vdso64_pages
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Sun, 27 Sep 2020 09:16:36 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

vdso32_pages and vdso64_pages are not used anymore.

Remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 3a4fbcc0d1be..e732776bac0a 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -47,7 +47,6 @@
 /* The alignment of the vDSO */
 #define VDSO_ALIGNMENT	(1 << 16)
 
-static unsigned int vdso32_pages;
 static void *vdso32_kbase;
 unsigned long vdso32_sigtramp;
 unsigned long vdso32_rt_sigtramp;
@@ -55,7 +54,6 @@ unsigned long vdso32_rt_sigtramp;
 extern char vdso32_start, vdso32_end;
 extern char vdso64_start, vdso64_end;
 static void *vdso64_kbase = &vdso64_start;
-static unsigned int vdso64_pages;
 #ifdef CONFIG_PPC64
 unsigned long vdso64_rt_sigtramp;
 #endif /* CONFIG_PPC64 */
@@ -701,20 +699,8 @@ static int __init vdso_init(void)
 	vdso_data->icache_log_block_size = ppc64_caches.l1i.log_block_size;
 #endif /* CONFIG_PPC64 */
 
-	/*
-	 * Calculate the size of the 64 bits vDSO
-	 */
-	vdso64_pages = (&vdso64_end - &vdso64_start) >> PAGE_SHIFT;
-	DBG("vdso64_kbase: %p, 0x%x pages\n", vdso64_kbase, vdso64_pages);
-
 	vdso32_kbase = &vdso32_start;
 
-	/*
-	 * Calculate the size of the 32 bits vDSO
-	 */
-	vdso32_pages = (&vdso32_end - &vdso32_start) >> PAGE_SHIFT;
-	DBG("vdso32_kbase: %p, 0x%x pages\n", vdso32_kbase, vdso32_pages);
-
 	vdso_setup_syscall_map();
 
 	/*
@@ -723,8 +709,6 @@ static int __init vdso_init(void)
 	 */
 	if (vdso_setup()) {
 		printk(KERN_ERR "vDSO setup failure, not enabled !\n");
-		vdso32_pages = 0;
-		vdso64_pages = 0;
 		return 0;
 	}
 
-- 
2.25.0

