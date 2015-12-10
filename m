Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 840C31A113E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 20:04:36 +1100 (AEDT)
Date: Thu, 10 Dec 2015 20:04:05 +1100
From: Anton Blanchard <anton@samba.org>
To: Rashmica <rashmicy@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org,
 paulus@samba.org, cyrilbur@gmail.com, scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Call check_if_tm_restore_required() in
 enable_kernel_*()
Message-ID: <20151210200405.4779b7df@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit a0e72cf12b1a ("powerpc: Create msr_check_and_{set,clear}()")
removed a call to check_if_tm_restore_required() in the
enable_kernel_*() functions. Add them back in.

Fixes: a0e72cf12b1a ("powerpc: Create msr_check_and_{set,clear}()")
Reported-by: Rashmica Gupta <rashmicy@gmail.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/process.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index fffc2d2..0cffb2c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -181,8 +181,10 @@ void enable_kernel_fp(void)
 
 	msr_check_and_set(MSR_FP);
 
-	if (current->thread.regs && (current->thread.regs->msr & MSR_FP))
+	if (current->thread.regs && (current->thread.regs->msr & MSR_FP)) {
+		check_if_tm_restore_required(current);
 		__giveup_fpu(current);
+	}
 }
 EXPORT_SYMBOL(enable_kernel_fp);
 #endif /* CONFIG_PPC_FPU */
@@ -204,8 +206,10 @@ void enable_kernel_altivec(void)
 
 	msr_check_and_set(MSR_VEC);
 
-	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC))
+	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC)) {
+		check_if_tm_restore_required(current);
 		__giveup_altivec(current);
+	}
 }
 EXPORT_SYMBOL(enable_kernel_altivec);
 
@@ -249,6 +253,7 @@ void enable_kernel_vsx(void)
 	msr_check_and_set(MSR_FP|MSR_VEC|MSR_VSX);
 
 	if (current->thread.regs && (current->thread.regs->msr & MSR_VSX)) {
+		check_if_tm_restore_required(current);
 		if (current->thread.regs->msr & MSR_FP)
 			__giveup_fpu(current);
 		if (current->thread.regs->msr & MSR_VEC)
@@ -289,8 +294,10 @@ void enable_kernel_spe(void)
 
 	msr_check_and_set(MSR_SPE);
 
-	if (current->thread.regs && (current->thread.regs->msr & MSR_SPE))
+	if (current->thread.regs && (current->thread.regs->msr & MSR_SPE)) {
+		check_if_tm_restore_required(current);
 		__giveup_spe(current);
+	}
 }
 EXPORT_SYMBOL(enable_kernel_spe);
 
-- 
2.5.0
