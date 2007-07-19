Return-Path: <avi@qumranet.com>
Received: from il.qumranet.com (il.qumranet.com [82.166.9.18])
	by ozlabs.org (Postfix) with ESMTP id D0A22DDF0C
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 01:57:59 +1000 (EST)
From: Avi Kivity <avi@qumranet.com>
To: paulus@samba.org
Subject: [PATCH] powerpc: Allow smp_call_function_single() to current cpu
Date: Thu, 19 Jul 2007 18:33:48 +0300
Message-Id: <11848592284075-git-send-email-avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, Avi Kivity <avi@qumranet.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This removes the requirement for callers to get_cpu() to check in simple
cases.  i386 and x86_64 already received a similar treatment.

Signed-off-by: Avi Kivity <avi@qumranet.com>
---
 arch/powerpc/kernel/smp.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index d577b71..087c92f 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -284,7 +284,7 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info, int
 			int wait)
 {
 	cpumask_t map = CPU_MASK_NONE;
-	int ret = -EBUSY;
+	int ret = 0;
 
 	if (!cpu_online(cpu))
 		return -EINVAL;
@@ -292,6 +292,11 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info, int
 	cpu_set(cpu, map);
 	if (cpu != get_cpu())
 		ret = smp_call_function_map(func,info,nonatomic,wait,map);
+	else {
+		local_irq_disable();
+		func(info);
+		local_irq_enable();
+	}
 	put_cpu();
 	return ret;
 }
-- 
1.5.2.4
