Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFBCC71122
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 13:34:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE01420895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 13:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE01420895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XQg26YMkzF35J
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 00:34:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XQJz505XzF3DW
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 00:19:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42XQJz3t4gz9sB5; Sun, 14 Oct 2018 00:19:15 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42XQJz3GQCz9sBj; Sun, 14 Oct 2018 00:19:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/6] powerpc/64s/hash: Add some SLB debugging tests
Date: Sun, 14 Oct 2018 00:18:36 +1100
Message-Id: <20181013131836.26764-6-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181013131836.26764-1-mpe@ellerman.id.au>
References: <20181013131836.26764-1-mpe@ellerman.id.au>
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
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Nicholas Piggin <npiggin@gmail.com>

This adds CONFIG_DEBUG_VM checks to ensure:
  - The kernel stack is in the SLB after it's flushed and bolted.
  - We don't insert an SLB for an address that is aleady in the SLB.
  - The kernel SLB miss handler does not take an SLB miss.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/paca.h |  3 ++
 arch/powerpc/mm/slb.c           | 53 +++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 97e8a57a4998..e843bc5d1a0f 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -115,6 +115,9 @@ struct paca_struct {
 	u16 vmalloc_sllp;
 	u8 slb_cache_ptr;
 	u8 stab_rr;			/* stab/slb round-robin counter */
+#ifdef CONFIG_DEBUG_VM
+	u8 in_kernel_slb_handler;
+#endif
 	u32 slb_used_bitmap;		/* Bitmaps for first 32 SLB entries. */
 	u32 slb_kern_bitmap;
 	u32 slb_cache[SLB_CACHE_ENTRIES];
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index d8d9c9bd15d3..4b6e7a21a7c5 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -58,6 +58,30 @@ static inline unsigned long mk_vsid_data(unsigned long ea, int ssize,
 	return __mk_vsid_data(get_kernel_vsid(ea, ssize), ssize, flags);
 }
 
+static void assert_slb_exists(unsigned long ea)
+{
+#ifdef CONFIG_DEBUG_VM
+	unsigned long tmp;
+
+	WARN_ON_ONCE(mfmsr() & MSR_EE);
+
+	asm volatile("slbfee. %0, %1" : "=r"(tmp) : "r"(ea) : "cr0");
+	WARN_ON(tmp == 0);
+#endif
+}
+
+static void assert_slb_notexists(unsigned long ea)
+{
+#ifdef CONFIG_DEBUG_VM
+	unsigned long tmp;
+
+	WARN_ON_ONCE(mfmsr() & MSR_EE);
+
+	asm volatile("slbfee. %0, %1" : "=r"(tmp) : "r"(ea) : "cr0");
+	WARN_ON(tmp != 0);
+#endif
+}
+
 static inline void slb_shadow_update(unsigned long ea, int ssize,
 				     unsigned long flags,
 				     enum slb_index index)
@@ -90,6 +114,7 @@ static inline void create_shadowed_slbe(unsigned long ea, int ssize,
 	 */
 	slb_shadow_update(ea, ssize, flags, index);
 
+	assert_slb_notexists(ea);
 	asm volatile("slbmte  %0,%1" :
 		     : "r" (mk_vsid_data(ea, ssize, flags)),
 		       "r" (mk_esid_data(ea, ssize, index))
@@ -111,6 +136,8 @@ void __slb_restore_bolted_realmode(void)
 		     : "r" (be64_to_cpu(p->save_area[index].vsid)),
 		       "r" (be64_to_cpu(p->save_area[index].esid)));
 	}
+
+	assert_slb_exists(local_paca->kstack);
 }
 
 /*
@@ -158,6 +185,7 @@ void slb_flush_and_restore_bolted(void)
 		     :: "r" (be64_to_cpu(p->save_area[KSTACK_INDEX].vsid)),
 			"r" (be64_to_cpu(p->save_area[KSTACK_INDEX].esid))
 		     : "memory");
+	assert_slb_exists(get_paca()->kstack);
 
 	get_paca()->slb_cache_ptr = 0;
 
@@ -410,9 +438,17 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 			unsigned long slbie_data = 0;
 
 			for (i = 0; i < offset; i++) {
-				/* EA */
-				slbie_data = (unsigned long)
+				unsigned long ea;
+
+				ea = (unsigned long)
 					get_paca()->slb_cache[i] << SID_SHIFT;
+				/*
+				 * Could assert_slb_exists here, but hypervisor
+				 * or machine check could have come in and
+				 * removed the entry at this point.
+				 */
+
+				slbie_data = ea;
 				slbie_data |= user_segment_size(slbie_data)
 						<< SLBIE_SSIZE_SHIFT;
 				slbie_data |= SLBIE_C; /* user slbs have C=1 */
@@ -640,6 +676,7 @@ static long slb_insert_entry(unsigned long ea, unsigned long context,
 	 * User preloads should add isync afterwards in case the kernel
 	 * accesses user memory before it returns to userspace with rfid.
 	 */
+	assert_slb_notexists(ea);
 	asm volatile("slbmte %0, %1" : : "r" (vsid_data), "r" (esid_data));
 
 	barrier();
@@ -740,7 +777,17 @@ long do_slb_fault(struct pt_regs *regs, unsigned long ea)
 	 * if they go via fast_exception_return too.
 	 */
 	if (id >= KERNEL_REGION_ID) {
-		return slb_allocate_kernel(ea, id);
+		long err;
+#ifdef CONFIG_DEBUG_VM
+		/* Catch recursive kernel SLB faults. */
+		BUG_ON(local_paca->in_kernel_slb_handler);
+		local_paca->in_kernel_slb_handler = 1;
+#endif
+		err = slb_allocate_kernel(ea, id);
+#ifdef CONFIG_DEBUG_VM
+		local_paca->in_kernel_slb_handler = 0;
+#endif
+		return err;
 	} else {
 		struct mm_struct *mm = current->mm;
 		long err;
-- 
2.17.1

