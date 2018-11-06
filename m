Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F024C32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 12:41:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC8420862
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 12:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC8420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42q8LS3gDLzF39R
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 23:41:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42q8FV2CnQzDrP0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 23:37:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42q8FT0K4Mz9sDJ; Tue,  6 Nov 2018 23:37:17 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42q8FS4pmmz9sDb; Tue,  6 Nov 2018 23:37:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc/mm/64s: Consolidate SLB assertions
Date: Tue,  6 Nov 2018 23:37:07 +1100
Message-Id: <20181106123709.940-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The code for assert_slb_exists() and assert_slb_notexists() is almost
identical, except for the polarity of the WARN_ON(). In a future patch
we'll need to modify this code, so consolidate it now into a single
function.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/slb.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index c3fdf2969d9f..f3e002ee457b 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -58,7 +58,7 @@ static inline unsigned long mk_vsid_data(unsigned long ea, int ssize,
 	return __mk_vsid_data(get_kernel_vsid(ea, ssize), ssize, flags);
 }
 
-static void assert_slb_exists(unsigned long ea)
+static void assert_slb_presence(bool present, unsigned long ea)
 {
 #ifdef CONFIG_DEBUG_VM
 	unsigned long tmp;
@@ -66,19 +66,8 @@ static void assert_slb_exists(unsigned long ea)
 	WARN_ON_ONCE(mfmsr() & MSR_EE);
 
 	asm volatile("slbfee. %0, %1" : "=r"(tmp) : "r"(ea) : "cr0");
-	WARN_ON(tmp == 0);
-#endif
-}
 
-static void assert_slb_notexists(unsigned long ea)
-{
-#ifdef CONFIG_DEBUG_VM
-	unsigned long tmp;
-
-	WARN_ON_ONCE(mfmsr() & MSR_EE);
-
-	asm volatile("slbfee. %0, %1" : "=r"(tmp) : "r"(ea) : "cr0");
-	WARN_ON(tmp != 0);
+	WARN_ON(present == (tmp == 0));
 #endif
 }
 
@@ -114,7 +103,7 @@ static inline void create_shadowed_slbe(unsigned long ea, int ssize,
 	 */
 	slb_shadow_update(ea, ssize, flags, index);
 
-	assert_slb_notexists(ea);
+	assert_slb_presence(false, ea);
 	asm volatile("slbmte  %0,%1" :
 		     : "r" (mk_vsid_data(ea, ssize, flags)),
 		       "r" (mk_esid_data(ea, ssize, index))
@@ -137,7 +126,7 @@ void __slb_restore_bolted_realmode(void)
 		       "r" (be64_to_cpu(p->save_area[index].esid)));
 	}
 
-	assert_slb_exists(local_paca->kstack);
+	assert_slb_presence(true, local_paca->kstack);
 }
 
 /*
@@ -185,7 +174,7 @@ void slb_flush_and_restore_bolted(void)
 		     :: "r" (be64_to_cpu(p->save_area[KSTACK_INDEX].vsid)),
 			"r" (be64_to_cpu(p->save_area[KSTACK_INDEX].esid))
 		     : "memory");
-	assert_slb_exists(get_paca()->kstack);
+	assert_slb_presence(true, get_paca()->kstack);
 
 	get_paca()->slb_cache_ptr = 0;
 
@@ -443,9 +432,9 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 				ea = (unsigned long)
 					get_paca()->slb_cache[i] << SID_SHIFT;
 				/*
-				 * Could assert_slb_exists here, but hypervisor
-				 * or machine check could have come in and
-				 * removed the entry at this point.
+				 * Could assert_slb_presence(true) here, but
+				 * hypervisor or machine check could have come
+				 * in and removed the entry at this point.
 				 */
 
 				slbie_data = ea;
@@ -676,7 +665,7 @@ static long slb_insert_entry(unsigned long ea, unsigned long context,
 	 * User preloads should add isync afterwards in case the kernel
 	 * accesses user memory before it returns to userspace with rfid.
 	 */
-	assert_slb_notexists(ea);
+	assert_slb_presence(false, ea);
 	asm volatile("slbmte %0, %1" : : "r" (vsid_data), "r" (esid_data));
 
 	barrier();
-- 
2.17.2

