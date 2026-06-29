Return-Path: <linuxppc-dev+bounces-23098-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225BAC44500
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 13:07:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpml11BLXz2xYh;
	Mon, 29 Jun 2026 23:06:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782738413;
	cv=none; b=X9I9WeMZCP9hXBAbp7BAe/+I27KvlOa/c3mMxS+JyiOomQvb9L1FLK0hmboIQTDtOnev/RfXx27Ys6dXPsrZ6jqjxHvB2yJ0aB+NetuyL2T5PEkdyIixlENCq7U17Ljw9ZlLSRUwuP+uTiJ+ILNB3ZRgCrVySlTVp0bXfua+m4LLfdcYAg2YQQlAs9nN2UxTllKU54Rv6tHFLksNOSQc/w4g6t+KTJTjg2fiEB7bupYp09FkoX9ISYEKoUakhD6ESdbI7G/WgPzdSmqTRXUJniyIgb6ylXgDNpadNU4j8fBMPLOUisUnTNiiZ6BCCW07NrKb/NRrMA5wCjt94RDWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782738413; c=relaxed/relaxed;
	bh=QajGHSeELTeFwAo2Vi+cAigxNZFa68v7esARJOfEGL8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBMgT3DaAy0wpa089ekyZVwGIYqeJwZ5aB+zvIBIbdZCajTLoUbeP3+wVzcNKDyJs1R9JIqicXMUTFCZSXb9UV941TiuORLy7L9IqkEH40nnN/AYWzhPzevg1YOw71D2Mbb8mwlariz+yewROhkZjuEkqQKzzUhr9V+f/HPQoYUchW7GeyMRnpmlp5iLmkL0RXjOSVa5B3hrDUr3ogMlxZEe4vU2m2CfQl9E1SvcppGCEtMfX2vVEieP2ShRrrTDCctpf2kqqChXtram3tFmdVwDFV6SabwIQX+vWCfQle7V7eiU5UhcUNTZgciFfxDfMkyNAXsBHq6q/KjYS1yUCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=K5W+RbBF; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=K5W+RbBF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpmkz652Mz2ygG
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 23:06:51 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QajGHSeELTeFwAo2Vi+cAigxNZFa68v7esARJOfEGL8=;
	b=K5W+RbBF/b3OBpG5ddsT3bmnCLBLEzgyzzh300maR3q5Yzre6htvRd1h62EH0Qq8ZRLKiCyVR
	7x2r9MGY/Q4YnrsdD5+L1K+xmcJorhcRgEsexa89co6ktYK7W/JX4y7GLJ/9v16AQNEERwnh96q
	DwurhrJk6XJseic49PmwfnU=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gpmXL5DzdzLmHQ;
	Mon, 29 Jun 2026 20:57:38 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 3797E40572;
	Mon, 29 Jun 2026 21:06:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Jun
 2026 21:06:42 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <oleg@redhat.com>, <richard.henderson@linaro.org>, <mattst88@gmail.com>,
	<linmag7@gmail.com>, <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <kees@kernel.org>, <guoren@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <geert@linux-m68k.org>,
	<tsbogend@alpha.franken.de>, <James.Bottomley@HansenPartnership.com>,
	<deller@gmx.de>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
	<luto@kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <chris@zankel.net>,
	<jcmvbkbc@gmail.com>, <peterz@infradead.org>, <wad@chromium.org>,
	<ruanjinjie@huawei.com>, <thuth@redhat.com>, <mark.rutland@arm.com>,
	<ada.coupriediaz@arm.com>, <kevin.brodsky@arm.com>, <linusw@kernel.org>,
	<yeoreum.yun@arm.com>, <song@kernel.org>, <james.morse@arm.com>,
	<anshuman.khandual@arm.com>, <broonie@kernel.org>, <liqiang01@kylinos.cn>,
	<pengcan@kylinos.cn>, <ryan.roberts@arm.com>, <yangtiezhu@loongson.cn>,
	<sshegde@linux.ibm.com>, <mchauras@linux.ibm.com>, <austin.kim@lge.com>,
	<jchrist@linux.ibm.com>, <arnd@arndb.de>, <thomas.weissschuh@linutronix.de>,
	<sohil.mehta@intel.com>, <andrew.cooper3@citrix.com>, <jgross@suse.com>,
	<kas@kernel.org>, <x86@kernel.org>, <linux-alpha@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-csky@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-m68k@lists.linux-m68k.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-um@lists.infradead.org>
Subject: [PATCH v16 02/18] syscall_user_dispatch: Introduce a weak fallback for arch_syscall_is_vdso_sigreturn()
Date: Mon, 29 Jun 2026 21:06:00 +0800
Message-ID: <20260629130616.642022-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629130616.642022-1-ruanjinjie@huawei.com>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Currently, multiple architectures (LoongArch, RISC-V, S390, Powerpc)
provide identical stubs for arch_syscall_is_vdso_sigreturn() that simply
return false. This results in redundant boilerplate code across the tree.

Introduce a default __weak implementation of
arch_syscall_is_vdso_sigreturn() directly in syscall_user_dispatch.c that
returns false. This allows architectures that do not utilize a vDSO
sigreturn to entirely drop their redundant inline definitions.

Architectures requiring a specialized check (such as x86) will continue to
override this fallback with their strong symbol definitions.

Clean up the redundant implementations in loongarch, riscv, s390
and powerpc.

Cc: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/loongarch/include/asm/syscall.h  | 5 -----
 arch/powerpc/include/asm/syscall.h    | 5 -----
 arch/riscv/include/asm/syscall.h      | 5 -----
 arch/s390/include/asm/syscall.h       | 5 -----
 include/linux/syscall_user_dispatch.h | 1 +
 kernel/entry/syscall_user_dispatch.c  | 5 +++++
 6 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/include/asm/syscall.h
index df8ea223c77b..946886794ced 100644
--- a/arch/loongarch/include/asm/syscall.h
+++ b/arch/loongarch/include/asm/syscall.h
@@ -85,9 +85,4 @@ static inline int syscall_get_arch(struct task_struct *task)
 #endif
 }
 
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
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
index 3858a6ffdd5c..73d69e02807d 100644
--- a/include/linux/syscall_user_dispatch.h
+++ b/include/linux/syscall_user_dispatch.h
@@ -10,6 +10,7 @@
 
 #ifdef CONFIG_GENERIC_ENTRY
 
+bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
 int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 			      unsigned long len, char __user *selector);
 
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index d89dffcc2d64..acf545774d37 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -32,6 +32,11 @@ static void trigger_sigsys(struct pt_regs *regs)
 	force_sig_info(&info);
 }
 
+bool __weak arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+	return false;
+}
+
 bool syscall_user_dispatch(struct pt_regs *regs)
 {
 	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
-- 
2.34.1


