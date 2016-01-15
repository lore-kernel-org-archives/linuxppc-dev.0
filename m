Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C0751A0050
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2016 00:43:14 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Fri, 15 Jan 2016 06:43:12 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 3FA1F1FF0042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 06:31:18 -0700 (MST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0FDh72W32047252
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 13:43:07 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0FDcesf006617
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 08:38:41 -0500
Date: Fri, 15 Jan 2016 19:13:07 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, raghavendra.kt@linux.vnet.ibm.com,
 vdavydov@parallels.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, anton@samba.org, nacc@linux.vnet.ibm.com,
 gkurz@linux.vnet.ibm.com, grant.likely@linaro.org,
 nikunj@linux.vnet.ibm.com, Steve Best <sbest@redhat.com>,
 Gustavo Duarte <gduarte@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [BUG] PowerNV crash with 4.4.0-rc8 at sched_init_numa (related
 to commit c118baf80256)
Message-ID: <20160115134307.GA28330@linux.vnet.ibm.com>
Reply-To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
References: <1477405602.6296768.1452378871633.JavaMail.zimbra@redhat.com>
 <1258383100.6297154.1452380635681.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1258383100.6297154.1452380635681.JavaMail.zimbra@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Jan Stancek <jstancek@redhat.com> [2016-01-09 18:03:55]:

> Hi,
> 
> I'm seeing bare metal ppc64le system crashing early during boot
> with latest upstream kernel (4.4.0-rc8):
> 
> # git describe
> v4.4-rc8-96-g751e5f5
> 
> [    0.625451] Unable to handle kernel paging request for data at address 0x00000000
> [    0.625586] Faulting instruction address: 0xc0000000004ae000
> [    0.625698] Oops: Kernel access of bad area, sig: 11 [#1]
> [    0.625789] SMP NR_CPUS=2048 NUMA PowerNV
> [    0.625879] Modules linked in:
> [    0.625973] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.0-rc8+ #6
> [    0.626087] task: c000002ff4300000 ti: c000002ff6084000 task.ti: c000002ff6084000
> [    0.626224] NIP: c0000000004ae000 LR: c00000000090b9e4 CTR: 0000000000000003
> [    0.626361] REGS: c000002ff6087930 TRAP: 0300   Not tainted  (4.4.0-rc8+)
> [    0.626475] MSR: 9000000100009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 48002044  XER: 20000000
> [    0.626808] CFAR: c000000000008468 DAR: 0000000000000000 DSISR: 40000000 SOFTE: 1
> GPR00: c00000000090b9ac c000002ff6087bb0 c000000001700900 c000003ff229e080
> GPR04: c000003ff229e080 0000000000000000 0000000000000003 0000000000000001
> GPR08: 0000000000000000 0000000000000000 0000000000000010 9000000100001003
> GPR12: 0000000000002200 c00000000fb40000 c00000000000bd68 0000000000000002
> GPR16: 0000000000000028 c000000000b25940 c00000000173ffa4 0000000000000000
> GPR20: c000000000b259d8 c000000000b259e0 c000000000b259e8 0000000000000000
> GPR24: c000003ff229e080 0000000000000000 c00000000189b180 0000000000000000
> GPR28: 0000000000000000 c000000001740a94 0000000000000002 0000000000000002
> [    0.627925] NIP [c0000000004ae000] __bitmap_or+0x30/0x50
> [    0.627973] LR [c00000000090b9e4] sched_init_numa+0x440/0x7c8
> [    0.628030] Call Trace:
> [    0.628054] [c000002ff6087bb0] [c00000000090b9ac] sched_init_numa+0x408/0x7c8 (unreliable)
> [    0.628136] [c000002ff6087ca0] [c000000000c60718] sched_init_smp+0x60/0x238
> [    0.628206] [c000002ff6087d00] [c000000000c44294] kernel_init_freeable+0x1fc/0x3b4
> [    0.628286] [c000002ff6087dc0] [c00000000000bd84] kernel_init+0x24/0x140
> [    0.628356] [c000002ff6087e30] [c000000000009544] ret_from_kernel_thread+0x5c/0x98
> [    0.628435] Instruction dump:
> [    0.628470] 38c6003f 78c9d183 4d820020 38c9ffff 39200000 78c60020 38c60001 7cc903a6
> [    0.628587] 60000000 60000000 60000000 60420000 <7d05482a> 7d44482a 7d0a5378 7d43492a
> [    0.628711] ---[ end trace b423f3e02b333fbf ]---
> [    0.628757]
> [    2.628822] Kernel panic - not syncing: Fatal exception
> [    2.628969] Rebooting in 10 seconds..[    0.000000] OPAL V3 detected !
> 
.... 
> The crash goes away if I revert following commit:
>   commit c118baf802562688d46e6002f2b5fe66b947da21
>   Author: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>   Date:   Thu Nov 5 18:46:29 2015 -0800
>     arch/powerpc/mm/numa.c: do not allocate bootmem memory for non existing nodes
>

Something like below should fix. I 'll send it in a separate email 
 marking Peter and Ingo. Basically for_each_node conversion
has targeted only slowpaths / used_once sort of functions.
But it seems there was a cpumask_or in sched_init_numa that used
unallocated node.

Sorry for getting back late.. Was overcautious checking x86/power
w/ and w/o DEBUG_PER_CPU_MAPS

---8<----- 
>From 6680994a5a8dde7eccfbd2bffde341fdff2aed63 Mon Sep 17 00:00:00 2001
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Date: Fri, 15 Jan 2016 18:19:56 +0530
Subject: [PATCH] Fix: PowerNV crash with 4.4.0-rc8 at sched_init_numa

Commit c118baf80256 ("arch/powerpc/mm/numa.c: do not allocate bootmem
memory for non existing nodes") avoided bootmem memory allocation for
non existent nodes.

When DEBUG_PER_CPU_MAPS enabled, powerNV system failed to boot because
in sched_init_numa, cpumask_or operation was done on unallocated nodes.
Fix that by making cpumask_or operation only on existing nodes.

[ Tested with and w/o DEBUG_PER_CPU_MAPS on x86 and powerpc ]

Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 44253ad..474658b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6840,7 +6840,7 @@ static void sched_init_numa(void)
 
 			sched_domains_numa_masks[i][j] = mask;
 
-			for (k = 0; k < nr_node_ids; k++) {
+			for_each_node(k) {
 				if (node_distance(j, k) > sched_domains_numa_distance[i])
 					continue;
 
-- 
1.7.11.7
