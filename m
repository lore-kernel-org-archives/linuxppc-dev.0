Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A393F1A0133
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 21:09:00 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 17 Oct 2015 15:38:58 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C30ADE005C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:54 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9HA8sEj53346392
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:54 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9HA8rvS017138
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:54 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 13/31] powerpc/booke: Move nohash headers (part 1)
Date: Sat, 17 Oct 2015 15:38:24 +0530
Message-Id: <1445076522-20527-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
