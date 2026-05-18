Return-Path: <linuxppc-dev+bounces-21101-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23351CD4F52
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:50:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJs2N6Nrmz3bs5;
	Mon, 18 May 2026 18:50:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779094220;
	cv=none; b=gsUL/Vcm+aoheQ3zfq6HtjozjK2YheI9waRUDQiaaDyQOEgTA9TFWtD6S5P0c+wRS6lSmlT0oDY2qKbs8iRUSJV3mKvBaA3rc/kCrIy8/CIUeyhkG/V3/8NIHjnhyO/UmmRNxTY7NXqFbNahaT66EQMrjpTJg6WDGVqF0nTalgaLPP8qNMFi+CUspo+ns7n6YHYr5MXyO9BABEHqepMYNk4LtZv0wIuVC2vYNuEURgNkDhaWc21R1N8Bwnsija+4Bw2e9Bwt8sq3y27B5yerJ6i6f1KHAcXA4D390GQPtNkaUKf1IBCadPY+Qplutv+Rl4mYWSj0eTyv2wGDdfGHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779094220; c=relaxed/relaxed;
	bh=XZNjExq7H0YZ5/JkBFHk426Iyxdv38aH11enOzWM1m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkDubFGtW49O64kvTnGOUxKt+gpG0Qix6lgHoY5KL+iX2mIk5vKEVI0Bze5rbWr304h3mAl0UCzMzD/S+O8yFPxDwGE/9Esg39RraEIneuDidlt0PgFfesJuXBXH8Dkv+FjdiO8IbZIT+yrRgtKZ+Uh+PbgUxYMJz7/XQJFtusjcg6pK/juCQJj4LSQzpL54Mb6ekqmPTEToEwtCSQVTBSie3t635Run6Qh+kKU/C2xAyrSvbDCe5F4OVNzu2rL8V7zIR1iwrUwgTICTiV/n5W8vuKbcRLHGQLe/Y9jBQPva0AL6ru6MHfRwI4iXlBCNyv/qFcXwZ5+HzALFWXeGUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=v691m1nl; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=tianruidong@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=v691m1nl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=tianruidong@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJs2J09dPz3by8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:50:15 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779094212; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XZNjExq7H0YZ5/JkBFHk426Iyxdv38aH11enOzWM1m0=;
	b=v691m1nlFa3KOjQrATQJFVOEAwu2d5w6W/1D1ueAAucd4roplnrHWFwHa7Kt7s/yDxCq+5Xm22jqYInqkcSPwYZto8P3raSk+tjE2TeMsAHxjG/KthSJfrL/kC774USzFSRXBjt1D2oecR0+hTXLt15SEMigb4avI2/16YiQt0I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X3647KN_1779094209;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X3647KN_1779094209 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 16:50:10 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	rafael@kernel.org,
	tony.luck@intel.com,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	tongtiangen@huawei.com,
	james.morse@arm.com,
	robin.murphy@arm.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	tglx@linutronix.de,
	mingo@redhat.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v14 3/8] arm64: add support for ARCH_HAS_COPY_MC
Date: Mon, 18 May 2026 16:49:47 +0800
Message-ID: <20260518084956.2538442-4-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260518084956.2538442-1-tianruidong@linux.alibaba.com>
References: <20260518084956.2538442-1-tianruidong@linux.alibaba.com>
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

From: Tong Tiangen <tongtiangen@huawei.com>

For the arm64 kernel, when it processes hardware memory errors for
synchronize notifications(do_sea()), if the errors is consumed within the
kernel, the current processing is panic. However, it is not optimal.

Take copy_from/to_user for example, If ld* triggers a memory error, even in
kernel mode, only the associated process is affected. Killing the user
process and isolating the corrupt page is a better choice.

Add new fixup type EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR to identify insn
that can recover from memory errors triggered by access to kernel memory,
and this fixup type is used in __arch_copy_to_user(), This make the regular
copy_to_user() will handle kernel memory errors.

