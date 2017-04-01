Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vwLgC5KZvzDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Apr 2017 01:42:15 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v31EcWew063526
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 1 Apr 2017 10:42:05 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29j5tuygtr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Apr 2017 10:42:05 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 1 Apr 2017 08:42:04 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/mm/radix: Remove unnecessary ptesync
Date: Sat,  1 Apr 2017 20:11:48 +0530
In-Reply-To: <1491057708-15934-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1491057708-15934-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1491057708-15934-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For a tlbiel with pid, we need to issue tlbiel with set number encoded. We
don't need to do ptesync for each of those. Instead we need one for the entire
tlbiel pid operation.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/tlb-radix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index f3e58bd60d1a..b68b5219cf45 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -34,10 +34,8 @@ static inline void __tlbiel_pid(unsigned long pid, int set,
 	prs = 1; /* process scoped */
 	r = 1;   /* raidx format */
 
-	asm volatile("ptesync": : :"memory");
 	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
-	asm volatile("ptesync": : :"memory");
 }
 
 /*
@@ -47,9 +45,11 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 {
 	int set;
 
+	asm volatile("ptesync": : :"memory");
 	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
 		__tlbiel_pid(pid, set, ric);
 	}
+	asm volatile("ptesync": : :"memory");
 	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
 }
 
-- 
2.7.4
