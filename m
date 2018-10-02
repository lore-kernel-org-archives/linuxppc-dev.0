Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5C3C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:57:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BEDD20666
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/lkXH3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEDD20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Pj1l5ZtrzDqfy
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 00:57:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T/lkXH3S";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="T/lkXH3S"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PhMj41XDzF3HS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 00:28:17 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id p5-v6so1710852plk.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xabar2VATOwse3HlR0UpP67f4YJ7beAlC0bOS3eA+Ws=;
 b=T/lkXH3S4MoEBA6x5gb+dE9khyYHuhsA2u7mdizCDBH4zSz+u2FiS5SKhHhBD4OtrL
 zkjoj51zaMBiBqkqS+wH+CW/zGMjAS15YFJApDC0JH1lSUo7gJqi+uBwqTwd/zJHdBS6
 BrmvmWhPTgAGaIr6Kdd/7+LdXTJ6WZ4twiFgQdLYDJ4s+ZdQSYyqH1atWyE7EHQroyLu
 2S7DYc84rAtbl+BK2uTY0NBFbRxZzn0lmvMRNsYfbIzEV3j9F6gtQRkECptTSjv6LE4Y
 SpHLR7XlUdnh54UnRUFWE0n5/mvc8gimxXhDuFViyyPE6i6Q+QCEFlLGRjggjZ8NfDSR
 qEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xabar2VATOwse3HlR0UpP67f4YJ7beAlC0bOS3eA+Ws=;
 b=BhqqrcIyKTFp9O6YIkJr97t9Bs/qkG5atNjOjW5Ye+ha4FA8dxdcQdTqPl3dW1imF2
 gcgf4YBsEdLVLSHoEDk36zoT5keogwxW1K6/uS9gMAzMD44+HugQYFzMcaKANSSfKki+
 +coUqnwFGE9CL7M4RUSSHLLMF8cl4YSo01egX6K2fF1kUYKsP8ZfBJNlw7PLVpdC2qyK
 QojUextkE7IfPmyZ7byOl2CTZC3o1JFwaJU8knNwQD+GJ8ZQ5HK6nt0sMFynxVHP2ut9
 icLgKePFDCcv7vaSJjyP/l6ldWilrVc2qYzDC5fm0JUY9BI8exRaVh8VfIYDfM+PRssf
 WJLw==
X-Gm-Message-State: ABuFfoiZsXiWmCUhkqbC12ctg+9mzJ6TXHOz1wCe4sU4HMK0X9qrG3Ea
 LLkkv9uOFeos3z/+IFZknSEZ35gb
X-Google-Smtp-Source: ACcGV63mMO7+B10JWck5dHKzb8Ty9DuBdFGNNk++O/TeNn7/Wgt2D+HqVtdmTJUzrygwTjUDrwILew==
X-Received: by 2002:a63:9c01:: with SMTP id
 f1-v6mr14477523pge.156.1538490495543; 
 Tue, 02 Oct 2018 07:28:15 -0700 (PDT)
Received: from roar.local0.net (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id p3-v6sm21862621pfo.130.2018.10.02.07.28.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Oct 2018 07:28:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/9] powerpc/64s/hash: add more barriers for slb preloading
Date: Wed,  3 Oct 2018 00:27:55 +1000
Message-Id: <20181002142759.6244-6-npiggin@gmail.com>
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

In several places, more care has to be taken to prevent compiler or
CPU re-ordering of memory accesses into critical sections that must
not take SLB faults. Barriers are explained in the comments.

Fixes: 5e46e29e6a97 ("powerpc/64s/hash: convert SLB miss handlers to C")
Fixes: 89ca4e126a3f ("powerpc/64s/hash: Add a SLB preload cache")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slb.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index a5bd3c02d432..8c38659f1b6b 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -344,6 +344,9 @@ void slb_setup_new_exec(void)
 		if (preload_add(ti, mm->mmap_base))
 			slb_allocate_user(mm, mm->mmap_base);
 	}
