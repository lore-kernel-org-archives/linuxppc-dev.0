Return-Path: <kernelfans@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401wtJ1zFDzF16f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 15:42:16 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id i14so2351332pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 21:42:16 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: cascardo@canonical.com, gpiccoli@linux.vnet.ibm.com,
 kexec@lists.infradead.org, paulus@ozlabs.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org
Subject: [PATCHv5 3/3] ppc64 boot: Wait for boot cpu to show up if nr_cpus
 limit is about to hit.
Date: Thu, 15 Mar 2018 12:41:52 +0800
Message-Id: <1521088912-31742-4-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1521088912-31742-1-git-send-email-kernelfans@gmail.com>
References: <1521088912-31742-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The kernel boot parameter 'nr_cpus=' allows one to specify number of
possible cpus in the system. In the normal scenario the first cpu (cpu0)
that shows up is the boot cpu and hence it gets covered under nr_cpus
limit.

But this assumption will be broken in kdump scenario where kdump kenrel
after a crash can boot up on an non-zero boot cpu. The paca structure
allocation depends on value of nr_cpus and is indexed using logical cpu
ids. This definetly will be an issue if boot cpu id > nr_cpus

This patch modifies allocate_pacas() and smp_setup_cpu_maps() to
accommodate boot cpu for the case where boot_cpuid > nr_cpu_ids.

This change would help to reduce the memory reservation requirement for
kdump on ppc64.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Tested-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Signed-off-by: Pingfan Liu <kernelfans@gmail.com> (separate the logical for
               cpu id mapping and stick to the semantics of nr_cpus)

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 arch/powerpc/include/asm/paca.h |  3 +++
 arch/powerpc/kernel/paca.c      | 19 ++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index b62c310..49ab29d 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -49,6 +49,9 @@ extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
 #define get_lppaca()	(get_paca()->lppaca_ptr)
 #define get_slb_shadow()	(get_paca()->slb_shadow_ptr)
 
+/* Maximum number of threads per core. */
+#define	MAX_SMT		8
+
 struct task_struct;
 
 /*
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 95ffedf..9c6f135 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -209,6 +209,7 @@ void __init allocate_pacas(void)
 {
 	u64 limit;
 	int cpu;
+	unsigned int nr_cpus_aligned;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	/*
@@ -220,20 +221,28 @@ void __init allocate_pacas(void)
 	limit = ppc64_rma_size;
 #endif
 
-	paca_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpu_ids);
+	/*
+	 * Alloc the paca[] align up to SMT threads.
+	 * This will help us to prepare for a situation where
+	 * boot cpu id > nr_cpus.
+	 * We keep the semantics of nr_cpus in kernel cmdline, but
+	 * waste a bit memory
+	 */
+	nr_cpus_aligned = _ALIGN_UP(nr_cpu_ids, MAX_SMT);
+	paca_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpus_aligned);
 
 	paca = __va(memblock_alloc_base(paca_size, PAGE_SIZE, limit));
 	memset(paca, 0, paca_size);
 
 	printk(KERN_DEBUG "Allocated %u bytes for %u pacas at %p\n",
-		paca_size, nr_cpu_ids, paca);
+		paca_size, nr_cpus_aligned, paca);
 
-	allocate_lppacas(nr_cpu_ids, limit);
+	allocate_lppacas(nr_cpus_aligned, limit);
 
-	allocate_slb_shadows(nr_cpu_ids, limit);
+	allocate_slb_shadows(nr_cpus_aligned, limit);
 
 	/* Can't use for_each_*_cpu, as they aren't functional yet */
-	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
+	for (cpu = 0; cpu < nr_cpus_aligned; cpu++)
 		initialise_paca(&paca[cpu], cpu);
 }
 
-- 
2.7.4
