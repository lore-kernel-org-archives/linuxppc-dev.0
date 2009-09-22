Return-Path: <anton@ozlabs.org>
Date: Tue, 22 Sep 2009 12:57:40 +1000
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org, benh@kernel.crashing.org, a.p.zijlstra@chello.nl,
	mingo@elte.hu
Subject: [PATCH] powerpc/perf_counter: Fix vdso detection
Message-ID: <20090922025740.GF31801@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


perf_counter uses arch_vma_name() to detect a vdso region which in turn uses
current->mm->context.vdso_base. We need to initialise this before doing
the mmap or else we fail to detect the vdso.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/kernel/vdso.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/vdso.c	2009-07-15 10:00:41.000000000 +1000
+++ linux.trees.git/arch/powerpc/kernel/vdso.c	2009-07-15 10:01:40.000000000 +1000
@@ -240,6 +240,13 @@
 	}
 
 	/*
+	 * Put vDSO base into mm struct. We need to do this before calling
+	 * install_special_mapping or the perf counter mmap tracking code
+	 * will fail to recognise it as a vDSO (since arch_vma_name fails).
+	 */
+	current->mm->context.vdso_base = vdso_base;
+
+	/*
 	 * our vma flags don't have VM_WRITE so by default, the process isn't
 	 * allowed to write those pages.
 	 * gdb can break that with ptrace interface, and thus trigger COW on
@@ -259,11 +266,10 @@
 				     VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
 				     VM_ALWAYSDUMP,
 				     vdso_pagelist);
-	if (rc)
+	if (rc) {
+		current->mm->context.vdso_base = 0;
 		goto fail_mmapsem;
-
-	/* Put vDSO base into mm struct */
-	current->mm->context.vdso_base = vdso_base;
+	}
 
 	up_write(&mm->mmap_sem);
 	return 0;
