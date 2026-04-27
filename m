Return-Path: <linuxppc-dev+bounces-20162-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ACAFF885E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 12:28:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g42sx6Cw8z2yjm;
	Mon, 27 Apr 2026 22:28:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777292917;
	cv=none; b=ML6y80jfghT2RDyUVoKCUS9qnMjW6KrCshQBn0tHa/3VtSLsVfKbhv0yWrbwQJIRu3eTpAFn+7YO7MfWz9aGQP4i8P+zzwcA4QHFngWvOXWvzlTg93/VKqwBhfy7qjG3/6jVISuy+z0L3m13KSuJq7ZPzV/pkQuBa7Wya6yZLPHKfR/nDFq+3x4UcJ6JMSB3LRVxSPreVXir5LI1cSue7fb41GqkeevSc1VRiX09sRBS8uSGOdbT1JBZiW66ZVnJ40Ta4GMreA9+V4iwhBlKPgPrAgw9oHs2XtEKpRe6eJ+4fJvwrLqZgDtKf87qdWv4Qg56alFstjefS9Aus32vyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777292917; c=relaxed/relaxed;
	bh=raVDKr4Vko7RlTRFhwZDaBEgYPbFcEnfldAQ2J2hXNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcR8GUpStSZAwGBEX8N5QZFZPY/+jHzemtbfq5kgdRGcPGvJ2XPX6O75Fs1YLE/FiJYC1563u79E3VvD8DKcZKZp/WESQUocdD7IL+Htpf0uvtX48UZEryrhcPLAevHFIbfNcXcLK4ncdK/owMcUWwt7sitLpdGN5Thvd3lFosr+EAVd9sGRp+lnYMOvyLmfjvVzah9H6wN+kzWYDVDABjCgeWieqC8EN0s1zs14nxzR3GnezrhLlRmNDd2aAAqn0CimyQvgVlj63O9AUVjXrxvA8XTVFN5QUJr4VusqpCxWeCgf9tZI/Rle8fQ4tez1sRkpIEI9JUYjEo5nAeni+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pgdIkCMj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pgdIkCMj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g42sx1175z2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 22:28:37 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-83177129e28so1713828b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 05:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777292915; x=1777897715; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raVDKr4Vko7RlTRFhwZDaBEgYPbFcEnfldAQ2J2hXNQ=;
        b=pgdIkCMjG9fd9k9LSWzd1WD9u16Gl2ebhP7KNw8kOPsh9TmHyUMVfAkPPhBiyFcmfV
         bWq4xMHbwKQ6JjYnstqDvWRU73ylZY/BK5NwhEsw7gkU37MVr5EM/2Q/7IJmRK7fS5n8
         /rh+WPtMOaL/tso5AplCwzQyIz1VK1gBuDzahDvkc4j9EtXFtbu4/MRjOYq8Ulss5+MV
         VI1FXRZEdbtaU1izEZXKp2JpuCuImgQV8xjUe4U5u+CibrTalRuRDKR+OQLZjI7j/x8y
         dhZ1UQZuF4EfwgfuyQJ4Q3JiLpkHj7Mk7DTp/EQY7SU4wYDEE9R4Raly4pC2xLwIsh/B
         U3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777292915; x=1777897715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=raVDKr4Vko7RlTRFhwZDaBEgYPbFcEnfldAQ2J2hXNQ=;
        b=cbak825qdI0C6GuNZKIjNgv4bcr2Xc56MS20PEwnM1dP5cv9RmxzlnYpY/xAtp21Cl
         jiYhotPO07WRe7LKpwOnobQvxV9ZZe+E7wclLoiUJIfPnQsWTXLpwNmdooGzHra4qd+I
         Xa9XyaUSwYJ6D+UEzQbItM1oe3vFCrrGquM9DQMVpczd1/0FjwbvLZfcRkt7pECX21eB
         Mv+tFqN+bndxSr68H10jH4Aga7jR3K9DiSfVLi0Rm2MujM9c9lIA4ascPQOlsTQQwuCV
         PrCzm4AYOkhZUoN+8NVD1ejf78t324oVXaXRbrNb9mRkft7K5A0ipR8bovT9Fy742UDk
         kZnw==
