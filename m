Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgZMX0G5czF11v
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 18:45:27 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id j9so8759130pgp.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 23:45:27 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: IMC fix out of bounds memory access at
 shutdown
Date: Tue, 13 Feb 2018 17:45:11 +1000
Message-Id: <20180213074511.6210-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The OPAL IMC driver's shutdown handler disables nest PMU counters by
walking nodes and taking the first CPU out of their cpumask, which is
used to index into the paca (get_hard_smp_processor_id()). This does
not always do the right thing, and in particular for CPU-less nodes it
returns NR_CPUS and that overruns the paca and dereferences random
memory.

Fix it by being more careful about checking returned CPU, and only
using online CPUs. It's not clear this shutdown code makes sense
after commit 885dcd709b ("powerpc/perf: Add nest IMC PMU support"),
but this should not make things worse

Changing the way pacas are allocated to an array of pointers exposed
this bug:

Unable to handle kernel paging request for data at address 0x2a21af1eeb000076
Faulting instruction address: 0xc0000000000a5468
Oops: Kernel access of bad area, sig: 11 [#1]
LE SMP NR_CPUS=2048 NUMA PowerNV
Modules linked in: iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp tun bridge stp llc iptable_filter ib_ipoib ib_cm ib_core kvm_hv kvm binfmt_misc vmx_crypto dm_multipath scsi_dh_rdac scsi_dh_alua ip_tables x_tables autofs4 crc32c_vpmsum
CPU: 52 PID: 1 Comm: systemd-shutdow Not tainted 4.15.0-12636-g3f1ac76cdc8f-dirty #134
NIP:  c0000000000a5468 LR: c0000000000a5454 CTR: 0000000000000000
REGS: c000200e58403870 TRAP: 0380   Not tainted  (4.15.0-12636-g3f1ac76cdc8f-dirty)
MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28288422  XER: 20040000
CFAR: c000000000152354 SOFTE: 0
GPR00: c0000000000a5454 c000200e58403af0 c000000001093f00 0000000000000001
GPR04: 0000000000000001 00000000000004dc c000200e609a0000 000000000001b3bc
GPR08: c0000000010d0b98 2a21af1eeb000046 c000200fff7fc000 0000000000000000
GPR12: 0000000000008000 c000000ffffeb800 0000000133f97b10 0000000000000000
GPR16: 00007ffff2e9dcc8 0000000133faf4a0 0000000133f97310 0000000000000000
GPR20: 0000000133f97e80 0000000133f97d80 0000000133f97470 0000000133f97aa8
GPR24: c0000000010cfb70 c000000000d20d68 c000000000d20d78 c000000000d30438
GPR28: c000000000d20d88 0000000000000800 c0000000010d10b8 00000000000000fc
NIP [c0000000000a5468] opal_imc_counters_shutdown+0x148/0x1d0
LR [c0000000000a5454] opal_imc_counters_shutdown+0x134/0x1d0
Call Trace:
[c000200e58403af0] [c0000000000a5454] opal_imc_counters_shutdown+0x134/0x1d0 (unreliable)
[c000200e58403b90] [c000000000723734] platform_drv_shutdown+0x44/0x60
[c000200e58403bb0] [c00000000071df58] device_shutdown+0x1f8/0x350
[c000200e58403c50] [c00000000010bbd4] kernel_restart_prepare+0x54/0x70
[c000200e58403c70] [c00000000010bd28] kernel_restart+0x28/0xc0
[c000200e58403ce0] [c00000000010c210] SyS_reboot+0x1d0/0x2c0
[c000200e58403e30] [c00000000000b920] system_call+0x58/0x6c
Instruction dump:
48512459 60000000 7fe4fb78 7c7d07b4 7f63db78 7fa5eb78 480acebd 60000000
e9580000 7ba91f24 38600001 7d2a482a <a8890030> 4bfe84a9 60000000 7fa5eb78
---[ end trace 8e58676c4eb8656a ]---

Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-imc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index dd4c9b8b8a81..f6f55ab4980e 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -199,9 +199,11 @@ static void disable_nest_pmu_counters(void)
 	const struct cpumask *l_cpumask;
 
 	get_online_cpus();
-	for_each_online_node(nid) {
+	for_each_node_with_cpus(nid) {
 		l_cpumask = cpumask_of_node(nid);
-		cpu = cpumask_first(l_cpumask);
+		cpu = cpumask_first_and(l_cpumask, cpu_online_mask);
+		if (cpu >= nr_cpu_ids)
+			continue;
 		opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST,
 				       get_hard_smp_processor_id(cpu));
 	}
-- 
2.16.1
