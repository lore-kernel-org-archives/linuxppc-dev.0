Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 043F61007E8
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 16:17:01 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id o696H79v019771
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:07 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o696H1hw1253450
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:01 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o696H0j1011392
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:01 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/13] powerpc/book3e: Use set_irq_regs() in the msgsnd/msgrcv
	IPI path
Date: Fri,  9 Jul 2010 16:16:49 +1000
Message-Id: <1278656215-24705-7-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1278656215-24705-6-git-send-email-benh@kernel.crashing.org>
References: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-3-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-4-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-5-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-6-git-send-email-benh@kernel.crashing.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Gibson <david@gibson.dropbear.id.au>

include/asm-generic/irq_regs.h declares per-cpu irq_regs variables and
get_irq_regs() and set_irq_regs() helper functions to maintain them.
These can be used to access the proper pt_regs structure related to the
current interrupt entry (if any).

In the powerpc arch code, this is used to maintain irq regs on
decrementer and external interrupt exceptions.  However, for the
doorbell exceptions used by the msgsnd/msgrcv IPI mechanism of newer
BookE CPUs, the irq_regs are not kept up to date.

In particular this means that xmon will not work properly on SMP,
because the secondary xmon instances started by IPI will blow up when
they cannot retrieve the irq regs.

This patch fixes the problem by adding calls to maintain the irq regs
across doorbell exceptions.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/dbell.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index 1c7a945..f7b5188 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -16,6 +16,7 @@
 #include <linux/percpu.h>
 
 #include <asm/dbell.h>
+#include <asm/irq_regs.h>
 
 #ifdef CONFIG_SMP
 struct doorbell_cpu_info {
@@ -63,17 +64,21 @@ void doorbell_message_pass(int target, int msg)
 
 void doorbell_exception(struct pt_regs *regs)
 {
+	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct doorbell_cpu_info *info = &__get_cpu_var(doorbell_cpu_info);
 	int msg;
 
 	/* Warning: regs can be NULL when called from irq enable */
 
 	if (!info->messages || (num_online_cpus() < 2))
-		return;
+		goto out;
 
 	for (msg = 0; msg < 4; msg++)
 		if (test_and_clear_bit(msg, &info->messages))
 			smp_message_recv(msg);
+
+out:
+	set_irq_regs(old_regs);
 }
 
 #else /* CONFIG_SMP */
-- 
1.6.3.3
