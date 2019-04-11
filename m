Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E28C10F14
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 08:37:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B122083E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 08:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B122083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fvXf5ntQzDqRB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 18:37:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=baidu.com
 (client-ip=61.135.168.139; helo=tc-sys-mailedm04.tc.baidu.com;
 envelope-from=lirongqing@baidu.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baidu.com
X-Greylist: delayed 550 seconds by postgrey-1.36 at bilbo;
 Thu, 11 Apr 2019 18:35:54 AEST
Received: from tc-sys-mailedm04.tc.baidu.com (mx139-tc.baidu.com
 [61.135.168.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 44fvVy2VdtzDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 18:35:53 +1000 (AEST)
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
 by tc-sys-mailedm04.tc.baidu.com (Postfix) with ESMTP id 5378E236C00B;
 Thu, 11 Apr 2019 16:26:15 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/lib: remove memcpy_flushcache redundant return
Date: Thu, 11 Apr 2019 16:26:15 +0800
Message-Id: <1554971175-2679-1-git-send-email-lirongqing@baidu.com>
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
 arch/powerpc/lib/pmem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

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

