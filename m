Return-Path: <galak@freescale.com>
Date: Tue, 18 Oct 2005 17:42:41 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510181742110.3329@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: replace use of _GLOBAL with .globl for ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The _GLOBAL() macro is for text symbols only. Changed to using
.globl for .data symbols.  This is also needed in ppc32 land
to allow FSL Book-E, 40x, and 44x to work.

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit ca6e6d7a599f8e8a5976c044910b98ef30258e30
tree d220cd916c8bdb6bb9c5ddbdfc2ecbfa5004cf89
parent a2084dccc9e9b0ccc5c40ed2f1273c82b23369d2
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 18 Oct 2005 17:40:56 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 18 Oct 2005 17:40:56 -0500

 arch/ppc/kernel/head_44x.S       |   18 +++++++++++-------
 arch/ppc/kernel/head_4xx.S       |   16 +++++++++++-----
 arch/ppc/kernel/head_fsl_booke.S |   17 +++++++++++------
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S
+++ b/arch/ppc/kernel/head_44x.S
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
diff --git a/arch/ppc/kernel/head_4xx.S b/arch/ppc/kernel/head_4xx.S
--- a/arch/ppc/kernel/head_4xx.S
+++ b/arch/ppc/kernel/head_4xx.S
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
diff --git a/arch/ppc/kernel/head_fsl_booke.S b/arch/ppc/kernel/head_fsl_booke.S
--- a/arch/ppc/kernel/head_fsl_booke.S
+++ b/arch/ppc/kernel/head_fsl_booke.S
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
