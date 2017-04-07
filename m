Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w002M1pbdzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 22:56:27 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id g2so15399806pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Apr 2017 05:56:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/5] powerpc: Introduce msgsnd/doorbell barrier primitives
Date: Fri,  7 Apr 2017 22:56:00 +1000
Message-Id: <20170407125602.31146-4-npiggin@gmail.com>
In-Reply-To: <20170407125602.31146-1-npiggin@gmail.com>
References: <20170407125602.31146-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 changes requirements and adds new instructions for
synchronization.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/dbell.h | 22 ++++++++++++++++++++++
 arch/powerpc/include/asm/smp.h   |  1 +
 arch/powerpc/kernel/dbell.c      |  8 +++++---
 arch/powerpc/kernel/smp.c        | 10 ++++++++--
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 5a7301f333a4..4db4cfdd829c 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -44,6 +44,17 @@ static inline void _ppc_msgsnd(u32 msg)
 		__asm__ __volatile__ (PPC_MSGSNDP(%0) : : "r" (msg));
 }
 
+/* sync before sending message */
+static inline void ppc_msgsnd_sync(void)
+{
+	__asm__ __volatile__ ("sync" : : : "memory");
+}
+
+/* sync after taking message interrupt */
+static inline void ppc_msgsync(void)
+{
+}
+
 #else /* CONFIG_PPC_BOOK3S */
 
 #define PPC_DBELL_MSGTYPE		PPC_DBELL
@@ -53,6 +64,17 @@ static inline void _ppc_msgsnd(u32 msg)
 	__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
 }
 
+/* sync before sending message */
+static inline void ppc_msgsnd_sync(void)
+{
+	__asm__ __volatile__ ("sync" : : : "memory");
+}
+
+/* sync after taking message interrupt */
+static inline void ppc_msgsync(void)
+{
+}
+
 #endif /* CONFIG_PPC_BOOK3S */
 
 extern void global_doorbell_cause_ipi(int cpu);
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 0ada12e61fd7..0ee8a6cb1d87 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -128,6 +128,7 @@ extern const char *smp_ipi_name[];
 extern void smp_muxed_ipi_message_pass(int cpu, int msg);
 extern void smp_muxed_ipi_set_message(int cpu, int msg);
 extern irqreturn_t smp_ipi_demux(void);
+extern irqreturn_t smp_ipi_demux_relaxed(void);
 
 void smp_init_pSeries(void);
 void smp_init_cell(void);
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index 2b41f145de05..98de6d3d904e 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -38,7 +38,7 @@ void global_doorbell_cause_ipi(int cpu)
 
 	kvmppc_set_host_ipi(cpu, 1);
 	/* Order previous accesses vs. msgsnd, which is treated as a store */
-	mb();
+	ppc_msgsnd_sync();
 	ppc_msgsnd(PPC_DBELL_MSGTYPE, 0, tag);
 }
 
@@ -53,7 +53,7 @@ void core_doorbell_cause_ipi(int cpu)
 
 	kvmppc_set_host_ipi(cpu, 1);
 	/* Order previous accesses vs. msgsnd, which is treated as a store */
-	mb();
+	ppc_msgsnd_sync();
 	ppc_msgsnd(PPC_DBELL_MSGTYPE, 0, tag);
 }
 
@@ -82,12 +82,14 @@ void doorbell_exception(struct pt_regs *regs)
 
 	irq_enter();
 
+	ppc_msgsync();
+
 	may_hard_irq_enable();
 
 	kvmppc_set_host_ipi(smp_processor_id(), 0);
 	__this_cpu_inc(irq_stat.doorbell_irqs);
 
-	smp_ipi_demux();
+	smp_ipi_demux_relaxed(); /* already performed the barrier */
 
 	irq_exit();
 	set_irq_regs(old_regs);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index f1f6e4e3906b..fd2441591b81 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -246,11 +246,17 @@ void smp_muxed_ipi_message_pass(int cpu, int msg)
 
 irqreturn_t smp_ipi_demux(void)
 {
+	mb();	/* order any irq clear */
+
+	return smp_ipi_demux_relaxed();
+}
+
+/* sync-free variant. Callers should ensure synchronization */
+irqreturn_t smp_ipi_demux_relaxed(void)
+{
 	struct cpu_messages *info;
 	unsigned long all;
 
-	mb();	/* order any irq clear */
-
 	info = this_cpu_ptr(&ipi_message);
 	do {
 		all = xchg(&info->messages, 0);
-- 
2.11.0
