Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: Fix reading/writing FPRs on 32 bit apps with ptrace
	on 64 bit kernels
Date: Tue, 24 Mar 2009 17:04:37 +1100
Message-ID: <26680.1237874677@neuling.org>
Cc: linuxppc-dev@ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix the calculation for offsetting into the FPRs when ptracing a 32 bit
app on 64 bit kernels.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: stable@kernel.org
---
benh: it'd be nice if this went back in to 27,28 & 29

Also, I vote we kill ptracing 64 bit apps from 32 apps as it's
completely broken and no one has ever noticed.

 arch/powerpc/kernel/ptrace32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/ptrace32.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ptrace32.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/ptrace32.c
@@ -67,7 +67,7 @@ static long compat_ptrace_old(struct tas
 /* Macros to workout the correct index for the FPR in the thread struct */
 #define FPRNUMBER(i) (((i) - PT_FPR0) >> 1)
 #define FPRHALF(i) (((i) - PT_FPR0) & 1)
-#define FPRINDEX(i) TS_FPRWIDTH * FPRNUMBER(i) + FPRHALF(i)
+#define FPRINDEX(i) TS_FPRWIDTH * FPRNUMBER(i) * 2 + FPRHALF(i)
 
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
