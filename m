Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B85191A0CAC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:37:18 +1100 (AEDT)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 09:07:16 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 2BF32125805C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 09:07:32 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB13bCSX55902238
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:12 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB13bBhj022001
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:12 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 13/35] powerpc/booke: Move nohash headers (part 1)
Date: Tue,  1 Dec 2015 09:06:38 +0530
Message-Id: <1448941020-15168-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
