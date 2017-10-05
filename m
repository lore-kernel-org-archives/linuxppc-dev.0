Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6tLY2VqxzDr1B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 11:04:52 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9504CdK017202
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Oct 2017 20:04:50 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dd94j1wdb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Oct 2017 20:04:50 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 4 Oct 2017 18:04:49 -0600
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Daniel Black <daniel.black@au1.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Drop lockdep_assert_cpus_held call from
 arch_update_cpu_topology
Date: Wed,  4 Oct 2017 21:04:30 -0300
Message-Id: <20171005000430.8080-1-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It turns out that not all paths calling arch_update_cpu_topology hold
cpu_hotplug_lock, but that's ok because those paths aren't supposed to race
with any concurrent hotplug events.

Callers of arch_update_cpu_topology are expected to know what they are
doing when they call the function without holding the lock, so remove the
lockdep warning.

Here are two reported splats that turned out to be harmless (as far as
I know, at least):

[  255.654622] ------------[ cut here ]------------
[  255.654658] WARNING: CPU: 1 PID: 14 at kernel/cpu.c:240 lockdep_assert_cpus_held+0x54/0x80
[  255.654661] Modules linked in: bridge stp llc binfmt_misc kvm_hv kvm leds_powernv vmx_crypto powernv_rng rng_core led_class powernv_op_panel autofs4 xfs btrfs lzo_compress raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c multipath mlx4_en raid10 crc32c_vpmsum lpfc be2net crc_t10dif crct10dif_generic crct10dif_common mlx4_core
[  255.654734] CPU: 1 PID: 14 Comm: cpuhp/1 Tainted: G        W       4.13.0 #1
[  255.654737] task: c000001ff25fa100 task.stack: c000001ff2578000
[  255.654740] NIP: c0000000000f8624 LR: c0000000000f8618 CTR: c0000000001763e0
[  255.654742] REGS: c000001ff257b780 TRAP: 0700   Tainted: G        W        (4.13.0)
[  255.654744] MSR: 9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>
[  255.654764]   CR: 24200422  XER: 00000000
[  255.654766] CFAR: c0000000001783d0 SOFTE: 1
               GPR00: c0000000000f8618 c000001ff257ba00 c000000001042100 0000000000000000
               GPR04: ffffffffffffffff 0000000000000001 0000000000000000 0000000000000000
               GPR08: 0000001ffe490000 0000000000000000 0000000000000000 c000007fee782f50
               GPR12: 0000000000000000 c00000000fd80500 c00000000012c878 c000001ff6209180
               GPR16: 0000000000000000 0000000000000000 c000000000ef2728 0000000000000000
               GPR20: 0000000000000000 0000000000000000 0000000000000001 0000000000000000
               GPR24: 0000000000000000 c000000001087d50 c000000000fe0e7d c0000000001448c0
               GPR28: 0000001ffe490000 0000000000000000 0000000000000002 c000000001088050
[  255.654842] NIP [c0000000000f8624] lockdep_assert_cpus_held+0x54/0x80
[  255.654845] LR [c0000000000f8618] lockdep_assert_cpus_held+0x48/0x80
[  255.654847] Call Trace:
[  255.654851] [c000001ff257ba00] [c0000000000f8618] lockdep_assert_cpus_held+0x48/0x80 (unreliable)
[  255.654858] [c000001ff257ba20] [c00000000007a848] arch_update_cpu_topology+0x18/0x30
[  255.654864] [c000001ff257ba40] [c00000000016bd0c] partition_sched_domains+0x8c/0x4e0
[  255.654870] [c000001ff257baf0] [c00000000020a914] cpuset_update_active_cpus+0x24/0x60
[  255.654876] [c000001ff257bb10] [c0000000001449bc] sched_cpu_deactivate+0xfc/0x1a0
[  255.654882] [c000001ff257bc20] [c0000000000f5a8c] cpuhp_invoke_callback+0x19c/0xe00
[  255.654888] [c000001ff257bcb0] [c0000000000f6868] cpuhp_down_callbacks+0x78/0xf0
[  255.654893] [c000001ff257bd00] [c0000000000f6c1c] cpuhp_thread_fun+0x1fc/0x210
[  255.654899] [c000001ff257bd50] [c000000000132f4c] smpboot_thread_fn+0x2fc/0x370
[  255.654905] [c000001ff257bdc0] [c00000000012ca24] kthread+0x1b4/0x1c0
[  255.654911] [c000001ff257be30] [c00000000000bcec] ret_from_kernel_thread+0x5c/0x70
[  255.654914] Instruction dump:
[  255.654919] 4e800020 60000000 60420000 7c0802a6 3c62ffeb 3880ffff 38639280 f8010030
[  255.654934] 4807fd45 60000000 2fa30000 409e0020 <0fe00000> e8010030 38210020 7c0803a6
[  255.654950] ---[ end trace 06efa323f571f14b ]---
[  255.894356] ------------[ cut here ]------------

