Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTL4p6kzBzDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 16:55:21 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5E6s286105548
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:19 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23geqnuewy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:19 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 00:55:18 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Kevin Hao <haokexin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 06/10] powerpc: kill mfvtb()
Date: Tue, 14 Jun 2016 12:24:44 +0530
In-Reply-To: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465887288-12952-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kevin Hao <haokexin@gmail.com>

This function is only used by get_vtb(). They are almost the same
except the reading from the real register. Move the mfspr() to
get_vtb() and kill the function mfvtb(). With this, we can eliminate
the use of cpu_has_feature() in very core header file like reg.h.
This is a preparation for the use of jump label for cpu_has_feature().

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/reg.h  | 9 ---------
 arch/powerpc/include/asm/time.h | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 5c4b6f4f8903..b56430b15c80 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1238,15 +1238,6 @@ static inline void msr_check_and_clear(unsigned long bits)
 		__msr_check_and_clear(bits);
 }
 
-static inline unsigned long mfvtb (void)
-{
-#ifdef CONFIG_PPC_BOOK3S_64
-	if (cpu_has_feature(CPU_FTR_ARCH_207S))
-		return mfspr(SPRN_VTB);
-#endif
-	return 0;
-}
-
 #ifdef __powerpc64__
 #if defined(CONFIG_PPC_CELL) || defined(CONFIG_PPC_FSL_BOOK3E)
 #define mftb()		({unsigned long rval;				\
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 1092fdd7e737..3a4d7e0cfbe7 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -103,7 +103,7 @@ static inline u64 get_vtb(void)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
-		return mfvtb();
+		return mfspr(SPRN_VTB);
 #endif
 	return 0;
 }
-- 
2.7.4