+
+	/* see switch_slb */
+	asm volatile("isync" : : : "memory");
 }
 
 void preload_new_slb_context(unsigned long start, unsigned long sp)
@@ -373,6 +376,9 @@ void preload_new_slb_context(unsigned long start, unsigned long sp)
 		if (preload_add(ti, heap))
 			slb_allocate_user(mm, heap);
 	}
+
+	/* see switch_slb */
+	asm volatile("isync" : : : "memory");
 }
 
 
@@ -389,6 +395,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	 * which would update the slb_cache/slb_cache_ptr fields in the PACA.
 	 */
 	hard_irq_disable();
+	asm volatile("isync" : : : "memory");
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
 		/*
 		 * SLBIA IH=3 invalidates all Class=1 SLBEs and their
@@ -396,7 +403,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 		 * switch_slb wants. So ARCH_300 does not use the slb
 		 * cache.
 		 */
-		asm volatile("isync ; " PPC_SLBIA(3)" ; isync");
+		asm volatile(PPC_SLBIA(3));
 	} else {
 		unsigned long offset = get_paca()->slb_cache_ptr;
 
@@ -404,7 +411,6 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 		    offset <= SLB_CACHE_ENTRIES) {
 			unsigned long slbie_data = 0;
 
-			asm volatile("isync" : : : "memory");
 			for (i = 0; i < offset; i++) {
 				/* EA */
 				slbie_data = (unsigned long)
@@ -419,7 +425,6 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 			if (!cpu_has_feature(CPU_FTR_ARCH_207S) && offset == 1)
 				asm volatile("slbie %0" : : "r" (slbie_data));
 
-			asm volatile("isync" : : : "memory");
 		} else {
 			struct slb_shadow *p = get_slb_shadow();
 			unsigned long ksp_esid_data =
@@ -427,8 +432,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 			unsigned long ksp_vsid_data =
 				be64_to_cpu(p->save_area[KSTACK_INDEX].vsid);
 
-			asm volatile("isync\n"
-				     PPC_SLBIA(1) "\n"
+			asm volatile(PPC_SLBIA(1) "\n"
 				     "slbmte	%0,%1\n"
 				     "isync"
 				     :: "r"(ksp_vsid_data),
@@ -466,6 +470,13 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 
 		slb_allocate_user(mm, ea);
 	}
+
+	/*
+	 * Synchronize slbmte preloads with possible subsequent user memory
+	 * address accesses by the kernel (user mode won't happen until
+	 * rfid, which is safe).
+	 */
+	asm volatile("isync" : : : "memory");
 }
 
 void slb_set_size(u16 size)
@@ -609,6 +620,17 @@ static long slb_insert_entry(unsigned long ea, unsigned long context,
 	if (!vsid)
 		return -EFAULT;
 
+	/*
+	 * There must not be a kernel SLB fault in alloc_slb_index or before
+	 * slbmte here or the allocation bitmaps could get out of whack with
+	 * the SLB.
+	 *
+	 * User SLB faults or preloads take this path which might get inlined
+	 * into the caller, so add compiler barriers here to ensure unsafe
+	 * memory accesses do not come between
+	 */
+	barrier();
+
 	index = alloc_slb_index(kernel);
 
 	vsid_data = __mk_vsid_data(vsid, ssize, flags);
@@ -617,10 +639,13 @@ static long slb_insert_entry(unsigned long ea, unsigned long context,
 	/*
 	 * No need for an isync before or after this slbmte. The exception
 	 * we enter with and the rfid we exit with are context synchronizing.
-	 * Also we only handle user segments here.
+	 * User preloads should add isync afterwards in case the kernel
+	 * accesses user memory before it returns to userspace with rfid.
 	 */
 	asm volatile("slbmte %0, %1" : : "r" (vsid_data), "r" (esid_data));
 
+	barrier();
+
 	if (!kernel)
 		slb_cache_update(esid_data);
 
-- 
2.18.0

