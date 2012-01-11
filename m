Return-Path: <brking@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BEF16B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2012 04:00:19 +1100 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Wed, 11 Jan 2012 12:00:13 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q0BGu7V53031168
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 11:56:07 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0BGu3jw021559
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 14:56:04 -0200
Message-Id: <201201111655.q0BGtv4O021066@d01av02.pok.ibm.com>
Subject: [PATCH 1/1] powerpc: Fix partition migration hang in
 stop_topology_update
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Wed, 11 Jan 2012 10:56:04 -0600
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 jlarrew@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This fixes a hang that was observed during live partition migration.
Since stop_topology_update must not be called from an interrupt
context, call it earlier in the migration process. The hang observed
can be seen below: 

WARNING: at kernel/timer.c:1011
Modules linked in: ip6t_LOG xt_tcpudp xt_pkttype ipt_LOG xt_limit ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_raw xt_NOTRACK ipt_REJECT xt_state iptable_raw iptable_filter ip6table_mangle nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4 ip_tables ip6table_filter ip6_tables x_tables ipv6 fuse loop ibmveth sg ext3 jbd mbcache raid456 async_raid6_recov async_pq raid6_pq async_xor xor async_memcpy async_tx raid10 raid1 raid0 scsi_dh_alua scsi_dh_rdac scsi_dh_hp_sw scsi_dh_emc dm_round_robin dm_multipath scsi_dh sd_mod crc_t10dif ibmvfc scsi_transport_fc scsi_tgt scsi_mod dm_snapshot dm_mod
NIP: c0000000000c52d8 LR: c00000000004be28 CTR: 0000000000000000
REGS: c00000005ffd77d0 TRAP: 0700   Not tainted  (3.2.0-git-00001-g07d106d)
MSR: 8000000000021032 <ME,CE,IR,DR>  CR: 48000084  XER: 00000001
CFAR: c00000000004be20
TASK = c00000005ec78860[0] 'swapper/3' THREAD: c00000005ec98000 CPU: 3
GPR00: 0000000000000001 c00000005ffd7a50 c000000000fbbc98 c000000000ec8340
GPR04: 00000000282a0020 0000000000000000 0000000000004000 0000000000000101
GPR08: 0000000000000012 c00000005ffd4000 0000000000000020 c000000000f3ba88
GPR12: 0000000000000000 c000000007f40900 0000000000000001 0000000000000004
GPR16: 0000000000000001 0000000000000000 0000000000000000 c000000001022310
GPR20: 0000000000000001 0000000000000000 0000000000200200 c000000001029e14
GPR24: 0000000000000000 0000000000000001 0000000000000040 c00000003f74bc80
GPR28: c00000003f74bc84 c000000000f38038 c000000000f16b58 c000000000ec8340
NIP [c0000000000c52d8] .del_timer_sync+0x28/0x60
LR [c00000000004be28] .stop_topology_update+0x20/0x38
Call Trace:
[c00000005ffd7a50] [c00000005ec78860] 0xc00000005ec78860 (unreliable)
[c00000005ffd7ad0] [c00000000004be28] .stop_topology_update+0x20/0x38
[c00000005ffd7b40] [c000000000028378] .__rtas_suspend_last_cpu+0x58/0x260
[c00000005ffd7bf0] [c0000000000fa230] .generic_smp_call_function_interrupt+0x160/0x358
[c00000005ffd7cf0] [c000000000036ec8] .smp_ipi_demux+0x88/0x100
[c00000005ffd7d80] [c00000000005c154] .icp_hv_ipi_action+0x5c/0x80
[c00000005ffd7e00] [c00000000012a088] .handle_irq_event_percpu+0x100/0x318
[c00000005ffd7f00] [c00000000012e774] .handle_percpu_irq+0x84/0xd0
[c00000005ffd7f90] [c000000000022ba8] .call_handle_irq+0x1c/0x2c
[c00000005ec9ba20] [c00000000001157c] .do_IRQ+0x22c/0x2a8
[c00000005ec9bae0] [c0000000000054bc] hardware_interrupt_entry+0x18/0x1c
Exception: 501 at .cpu_idle+0x194/0x2f8
    LR = .cpu_idle+0x194/0x2f8
[c00000005ec9bdd0] [c000000000017e58] .cpu_idle+0x188/0x2f8 (unreliable)
[c00000005ec9be90] [c00000000067ec18] .start_secondary+0x3e4/0x524
[c00000005ec9bf90] [c0000000000093e8] .start_secondary_prolog+0x10/0x14
Instruction dump:
ebe1fff8 4e800020 fbe1fff8 7c0802a6 f8010010 7c7f1b78 f821ff81 78290464
80090014 5400019e 7c0000d0 78000fe0 <0b000000> 4800000c 7c210b78 7c421378

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/rtas.c               |    5 +++--
 arch/powerpc/platforms/pseries/suspend.c |    6 +++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff -puN arch/powerpc/kernel/rtas.c~powerpc_migration_vphn_fix arch/powerpc/kernel/rtas.c
--- linux-2.6/arch/powerpc/kernel/rtas.c~powerpc_migration_vphn_fix	2012-01-11 10:53:07.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/kernel/rtas.c	2012-01-11 10:53:07.000000000 -0600
@@ -716,7 +716,6 @@ static int __rtas_suspend_last_cpu(struc
 	int cpu;
 
 	slb_set_size(SLB_MIN_SIZE);
-	stop_topology_update();
 	printk(KERN_DEBUG "calling ibm,suspend-me on cpu %i\n", smp_processor_id());
 
 	while (rc == H_MULTI_THREADS_ACTIVE && !atomic_read(&data->done) &&
@@ -732,7 +731,6 @@ static int __rtas_suspend_last_cpu(struc
 		rc = atomic_read(&data->error);
 
 	atomic_set(&data->error, rc);
-	start_topology_update();
 	pSeries_coalesce_init();
 
 	if (wake_when_done) {
@@ -846,6 +844,7 @@ int rtas_ibm_suspend_me(struct rtas_args
 	atomic_set(&data.error, 0);
 	data.token = rtas_token("ibm,suspend-me");
 	data.complete = &done;
+	stop_topology_update();
 
 	/* Call function on all CPUs.  One of us will make the
 	 * rtas call
@@ -858,6 +857,8 @@ int rtas_ibm_suspend_me(struct rtas_args
 	if (atomic_read(&data.error) != 0)
 		printk(KERN_ERR "Error doing global join\n");
 
+	start_topology_update();
+
 	return atomic_read(&data.error);
 }
 #else /* CONFIG_PPC_PSERIES */
diff -puN arch/powerpc/platforms/pseries/suspend.c~powerpc_migration_vphn_fix arch/powerpc/platforms/pseries/suspend.c
--- linux-2.6/arch/powerpc/platforms/pseries/suspend.c~powerpc_migration_vphn_fix	2012-01-11 10:53:07.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/suspend.c	2012-01-11 10:53:07.000000000 -0600
@@ -24,6 +24,7 @@
 #include <asm/machdep.h>
 #include <asm/mmu.h>
 #include <asm/rtas.h>
+#include <asm/topology.h>
 
 static u64 stream_id;
 static struct device suspend_dev;
@@ -138,8 +139,11 @@ static ssize_t store_hibernate(struct de
 			ssleep(1);
 	} while (rc == -EAGAIN);
 
-	if (!rc)
+	if (!rc) {
+		stop_topology_update();
 		rc = pm_suspend(PM_SUSPEND_MEM);
+		start_topology_update();
+	}
 
 	stream_id = 0;
 
_
