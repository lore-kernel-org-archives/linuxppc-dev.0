Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AE631A0BC6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 07:46:40 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 5 Nov 2015 02:16:37 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 9242B125805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 02:16:35 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4KkZ9J4653234
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 02:16:35 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4KkWUJ027845
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 02:16:34 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Stephane Eranian <eranian@gmail.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [RFC PATCH 1/3] perf/core: extend perf_regs to include arch specific
 regs
Date: Thu,  5 Nov 2015 02:16:16 +0530
Message-Id: <1446669978-6366-2-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As a foundation patch, new structure called arch_misc_regs
added to perf_regs. And perf_reg_value() is modified to expect
perf_regs instead of pt_regs. This way, perf_reg_value() can decide
on the struct to pick based on the register idx.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Stephane Eranian <eranian@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 Will really appreciate comments and feedback for the patch

 arch/arm/include/asm/ptrace.h          | 2 ++
 arch/arm/kernel/perf_regs.c            | 4 +++-
 arch/arm64/include/asm/ptrace.h        | 2 ++
 arch/arm64/kernel/perf_regs.c          | 4 +++-
 arch/powerpc/include/uapi/asm/ptrace.h | 2 ++
 arch/powerpc/perf/perf_regs.c          | 4 +++-
 arch/x86/include/asm/ptrace.h          | 2 ++
 arch/x86/kernel/perf_regs.c            | 4 +++-
 include/linux/perf_regs.h              | 5 +++--
 kernel/events/core.c                   | 6 +++---
 10 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 51622ba7c4a6..26cd8dbf1f02 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -17,6 +17,8 @@ struct pt_regs {
 	unsigned long uregs[18];
 };
 
+struct arch_misc_regs {};
+
 #define user_mode(regs)	\
 	(((regs)->ARM_cpsr & 0xf) == 0)
 
diff --git a/arch/arm/kernel/perf_regs.c b/arch/arm/kernel/perf_regs.c
index 592dda3f21ff..18999abbadbe 100644
--- a/arch/arm/kernel/perf_regs.c
+++ b/arch/arm/kernel/perf_regs.c
@@ -6,8 +6,10 @@
 #include <asm/perf_regs.h>
 #include <asm/ptrace.h>
 
-u64 perf_reg_value(struct pt_regs *regs, int idx)
+u64 perf_reg_value(struct perf_regs *p_regs, int idx)
 {
+	struct pt_regs *regs = p_regs->regs;
+
 	if (WARN_ON_ONCE((u32)idx >= PERF_REG_ARM_MAX))
 		return 0;
 
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 536274ed292e..9a33ab69f19f 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -118,6 +118,8 @@ struct pt_regs {
 	u64 syscallno;
 };
 
+struct arch_misc_regs {};
+
 #define arch_has_single_step()	(1)
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 3f62b35fb6f1..8ee80d7c8604 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -7,8 +7,10 @@
 #include <asm/perf_regs.h>
 #include <asm/ptrace.h>
 
-u64 perf_reg_value(struct pt_regs *regs, int idx)
+u64 perf_reg_value(struct perf_regs *p_regs, int idx)
 {
+	struct pt_regs *regs = p_regs->regs;
+
 	if (WARN_ON_ONCE((u32)idx >= PERF_REG_ARM64_MAX))
 		return 0;
 
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 8036b385417d..0025651ab8bc 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -51,6 +51,8 @@ struct pt_regs {
 	unsigned long result;		/* Result of a system call */
 };
 
+struct arch_misc_regs {};
+
 #endif /* __ASSEMBLY__ */
 
 
diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
index 0520492d4078..f7995b46078a 100644
--- a/arch/powerpc/perf/perf_regs.c
+++ b/arch/powerpc/perf/perf_regs.c
@@ -61,8 +61,10 @@ static unsigned int pt_regs_offset[PERF_REG_POWERPC_MAX] = {
 	PT_REGS_OFFSET(PERF_REG_POWERPC_DSISR, dsisr),
 };
 
-u64 perf_reg_value(struct pt_regs *regs, int idx)
+u64 perf_reg_value(struct perf_regs *p_regs, int idx)
 {
+	struct pt_regs *regs = p_regs->regs;
+
 	if (WARN_ON_ONCE(idx >= PERF_REG_POWERPC_MAX))
 		return 0;
 	return regs_get_register(regs, pt_regs_offset[idx]);
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 6271281f947d..410a2eb885c1 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -67,6 +67,8 @@ struct pt_regs {
 
 #endif /* !__i386__ */
 
+struct arch_misc_regs {};
+
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt_types.h>
 #endif
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index da8cb987b973..c6e41f7f648b 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -55,8 +55,10 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
 #endif
 };
 
-u64 perf_reg_value(struct pt_regs *regs, int idx)
+u64 perf_reg_value(struct perf_regs *p_regs, int idx)
 {
+	struct pt_regs *regs = p_regs->regs;
+
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
 		return 0;
 
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index a5f98d53d732..7727a30e7d84 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -4,18 +4,19 @@
 struct perf_regs {
 	__u64		abi;
 	struct pt_regs	*regs;
+	struct arch_misc_regs *arch_regs;
 };
 
 #ifdef CONFIG_HAVE_PERF_REGS
 #include <asm/perf_regs.h>
-u64 perf_reg_value(struct pt_regs *regs, int idx);
+u64 perf_reg_value(struct perf_regs *p_regs, int idx);
 int perf_reg_validate(u64 mask);
 u64 perf_reg_abi(struct task_struct *task);
 void perf_get_regs_user(struct perf_regs *regs_user,
 			struct pt_regs *regs,
 			struct pt_regs *regs_user_copy);
 #else
-static inline u64 perf_reg_value(struct pt_regs *regs, int idx)
+static inline u64 perf_reg_value(struct perf_regs *p_regs, int idx)
 {
 	return 0;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b11756f9b6dc..c04bdad3d365 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4934,7 +4934,7 @@ EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
 
 static void
 perf_output_sample_regs(struct perf_output_handle *handle,
-			struct pt_regs *regs, u64 mask)
+			struct perf_regs *regs, u64 mask)
 {
 	int bit;
 
@@ -5331,7 +5331,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 		if (abi) {
 			u64 mask = event->attr.sample_regs_user;
 			perf_output_sample_regs(handle,
-						data->regs_user.regs,
+						&data->regs_user,
 						mask);
 		}
 	}
@@ -5363,7 +5363,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 			u64 mask = event->attr.sample_regs_intr;
 
 			perf_output_sample_regs(handle,
-						data->regs_intr.regs,
+						&data->regs_intr,
 						mask);
 		}
 	}
-- 
1.9.1
