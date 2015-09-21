Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FA541A0052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:16 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 16:42:15 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DCBDA2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:12 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8L6g6OU54919342
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:14 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8L6feDZ014033
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:41:40 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 02/31] powerpc/mm: move pte headers to book3s directory (part
 2)
Date: Mon, 21 Sep 2015 12:10:29 +0530
Message-Id: <1442817658-2588-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Splitting this so that rename can track changes to file. Before merging
we will fold this

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/hash.h                      |  6 +++---
 .../include/asm/{pte-hash64-4k.h => book3s/64/hash-4k.h}       |  0
 .../include/asm/{pte-hash64-64k.h => book3s/64/hash-64k.h}     |  0
 arch/powerpc/include/asm/book3s/64/hash.h                      | 10 +++++-----
 4 files changed, 8 insertions(+), 8 deletions(-)
 rename arch/powerpc/include/asm/{pte-hash64-4k.h => book3s/64/hash-4k.h} (100%)
 rename arch/powerpc/include/asm/{pte-hash64-64k.h => book3s/64/hash-64k.h} (100%)

diff --git a/arch/powerpc/include/asm/book3s/32/hash.h b/arch/powerpc/include/asm/book3s/32/hash.h
index 62cfb0c663bb..264b754d65b0 100644
--- a/arch/powerpc/include/asm/book3s/32/hash.h
+++ b/arch/powerpc/include/asm/book3s/32/hash.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PTE_HASH32_H
-#define _ASM_POWERPC_PTE_HASH32_H
+#ifndef _ASM_POWERPC_BOOK3S_32_HASH_H
+#define _ASM_POWERPC_BOOK3S_32_HASH_H
 #ifdef __KERNEL__
 
 /*
@@ -43,4 +43,4 @@
 #define PTE_ATOMIC_UPDATES	1
 
 #endif /* __KERNEL__ */
-#endif /*  _ASM_POWERPC_PTE_HASH32_H */
+#endif /* _ASM_POWERPC_BOOK3S_32_HASH_H */
diff --git a/arch/powerpc/include/asm/pte-hash64-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
similarity index 100%
rename from arch/powerpc/include/asm/pte-hash64-4k.h
rename to arch/powerpc/include/asm/book3s/64/hash-4k.h
diff --git a/arch/powerpc/include/asm/pte-hash64-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
similarity index 100%
rename from arch/powerpc/include/asm/pte-hash64-64k.h
rename to arch/powerpc/include/asm/book3s/64/hash-64k.h
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index ef612c160da7..8e60d4fa434d 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PTE_HASH64_H
-#define _ASM_POWERPC_PTE_HASH64_H
+#ifndef _ASM_POWERPC_BOOK3S_64_HASH_H
+#define _ASM_POWERPC_BOOK3S_64_HASH_H
 #ifdef __KERNEL__
 
 /*
@@ -45,10 +45,10 @@
 #define PTE_ATOMIC_UPDATES	1
 
 #ifdef CONFIG_PPC_64K_PAGES
-#include <asm/pte-hash64-64k.h>
+#include <asm/book3s/64/hash-64k.h>
 #else
-#include <asm/pte-hash64-4k.h>
+#include <asm/book3s/64/hash-4k.h>
 #endif
 
 #endif /* __KERNEL__ */
-#endif /*  _ASM_POWERPC_PTE_HASH64_H */
+#endif /* _ASM_POWERPC_BOOK3S_64_HASH_H */
-- 
2.5.0
