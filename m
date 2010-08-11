Return-Path: <brking@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D23E5B70CE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 06:35:24 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7BKRqCg014204
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Aug 2010 14:27:52 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7BKYxCT092840
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Aug 2010 14:35:04 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o7BKYv6a013830
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Aug 2010 14:34:58 -0600
Message-Id: <201008112034.o7BKYvEJ013392@d03av04.boulder.ibm.com>
Subject: [PATCH 1/1] powerpc: Clear cpu_sibling_map in cpu_die
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Wed, 11 Aug 2010 15:34:56 -0500
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


While testing CPU DLPAR, the following problem was discovered.
We were DLPAR removing the first CPU, which in this case was
logical CPUs 0-3. CPUs 0-2 were already marked offline and
we were in the process of offlining CPU 3. After marking
the CPU inactive and offline in cpu_disable, but before the
cpu was completely idle (cpu_die), we ended up in __make_request
on CPU 3. There we looked at the topology map to see which CPU
to complete the I/O on and found no CPUs in the cpu_sibling_map.
This resulted in the block layer setting the completion cpu
to be NR_CPUS, which then caused an oops when we tried to
complete the I/O.

Fix this by delaying clearing the sibling map of the cpu we
are offlining for the cpu we are offlining until cpu_die.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/smp.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff -puN arch/powerpc/kernel/smp.c~powerpc_sibling_map_offline arch/powerpc/kernel/smp.c
--- linux-2.6/arch/powerpc/kernel/smp.c~powerpc_sibling_map_offline	2010-08-09 16:49:47.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/kernel/smp.c	2010-08-09 16:49:47.000000000 -0500
@@ -598,8 +598,11 @@ int __cpu_disable(void)
 	/* Update sibling maps */
 	base = cpu_first_thread_in_core(cpu);
 	for (i = 0; i < threads_per_core; i++) {
-		cpumask_clear_cpu(cpu, cpu_sibling_mask(base + i));
-		cpumask_clear_cpu(base + i, cpu_sibling_mask(cpu));
+		if ((base + i) != cpu) {
+			cpumask_clear_cpu(cpu, cpu_sibling_mask(base + i));
+			cpumask_clear_cpu(base + i, cpu_sibling_mask(cpu));
+		}
+
 		cpumask_clear_cpu(cpu, cpu_core_mask(base + i));
 		cpumask_clear_cpu(base + i, cpu_core_mask(cpu));
 	}
@@ -641,6 +644,8 @@ void cpu_hotplug_driver_unlock()
 
 void cpu_die(void)
 {
+	cpumask_clear_cpu(smp_processor_id(), cpu_sibling_mask(smp_processor_id()));
+
 	if (ppc_md.cpu_die)
 		ppc_md.cpu_die();
 }
_
