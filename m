Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0F71DDDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 14:41:46 +1000 (EST)
Date: Mon, 17 Sep 2007 14:41:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Remove cmd_line from head*.S
Message-Id: <20070917144138.3e0a31d7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It is just a C char array, so declare it thusly.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/head_32.S        |    8 --------
 arch/powerpc/kernel/head_40x.S       |    7 -------
 arch/powerpc/kernel/head_44x.S       |    8 --------
 arch/powerpc/kernel/head_64.S        |    8 --------
 arch/powerpc/kernel/head_8xx.S       |    8 --------
 arch/powerpc/kernel/head_fsl_booke.S |    8 --------
 arch/powerpc/kernel/setup-common.c   |    2 ++
 7 files changed, 2 insertions(+), 47 deletions(-)

This version has the definition in setup-common.c.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 0e3df1f..a2e4df0 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -1300,14 +1300,6 @@ empty_zero_page:
 swapper_pg_dir:
 	.space	4096
 
-/*
- * This space gets a copy of optional info passed to us by the bootstrap
- * Used to pass parameters into the kernel like root=/dev/sda1, etc.
- */
-	.globl	cmd_line
-cmd_line:
-	.space	512
-
 	.globl intercept_table
 intercept_table:
 	.long 0, 0, i0x200, i0x300, i0x400, 0, i0x600, i0x700
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index a8e0457..8a69eec 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -1006,13 +1006,6 @@ critical_stack_top:
 	.globl	exception_stack_top
 exception_stack_top:
 
-/* This space gets a copy of optional info passed to us by the bootstrap
- * which is used to pass parameters into the kernel like root=/dev/sda1, etc.
- */
-	.globl	cmd_line
-cmd_line:
-	.space	512
-
 /* Room for two PTE pointers, usually the kernel and current user pointers
  * to their respective root page table.
  */
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index e26d26e..e405c59 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -744,14 +744,6 @@ exception_stack_bottom:
 exception_stack_top:
 
 /*
- * This space gets a copy of optional info passed to us by the bootstrap
- * which is used to pass parameters into the kernel like root=/dev/sda1, etc.
- */
-	.globl	cmd_line
-cmd_line:
-	.space	512
-
-/*
  * Room for two PTE pointers, usually the kernel and current user pointers
  * to their respective root page table.
  */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index cec5908..f4ae82e 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -1540,11 +1540,3 @@ empty_zero_page:
 	.globl	swapper_pg_dir
 swapper_pg_dir:
 	.space	PAGE_SIZE
-
-/*
- * This space gets a copy of optional info passed to us by the bootstrap
- * Used to pass parameters into the kernel like root=/dev/sda1, etc.
- */
-	.globl	cmd_line
-cmd_line:
-	.space	COMMAND_LINE_SIZE
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 901be47..22e1a3c 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -835,14 +835,6 @@ empty_zero_page:
 swapper_pg_dir:
 	.space	4096
 
-/*
- * This space gets a copy of optional info passed to us by the bootstrap
- * Used to pass parameters into the kernel like root=/dev/sda1, etc.
- */
-	.globl	cmd_line
-cmd_line:
-	.space	512
-
 /* Room for two PTE table poiners, usually the kernel and current user
  * pointer to their respective root page table (pgdir).
  */
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 1f155d3..5f47adb 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -1050,14 +1050,6 @@ exception_stack_bottom:
 exception_stack_top:
 
 /*
- * This space gets a copy of optional info passed to us by the bootstrap
- * which is used to pass parameters into the kernel like root=/dev/sda1, etc.
- */
-	.globl	cmd_line
-cmd_line:
-	.space	512
-
-/*
  * Room for two PTE pointers, usually the kernel and current user pointers
  * to their respective root page table.
  */
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 50ef38c..36c90ba 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -76,6 +76,8 @@ EXPORT_SYMBOL(machine_id);
 
 unsigned long klimit = (unsigned long) _end;
 
+char cmd_line[COMMAND_LINE_SIZE];
+
 /*
  * This still seems to be needed... -- paulus
  */ 
-- 
1.5.3.1
