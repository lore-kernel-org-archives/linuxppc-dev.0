Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F1E6C2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 20:20:54 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Thu, 16 May 2013 15:45:00 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E188FE0053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 15:53:05 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4GAKUoD10092904
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 15:50:30 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4GAKVMb008983
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 20:20:32 +1000
Message-ID: <1368699626.2618.183.camel@ThinkPad-T5421>
Subject: [RFC PATCH powerpc] Set cpu sibling mask before online cpu
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 16 May 2013 18:20:26 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It seems following race is possible:

	cpu0					cpux
smp_init->cpu_up->_cpu_up
	__cpu_up
		kick_cpu(1)
-------------------------------------------------------------------------
		waiting online			...
		...				notify CPU_STARTING
							set cpux active
						set cpux online
-------------------------------------------------------------------------
		finish waiting online
		...
sched_init_smp
	init_sched_domains(cpu_active_mask)
		build_sched_domains
						set cpux sibling info
-------------------------------------------------------------------------

Execution of cpu0 and cpux could be concurrent between two separator
lines.
			
So if the cpux sibling information was set too late (normally
impossible, but could be triggered by adding some delay in
start_secondary, after setting cpu online), build_sched_domains()
running on cpu0 might see cpux active, with an empty sibling mask, then
cause some bad address accessing like following:

[    0.099855] Unable to handle kernel paging request for data at address 0xc00000038518078f
[    0.099868] Faulting instruction address: 0xc0000000000b7a64
[    0.099883] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.099895] PREEMPT SMP NR_CPUS=16 DEBUG_PAGEALLOC NUMA pSeries
[    0.099922] Modules linked in:
[    0.099940] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0-rc1-00120-gb973425-dirty #16
[    0.099956] task: c0000001fed80000 ti: c0000001fed7c000 task.ti: c0000001fed7c000
[    0.099971] NIP: c0000000000b7a64 LR: c0000000000b7a40 CTR: c0000000000b4934
[    0.099985] REGS: c0000001fed7f760 TRAP: 0300   Not tainted  (3.10.0-rc1-00120-gb973425-dirty)
[    0.099997] MSR: 8000000000009032 <SF,EE,ME,IR,DR,RI>  CR: 24272828  XER: 20000003
[    0.100045] SOFTE: 1
[    0.100053] CFAR: c000000000445ee8
[    0.100064] DAR: c00000038518078f, DSISR: 40000000
[    0.100073] 
GPR00: 0000000000000080 c0000001fed7f9e0 c000000000c84d48 0000000000000010 
GPR04: 0000000000000010 0000000000000000 c0000001fc55e090 0000000000000000 
GPR08: ffffffffffffffff c000000000b80b30 c000000000c962d8 00000003845ffc5f 
GPR12: 0000000000000000 c00000000f33d000 c00000000000b9e4 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000001 0000000000000000 
GPR20: c000000000ccf750 0000000000000000 c000000000c94d48 c0000001fc504000 
GPR24: c0000001fc504000 c0000001fecef848 c000000000c94d48 c000000000ccf000 
GPR28: c0000001fc522090 0000000000000010 c0000001fecef848 c0000001fed7fae0 
[    0.100293] NIP [c0000000000b7a64] .get_group+0x84/0xc4
[    0.100307] LR [c0000000000b7a40] .get_group+0x60/0xc4
[    0.100318] Call Trace:
[    0.100332] [c0000001fed7f9e0] [c0000000000dbce4] .lock_is_held+0xa8/0xd0 (unreliable)
[    0.100354] [c0000001fed7fa70] [c0000000000bf62c] .build_sched_domains+0x728/0xd14
[    0.100375] [c0000001fed7fbe0] [c000000000af67bc] .sched_init_smp+0x4fc/0x654
[    0.100394] [c0000001fed7fce0] [c000000000adce24] .kernel_init_freeable+0x17c/0x30c
[    0.100413] [c0000001fed7fdb0] [c00000000000ba08] .kernel_init+0x24/0x12c
[    0.100431] [c0000001fed7fe30] [c000000000009f74] .ret_from_kernel_thread+0x5c/0x68
[    0.100445] Instruction dump:
[    0.100456] 38800010 38a00000 4838e3f5 60000000 7c6307b4 2fbf0000 419e0040 3d220001 
[    0.100496] 78601f24 39491590 e93e0008 7d6a002a <7d69582a> f97f0000 7d4a002a e93e0010 
[    0.100559] ---[ end trace 31fd0ba7d8756001 ]---

This patch tries to move the sibling maps updating before
notify_cpu_starting() and cpu online, and a write barrier there to make
sure sibling maps are updated before active and online mask. 

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index ee7ac5e..c765937 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -637,12 +637,10 @@ __cpuinit void start_secondary(void *unused)
 
 	vdso_getcpu_init();
 #endif
-	notify_cpu_starting(cpu);
-	set_cpu_online(cpu, true);
 	/* Update sibling maps */
 	base = cpu_first_thread_sibling(cpu);
 	for (i = 0; i < threads_per_core; i++) {
-		if (cpu_is_offline(base + i))
+		if (cpu_is_offline(base + i) && (cpu != base + i))
 			continue;
 		cpumask_set_cpu(cpu, cpu_sibling_mask(base + i));
 		cpumask_set_cpu(base + i, cpu_sibling_mask(cpu));
@@ -667,6 +665,10 @@ __cpuinit void start_secondary(void *unused)
 	}
 	of_node_put(l2_cache);
 
+	smp_wmb();
+	notify_cpu_starting(cpu);
+	set_cpu_online(cpu, true);
+
 	local_irq_enable();
 
 	cpu_startup_entry(CPUHP_ONLINE);
