Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39A941A0048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:14 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 16:42:14 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7C4D92BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:11 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8L6frcZ65929456
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:01 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8L6fcj6014002
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:41:38 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 01/31] powerpc/mm: move pte headers to book3s directory
Date: Mon, 21 Sep 2015 12:10:28 +0530
Message-Id: <1442817658-2588-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/{pte-hash32.h => book3s/32/hash.h} | 0
 arch/powerpc/include/asm/{pte-hash64.h => book3s/64/hash.h} | 0
 arch/powerpc/include/asm/pgtable-ppc32.h                    | 2 +-
 arch/powerpc/include/asm/pgtable-ppc64.h                    | 2 +-
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/powerpc/include/asm/{pte-hash32.h => book3s/32/hash.h} (100%)
 rename arch/powerpc/include/asm/{pte-hash64.h => book3s/64/hash.h} (100%)

diff --git a/arch/powerpc/include/asm/pte-hash32.h b/arch/powerpc/include/asm/book3s/32/hash.h
similarity index 100%
rename from arch/powerpc/include/asm/pte-hash32.h
rename to arch/powerpc/include/asm/book3s/32/hash.h
diff --git a/arch/powerpc/include/asm/pte-hash64.h b/arch/powerpc/include/asm/book3s/64/hash.h
similarity index 100%
rename from arch/powerpc/include/asm/pte-hash64.h
rename to arch/powerpc/include/asm/book3s/64/hash.h
diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 9c326565d498..1a58a05be99c 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -116,7 +116,7 @@ extern int icache_44x_need_flush;
 #elif defined(CONFIG_8xx)
 #include <asm/pte-8xx.h>
 #else /* CONFIG_6xx */
-#include <asm/pte-hash32.h>
+#include <asm/book3s/32/hash.h>
 #endif
 
 /* And here we include common definitions */
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index fa1dfb7f7b48..4f7d8e2f2a2f 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -98,7 +98,7 @@
  * Include the PTE bits definitions
  */
 #ifdef CONFIG_PPC_BOOK3S
-#include <asm/pte-hash64.h>
+#include <asm/book3s/64/hash.h>
 #else
 #include <asm/pte-book3e.h>
 #endif
-- 
2.5.0
