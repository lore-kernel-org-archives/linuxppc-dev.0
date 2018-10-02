Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928BDC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 15:09:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1FD206B2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 15:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqKESOvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1FD206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PjGs50VszF3FT
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 01:09:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZqKESOvX";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZqKESOvX"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PhMs1v54zF3G3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 00:28:25 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id v5-v6so1707022plz.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WxPY2zjrOixNRKmZFL1+zz2l+w3UxHKAd+eS6MKgwVc=;
 b=ZqKESOvXUMbo6k5pJuP0Ao8xHUrJuOledzZSvXi13oit9gm4oWd5lHSDaVfA8BMUz7
 X48MGN74MffZWizJeNlDVEYzyQr1dyaxc+iAORtxUBpUpPriSEOm4NUMAEU7BOUQktJW
 irJL7kBVLN5h9Wcdxj7DM4M/oY0I+UeqqJ7Mr6n9HotnTHCoHUdF19rgZQ1M7DbYUJLl
 UOp8BRGJO3m9PMQC06+WBtaqR9FzJnPnu91mem/i9NJZL3owlC5q/xIlVaHQEI/pVIbX
 DwSI+xh76a4lLYjcqHWTDtc3VjRIYQCstfdGKWJVXnMNwxktFBDBIuHEIPvtk8v6dWmy
 1tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WxPY2zjrOixNRKmZFL1+zz2l+w3UxHKAd+eS6MKgwVc=;
 b=BUqRKwGn7IfM7TsX/oAWQQ62su0frETptIz20/DpJ6FPg1xafsZqP7NY4e+bjAZSz9
 6EwWz8Revjj4/v3Ed4P1VCJLXRbqrr27Dx3PgfrmxGDipHT/bhuE8q72YWZ4xR8co1Hu
 8/8ItbinO7wmeNZGman/e97vxC2UGNPUFmca97LhsSdXPq/OD5/MWdidvslLYWsyAO5Y
 U8xZf3aMYpsrN0Hp8VsPSHTM/+xv68sqHYmhFhc+BrsBvRnM/KHmrBklvd7eizxsrUoP
 3Iry4q8E7m/XylIACY7MdfN9lOWS10t6YvFpK8PV4Bcf3EU5rw0OxO2Y7Xy6LFwDZRkQ
 VDrA==
X-Gm-Message-State: ABuFfohzssXADqUY50PEroppzOVRg7l+h86RO/HtNPGSHHJP6YaVhW5o
 40xdou4eDaw7Yej8Ho/Z3DU4hAru
X-Google-Smtp-Source: ACcGV60mwF3JtjZI/yosilxqtezdWZSilRccJVCN5vNjGY88IE9iiE9s24BBb5zv5LPSq5ES+Ibd+Q==
X-Received: by 2002:a62:85cb:: with SMTP id
 m72-v6mr16709454pfk.173.1538490503223; 
 Tue, 02 Oct 2018 07:28:23 -0700 (PDT)
Received: from roar.local0.net (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id p3-v6sm21862621pfo.130.2018.10.02.07.28.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Oct 2018 07:28:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 8/9] powerpc/64s/hash: slb_flush_and_rebolt simplify
Date: Wed,  3 Oct 2018 00:27:58 +1000
Message-Id: <20181002142759.6244-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181002142759.6244-1-npiggin@gmail.com>
References: <20181002142759.6244-1-npiggin@gmail.com>
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

slb_flush_and_rebolt is misleading, it is called in virtual mode, so
it can not possibly change the stack, so it should not be touching the
shadow area. And since vmalloc is no longer bolted, it should not
change any bolted mappings at all.

Change the name to slb_flush_and_restore_bolted, and have it just load
the kernel stack from what's currently in the shadow SLB area.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
 arch/powerpc/kernel/swsusp_asm64.S            |  2 +-
 arch/powerpc/mm/hash_utils_64.c               |  4 +-
 arch/powerpc/mm/slb.c                         | 46 +++++++------------
 arch/powerpc/mm/slice.c                       |  2 +-
 5 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 14e552ea5e52..60cda8fb0677 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -503,7 +503,7 @@ struct slb_entry {
 };
 
 extern void slb_initialize(void);
-extern void slb_flush_and_rebolt(void);
+void slb_flush_and_restore_bolted(void);
 void slb_flush_all_realmode(void);
 void __slb_restore_bolted_realmode(void);
 void slb_restore_bolted_realmode(void);
diff --git a/arch/powerpc/kernel/swsusp_asm64.S b/arch/powerpc/kernel/swsusp_asm64.S
index f83bf6f72cb0..185216becb8b 100644
--- a/arch/powerpc/kernel/swsusp_asm64.S
+++ b/arch/powerpc/kernel/swsusp_asm64.S
@@ -262,7 +262,7 @@ END_FW_FTR_SECTION_IFCLR(FW_FEATURE_LPAR)
 
 	addi	r1,r1,-128
 #ifdef CONFIG_PPC_BOOK3S_64
