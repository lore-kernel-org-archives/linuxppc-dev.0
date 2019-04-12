Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA457C10F13
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 02:53:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1801220869
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 02:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1801220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gMst597nzDqRd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 12:53:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=baidu.com
 (client-ip=61.135.168.60; helo=tc-sys-mailedm02.tc.baidu.com;
 envelope-from=lirongqing@baidu.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baidu.com
Received: from tc-sys-mailedm02.tc.baidu.com (mx60.baidu.com [61.135.168.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 44gMr65ScJzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 12:51:58 +1000 (AEST)
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
 by tc-sys-mailedm02.tc.baidu.com (Postfix) with ESMTP id A02C511C0058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 10:51:53 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH][v2] powerpc/lib: remove memcpy_flushcache redundant return
Date: Fri, 12 Apr 2019 10:51:53 +0800
Message-Id: <1555037513-22543-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
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

Align it with other architectures and none of the callers has
been interested its return

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
v1->v2: change memcpy_flushcache declaration in arch/powerpc/include/asm/string.h

 arch/powerpc/include/asm/string.h | 2 +-
 arch/powerpc/lib/pmem.c           | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 1647de15a31e..15e2e16272ea 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -25,7 +25,7 @@ extern void * memcpy(void *,const void *,__kernel_size_t);
 extern void * memmove(void *,const void *,__kernel_size_t);
 extern int memcmp(const void *,const void *,__kernel_size_t);
 extern void * memchr(const void *,int,__kernel_size_t);
-extern void * memcpy_flushcache(void *,const void *,__kernel_size_t);
+extern void memcpy_flushcache(void *, const void *, __kernel_size_t);
 
 #ifdef CONFIG_PPC64
 #define __HAVE_ARCH_MEMSET32
diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
index 53c018762e1c..a7a1b3fc6720 100644
--- a/arch/powerpc/lib/pmem.c
+++ b/arch/powerpc/lib/pmem.c
@@ -48,14 +48,12 @@ long __copy_from_user_flushcache(void *dest, const void __user *src,
 	return copied;
 }
 
-void *memcpy_flushcache(void *dest, const void *src, size_t size)
+void memcpy_flushcache(void *dest, const void *src, size_t size)
 {
 	unsigned long start = (unsigned long) dest;
 
 	memcpy(dest, src, size);
 	flush_inval_dcache_range(start, start + size);
-
-	return dest;
 }
 EXPORT_SYMBOL(memcpy_flushcache);
 
-- 
2.16.2

