Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BF3D7B6F01
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 16:17:00 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id o696ELQY019057
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:14:21 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o696Gx4r454738
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:16:59 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o696Gx1i012763
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:16:59 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/13] powerpc/book3e: More doorbell cleanups. Sample the PIR
	register
Date: Fri,  9 Jul 2010 16:16:46 +1000
Message-Id: <1278656215-24705-4-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1278656215-24705-3-git-send-email-benh@kernel.crashing.org>
References: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-3-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The doorbells use the content of the PIR register to match messages
from other CPUs. This may or may not be the same as our linux CPU
number, so using that as the "target" is no right.

Instead, we sample the PIR register at boot on every processor
and use that value subsequently when sending IPIs.

We also use a per-cpu message mask rather than a global array which
should limit cache line contention.

Note: We could use the CPU number in the device-tree instead of
the PIR register, as they are supposed to be equivalent. This
might prove useful if doorbells are to be used to kick CPUs out
of FW at boot time, thus before we can sample the PIR. This is
however not the case now and using the PIR just works.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/dbell.h  |    7 ++---
 arch/powerpc/kernel/dbell.c       |   47 ++++++++++++++++++++++++++----------
 arch/powerpc/platforms/85xx/smp.c |    4 ++-
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 501189a..ced7e48 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -27,10 +27,9 @@ enum ppc_dbell {
 	PPC_G_DBELL_MC = 4,	/* guest mcheck doorbell */
 };
 
-#ifdef CONFIG_SMP
-extern unsigned long dbell_smp_message[NR_CPUS];
-extern void smp_dbell_message_pass(int target, int msg);
-#endif
+extern void doorbell_message_pass(int target, int msg);
+extern void doorbell_exception(struct pt_regs *regs);
+extern void doorbell_setup_this_cpu(void);
 
 static inline void ppc_msgsnd(enum ppc_dbell type, u32 flags, u32 tag)
 {
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index e3a7177..1c7a945 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -13,45 +13,66 @@
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
+#include <linux/percpu.h>
 
 #include <asm/dbell.h>
 
 #ifdef CONFIG_SMP
-unsigned long dbell_smp_message[NR_CPUS];
+struct doorbell_cpu_info {
+	unsigned long	messages;	/* current messages bits */
+	unsigned int	tag;		/* tag value */
+};
 
-void smp_dbell_message_pass(int target, int msg)
+static DEFINE_PER_CPU(struct doorbell_cpu_info, doorbell_cpu_info);
+
+void doorbell_setup_this_cpu(void)
+{
+	struct doorbell_cpu_info *info = &__get_cpu_var(doorbell_cpu_info);
+
+	info->messages = 0;
+	info->tag = mfspr(SPRN_PIR) & 0x3fff;
+}
+
+void doorbell_message_pass(int target, int msg)
 {
+	struct doorbell_cpu_info *info;
 	int i;
 
-	if(target < NR_CPUS) {
-		set_bit(msg, &dbell_smp_message[target]);
-		ppc_msgsnd(PPC_DBELL, 0, target);
+	if (target < NR_CPUS) {
+		info = &per_cpu(doorbell_cpu_info, target);
+		set_bit(msg, &info->messages);
+		ppc_msgsnd(PPC_DBELL, 0, info->tag);
 	}
-	else if(target == MSG_ALL_BUT_SELF) {
+	else if (target == MSG_ALL_BUT_SELF) {
 		for_each_online_cpu(i) {
 			if (i == smp_processor_id())
 				continue;
-			set_bit(msg, &dbell_smp_message[i]);
-			ppc_msgsnd(PPC_DBELL, 0, i);
+			info = &per_cpu(doorbell_cpu_info, i);
+			set_bit(msg, &info->messages);
+			ppc_msgsnd(PPC_DBELL, 0, info->tag);
 		}
 	}
 	else { /* target == MSG_ALL */
-		for_each_online_cpu(i)
-			set_bit(msg, &dbell_smp_message[i]);
+		for_each_online_cpu(i) {
+			info = &per_cpu(doorbell_cpu_info, i);
+			set_bit(msg, &info->messages);
+		}
 		ppc_msgsnd(PPC_DBELL, PPC_DBELL_MSG_BRDCAST, 0);
 	}
 }
 
 void doorbell_exception(struct pt_regs *regs)
 {
-	int cpu = smp_processor_id();
+	struct doorbell_cpu_info *info = &__get_cpu_var(doorbell_cpu_info);
 	int msg;
 
-	if (num_online_cpus() < 2)
+	/* Warning: regs can be NULL when called from irq enable */
+
+	if (!info->messages || (num_online_cpus() < 2))
 		return;
 
 	for (msg = 0; msg < 4; msg++)
-		if (test_and_clear_bit(msg, &dbell_smp_message[cpu]))
+		if (test_and_clear_bit(msg, &info->messages))
 			smp_message_recv(msg);
 }
 
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index a15f582..4c3cde9 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -99,6 +99,8 @@ static void __init
 smp_85xx_setup_cpu(int cpu_nr)
 {
 	mpic_setup_this_cpu();
+	if (cpu_has_feature(CPU_FTR_DBELL))
+		doorbell_setup_this_cpu();
 }
 
 struct smp_ops_t smp_85xx_ops = {
@@ -117,7 +119,7 @@ void __init mpc85xx_smp_init(void)
 	}
 
 	if (cpu_has_feature(CPU_FTR_DBELL))
-		smp_85xx_ops.message_pass = smp_dbell_message_pass;
+		smp_85xx_ops.message_pass = doorbell_message_pass;
 
 	BUG_ON(!smp_85xx_ops.message_pass);
 
-- 
1.6.3.3
