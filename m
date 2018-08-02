Return-Path: <kernelfans@gmail.com>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hBFg0XTmzF27H
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 23:43:02 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id h12-v6so1225309pgs.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 06:43:02 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] powerpc/cpu: post the event cpux add/remove instead of
 online/offline during hotplug
Date: Thu,  2 Aug 2018 21:42:39 +0800
Message-Id: <1533217359-11420-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1533217359-11420-1-git-send-email-kernelfans@gmail.com>
References: <1533217359-11420-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Technically speaking, echo 1/0 > cpuX/online is only a subset of cpu
hotplug/unplug, i.e. add/remove. The latter one includes the physical
adding/removing of a cpu device. Some user space tools such as kexec-tools
resort to the event add/remove to automatically rebuild dtb.
If the dtb is not rebuilt correctly, we may hang on 2nd kernel due to
lack the info of boot-cpu-hwid in dtb.

The steps to trigger the bug: (suppose 8 threads/core)
    drmgr -c cpu -r -q 1
    systemctl restart kdump.service
    drmgr -c cpu -a -q 1
    taskset -c 11 sh -c "echo c > /proc/sysrq-trigger"

Then, failure info:
    [  205.299528] SysRq : Trigger a crash
    [  205.299551] Unable to handle kernel paging request for data at address 0x00000000
    [  205.299558] Faulting instruction address: 0xc0000000006001a0
    [  205.299564] Oops: Kernel access of bad area, sig: 11 [#1]
    [  205.299569] SMP NR_CPUS=2048 NUMA pSeries
    [  205.299575] Modules linked in: macsec sctp_diag sctp tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag ip6t_rpfilter ipt_REJECT nf_reject_ipv4 ip6t_REJECT nf_reject_ipv6
    xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw iptable_nat
    nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter xfs libcrc32c sg
    pseries_rng binfmt_misc ip_tables ext4 mbcache jbd2 sd_mod crc_t10dif crct10dif_generic crct10dif_common ibmvscsi scsi_transport_srp ibmveth scsi_tgt dm_mirror dm_region_hash dm_log dm_mod
    [  205.299658] CPU: 11 PID: 2521 Comm: bash Not tainted 3.10.0-799.el7.ppc64le #1
    [  205.299664] task: c00000017bcd15e0 ti: c00000014f410000 task.ti: c00000014f410000
    [  205.299670] NIP: c0000000006001a0 LR: c000000000600ddc CTR: c000000000600180
    [  205.299676] REGS: c00000014f413a70 TRAP: 0300   Not tainted  (3.10.0-799.el7.ppc64le)
    [  205.299681] MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28222822  XER: 00000001
    [  205.299696] CFAR: c000000000009368 DAR: 0000000000000000 DSISR: 42000000 SOFTE: 1
    GPR00: c000000000600dbc c00000014f413cf0 c000000001263200 0000000000000063
    GPR04: c0000000019ca818 c0000000019db5f8 00000000000000c2 c00000000140aa30
    GPR08: 0000000000000007 0000000000000001 0000000000000000 c00000000140fc60
    GPR12: c000000000600180 c000000007b36300 0000000010139e58 0000000040000000
    GPR16: 000000001013b5d0 0000000000000000 00000000101306fc 0000000010139de4
    GPR20: 0000000010139de8 0000000010093150 0000000000000000 0000000000000000
    GPR24: 000000001013b5e0 00000000100fa0e8 0000000000000007 c0000000011af1c8
    GPR28: 0000000000000063 c0000000011af588 c000000001179ba8 0000000000000002
    [  205.299770] NIP [c0000000006001a0] sysrq_handle_crash+0x20/0x30
    [  205.299776] LR [c000000000600ddc] write_sysrq_trigger+0x10c/0x230
    [  205.299781] Call Trace:
    [  205.299786] [c00000014f413cf0] [c000000000600dbc] write_sysrq_trigger+0xec/0x230 (unreliable)
    [  205.299794] [c00000014f413d90] [c0000000003eb2c4] proc_reg_write+0x84/0x120
    [  205.299801] [c00000014f413dd0] [c000000000330a80] SyS_write+0x150/0x400
    [  205.299808] [c00000014f413e30] [c00000000000a184] system_call+0x38/0xb4
    [  205.299813] Instruction dump:
    [  205.299816] 409effb8 7fc3f378 4bfff381 4bffffac 3c4c00c6 38423080 3d42fff1 394a6930
    [  205.299827] 39200001 912a0000 7c0004ac 39400000 <992a0000> 4e800020 60000000 60420000
    [  205.299838] ---[ end trace f590a5dbd3f63aab ]---
    [  205.301812]
    [  205.301829] Sending IPI to other CPUs
    [  205.302846] IPI complete
    I'm in purgatory
          -- > hang up here

This patch uses the interface register_/unregister_cpu to fix the problem.

Test the compatibility with ppc64_cpu on a powerKVM guest, with the
following topo:
  Thread(s) per core:  8
  Core(s) per socket:  2
  Socket(s):           2
  NUMA node(s):        1
and the following instructions:
  ppc64_cpu --smt=off
  drmgr -c cpu -r 1
  drmgr -c cpu -a 1
  ppc64_cpu --smt=on
or
  drmgr -c cpu -r 1
  ppc64_cpu --smt=off
  drmgr -c cpu -a 1
  ppc64_cpu --smt=on

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
v2 -> v3
  create sysfs file "dev_attr_physical_id" before cpu online callbacks,
  hence it can work with ppc64_cpu
---
 arch/powerpc/include/asm/setup.h             |  4 +++
 arch/powerpc/include/asm/smp.h               |  1 +
 arch/powerpc/kernel/sysfs.c                  | 38 +++++++++++++++++++++++-----
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 16 +++++++++++-
 4 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 8721fd0..e0597f2 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -40,6 +40,10 @@ static inline void pseries_big_endian_exceptions(void) {}
 static inline void pseries_little_endian_exceptions(void) {}
 #endif /* CONFIG_PPC_PSERIES */
 
+extern bool cpudev_is_dummy(int cpu);
+extern int register_ppc_cpu(int cpu);
+extern int unregister_ppc_cpu(int cpu);
+
 void rfi_flush_enable(bool enable);
 
 /* These are bit flags */
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 29ffaab..344180a 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -36,6 +36,7 @@ extern u32 *cpu_to_phys_id;
 extern void cpu_die(void);
 extern int cpu_to_chip_id(int cpu);
 
+DECLARE_PER_CPU(struct cpu, cpu_devices);
 #ifdef CONFIG_SMP
 
 struct smp_ops_t {
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 755dc98..2f6c9f9 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -27,7 +27,7 @@
 #include <asm/lppaca.h>
 #endif
 
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
+DEFINE_PER_CPU(struct cpu, cpu_devices);
 
 /*
  * SMT snooze delay stuff, 64-bit only for now
@@ -1025,6 +1025,35 @@ static ssize_t show_physical_id(struct device *dev,
 }
 static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
 
+/* unplugged cpu is true */
+bool cpudev_is_dummy(int cpu)
+{
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
+
+	return !kref_read(&c->dev.kobj.kref);
+}
+
+/* create all files in sysfs, which can not be postponed till cpu online
+ * callbacks
+ */
+int register_ppc_cpu(int cpu)
+{
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
+
+	register_cpu(c, cpu);
+	device_create_file(&c->dev, &dev_attr_physical_id);
+	return 0;
+}
+
+int unregister_ppc_cpu(int cpu)
+{
+	device_remove_file(&per_cpu(cpu_devices, cpu).dev,
+		&dev_attr_physical_id);
+	unregister_cpu(container_of(get_cpu_device(cpu),
+		struct cpu, dev));
+	return 0;
+}
+
 static int __init topology_init(void)
 {
 	int cpu, r;
@@ -1044,11 +1073,8 @@ static int __init topology_init(void)
 		if (ppc_md.cpu_die)
 			c->hotpluggable = 1;
 
-		if (cpu_online(cpu) || c->hotpluggable) {
-			register_cpu(c, cpu);
-
-			device_create_file(&c->dev, &dev_attr_physical_id);
-		}
+		if (cpu_online(cpu) || c->hotpluggable)
+			register_ppc_cpu(cpu);
 	}
 	r = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powerpc/topology:online",
 			      register_cpu_online, unregister_cpu_online);
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 6ef77ca..f361fc8 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -37,6 +37,7 @@
 #include <asm/xive.h>
 #include <asm/plpar_wrappers.h>
 #include <asm/topology.h>
+#include <asm/setup.h>
 
 #include "pseries.h"
 #include "offline_states.h"
@@ -367,6 +368,11 @@ static int dlpar_online_cpu(struct device_node *dn)
 			cpu_maps_update_done();
 			timed_topology_update(1);
 			find_and_online_cpu_nid(cpu);
+			/* protect against the offline's failure,
+			 * then re-online
+			 */
+			if (cpudev_is_dummy(cpu))
+				register_ppc_cpu(cpu);
 			rc = device_online(get_cpu_device(cpu));
 			if (rc)
 				goto out;
@@ -530,8 +536,12 @@ static int dlpar_offline_cpu(struct device_node *dn)
 			if (get_hard_smp_processor_id(cpu) != thread)
 				continue;
 
-			if (get_cpu_current_state(cpu) == CPU_STATE_OFFLINE)
+			if (get_cpu_current_state(cpu) == CPU_STATE_OFFLINE) {
+				cpu_maps_update_done();
+				unregister_ppc_cpu(cpu);
+				cpu_maps_update_begin();
 				break;
+			}
 
 			if (get_cpu_current_state(cpu) == CPU_STATE_ONLINE) {
 				set_preferred_offline_state(cpu,
@@ -541,6 +551,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
 				rc = device_offline(get_cpu_device(cpu));
 				if (rc)
 					goto out;
+				unregister_ppc_cpu(cpu);
 				cpu_maps_update_begin();
 				break;
 
@@ -554,6 +565,9 @@ static int dlpar_offline_cpu(struct device_node *dn)
 			BUG_ON(plpar_hcall_norets(H_PROD, thread)
 								!= H_SUCCESS);
 			__cpu_die(cpu);
+			cpu_maps_update_done();
+			unregister_ppc_cpu(cpu);
+			cpu_maps_update_begin();
 			break;
 		}
 		if (cpu == num_possible_cpus())
-- 
2.7.4
