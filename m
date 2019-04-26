Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCA4C43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:20:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60B2206E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="DVuXMago"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60B2206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r3nL6Q1KzDqhS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:20:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="DVuXMago"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r3Kz2fFczDqdp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 15:59:51 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44r3Kv2Tq7z9v1vP;
 Fri, 26 Apr 2019 07:59:47 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=DVuXMago; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 3dBihyuc_5WN; Fri, 26 Apr 2019 07:59:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44r3Kv1TYdz9v1tj;
 Fri, 26 Apr 2019 07:59:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556258387; bh=4kEDLZNkBNAYCQ5OcoGO2PuBDx1/QI5nsGEmUjCJNzw=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=DVuXMagoAbuIWEZZwTVKXG0tADE8VQ6UXfN3DKe7buTgDOsVa/1q/pFswEdag6l50
 8iW1iTmS5hlqHdjdbcu4CjwKQCZRKos6LJ1I6JlZ6TCI+OueKSyCmY44BmqIEqps76
 jOXZWwWupVwRDaoeMRz/j7chAgrU1fSHth4Jmeuk=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1962C8B807;
 Fri, 26 Apr 2019 07:59:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id AQkN-zkAJyC0; Fri, 26 Apr 2019 07:59:48 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 01C618B74C;
 Fri, 26 Apr 2019 07:59:48 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id D962166276; Fri, 26 Apr 2019 05:59:47 +0000 (UTC)
Message-Id: <abacb62daee8e70f14ce3899a255f756c6b20583.1556258135.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556258134.git.christophe.leroy@c-s.fr>
References: <cover.1556258134.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 12/17] powerpc/mm: move hugetlb_disabled into asm/hugetlb.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Fri, 26 Apr 2019 05:59:47 +0000 (UTC)
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

No need to have this in asm/page.h, move it into asm/hugetlb.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hugetlb.h | 2 ++
 arch/powerpc/include/asm/page.h    | 1 -
 arch/powerpc/kernel/fadump.c       | 1 +
 arch/powerpc/mm/hash_utils_64.c    | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index fd5c0873a57d..84598c6b0959 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -13,6 +13,8 @@
 #include <asm/nohash/32/hugetlb-8xx.h>
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
+extern bool hugetlb_disabled;
+
 void flush_dcache_icache_hugepage(struct page *page);
 
 int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 748f5db2e2b7..6b508420d92b 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -29,7 +29,6 @@
 
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_HUGETLB_PAGE
-extern bool hugetlb_disabled;
 extern unsigned int HPAGE_SHIFT;
 #else
 #define HPAGE_SHIFT PAGE_SHIFT
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 45a8d0be1c96..25f063f56ec5 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -36,6 +36,7 @@
 #include <linux/sysfs.h>
 #include <linux/slab.h>
 #include <linux/cma.h>
+#include <linux/hugetlb.h>
 
 #include <asm/debugfs.h>
 #include <asm/page.h>
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f727197de713..db1aef2adc88 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -37,6 +37,7 @@
 #include <linux/context_tracking.h>
 #include <linux/libfdt.h>
 #include <linux/pkeys.h>
+#include <linux/hugetlb.h>
 
 #include <asm/debugfs.h>
 #include <asm/processor.h>
-- 
2.13.3

