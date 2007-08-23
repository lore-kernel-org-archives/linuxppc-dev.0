Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 01799DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 14:05:29 +1000 (EST)
Date: Thu, 23 Aug 2007 14:05:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 1/2] [POWERPC] Remove cmd_line from head*.S
Message-Id: <20070823140526.e4d5f3dc.sfr@canb.auug.org.au>
In-Reply-To: <20070823130913.2e9db6eb.sfr@canb.auug.org.au>
References: <20070823130913.2e9db6eb.sfr@canb.auug.org.au>
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
 arch/powerpc/kernel/prom.c           |    2 ++
 7 files changed, 2 insertions(+), 47 deletions(-)

This is just rebased on Paulus' current tree as someone renamed head_4xx.S.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 7d73a13..de2fa61 100644
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
index 8869596..e4068ff 100644
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
index 33c4e8c..381d07a 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -1538,11 +1538,3 @@ empty_zero_page:
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
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 0028fe6..dc85005 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -60,6 +60,8 @@
 #endif
 
 
+char cmd_line[COMMAND_LINE_SIZE];
+
 static int __initdata dt_root_addr_cells;
 static int __initdata dt_root_size_cells;
 
-- 
1.5.2.4
