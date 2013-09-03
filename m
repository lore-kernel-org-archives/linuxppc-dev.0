Return-Path: <paulus@ozlabs.org>
Date: Tue, 3 Sep 2013 20:16:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: xmon: Fix printing of set of CPUs in xmon
Message-ID: <20130903101623.GA12878@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 24ec2125f3 ("powerpc/xmon: Use cpumask iterator to avoid warning")
replaced a loop from 0 to NR_CPUS-1 with a for_each_possible_cpu() loop,
which means that if the last possible cpu is in xmon, we print the
wrong value for the end of the range.  For example, if 4 cpus are
possible, NR_CPUS is 128, and all cpus are in xmon, we print "0-7f"
rather than "0-3".  The code also assumes that the set of possible
cpus is contiguous, which may not necessarily be true.

This fixes the code to check explicitly for contiguity, and to print
the ending value correctly.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/xmon/xmon.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 1fcdc2e..a7f176c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -972,27 +972,27 @@ static void bootcmds(void)
 static int cpu_cmd(void)
 {
 #ifdef CONFIG_SMP
-	unsigned long cpu;
+	unsigned long cpu, first_cpu, last_cpu;
 	int timeout;
-	int count;
 
 	if (!scanhex(&cpu)) {
 		/* print cpus waiting or in xmon */
 		printf("cpus stopped:");
-		count = 0;
+		last_cpu = first_cpu = NR_CPUS;
 		for_each_possible_cpu(cpu) {
 			if (cpumask_test_cpu(cpu, &cpus_in_xmon)) {
-				if (count == 0)
-					printf(" %x", cpu);
-				++count;
-			} else {
-				if (count > 1)
-					printf("-%x", cpu - 1);
-				count = 0;
+				if (cpu == last_cpu + 1) {
+					last_cpu = cpu;
+				} else {
+					if (last_cpu != first_cpu)
+						printf("-%lx", last_cpu);
+					last_cpu = first_cpu = cpu;
+					printf(" %lx", cpu);
+				}
 			}
 		}
-		if (count > 1)
-			printf("-%x", NR_CPUS - 1);
+		if (last_cpu != first_cpu)
+			printf("-%lx", last_cpu);
 		printf("\n");
 		return 0;
 	}
-- 
1.8.4.rc3
