Return-Path: <linuxppc-dev+bounces-22765-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C2BCD98E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 09:22:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggwGW5RhDz2ysb;
	Thu, 18 Jun 2026 19:21:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781774515;
	cv=none; b=amuPEFDhZPzMT/cTLW8QRpP5cEySNYt/BmIrsSGu/DU0vh8Hq3aH45XpqAAcGIKrZ7m4+T/fASsc3PoyVrOzJ1RSU/KUEw/YzxpWrAVwiZKgfaUsrMFn2dljYpYoE1mwwhAalWuumUdaJY2my7IqjoQntqTE36LBN7PO0z3ALcBGizZHkO4uVxuC72jDIBAPIEnJJOyKj0TjssJNTHhDb24pGkfGE1DdTtKI677ydTiGhF22Ad+Bat0yeHyMwTLdVcZmHt4zrh6UZlxoTxE5prkDvgEMifpkR+RUnfJi47QAMlOL4cLS4mXNVAps+TyNJ0rIfSPyt2T/dAiEjCCBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781774515; c=relaxed/relaxed;
	bh=tou+gUoWEZe2fvebXTjOCap3tZyiNjWgYvWq5vHGM5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7vfxuJka72su554nzKrkDigrQpgfmeumuDB9uCvaip8uxJ+lP3YBU07pyCYa8bvzQt82bB5F3V5F0ylhgbY/YLuaFrE7pnbCJRWVK81HfYno42T6+T1QUj5zV8Jpoji0iB89IvClcR8ejj9nXXU4dDvvGzqTnmxu0dKmPxhJ9lK9qqq2mP16QdCZEy7bnZAioMSHIQvKjl02DEJ74OUcFq+nBZFctBR64EzDOX8MBFROP/ycuo9q3pYKLK3dmvsZJxgXIHjzUzmIdinlGcPeP29fSGZrZuOlNFWTgqOJtCkVrVe4B5cTGBsgwmEfDR6FnRfWEOawPK02143oaYDrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MD2lNJp1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=tianruidong@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MD2lNJp1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=tianruidong@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggwGV4VFzz2yNn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 19:21:54 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781774510; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tou+gUoWEZe2fvebXTjOCap3tZyiNjWgYvWq5vHGM5w=;
	b=MD2lNJp1vV6Shs41I1uQQrgEY57rNCTHvC7UABOAYSyRYEXj57Jn9T9gUyYhNKm9W3lpOte+ZcSnrULJFTJC8SGb8NTP92KUkumJQdHkIOxyTOU8wER5Q6KCnIKlQeBn3LbHqqIUYmuDKftlmSSdEunLYPzaEq/+NVWEAkpCfBs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X56UStd_1781774505;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X56UStd_1781774505 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 17:21:48 +0800
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
Subject: [PATCH v15 3/9] arm64: extable: merge UACCESS_ERR_ZERO and KACCESS_ERR_ZERO into ACCESS_ERR_ZERO
Date: Thu, 18 Jun 2026 17:21:17 +0800
Message-ID: <20260618092124.3901230-4-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260618092124.3901230-1-tianruidong@linux.alibaba.com>
References: <20260618092124.3901230-1-tianruidong@linux.alibaba.com>
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

EX_TYPE_UACCESS_ERR_ZERO and EX_TYPE_KACCESS_ERR_ZERO have identical
handling in fixup_exception(): both unconditionally invoke
ex_handler_uaccess_err_zero() to set the error register to -EFAULT,
zero the destination register, and branch to the fixup address.

Merge them into a single EX_TYPE_ACCESS_ERR_ZERO to reduce redundancy
and renumber the subsequent types accordingly.

