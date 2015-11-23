Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 887231A029E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:23:50 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 20:23:48 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CE8623578058
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:23:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANANbRV54329552
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:23:45 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANANCaZ012561
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:23:13 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 01/31] powerpc/mm: move pte headers to book3s directory
Date: Mon, 23 Nov 2015 15:52:10 +0530
Message-Id: <1448274160-28446-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Acked-by: Scott Wood <scottwood@freescale.com>
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
index 3245f2d96d4f..b36a932abdfb 100644
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
