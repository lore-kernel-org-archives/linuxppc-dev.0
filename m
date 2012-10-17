Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 201922C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2012 21:50:35 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH 2/2] PPC_BOOK3E/KGDB: support kgdb kernel space
Date: Wed, 17 Oct 2012 18:50:11 +0800
Message-ID: <1350471011-2478-2-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1350471011-2478-1-git-send-email-tiejun.chen@windriver.com>
References: <1350471011-2478-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, jason.wessel@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can support KGDB with current debug exception for BOOK3E, so we
should initial specific dbg_kstack to avoid overwriting other thing.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/exceptions-64e.S |    4 ++++
 arch/powerpc/kernel/paca.c           |   10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 4684e33..ed5862d 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -539,11 +539,15 @@ kernel_dbg_exc:
 	rfdi
 
 	/* Normal debug exception */
+#ifndef CONFIG_KGDB
 	/* XXX We only handle coming from userspace for now since we can't
 	 *     quite save properly an interrupted kernel state yet
 	 */
 1:	andi.	r14,r11,MSR_PR;		/* check for userspace again */
 	beq	kernel_dbg_exc;		/* if from kernel mode */
+#else
+1:
+#endif
 
 	/* Now we mash up things to make it look like we are coming on a
 	 * normal exception
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index cd6da85..28a5141 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -122,6 +122,13 @@ EXPORT_SYMBOL(paca);
 
 struct paca_struct boot_paca;
 
+void *debug_kstack;
+static void allocate_dbg_kstack(unsigned long limit)
+{
+	debug_kstack = __va(memblock_alloc_base(THREAD_SIZE,
+					THREAD_SIZE, limit));
+}
+
 void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 {
        /* The TOC register (GPR2) points 32kB into the TOC, so that 64kB
@@ -133,6 +140,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 	new_paca->lppaca_ptr = new_lppaca(cpu);
 #else
 	new_paca->kernel_pgd = swapper_pg_dir;
+	new_paca->dbg_kstack = debug_kstack;
 #endif
 	new_paca->lock_token = 0x8000;
 	new_paca->paca_index = cpu;
@@ -192,6 +200,8 @@ void __init allocate_pacas(void)
 
 	allocate_lppacas(nr_cpu_ids, limit);
 
+	allocate_dbg_kstack(limit);
+
 	/* Can't use for_each_*_cpu, as they aren't functional yet */
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
 		initialise_paca(&paca[cpu], cpu);
-- 
1.7.9.5