X-Forwarded-Encrypted: i=1; AFNElJ+xqxW1bqQXrmLe1sXj7qemsFM91tX+DDFZKgLEXl5zRrPhVcXQQLfAYc62TzQXb3qknDt4NIdNBS7gqMI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzM4Q/OyEvC+hI7SsLitiU+BXTSsJBmGp61liccQLHt6zPwt90V
	89mZQLZV0ZnjFTftQo70/CO7Q4DlePBTCBaMBVNTf/vPu2+e2NKmR1kA
X-Gm-Gg: AeBDietXGUvF/hL8D1yM+g1mHnrl7b2N9L7QNG2hovwltYZTw+7GPefpn55r3moqBBe
	k8tCdYbsGc+Zsu495Z/5CWcloM7e7Y3OQQUOuGaFPqVqAi0LcUqQ3ZqsoIC4i3TxGquc00uroJ+
	CcqnqIDggDegSWu0HUHgQR1DtX2toEOZ4FBbq711zja8E14+8Va+reo9wKqSOMS+NetRvtkBXa2
	AR4qwHL6gSzKGoI0RCRPKI3OycjXdi1qa2lYYecY3gpv2O0/Tq9mKNgNAeWvc5RzFLa6NqaLyZ7
	e+UdX0kyCanrmTEKGd4paU8JFGf/tKFkc3qv9hQxhMa/XbwiTPGKvdlNsitWbDKM9+Mt+SM58IP
	eXwQmuoVD21S1Ni+oZhxDi3pDECP7WKkfOzSf6xHYtmy3YVComwfiLP+L8FPjtf4ADu8xKoHfI2
	io3Po+ov/hqP6szKpkU75wyGyDcihgN5Ujd8Lhk6m29ezs0HMsRrRFiwQoKZbxoTxcAgdnXKBUU
	XWC2hLxDdCf2Fy0
X-Received: by 2002:a05:6a00:4214:b0:81f:3fbd:ccf with SMTP id d2e1a72fcca58-82f8c8bcc27mr42452795b3a.23.1777292915109;
        Mon, 27 Apr 2026 05:28:35 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9f7735sm32733466b3a.21.2026.04.27.05.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:28:34 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	oleg@redhat.com,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	mchauras@linux.ibm.com,
	sshegde@linux.ibm.com,
	thuth@redhat.com,
	ruanjinjie@huawei.com,
	akpm@linux-foundation.org,
	macro@orcam.me.uk,
	ldv@strace.io,
	charlie@rivosinc.com,
	deller@gmx.de,
	kevin.brodsky@arm.com,
	ritesh.list@gmail.com,
	yeoreum.yun@arm.com,
	agordeev@linux.ibm.com,
	segher@kernel.crashing.org,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	pmladek@suse.com,
	feng.tang@linux.alibaba.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com
Cc: Samir M <samir@linux.ibm.com>,
	David Gow <davidgow@google.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v5 3/8] powerpc: introduce arch_enter_from_user_mode
Date: Mon, 27 Apr 2026 17:57:37 +0530
Message-ID: <20260427122742.210074-4-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427122742.210074-1-mkchauras@gmail.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>

Implement the arch_enter_from_user_mode() hook required by the generic
entry/exit framework. This helper prepares the CPU state when entering
the kernel from userspace, ensuring correct handling of KUAP/KUEP,
transactional memory, and debug register state.

This patch contains no functional changes, it is purely preparatory for
enabling the generic syscall and interrupt entry path on PowerPC.

Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Tested-by: Samir M <samir@linux.ibm.com>
Tested-by: David Gow <davidgow@google.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/include/asm/entry-common.h | 118 ++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index 05ce0583b600..837a7e020e82 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -3,6 +3,124 @@
 #ifndef _ASM_PPC_ENTRY_COMMON_H
 #define _ASM_PPC_ENTRY_COMMON_H
 
+#include <asm/cputime.h>
+#include <asm/interrupt.h>
 #include <asm/stacktrace.h>
