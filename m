Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vs715cnCzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 23:32:45 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7LDO9cw131934
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 09:32:43 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m0hq7dkq0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 09:32:42 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 21 Aug 2018 07:32:41 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 1/2] powerpc/mm/hash: Rename get_ea_context to
 get_user_context
Date: Tue, 21 Aug 2018 19:02:25 +0530
Message-Id: <20180821133226.15908-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will be adding get_kernel_context later. Update function name to indicate
this handle context allocation user space address.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 4 ++--
 arch/powerpc/include/asm/mmu_context.h   | 2 +-
 arch/powerpc/mm/slb.c                    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 9c8c669a6b6a..6328857f259f 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -208,7 +208,7 @@ extern void radix_init_pseries(void);
 static inline void radix_init_pseries(void) { };
 #endif
 
-static inline int get_ea_context(mm_context_t *ctx, unsigned long ea)
+static inline int get_user_context(mm_context_t *ctx, unsigned long ea)
 {
 	int index = ea >> MAX_EA_BITS_PER_CONTEXT;
 
@@ -223,7 +223,7 @@ static inline int get_ea_context(mm_context_t *ctx, unsigned long ea)
 static inline unsigned long get_user_vsid(mm_context_t *ctx,
 					  unsigned long ea, int ssize)
 {
-	unsigned long context = get_ea_context(ctx, ea);
+	unsigned long context = get_user_context(ctx, ea);
 
 	return get_vsid(context, ea, ssize);
 }
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b2f89b621b15..dbbab7ba449b 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -81,7 +81,7 @@ static inline bool need_extra_context(struct mm_struct *mm, unsigned long ea)
 {
 	int context_id;
 
-	context_id = get_ea_context(&mm->context, ea);
+	context_id = get_user_context(&mm->context, ea);
 	if (!context_id)
 		return true;
 	return false;
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index b0f4c038d658..f63a608922ca 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -464,7 +464,7 @@ static long slb_allocate_user(struct mm_struct *mm, unsigned long ea)
 	if (ea >= mm->context.slb_addr_limit)
 		return -EFAULT;
 
-	context = get_ea_context(&mm->context, ea);
+	context = get_user_context(&mm->context, ea);
 	if (!context)
 		return -EFAULT;
 
-- 
2.17.1
