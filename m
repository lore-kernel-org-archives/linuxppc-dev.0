Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qx1Xt0JYhzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 14:53:01 +1000 (AEST)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 29 Apr 2016 10:22:59 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id AA171E005A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 10:25:51 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3T4qwfq60883118
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 10:22:58 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3T4qqAk005893
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 10:22:54 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/radix: Document software bits for radix
Date: Fri, 29 Apr 2016 10:22:50 +0530
Message-Id: <1461905570-7717-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add #defines for PowerISA 3.0 software defined bits

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 9faa511757a1..5e1f3b5a4965 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -20,12 +20,16 @@
 /*
  * Software bits
  */
+#define _RPAGE_SW0		0x2000000000000000UL
+#define _RPAGE_SW1		0x00800
+#define _RPAGE_SW2		0x00400
+#define _RPAGE_SW3		0x00200
 #ifdef CONFIG_MEM_SOFT_DIRTY
-#define _PAGE_SOFT_DIRTY	0x00200 /* software: software dirty tracking */
+#define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
 #else
 #define _PAGE_SOFT_DIRTY	0x00000
 #endif
-#define _PAGE_SPECIAL		0x00400 /* software: special page */
+#define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
 
 
 #define _PAGE_PTE		(1ul << 62)	/* distinguishes PTEs from pointers */
-- 
2.7.4