+#include <asm/tm.h>
+
+static __always_inline void booke_load_dbcr0(void)
+{
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
+	unsigned long dbcr0 = current->thread.debug.dbcr0;
+
+	if (likely(!(dbcr0 & DBCR0_IDM)))
+		return;
+
+	/*
+	 * Check to see if the dbcr0 register is set up to debug.
+	 * Use the internal debug mode bit to do this.
+	 */
+	mtmsr(mfmsr() & ~MSR_DE);
+	if (IS_ENABLED(CONFIG_PPC32)) {
+		isync();
+		global_dbcr0[smp_processor_id()] = mfspr(SPRN_DBCR0);
+	}
+	mtspr(SPRN_DBCR0, dbcr0);
+	mtspr(SPRN_DBSR, -1);
+#endif
+}
+
+static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
+{
+	kuap_lock();
+
+	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
+		BUG_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
+
+	BUG_ON(regs_is_unrecoverable(regs));
+	BUG_ON(!user_mode(regs));
+	BUG_ON(regs_irqs_disabled(regs));
+
+#ifdef CONFIG_PPC_PKEY
+	if (mmu_has_feature(MMU_FTR_PKEY) && trap_is_syscall(regs)) {
+		unsigned long amr, iamr;
+		bool flush_needed = false;
+		/*
+		 * When entering from userspace we mostly have the AMR/IAMR
+		 * different from kernel default values. Hence don't compare.
+		 */
+		amr = mfspr(SPRN_AMR);
+		iamr = mfspr(SPRN_IAMR);
+		regs->amr  = amr;
+		regs->iamr = iamr;
+		if (mmu_has_feature(MMU_FTR_KUAP)) {
+			mtspr(SPRN_AMR, AMR_KUAP_BLOCKED);
+			flush_needed = true;
+		}
+		if (mmu_has_feature(MMU_FTR_BOOK3S_KUEP)) {
+			mtspr(SPRN_IAMR, AMR_KUEP_BLOCKED);
+			flush_needed = true;
+		}
+		if (flush_needed)
+			isync();
+	}
+#endif
+	kuap_assert_locked();
+	booke_restore_dbcr0();
+	account_cpu_user_entry();
+	account_stolen_time();
+
+	/*
+	 * This is not required for the syscall exit path, but makes the
+	 * stack frame look nicer. If this was initialised in the first stack
+	 * frame, or if the unwinder was taught the first stack frame always
+	 * returns to user with IRQS_ENABLED, this store could be avoided!
+	 */
+	irq_soft_mask_regs_set_state(regs, IRQS_ENABLED);
+
+	/*
+	 * If system call is called with TM active, set _TIF_RESTOREALL to
+	 * prevent RFSCV being used to return to userspace, because POWER9
+	 * TM implementation has problems with this instruction returning to
+	 * transactional state. Final register values are not relevant because
+	 * the transaction will be aborted upon return anyway. Or in the case
+	 * of unsupported_scv SIGILL fault, the return state does not much
+	 * matter because it's an edge case.
+	 */
+	if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
+	    unlikely(MSR_TM_TRANSACTIONAL(regs->msr)))
+		set_bits(_TIF_RESTOREALL, &current_thread_info()->flags);
+
+	/*
+	 * If the system call was made with a transaction active, doom it and
+	 * return without performing the system call. Unless it was an
+	 * unsupported scv vector, in which case it's treated like an illegal
+	 * instruction.
+	 */
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (unlikely(MSR_TM_TRANSACTIONAL(regs->msr)) &&
+	    !trap_is_unsupported_scv(regs)) {
+		/* Enable TM in the kernel, and disable EE (for scv) */
+		hard_irq_disable();
+		mtmsr(mfmsr() | MSR_TM);
+
+		/* tabort, this dooms the transaction, nothing else */
+		asm volatile(".long 0x7c00071d | ((%0) << 16)"
+			     :: "r"(TM_CAUSE_SYSCALL | TM_CAUSE_PERSISTENT));
+
+		/*
+		 * Userspace will never see the return value. Execution will
+		 * resume after the tbegin. of the aborted transaction with the
+		 * checkpointed register state. A context switch could occur
+		 * or signal delivered to the process before resuming the
+		 * doomed transaction context, but that should all be handled
+		 * as expected.
+		 */
+		return;
+	}
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+}
+
+#define arch_enter_from_user_mode arch_enter_from_user_mode
 
 #endif /* _ASM_PPC_ENTRY_COMMON_H */
-- 
2.53.0


