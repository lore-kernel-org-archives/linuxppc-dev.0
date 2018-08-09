Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mTnP6HkQzDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 23:36:57 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w79DTtCO141562
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Aug 2018 09:36:54 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2krnftu9jh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Aug 2018 09:36:54 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 9 Aug 2018 07:36:52 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] powerpc/mm/hash: Remove unnecessary do { }while(0) loop
Date: Thu,  9 Aug 2018 19:06:42 +0530
Message-Id: <20180809133642.16007-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avoid coverity false warnings like

*** CID 187347:  Control flow issues  (UNREACHABLE)
/arch/powerpc/mm/hash_native_64.c: 819 in native_flush_hash_range()
813        slot += hidx & _PTEIDX_GROUP_IX;
814        hptep = htab_address + slot;
815        want_v = hpte_encode_avpn(vpn, psize, ssize);
816        hpte_v = hpte_get_old_v(hptep);
817
818        if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID))
>>>     CID 187347:  Control flow issues  (UNREACHABLE)

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index c81793d47af9..f82ee8a3b561 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -137,10 +137,9 @@ extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
 		shift = mmu_psize_defs[psize].shift;			\
 		for (index = 0; vpn < __end; index++,			\
 			     vpn += (1L << (shift - VPN_SHIFT))) {	\
-			if (!__split || __rpte_sub_valid(rpte, index))	\
-				do {
+		if (!__split || __rpte_sub_valid(rpte, index))
 
-#define pte_iterate_hashed_end() } while(0); } } while(0)
+#define pte_iterate_hashed_end()  } } while(0)
 
 #define pte_pagesize_index(mm, addr, pte)	\
 	(((pte) & H_PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)
-- 
2.17.1
