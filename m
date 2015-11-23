Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1595D1A03C3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:24:11 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 20:24:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C6EEC3578047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:24:06 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANANxas31653988
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:24:08 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANANXcS013236
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:23:34 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 13/31] powerpc/booke: Move nohash headers (part 1)
Date: Mon, 23 Nov 2015 15:52:22 +0530
Message-Id: <1448274160-28446-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Move the booke related headers below booke/32 or booke/64

We are splitting this change into multiple patch to make the rebasing
easier. The following patches can be folded into this if needed.
They are kept separate for easier review.

Acked-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/{pgtable-book3e.h => nohash/pgtable.h} | 0
 arch/powerpc/include/asm/pgtable.h                              | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/include/asm/{pgtable-book3e.h => nohash/pgtable.h} (100%)

diff --git a/arch/powerpc/include/asm/pgtable-book3e.h b/arch/powerpc/include/asm/nohash/pgtable.h
similarity index 100%
rename from arch/powerpc/include/asm/pgtable-book3e.h
rename to arch/powerpc/include/asm/nohash/pgtable.h
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 8f7338678fdc..ac9fb114e25d 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -15,7 +15,7 @@ struct mm_struct;
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/book3s/pgtable.h>
 #else
-#include <asm/pgtable-book3e.h>
+#include <asm/nohash/pgtable.h>
 #endif /* !CONFIG_PPC_BOOK3S */
 
 #ifndef __ASSEMBLY__
-- 
2.5.0