and:

[    2.862745] ------------[ cut here ]------------
[    2.862772] WARNING: CPU: 0 PID: 1 at kernel/cpu.c:240 lockdep_assert_cpus_held+0x5c/0x70
[    2.862784] Modules linked in:
[    2.862819] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-00083-gb38923a #1
[    2.862835] task: c000003ff3280000 task.stack: c000003ff6104000
[    2.862847] NIP:  c00000000010ac7c LR: c00000000010ac70 CTR: 0000000000000000
[    2.862862] REGS: c000003ff61078d0 TRAP: 0700   Not tainted  (4.13.0-00083-gb38923a)
[    2.862874] MSR:  9000000002029033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000022  XER: 00000000
[    2.863046] CFAR: c000000000190bbc SOFTE: 1
               GPR00: c00000000010ac70 c000003ff6107b50 c000000001150500 0000000000000000
               GPR04: c000000000fdbe60 0000000000000000 c00000000123c5f8 0000000000000000
               GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
               GPR12: 0000000024000082 c00000000fd40000 c00000000000dc08 0000000000000000
               GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
               GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
               GPR24: 0000000000000000 c000000000eb392c 0000000000000000 c000000000f2bdb0
               GPR28: 0000000000000000 0000000000000000 c000000001199050 c00000000123c4f8
[    2.863597] NIP [c00000000010ac7c] lockdep_assert_cpus_held+0x5c/0x70
[    2.863612] LR [c00000000010ac70] lockdep_assert_cpus_held+0x50/0x70
[    2.863627] Call Trace:
[    2.863642] [c000003ff6107b50] [c00000000010ac70] lockdep_assert_cpus_held+0x50/0x70 (unreliable)
[    2.863692] [c000003ff6107b70] [c0000000000802c0] arch_update_cpu_topology+0x20/0x40
[    2.863724] [c000003ff6107b90] [c000000000182ec4] sched_init_domains+0x74/0x100
[    2.863752] [c000003ff6107bd0] [c000000000ed5c78] sched_init_smp+0x58/0x168
[    2.863783] [c000003ff6107d00] [c000000000eb460c] kernel_init_freeable+0x1fc/0x3ac
[    2.863818] [c000003ff6107dc0] [c00000000000dc2c] kernel_init+0x2c/0x150
[    2.863852] [c000003ff6107e30] [c00000000000bcec] ret_from_kernel_thread+0x5c/0x70
[    2.863886] Instruction dump:
[    2.863915] 409e0014 38210020 e8010010 7c0803a6 4e800020 3c62ffe9 3880ffff 3863b960
[    2.864036] 48085e3d 60000000 2fa30000 409effd8 <0fe00000> 38210020 e8010010 7c0803a6
[    2.864172] ---[ end trace 240e34251693e732 ]---

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Fixes: 3e401f7a2e51 ("powerpc: Only obtain cpu_hotplug_lock if called by rtasd")
Link: https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-September/163244.html
Link: https://github.com/linuxppc/linux/issues/106
---
 arch/powerpc/mm/numa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b95c584ce19d..a51df9ef529d 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1438,7 +1438,6 @@ int numa_update_cpu_topology(bool cpus_locked)
 
 int arch_update_cpu_topology(void)
 {
-	lockdep_assert_cpus_held();
 	return numa_update_cpu_topology(true);
 }
 
