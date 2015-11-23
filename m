Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A71B1A0337
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:23:52 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 20:23:50 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B22572CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:23:47 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANANf5H35061972
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:23:49 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANANEMr012635
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:23:15 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 02/31] powerpc/mm: move pte headers to book3s directory
 (part 2)
Date: Mon, 23 Nov 2015 15:52:11 +0530
Message-Id: <1448274160-28446-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Acked-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/hash.h                      |  6 +++---
 .../include/asm/{pte-hash64-4k.h => book3s/64/hash-4k.h}       |  1 -
 .../include/asm/{pte-hash64-64k.h => book3s/64/hash-64k.h}     |  0
 arch/powerpc/include/asm/book3s/64/hash.h                      | 10 +++++-----
 4 files changed, 8 insertions(+), 9 deletions(-)
 rename arch/powerpc/include/asm/{pte-hash64-4k.h => book3s/64/hash-4k.h} (99%)
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
similarity index 99%
rename from arch/powerpc/include/asm/pte-hash64-4k.h
rename to arch/powerpc/include/asm/book3s/64/hash-4k.h
index c134e809aac3..79750fd3eeb8 100644
--- a/arch/powerpc/include/asm/pte-hash64-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -14,4 +14,3 @@
 
 /* shift to put page number into pte */
 #define PTE_RPN_SHIFT	(17)
-
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