[Ruidong: handle EX_TYPE_UACCESS_CPY in fixup_exception_me()]

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/asm-extable.h | 22 +++++++++++++++++++-
 arch/arm64/include/asm/asm-uaccess.h |  4 ++++
 arch/arm64/include/asm/extable.h     |  1 +
 arch/arm64/lib/copy_to_user.S        | 10 +++++-----
 arch/arm64/mm/extable.c              | 21 +++++++++++++++++++
 arch/arm64/mm/fault.c                | 30 ++++++++++++++++++++--------
 7 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fe60738e5943..831b20d45893 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -21,6 +21,7 @@ config ARM64
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CC_PLATFORM
 	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
+	select ARCH_HAS_COPY_MC if ACPI_APEI_GHES
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index d67e2fdd1aee..4980023f2fbd 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -11,6 +11,8 @@
 #define EX_TYPE_KACCESS_ERR_ZERO	3
 #define EX_TYPE_UACCESS_CPY		4
 #define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	5
+/* kernel access memory error safe */
+#define EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR	6
 
 /* Data fields for EX_TYPE_UACCESS_ERR_ZERO */
 #define EX_DATA_REG_ERR_SHIFT	0
@@ -42,7 +44,7 @@
 	(.L__gpr_num_##gpr << EX_DATA_REG_##reg##_SHIFT)
 
 #define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
-	__ASM_EXTABLE_RAW(insn, fixup, 					\
+	__ASM_EXTABLE_RAW(insn, fixup,					\
 			  EX_TYPE_UACCESS_ERR_ZERO,			\
 			  (						\
 			    EX_DATA_REG(ERR, err) |			\
@@ -55,6 +57,17 @@
 #define _ASM_EXTABLE_UACCESS(insn, fixup)				\
 	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, wzr, wzr)
 
+#define _ASM_EXTABLE_KACCESS_ERR_ZERO_MEM_ERR(insn, fixup, err, zero)	\
+	__ASM_EXTABLE_RAW(insn, fixup,					\
+			  EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR,		\
+			  (						\
+			    EX_DATA_REG(ERR, err) |			\
+			    EX_DATA_REG(ZERO, zero)			\
+			  ))
+
+#define _ASM_EXTABLE_KACCESS_MEM_ERR(insn, fixup)			\
+	_ASM_EXTABLE_KACCESS_ERR_ZERO_MEM_ERR(insn, fixup, wzr, wzr)
+
 /*
  * Create an exception table entry for uaccess `insn`, which will branch to `fixup`
  * when an unhandled fault is taken.
@@ -76,6 +89,13 @@
 	.macro		_asm_extable_uaccess_cpy, insn, fixup, uaccess_is_write
 	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_UACCESS_CPY, \uaccess_is_write)
 	.endm
+/*
+ * Create an exception table entry for kaccess `insn`, which will branch to
+ * `fixup` when an unhandled fault is taken.
+ */
+	.macro          _asm_extable_kaccess_mem_err, insn, fixup
+	_ASM_EXTABLE_KACCESS_MEM_ERR(\insn, \fixup)
+	.endm
 
 #else /* __ASSEMBLER__ */
 
diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index 12aa6a283249..c8f0af5fde63 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -57,6 +57,10 @@ alternative_else_nop_endif
 	.endm
 #endif
 
+#define KERNEL_MEM_ERR(l, x...)			\
+9999:	x;					\
+	_asm_extable_kaccess_mem_err	9999b, l
+
 #define USER(l, x...)				\
 9999:	x;					\
 	_asm_extable_uaccess	9999b, l
diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
index 9dc39612bdf5..47c851d7df4f 100644
--- a/arch/arm64/include/asm/extable.h
+++ b/arch/arm64/include/asm/extable.h
@@ -48,4 +48,5 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
 #endif /* !CONFIG_BPF_JIT */
 
 bool fixup_exception(struct pt_regs *regs, unsigned long esr);
+bool fixup_exception_me(struct pt_regs *regs);
 #endif
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 819f2e3fc7a9..991d94ecc1a8 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -20,7 +20,7 @@
  *	x0 - bytes not copied
  */
 	.macro ldrb1 reg, ptr, val
-	ldrb  \reg, [\ptr], \val
+	KERNEL_MEM_ERR(9998f, ldrb  \reg, [\ptr], \val)
 	.endm
 
 	.macro strb1 reg, ptr, val
@@ -28,7 +28,7 @@
 	.endm
 
 	.macro ldrh1 reg, ptr, val
-	ldrh  \reg, [\ptr], \val
+	KERNEL_MEM_ERR(9998f, ldrh  \reg, [\ptr], \val)
 	.endm
 
 	.macro strh1 reg, ptr, val
@@ -36,7 +36,7 @@
 	.endm
 
 	.macro ldr1 reg, ptr, val
-	ldr \reg, [\ptr], \val
+	KERNEL_MEM_ERR(9998f, ldr \reg, [\ptr], \val)
 	.endm
 
 	.macro str1 reg, ptr, val
@@ -44,7 +44,7 @@
 	.endm
 
 	.macro ldp1 reg1, reg2, ptr, val
-	ldp \reg1, \reg2, [\ptr], \val
+	KERNEL_MEM_ERR(9998f, ldp \reg1, \reg2, [\ptr], \val)
 	.endm
 
 	.macro stp1 reg1, reg2, ptr, val
@@ -74,7 +74,7 @@ SYM_FUNC_START(__arch_copy_to_user)
 9997:	cmp	dst, dstin
 	b.ne	9998f
 	// Before being absolutely sure we couldn't copy anything, try harder
-	ldrb	tmp1w, [srcin]
+KERNEL_MEM_ERR(9998f, ldrb	tmp1w, [srcin])
 USER(9998f, sttrb tmp1w, [dst])
 	add	dst, dst, #1
 9998:	sub	x0, end, dst			// bytes not copied
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 6e0528831cd3..f78ac7e92845 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -110,7 +110,28 @@ bool fixup_exception(struct pt_regs *regs, unsigned long esr)
 		return ex_handler_uaccess_cpy(ex, regs, esr);
 	case EX_TYPE_LOAD_UNALIGNED_ZEROPAD:
 		return ex_handler_load_unaligned_zeropad(ex, regs);
+	case EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR:
+		return false;
 	}
 
 	BUG();
 }
+
+bool fixup_exception_me(struct pt_regs *regs)
+{
+	const struct exception_table_entry *ex;
+
+	ex = search_exception_tables(instruction_pointer(regs));
+	if (!ex)
+		return false;
+
+	switch (ex->type) {
+	case EX_TYPE_UACCESS_CPY:
+		return ex_handler_uaccess_cpy(ex, regs, 0);
+	case EX_TYPE_UACCESS_ERR_ZERO:
+	case EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR:
+		return ex_handler_uaccess_err_zero(ex, regs);
+	}
+
+	return false;
+}
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 0f3c5c7ca054..efbda54770be 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -858,21 +858,35 @@ static int do_bad(unsigned long far, unsigned long esr, struct pt_regs *regs)
 	return 1; /* "fault" */
 }
 
+/*
+ * APEI claimed this as a firmware-first notification.
+ * Some processing deferred to task_work before ret_to_user().
+ */
+static int do_apei_claim_sea(struct pt_regs *regs)
+{
+	int ret;
+
+	ret = apei_claim_sea(regs);
+	if (ret)
+		return ret;
+
+	if (!user_mode(regs) && IS_ENABLED(CONFIG_ARCH_HAS_COPY_MC)) {
+		if (!fixup_exception_me(regs))
+			return -ENOENT;
+	}
+
+	return ret;
+}
+
 static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
 {
 	const struct fault_info *inf;
 	unsigned long siaddr;
 
-	inf = esr_to_fault_info(esr);
-
-	if (user_mode(regs) && apei_claim_sea(regs) == 0) {
-		/*
-		 * APEI claimed this as a firmware-first notification.
-		 * Some processing deferred to task_work before ret_to_user().
-		 */
+	if (do_apei_claim_sea(regs) == 0)
 		return 0;
-	}
 
+	inf = esr_to_fault_info(esr);
 	if (esr & ESR_ELx_FnV) {
 		siaddr = 0;
 	} else {
-- 
2.39.3