-	bl	slb_flush_and_rebolt
+	bl	slb_flush_and_restore_bolted
 #endif
 	bl	do_after_copyback
 	addi	r1,r1,128
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f23a89d8e4ce..974d0332e1d8 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1125,7 +1125,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
 	if ((get_paca_psize(addr) != MMU_PAGE_4K) && (current->mm == mm)) {
 
 		copy_mm_to_paca(mm);
-		slb_flush_and_rebolt();
+		slb_flush_and_restore_bolted();
 	}
 }
 #endif /* CONFIG_PPC_64K_PAGES */
@@ -1197,7 +1197,7 @@ static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
 	if (user_region) {
 		if (psize != get_paca_psize(ea)) {
 			copy_mm_to_paca(mm);
-			slb_flush_and_rebolt();
+			slb_flush_and_restore_bolted();
 		}
 	} else if (get_paca()->vmalloc_sllp !=
 		   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index c273d0baf4fc..e3c5280f43bd 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -115,8 +115,6 @@ void __slb_restore_bolted_realmode(void)
 
 /*
  * Insert the bolted entries into an empty SLB.
- * This is not the same as rebolt because the bolted segments are not
- * changed, just loaded from the shadow area.
  */
 void slb_restore_bolted_realmode(void)
 {
@@ -135,12 +133,15 @@ void slb_flush_all_realmode(void)
 	asm volatile("slbmte %0,%0; slbia" : : "r" (0));
 }
 
-void slb_flush_and_rebolt(void)
+/*
+ * This flushes non-bolted entries, it can be run in virtual mode. Must
+ * be called with interrupts disabled.
+ */
+void slb_flush_and_restore_bolted(void)
 {
-	/* If you change this make sure you change SLB_NUM_BOLTED
-	 * and PR KVM appropriately too. */
-	unsigned long linear_llp, lflags;
-	unsigned long ksp_esid_data, ksp_vsid_data;
+	struct slb_shadow *p = get_slb_shadow();
+
+	BUILD_BUG_ON(SLB_NUM_BOLTED != 2);
 
 	WARN_ON(!irqs_disabled());
 
@@ -150,30 +151,12 @@ void slb_flush_and_rebolt(void)
 	 */
 	hard_irq_disable();
 
-	linear_llp = mmu_psize_defs[mmu_linear_psize].sllp;
-	lflags = SLB_VSID_KERNEL | linear_llp;
-
-	ksp_esid_data = mk_esid_data(get_paca()->kstack, mmu_kernel_ssize, KSTACK_INDEX);
-	if ((ksp_esid_data & ~0xfffffffUL) <= PAGE_OFFSET) {
-		ksp_esid_data &= ~SLB_ESID_V;
-		ksp_vsid_data = 0;
-		slb_shadow_clear(KSTACK_INDEX);
-	} else {
-		/* Update stack entry; others don't change */
-		slb_shadow_update(get_paca()->kstack, mmu_kernel_ssize, lflags, KSTACK_INDEX);
-		ksp_vsid_data =
-			be64_to_cpu(get_slb_shadow()->save_area[KSTACK_INDEX].vsid);
-	}
-
-	/* We need to do this all in asm, so we're sure we don't touch
-	 * the stack between the slbia and rebolting it. */
 	asm volatile("isync\n"
 		     "slbia\n"
-		     /* Slot 1 - kernel stack */
-		     "slbmte	%0,%1\n"
-		     "isync"
-		     :: "r"(ksp_vsid_data),
-		        "r"(ksp_esid_data)
+		     "slbmte  %0, %1\n"
+		     "isync\n"
+		     :: "r" (be64_to_cpu(p->save_area[KSTACK_INDEX].vsid)),
+			"r" (be64_to_cpu(p->save_area[KSTACK_INDEX].esid))
 		     : "memory");
 
 	get_paca()->slb_cache_ptr = 0;
@@ -254,7 +237,10 @@ void slb_dump_contents(struct slb_entry *slb_ptr)
 
 void slb_vmalloc_update(void)
 {
-	slb_flush_and_rebolt();
+	/*
+	 * vmalloc is not bolted, so just have to flush non-bolted.
+	 */
+	slb_flush_and_restore_bolted();
 }
 
 static bool preload_hit(struct thread_info *ti, unsigned long esid)
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 546dd07c8083..50ba3d0456a5 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -219,7 +219,7 @@ static void slice_flush_segments(void *parm)
 	copy_mm_to_paca(current->active_mm);
 
 	local_irq_save(flags);
-	slb_flush_and_rebolt();
+	slb_flush_and_restore_bolted();
 	local_irq_restore(flags);
 #endif
 }
-- 
2.18.0