The _ASM_EXTABLE_UACCESS_ERR_ZERO and _ASM_EXTABLE_KACCESS_ERR_ZERO
helper macros are preserved as-is for caller readability, but both now
emit the unified EX_TYPE_ACCESS_ERR_ZERO type.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 arch/arm64/include/asm/asm-extable.h | 15 +++++++--------
 arch/arm64/mm/extable.c              |  7 +++----
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index d67e2fdd1aee..06b19023939b 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -7,12 +7,11 @@
 
 #define EX_TYPE_NONE			0
 #define EX_TYPE_BPF			1
-#define EX_TYPE_UACCESS_ERR_ZERO	2
-#define EX_TYPE_KACCESS_ERR_ZERO	3
-#define EX_TYPE_UACCESS_CPY		4
-#define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	5
+#define EX_TYPE_ACCESS_ERR_ZERO		2
+#define EX_TYPE_UACCESS_CPY		3
+#define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	4
 
-/* Data fields for EX_TYPE_UACCESS_ERR_ZERO */
+/* Data fields for EX_TYPE_ACCESS_ERR_ZERO */
 #define EX_DATA_REG_ERR_SHIFT	0
 #define EX_DATA_REG_ERR		GENMASK(4, 0)
 #define EX_DATA_REG_ZERO_SHIFT	5
@@ -43,7 +42,7 @@
 
 #define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
 	__ASM_EXTABLE_RAW(insn, fixup, 					\
-			  EX_TYPE_UACCESS_ERR_ZERO,			\
+			  EX_TYPE_ACCESS_ERR_ZERO,			\
 			  (						\
 			    EX_DATA_REG(ERR, err) |			\
 			    EX_DATA_REG(ZERO, zero)			\
@@ -96,7 +95,7 @@
 #define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
 	__DEFINE_ASM_GPR_NUMS						\
 	__ASM_EXTABLE_RAW(#insn, #fixup, 				\
-			  __stringify(EX_TYPE_UACCESS_ERR_ZERO),	\
+			  __stringify(EX_TYPE_ACCESS_ERR_ZERO),	\
 			  "("						\
 			    EX_DATA_REG(ERR, err) " | "			\
 			    EX_DATA_REG(ZERO, zero)			\
@@ -105,7 +104,7 @@
 #define _ASM_EXTABLE_KACCESS_ERR_ZERO(insn, fixup, err, zero)		\
 	__DEFINE_ASM_GPR_NUMS						\
 	__ASM_EXTABLE_RAW(#insn, #fixup, 				\
-			  __stringify(EX_TYPE_KACCESS_ERR_ZERO),	\
+			  __stringify(EX_TYPE_ACCESS_ERR_ZERO),	\
 			  "("						\
 			    EX_DATA_REG(ERR, err) " | "			\
 			    EX_DATA_REG(ZERO, zero)			\
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 6e0528831cd3..76b18780f1f9 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -41,7 +41,7 @@ get_ex_fixup(const struct exception_table_entry *ex)
 	return ((unsigned long)&ex->fixup + ex->fixup);
 }
 
-static bool ex_handler_uaccess_err_zero(const struct exception_table_entry *ex,
+static bool ex_handler_access_err_zero(const struct exception_table_entry *ex,
 					struct pt_regs *regs)
 {
 	int reg_err = FIELD_GET(EX_DATA_REG_ERR, ex->data);
@@ -103,9 +103,8 @@ bool fixup_exception(struct pt_regs *regs, unsigned long esr)
 	switch (ex->type) {
 	case EX_TYPE_BPF:
 		return ex_handler_bpf(ex, regs);
-	case EX_TYPE_UACCESS_ERR_ZERO:
-	case EX_TYPE_KACCESS_ERR_ZERO:
-		return ex_handler_uaccess_err_zero(ex, regs);
+	case EX_TYPE_ACCESS_ERR_ZERO:
+		return ex_handler_access_err_zero(ex, regs);
 	case EX_TYPE_UACCESS_CPY:
 		return ex_handler_uaccess_cpy(ex, regs, esr);
 	case EX_TYPE_LOAD_UNALIGNED_ZEROPAD:
-- 
2.39.3


