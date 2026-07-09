Return-Path: <linuxppc-dev+bounces-23908-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E79C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 07:28:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwmlT18y0z3c9w;
	Thu, 09 Jul 2026 17:28:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783582085;
	cv=none; b=esL5eCn1k5pMJozF/RqCwKLNyEqj0FZrhvm0MozQ5WbxNOl2wjeBcJt3yRIR4EJ7BmI5/Z6cSNdBH1AX6BBiCgXNG5v0PwRxk03KrYXdGu1+8bd2LqLHee40abZPdbuFQQRUH0UyftDvzLdirLheC3cZWoftEZVxfaQ8qCiBmGdyqMpQqXr+Q0RgtUdjnz94m440o77URnEsPgZWWS1aRJQgVSYhu1tHX8bGt8O/YOJaZuTbD416JQLW0g+6FkCB3Wva8Megwx4mlZZ8w4GE+qLQWnm7si2o10GfOibDSvxCgJD8+PX/GR+ltoSbe/ScCNeXYZck91XTOWETGupQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783582085; c=relaxed/relaxed;
	bh=+d8+hXbp8vZoFm5ME6uj8LWk7bRuSPPZwP0vsJH0Xoc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i/hNUZPZbZ/J+KrZRkPICJVJqU0PYpa48VwLioS0VD8OPRMPX6pBjRTD/BMesaDeIInQJKM82fK6imoKZcVaeA7BXpPBpO0hELU2/sQ7QfOASz6/3s+u0z9A49834z8KM10tKXIkcdchPoLGRpfCzlRg9mWVZgY4wilCs429BirNkpTTUA9RKk/HzC6OCe4FGsFvucooK6G+AaxsFXP/G1J6RW/Vloon7hlX/EOpZVZa4DxSOCT+jHMbUCmcWhI44HgeEZdih00bF2omdJCSMEpsnqwqRCg4aUQQY+orJqrTa86s6akUNHOOwLFENthfjk8an5JeTqYPE9FNd6o+6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=m5+EHwbd; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=m5+EHwbd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwmlQ3Z8tz3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 17:27:59 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+d8+hXbp8vZoFm5ME6uj8LWk7bRuSPPZwP0vsJH0Xoc=;
	b=m5+EHwbdqX4zMx4HWe3w4vFomb7O6mvMNVQ4OW6SQl7xhblwN3y1cSjYkfCctkvX3B9vPfkzv
	EKkzZYLkWAmKN+eCt0bQy9mYL0Np6EP0Usfh7tRd6ELvNyP9gDfyWdZK1Hpei8NTdoaTTig58r/
	PddtkWbymG7ljm2zZIA+aCA=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gwmXZ2J8yz1prKZ;
	Thu,  9 Jul 2026 15:18:38 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E098640537;
	Thu,  9 Jul 2026 15:27:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Jul
 2026 15:27:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
	<agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <nathan@kernel.org>,
	<kees@kernel.org>, <xur@google.com>, <peterz@infradead.org>,
	<gourry@gourry.net>, <lukas.bulwahn@redhat.com>, <ryan.roberts@arm.com>,
	<ruanjinjie@huawei.com>, <yangtiezhu@loongson.cn>, <sshegde@linux.ibm.com>,
	<mchauras@linux.ibm.com>, <austin.kim@lge.com>, <arnd@arndb.de>,
	<jchrist@linux.ibm.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>
Subject: [PATCH] syscall_user_dispatch: Introduce ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
Date: Thu, 9 Jul 2026 15:28:03 +0800
Message-ID: <20260709072803.3843948-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Currently, only x86 genuinely implements and supports Syscall User
Dispatch (SUD). Multiple architectures provide a stub
arch_syscall_is_vdso_sigreturn() returning 'false' simply to satisfy
GENERIC_ENTRY compilation, which creates a false impression of feature
support.

Introduce ARCH_SUPPORTS_SYSCALL_USER_DISPATCH to decouple this mechanism
from GENERIC_ENTRY. Select it exclusively on x86 and remove the redundant
stub functions from other architectures.

Link: https://lore.kernel.org/linux-arm-kernel/akZgV0Y4YAmB43_g@J2N7QTR9R3.cambridge.arm.com/
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/Kconfig                         | 1 +
 arch/loongarch/include/asm/syscall.h | 6 ------
 arch/powerpc/include/asm/syscall.h   | 5 -----
 arch/riscv/include/asm/syscall.h     | 5 -----
 arch/s390/include/asm/syscall.h      | 5 -----
 arch/x86/Kconfig                     | 1 +
 6 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 0c01521c2f3f..393d0fb75eac 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -116,6 +116,7 @@ config GENERIC_ENTRY
 
 config SYSCALL_USER_DISPATCH
 	bool "Syscall User Dispatch"
+	depends on ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
 	depends on GENERIC_ENTRY
 	default y
 	help
diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/include/asm/syscall.h
index df8ea223c77b..d9275010f548 100644
--- a/arch/loongarch/include/asm/syscall.h
+++ b/arch/loongarch/include/asm/syscall.h
@@ -84,10 +84,4 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_LOONGARCH64;
 #endif
 }
-
-static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
-{
-	return false;
-}
-
 #endif	/* __ASM_LOONGARCH_SYSCALL_H */
diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index 834fcc4f7b54..4b3c52ed6e9d 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -139,9 +139,4 @@ static inline int syscall_get_arch(struct task_struct *task)
 	else
 		return AUDIT_ARCH_PPC64;
 }
-
-static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
-{
-	return false;
-}
 #endif	/* _ASM_SYSCALL_H */
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 8067e666a4ca..987c9a78806f 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -112,11 +112,6 @@ static inline void syscall_handler(struct pt_regs *regs, ulong syscall)
 	regs->a0 = fn(regs);
 }
 
-static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
-{
-	return false;
-}
-
 asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
 
 asmlinkage long sys_riscv_hwprobe(struct riscv_hwprobe *, size_t, size_t,
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index 4271e4169f45..5f310caad1fc 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -89,11 +89,6 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_S390X;
 }
 
-static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
-{
-	return false;
-}
-
 #define SYSCALL_FMT_0
 #define SYSCALL_FMT_1 , "0" (r2)
 #define SYSCALL_FMT_2 , "d" (r3) SYSCALL_FMT_1
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bdad90f210e4..f3f8ad107eeb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -335,6 +335,7 @@ config X86
 	select SCHED_SMT			if SMP
 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
 	select ARCH_SUPPORTS_SCHED_MC		if SMP
+	select ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
 	select HAVE_SINGLE_FTRACE_DIRECT_OPS	if X86_64 && DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 
 config INSTRUCTION_DECODER
-- 
2.34.1


