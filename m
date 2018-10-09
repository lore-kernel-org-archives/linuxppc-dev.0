Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CBAC64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 15:53:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA67213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 15:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA67213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V1wf2Z9XzF3Jm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 02:53:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TzF161F4zF325
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:52:21 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42TzDj47PVz9ttgQ;
 Tue,  9 Oct 2018 15:52:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Rgk9iDUDvFE5; Tue,  9 Oct 2018 15:52:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42TzDj3Z7yz9ttfw;
 Tue,  9 Oct 2018 15:52:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 26AF18B80B;
 Tue,  9 Oct 2018 15:52:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id kNJe8wF8m5Kp; Tue,  9 Oct 2018 15:52:17 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D0DB18B80A;
 Tue,  9 Oct 2018 15:52:16 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 7B86B6F444; Tue,  9 Oct 2018 13:52:16 +0000 (UTC)
Message-Id: <2b1bca2aba3213b13dadaca5e311a15e9fcb1aab.1539092112.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 22/24] powerpc/mm: Get rid of pte-common.h
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 aneesh.kumar@linux.vnet.ibm.com
Date: Tue,  9 Oct 2018 13:52:16 +0000 (UTC)
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
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Do not include pte-common.h in nohash/32/pgtable.h

As that was the last includer, get rid of pte-common.h

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 23 +++++++++++++++++++++--
 arch/powerpc/include/asm/pte-common.h        | 25 -------------------------
 2 files changed, 21 insertions(+), 27 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/pte-common.h

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index ce9270a0ea42..d2908a8038e8 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -128,8 +128,27 @@ extern int icache_44x_need_flush;
 #include <asm/nohash/32/pte-8xx.h>
 #endif
 
-/* And here we include common definitions */
-#include <asm/pte-common.h>
+/* Location of the PFN in the PTE. Most 32-bit platforms use the same
+ * as _PAGE_SHIFT here (ie, naturally aligned).
+ * Platform who don't just pre-define the value so we don't override it here
+ */
+#ifndef PTE_RPN_SHIFT
+#define PTE_RPN_SHIFT	(PAGE_SHIFT)
+#endif
+
+/* The mask covered by the RPN must be a ULL on 32-bit platforms with
+ * 64-bit PTEs
+ */
+#if defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
+#define PTE_RPN_MASK	(~((1ULL << PTE_RPN_SHIFT) - 1))
+#else
+#define PTE_RPN_MASK	(~((1UL << PTE_RPN_SHIFT) - 1))
+#endif
+
+/* _PAGE_CHG_MASK masks of bits that are to be preserved across
+ * pgprot changes
+ */
+#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPECIAL)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
deleted file mode 100644
index ff01368a175a..000000000000
--- a/arch/powerpc/include/asm/pte-common.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Included from asm/pgtable-*.h only ! */
-
-/* Location of the PFN in the PTE. Most 32-bit platforms use the same
- * as _PAGE_SHIFT here (ie, naturally aligned).
- * Platform who don't just pre-define the value so we don't override it here
- */
-#ifndef PTE_RPN_SHIFT
-#define PTE_RPN_SHIFT	(PAGE_SHIFT)
-#endif
-
-/* The mask covered by the RPN must be a ULL on 32-bit platforms with
- * 64-bit PTEs
- */
-#if defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
-#define PTE_RPN_MASK	(~((1ULL<<PTE_RPN_SHIFT)-1))
-#else
-#define PTE_RPN_MASK	(~((1UL<<PTE_RPN_SHIFT)-1))
-#endif
-
-/* _PAGE_CHG_MASK masks of bits that are to be preserved across
- * pgprot changes
- */
-#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_DIRTY | \
-                         _PAGE_ACCESSED | _PAGE_SPECIAL)
-- 
2.13.3

