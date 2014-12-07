Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B45271A04EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 09:09:23 +1100 (AEDT)
Received: by mail-wg0-f51.google.com with SMTP id k14so4859575wgh.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Dec 2014 14:09:20 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] arch: powerpc: kernel: smp.c:  Remove unused function
Date: Sun,  7 Dec 2014 23:11:59 +0100
Message-Id: <1417990319-19019-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Li Zhong <zhong@linux.vnet.ibm.com>,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, Rob Herring <robh+dt@kernel.org>,
 Anton Blanchard <anton@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the function generic_mach_cpu_die() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/powerpc/include/asm/smp.h |    1 -
 arch/powerpc/kernel/smp.c      |   14 --------------
 2 files changed, 15 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 5a6614a..d607df5 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -64,7 +64,6 @@ DECLARE_PER_CPU(unsigned int, cpu_pvr);
 extern void migrate_irqs(void);
 int generic_cpu_disable(void);
 void generic_cpu_die(unsigned int cpu);
-void generic_mach_cpu_die(void);
 void generic_set_cpu_dead(unsigned int cpu);
 void generic_set_cpu_up(unsigned int cpu);
 int generic_check_cpu_restart(unsigned int cpu);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 71e186d..83d4f3f 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -434,20 +434,6 @@ void generic_cpu_die(unsigned int cpu)
 	printk(KERN_ERR "CPU%d didn't die...\n", cpu);
 }
 
-void generic_mach_cpu_die(void)
-{
-	unsigned int cpu;
-
-	local_irq_disable();
-	idle_task_exit();
-	cpu = smp_processor_id();
-	printk(KERN_DEBUG "CPU%d offline\n", cpu);
-	__get_cpu_var(cpu_state) = CPU_DEAD;
-	smp_wmb();
-	while (__get_cpu_var(cpu_state) != CPU_UP_PREPARE)
-		cpu_relax();
-}
-
 void generic_set_cpu_dead(unsigned int cpu)
 {
 	per_cpu(cpu_state, cpu) = CPU_DEAD;
-- 
1.7.10.4
