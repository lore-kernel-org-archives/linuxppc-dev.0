Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A12462C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 18:43:41 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 20 Mar 2013 17:38:28 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B61F83578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 18:43:19 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2K7gjcH61341780
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 18:42:45 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2K7gnBu008016
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 18:42:49 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Add accounting for Doorbell interrupts
Date: Wed, 20 Mar 2013 18:42:12 +1100
Message-Id: <1363765332-28461-1-git-send-email-imunsie@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch adds a new line to /proc/interrupts to account for the
doorbell interrupts that each hardware thread has received. The total
interrupt count in /proc/stat will now also include doorbells.

 # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 16:        551       1267        281        175      XICS Level     IPI
LOC:       2037       1503       1688       1625   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
CNT:          0          0          0          0   Performance monitoring interrupts
MCE:          0          0          0          0   Machine check exceptions
DBL:         42        550         20         91   Doorbell interrupts

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/include/asm/hardirq.h |    1 +
 arch/powerpc/kernel/dbell.c        |    2 ++
 arch/powerpc/kernel/irq.c          |    8 ++++++++
 3 files changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index 3147a29..e88c5f2 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -10,6 +10,7 @@ typedef struct {
 	unsigned int pmu_irqs;
 	unsigned int mce_exceptions;
 	unsigned int spurious_irqs;
+	unsigned int doorbell_irqs;
 } ____cacheline_aligned irq_cpustat_t;
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index 9ebbc24..d55c76c 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -41,6 +41,8 @@ void doorbell_exception(struct pt_regs *regs)
 
 	may_hard_irq_enable();
 
+	__get_cpu_var(irq_stat).doorbell_irqs++;
+
 	smp_ipi_demux();
 
 	irq_exit();
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4f97fe3..3a3c3b9 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -374,6 +374,13 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%10u ", per_cpu(irq_stat, j).mce_exceptions);
 	seq_printf(p, "  Machine check exceptions\n");
 
+	if (cpu_has_feature(CPU_FTR_DBELL)) {
+		seq_printf(p, "%*s: ", prec, "DBL");
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", per_cpu(irq_stat, j).doorbell_irqs);
+		seq_printf(p, "  Doorbell interrupts\n");
+	}
+
 	return 0;
 }
 
@@ -387,6 +394,7 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 	sum += per_cpu(irq_stat, cpu).pmu_irqs;
 	sum += per_cpu(irq_stat, cpu).mce_exceptions;
 	sum += per_cpu(irq_stat, cpu).spurious_irqs;
+	sum += per_cpu(irq_stat, cpu).doorbell_irqs;
 
 	return sum;
 }
-- 
1.7.10.4
