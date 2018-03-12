Return-Path: <kernelfans@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4005362FP0zDsMk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 15:43:30 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id s13so3133950pgn.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 21:43:30 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, mahesh@linux.vnet.ibm.com,
 cascardo@canonical.com, gpiccoli@linux.vnet.ibm.com, paulus@ozlabs.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au
Subject: [PATCHv4 2/3] powerpc,
 cpu: handling the special case when boot_cpuid greater than nr_cpus
Date: Mon, 12 Mar 2018 12:43:09 +0800
Message-Id: <1520829790-14029-3-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1520829790-14029-1-git-send-email-kernelfans@gmail.com>
References: <1520829790-14029-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For kexec -p, after boot_cpuid is mapping into the range of [0,
threads_per_core), then if nr_cpus is small, we will have the bitmap
[0,..., nr_cpus, ..., boot_cpuid, ...). This patch chooses cpus inside
the range of [boot_cpuid - nr_cpus +1, ..., boot_cpuid] to be online.

With this patch and the next, on a P9 machine with thread_per_core=4,
and set nr_cpus=2 for the crash kernel.
After
    taskset -c 11 sh -c "echo c > /proc/sysrq-trigger"
Then
    kdump:/sys/devices/system/cpu# cat possible
    2-3
    kdump:/sys/devices/system/cpu# cat present
    2-3
    kdump:/sys/devices/system/cpu# cat online
    2-3

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 arch/powerpc/kernel/setup-common.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 1a67344..6920b5e 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -462,6 +462,8 @@ void __init smp_setup_cpu_maps(void)
 	struct device_node *dn;
 	struct device_node *boot_dn = NULL;
 	bool handling_bootdn = true;
+	int head_thread = 0;
+	int online_cnt = 0;
 	int cpu = 0;
 	int nthreads = 1;
 
@@ -499,13 +501,19 @@ void __init smp_setup_cpu_maps(void)
 			if (boot_cpuid < nthreads &&
 				be32_to_cpu(intserv[boot_cpuid]) == boot_cpuhwid) {
 				boot_dn = dn;
+				/* choose a bunch of continous threads */
+				if (boot_cpuid > nr_cpu_ids - 1) {
+					head_thread = boot_cpuid - nr_cpu_ids + 1;
+					/* keep the mapping of logical and thread */
+					cpu = head_thread;
+				}
 			}
 			if (boot_dn == NULL)
 				continue;
 		} else if (dn == boot_dn)
 			continue;
 
-		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
+		for (j = head_thread; j < nthreads && online_cnt < nr_cpu_ids; j++) {
 			bool avail;
 
 			DBG("    thread %d -> cpu %d (hard id %d)\n",
@@ -520,13 +528,15 @@ void __init smp_setup_cpu_maps(void)
 			set_hard_smp_processor_id(cpu, be32_to_cpu(intserv[j]));
 			set_cpu_possible(cpu, true);
 			cpu++;
+			online_cnt++;
 		}
 
-		if (cpu >= nr_cpu_ids) {
+		if (online_cnt >= nr_cpu_ids) {
 			of_node_put(dn);
 			break;
 		}
 		if (handling_bootdn) {
+			head_thread = 0;
 			handling_bootdn = false;
 			goto again;
 		}
-- 
2.7.4
