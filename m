Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 799F11A03A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 14:01:55 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: mikey@neuling.org, anton@samba.org, linuxppc-dev@ozlabs.org,
 Aaron Sawdey <sawdey@us.ibm.com>, Denis Kirjanov <kda@linux-powerpc.org>,
 Steve Munroe <sjmunroe@us.ibm.com>
Subject: [PATCH v2 2/2] powerpc/vdso: Avoid link stack corruption in
 __get_datapage()
Date: Fri, 25 Sep 2015 14:01:40 +1000
Message-Id: <1443153700-15395-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1443153700-15395-1-git-send-email-mikey@neuling.org>
References: <1443153700-15395-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc has a link register (lr) used for calling functions. We "bl
<func>" to call a function, and "blr" to return back to the call site.

The lr is only a single register, so if we call another function from
inside this function (ie. nested calls), software must save away the
lr on the software stack before calling the new function. Before
returning (ie. before the "blr"), the lr is restored by software from
the software stack.

This makes branch prediction quite difficult for the processor as it
will only know the branch target just before the "blr".

To help with this, modern powerpc processors keep a (non-architected)
hardware stack of lr called a "link stack". When a "bl <func>" is
run, the lr is pushed onto this stack. When a "blr" is called, the
branch predictor pops the lr value from the top of the link stack, and
uses it to predict the branch target. Hence the processor pipeline
knows a lot earlier the branch target.

This works great but there are some cases where you call "bl" but
without a matching "blr". Once such case is when trying to determine
the program counter (which can't be read directly). Here you "bl+4;
mflr" to get the program counter. If you do this, the link stack will
get out of sync with reality, causing the branch predictor to
mis-predict subsequent function returns.

To avoid this, modern micro-architectures have a special case of bl.
Using the form "bcl 20,31,+4", ensures the processor doesn't push to
the link stack.

The 32 and 64 bit variants of __get_datapage() use a "bl; mflr" to
determine the loaded address of the VDSO. The current versions of
these attempt to use this special bl variant.

Unfortunately they use +8 rather than the required +4. Hence the
current code results in the link stack getting out of sync with
reality and hence the resulting performance degradation.

This patch moves it to bcl+4 by moving __kernel_datapage_offset out of
__get_datapage().

With this patch, running a gettimeofday() (which uses
__get_datapage()) microbenchmark we get a decent bump in performance
on POWER7/8.

For the benchmark in tools/testing/selftests/powerpc/benchmarks/gettimeofday.c
  POWER8:
    64bit gets ~4% improvement
    32bit gets ~9% improvement
  POWER7:
    64bit gets ~7% improvement

Signed-off-by: Michael Neuling <mikey@neuling.org>
Reported-by: Aaron Sawdey <sawdey@us.ibm.com>

---
Giant-commit-log-essay-suggested-by: mpe
---
 arch/powerpc/kernel/vdso32/datapage.S | 12 +++++++-----
 arch/powerpc/kernel/vdso64/datapage.S | 12 +++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kernel/vdso32/datapage.S
index dc21e89..59cf5f4 100644
--- a/arch/powerpc/kernel/vdso32/datapage.S
+++ b/arch/powerpc/kernel/vdso32/datapage.S
@@ -16,6 +16,10 @@
 #include <asm/vdso.h>
 
 	.text
+	.global	__kernel_datapage_offset;
+__kernel_datapage_offset:
+	.long	0
+
 V_FUNCTION_BEGIN(__get_datapage)
   .cfi_startproc
 	/* We don't want that exposed or overridable as we want other objects
@@ -27,13 +31,11 @@ V_FUNCTION_BEGIN(__get_datapage)
 	mflr	r0
   .cfi_register lr,r0
 
-	bcl	20,31,1f
-	.global	__kernel_datapage_offset;
-__kernel_datapage_offset:
-	.long	0
-1:
+	bcl	20,31,data_page_branch
+data_page_branch:
 	mflr	r3
 	mtlr	r0
+	addi	r3, r3, __kernel_datapage_offset-data_page_branch
 	lwz	r0,0(r3)
 	add	r3,r0,r3
 	blr
diff --git a/arch/powerpc/kernel/vdso64/datapage.S b/arch/powerpc/kernel/vdso64/datapage.S
index 79796de..2f01c4a 100644
--- a/arch/powerpc/kernel/vdso64/datapage.S
+++ b/arch/powerpc/kernel/vdso64/datapage.S
@@ -16,6 +16,10 @@
 #include <asm/vdso.h>
 
 	.text
+.global	__kernel_datapage_offset;
+__kernel_datapage_offset:
+	.long	0
+
 V_FUNCTION_BEGIN(__get_datapage)
   .cfi_startproc
 	/* We don't want that exposed or overridable as we want other objects
@@ -27,13 +31,11 @@ V_FUNCTION_BEGIN(__get_datapage)
 	mflr	r0
   .cfi_register lr,r0
 
-	bcl	20,31,1f
-	.global	__kernel_datapage_offset;
-__kernel_datapage_offset:
-	.long	0
-1:
+	bcl	20,31,data_page_branch
+data_page_branch:
 	mflr	r3
 	mtlr	r0
+	addi	r3, r3, __kernel_datapage_offset-data_page_branch
 	lwz	r0,0(r3)
 	add	r3,r0,r3
 	blr
-- 
2.1.4
