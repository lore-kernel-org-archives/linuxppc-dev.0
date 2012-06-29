Return-Path: <anton@samba.org>
Date: Fri, 29 Jun 2012 15:28:57 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Use cpumask iterator to avoid warning in xmon
Message-ID: <20120629152857.41ac747d@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We have a bug report where the kernel hits a warning in the cpumask
code:

WARNING: at include/linux/cpumask.h:107

Which is:
        WARN_ON_ONCE(cpu >= nr_cpumask_bits);

The backtrace is:
        cpu_cmd
        cmds
        xmon_core
        xmon
        die

xmon is iterating through 0 to NR_CPUS. I'm not sure why we are still
open coding this but iterating above nr_cpu_ids is definitely a bug.

This patch iterates through all possible cpus, in case we issue a
system reset and CPUs in an offline state call in.

Perhaps the old code was trying to handle CPUs that were in the
partition but were never started (eg kexec into a kernel with an
nr_cpus= boot option). They are going to die way before we get into
xmon since we haven't set any kernel state up for them.

Signed-off-by: Anton Blanchard <anton@samba.org>  
---
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 0f3ab06..eab3492 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -971,7 +971,7 @@ static int cpu_cmd(void)
 		/* print cpus waiting or in xmon */
 		printf("cpus stopped:");
 		count = 0;
-		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
+		for_each_possible_cpu(cpu) {
 			if (cpumask_test_cpu(cpu, &cpus_in_xmon)) {
 				if (count == 0)
 					printf(" %x", cpu);
