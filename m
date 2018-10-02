Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1892BC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 15:11:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D925206B2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 15:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQM8xoyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D925206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PjKm2YLJzF3Hf
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 01:11:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQM8xoyE";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQM8xoyE"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PhMv4lsXzF3HZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 00:28:27 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id w14-v6so1712318plp.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yyHuk6HR0OR9igmPeNIzCT5CKfRXqlg5ffA4560776Q=;
 b=UQM8xoyEyQ5ucmg88UaBLcOqUVWQI1KD+qfiqZOnSJix5eXnQTtPRFK7pPWZHEnrds
 OAkm0ZdHVZXdB6RHuzJb5JkyPgP+q+X5CeorrSlMhHqQtWglotrHR0fh2427akT5/YHu
 ppJ/m5w0wLp7IHpcuaqNFNEXqQos2/He8dk/t6A6gCBYKsMatzA7FyDFLSvzppjSr72E
 pdzt9D9L1l/r2z6hD5qj48XDpiWP58Do++d5rAyYGZ9QlqltS57GDfcS6ZsPsQyg6k7i
 CCO6zD+ab/XdOJAOYtlDok+114Dp05AIoH1T0e/Rj0s+hnlKqIBq/iDlWyeR3ICX9LmS
 7i5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yyHuk6HR0OR9igmPeNIzCT5CKfRXqlg5ffA4560776Q=;
 b=kv8/QeZLLaTGzWhEekQzvbCC0O9KJRIbod7LX6WJuWbdxCnw2HF9DKlUHEDPpK9bDN
 0r8JFEqxDj5nKcjUOhCR1+t96j0r13MKMoNoV8Ky61mCKt8pkAhkJf745EZMYuFSrfRY
 6Ai53SmQbGk2Qk4VDB9oruLzakagRHNESYIs8cjBYp6jXel09gyyKppyodgXQJckftnR
 l+w58W2dy6RM1IAn0xy3/eW4IP7MHqDva80UgflmXn9nyOtHyzeWTJBmtXmYWxYqgQmF
 ZfSJ396TT6XVt85s9oPC7ERwtbHlyXhUfGuSdBNhz2tH5QpcslRLaboyfRS6g05qh4Z1
 UzTw==
X-Gm-Message-State: ABuFfoghqxpAzHoY4vRfl1r2KbNfzrak1us1VqUoMqHCq2JPmixq3GV/
 gkJKOaIHPZMqbSipM8KdGD3iCOVl
X-Google-Smtp-Source: ACcGV60UcFNJFsvMCr9xlrC7JCLs2CFFg7E1vr8Hwusgd5u9h+soS9jWNoUKRWNgO3imhwIRDQt85w==
X-Received: by 2002:a17:902:9693:: with SMTP id
 n19-v6mr17181245plp.282.1538490505795; 
 Tue, 02 Oct 2018 07:28:25 -0700 (PDT)
Received: from roar.local0.net (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id p3-v6sm21862621pfo.130.2018.10.02.07.28.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Oct 2018 07:28:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 9/9] powerpc/64s/hash: add some slb debugging tests
Date: Wed,  3 Oct 2018 00:27:59 +1000
Message-Id: <20181002142759.6244-10-npiggin@gmail.com>
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

This adds CONFIG_DEBUG_VM checks to ensure:
- The kernel stack is in the SLB after it's flushed and bolted.
- We don't insert an SLB for an address that is aleady in the SLB.
- The kernel SLB miss handler does not take an SLB miss.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/paca.h |  3 ++
 arch/powerpc/mm/slb.c           | 53 +++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 4838149ee07b..2bfbd8811b72 100644
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
index e3c5280f43bd..703c344f6751 100644
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
2.18.0

