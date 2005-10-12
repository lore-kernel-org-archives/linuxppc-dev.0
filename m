Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id EBC4D6851C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2005 14:54:12 +1000 (EST)
Date: Tue, 11 Oct 2005 23:54:00 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510112351570.5147@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: replace use of _GLOBAL with .globl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The _GLOBAL() macro is for text symbols only. Changed to using
.globl for .data symbols.

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit fd11c0f260c84cbbe502ce5f238eeb44b908890f
tree 38824b61a2053d2b7256ba72ed8998c20cf04136
parent 273488f8b09a65c56a462c348fbbf43de55fe464
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 11 Oct 2005 23:51:07 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 11 Oct 2005 23:51:07 -0500

 arch/powerpc/kernel/head_44x.S       |   18 +++++++++++-------
 arch/powerpc/kernel/head_4xx.S       |   16 +++++++++++-----
 arch/powerpc/kernel/head_fsl_booke.S |   17 +++++++++++------
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -743,14 +743,18 @@ _GLOBAL(set_context)
  * goes at the beginning of the data segment, which is page-aligned.
  */
 	.data
-_GLOBAL(sdata)
-_GLOBAL(empty_zero_page)
+	.align	12
+	.globl	sdata
+sdata:
+	.globl	empty_zero_page
+empty_zero_page:
 	.space	4096
 
 /*
  * To support >32-bit physical addresses, we use an 8KB pgdir.
  */
-_GLOBAL(swapper_pg_dir)
+	.globl	swapper_pg_dir
+swapper_pg_dir:
 	.space	8192
 
 /* Reserved 4k for the critical exception stack & 4k for the machine
@@ -759,13 +763,15 @@ _GLOBAL(swapper_pg_dir)
         .align 12
 exception_stack_bottom:
 	.space	BOOKE_EXCEPTION_STACK_SIZE
-_GLOBAL(exception_stack_top)
+	.globl	exception_stack_top
+exception_stack_top:
 
 /*
  * This space gets a copy of optional info passed to us by the bootstrap
  * which is used to pass parameters into the kernel like root=/dev/sda1, etc.
  */
-_GLOBAL(cmd_line)
+	.globl	cmd_line
+cmd_line:
 	.space	512
 
 /*
@@ -774,5 +780,3 @@ _GLOBAL(cmd_line)
  */
 abatron_pteptrs:
 	.space	8
-
-
diff --git a/arch/powerpc/kernel/head_4xx.S b/arch/powerpc/kernel/head_4xx.S
--- a/arch/powerpc/kernel/head_4xx.S
+++ b/arch/powerpc/kernel/head_4xx.S
@@ -988,10 +988,14 @@ _GLOBAL(set_context)
  * goes at the beginning of the data segment, which is page-aligned.
  */
 	.data
-_GLOBAL(sdata)
-_GLOBAL(empty_zero_page)
+	.align	12
+	.globl	sdata
+sdata:
+	.globl	empty_zero_page
+empty_zero_page:
 	.space	4096
-_GLOBAL(swapper_pg_dir)
+	.globl	swapper_pg_dir
+swapper_pg_dir:
 	.space	4096
 
 
@@ -1001,12 +1005,14 @@ _GLOBAL(swapper_pg_dir)
 exception_stack_bottom:
 	.space	4096
 critical_stack_top:
-_GLOBAL(exception_stack_top)
+	.globl	exception_stack_top
+exception_stack_top:
 
 /* This space gets a copy of optional info passed to us by the bootstrap
  * which is used to pass parameters into the kernel like root=/dev/sda1, etc.
  */
-_GLOBAL(cmd_line)
+	.globl	cmd_line
+cmd_line:
 	.space	512
 
 /* Room for two PTE pointers, usually the kernel and current user pointers
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -1028,10 +1028,14 @@ _GLOBAL(set_context)
  * goes at the beginning of the data segment, which is page-aligned.
  */
 	.data
-_GLOBAL(sdata)
-_GLOBAL(empty_zero_page)
+	.align	12
+	.globl	sdata
+sdata:
+	.globl	empty_zero_page
+empty_zero_page:
 	.space	4096
-_GLOBAL(swapper_pg_dir)
+	.globl	swapper_pg_dir
+swapper_pg_dir:
 	.space	4096
 
 /* Reserved 4k for the critical exception stack & 4k for the machine
@@ -1040,13 +1044,15 @@ _GLOBAL(swapper_pg_dir)
         .align 12
 exception_stack_bottom:
 	.space	BOOKE_EXCEPTION_STACK_SIZE * NR_CPUS
-_GLOBAL(exception_stack_top)
+	.globl	exception_stack_top
+exception_stack_top:
 
 /*
  * This space gets a copy of optional info passed to us by the bootstrap
  * which is used to pass parameters into the kernel like root=/dev/sda1, etc.
  */
-_GLOBAL(cmd_line)
+	.globl	cmd_line
+cmd_line:
 	.space	512
 
 /*
@@ -1055,4 +1061,3 @@ _GLOBAL(cmd_line)
  */
 abatron_pteptrs:
 	.space	8
-
