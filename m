Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F7371A1E34
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 20:08:14 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 2 Sep 2015 15:38:11 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1E0761258028
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 15:37:25 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t82A7UkO12058680
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2015 15:37:31 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t82A7TaB003305
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2015 15:37:29 +0530
Message-ID: <55E6CA60.6030502@linux.vnet.ibm.com>
Date: Wed, 02 Sep 2015 15:37:28 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: [RESEND] Soft lockup after huge page offline attempt
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Worked on a modified version of the following selftest
test case in the kernel source.

tools/testing/selftests/vm/hugepage-mmap.c

This modified test will try to do the following sequence of
events in the same order.

(1) Allocate 16 Huge TLB pages (16MB each) through mmap

(2) mlock() the entire range of 256MB memory

(3) Fetch PFN from /proc/self/pagemap for each huge TLB page
    starting address present in the 256MB range

(4) Convert each PFN into PA as PFN << PAGE_SHIFT which is then
    written into /sys/devices/system/memory/soft_offline_page

(5) unmap() the 256MB memory range

(6) unlink() the file (inside the hugetlbfs mount path) used for mmap

The soft offline page attempts fail as expected as we dont support that on
POWER yet.

[  145.359405] soft offline: 0xba100: migration failed 1, type 43ffff000004008
[  145.359572] soft offline: 0xba200: migration failed 1, type 43ffff000004008
[  145.359644] soft offline: 0xba300: migration failed 1, type 43ffff000004008
[  145.359716] soft offline: 0xba400: migration failed 1, type 43ffff000004008
[  145.359783] soft offline: 0xba500: migration failed 1, type 43ffff000004008
[  145.359853] soft offline: 0xba600: migration failed 1, type 43ffff000004008
[  145.359931] soft offline: 0xba700: migration failed 1, type 43ffff000004008
[  145.360008] soft offline: 0xba800: migration failed 1, type 43ffff000004008
[  145.360080] soft offline: 0xba900: migration failed 1, type 43ffff000004008
[  145.360148] soft offline: 0xbaa00: migration failed 1, type 43ffff000004008
[  145.360218] soft offline: 0xbab00: migration failed 1, type 43ffff000004008
[  145.360286] soft offline: 0xbac00: migration failed 1, type 43ffff000004008
[  145.360353] soft offline: 0xbad00: migration failed 1, type 43ffff000004008
[  145.360420] soft offline: 0xbae00: migration failed 1, type 43ffff000004008
[  145.360485] soft offline: 0xbaf00: migration failed 1, type 43ffff000004008
[  145.360552] soft offline: 0xbb000: migration failed 1, type 43ffff000004008

But interestingly the test thread hangs for good after that. We can see this
soft lock up message in the console.

[  168.038353] NMI watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [hugepage-mmap:1238]
[  168.038384] Modules linked in: windfarm_smu_sat i2c_core pseries_rng windfarm_pid xfs libcrc32c ibmvscsi scsi_transport_srp ibmveth
[  168.038411] CPU: 3 PID: 1238 Comm: hugepage-mmap Not tainted 4.2.0+ #7
[  168.038416] task: c0000000ffa304b0 ti: c000000beff8c000 task.ti: c000000beff8c000
[  168.038422] NIP: c000000000228164 LR: c00000000022820c CTR: c0000000003ff060
[  168.038428] REGS: c000000beff8f8c0 TRAP: 0901   Not tainted  (4.2.0+)
[  168.038432] MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22000228  XER: 00000000
[  168.038446] CFAR: c000000000228180 SOFTE: 1 
GPR00: 0000000000000000 c000000beff8fb40 c000000001306000 f000000002e84000 
GPR04: c000000beff8fb60 0000000000000220 c000000bf98b5248 0000000000000000 
GPR08: 0000000000000044 0000000000000000 f000000002e8401c 0000000000000000 
GPR12: 0000000000000000 c00000000ea51c80 
[  168.038483] NIP [c000000000228164] find_get_pages+0xa4/0x1e0
[  168.038489] LR [c00000000022820c] find_get_pages+0x14c/0x1e0
[  168.038493] Call Trace:
[  168.038496] [c000000beff8fb40] [c000000beff8fbc0] 0xc000000beff8fbc0 (unreliable)
[  168.038503] [c000000beff8fbc0] [c00000000023ba20] pagevec_lookup+0x50/0x80
[  168.038510] [c000000beff8fc00] [c0000000003fe630] truncate_hugepages+0xb0/0x280
[  168.038517] [c000000beff8fd10] [c0000000003ff090] hugetlbfs_evict_inode+0x30/0x70
[  168.038524] [c000000beff8fd40] [c0000000002f1d34] evict+0xf4/0x290
[  168.038531] [c000000beff8fd80] [c0000000002e3268] do_unlinkat+0x208/0x370
[  168.038538] [c000000beff8fe30] [c000000000009360] system_call+0x38/0xd0
[  168.038543] Instruction dump:
[  168.038546] 419e00c8 e87f0000 2fa30000 419e0080 786907a1 408200d8 813b000c 552902ee 
[  168.038556] 0b090000 3943001c 7c2004ac 7d205028 <2c090000> 41c20014 31090001 7d00512d 

After a while, we see these messages as well on the console before it freezes.

INFO: rcu_sched self-detected stall on CPU
[  205.368370] 	3: (5999 ticks this GP) idle=b23/140000000000001/0 softirq=1329/1329 fqs=6000 
[  205.368375] 	 (t=6000 jiffies g=896 c=895 q=678)
[  205.368383] Task dump for CPU 3:
[  205.368387] hugepage-mmap   R  running task        0  1238   1233 0x00042004
[  205.368394] Call Trace:
[  205.368401] [c000000beff8f3e0] [c000000000106660] sched_show_task+0xe0/0x180 (unreliable)
[  205.368409] [c000000beff8f450] [c00000000014d9e4] rcu_dump_cpu_stacks+0xe4/0x150
[  205.368416] [c000000beff8f4a0] [c0000000001529c4] rcu_check_callbacks+0x6b4/0x9b0
[  205.368424] [c000000beff8f5d0] [c000000000159ee4] update_process_times+0x54/0xa0
[  205.368431] [c000000beff8f600] [c000000000170b48] tick_sched_handle.isra.6+0x48/0xe0
[  205.368437] [c000000beff8f640] [c000000000170c44] tick_sched_timer+0x64/0xd0
[  205.368444] [c000000beff8f680] [c00000000015a954] __hrtimer_run_queues+0x124/0x3c0
[  205.368450] [c000000beff8f710] [c00000000015b88c] hrtimer_interrupt+0xec/0x2c0
[  205.368457] [c000000beff8f7d0] [c00000000001f77c] __timer_interrupt+0x8c/0x230
[  205.368464] [c000000beff8f820] [c00000000001fe30] timer_interrupt+0xa0/0xe0
[  205.368470] [c000000beff8f850] [c000000000002768] decrementer_common+0x168/0x180
[  205.368478] --- interrupt: 901 at find_get_pages+0xa0/0x1e0
[  205.368478]     LR = find_get_pages+0x14c/0x1e0
[  205.368486] [c000000beff8fb40] [c000000beff8fbc0] 0xc000000beff8fbc0 (unreliable)
[  205.368493] [c000000beff8fbc0] [c00000000023ba20] pagevec_lookup+0x50/0x80
[  205.368500] [c000000beff8fc00] [c0000000003fe630] truncate_hugepages+0xb0/0x280
[  205.368507] [c000000beff8fd10] [c0000000003ff090] hugetlbfs_evict_inode+0x30/0x70
[  205.368513] [c000000beff8fd40] [c0000000002f1d34] evict+0xf4/0x290
[  205.368520] [c000000beff8fd80] [c0000000002e3268] do_unlinkat+0x208/0x370
[  205.368526] [c000000beff8fe30] [c000000000009360] system_call+0x38/0xd0


Then the entire system hangs for good, requiring a reboot. The problem can be recreated
without unlink() step if we just try to unmount the hugetlbfs afterwards. I am still
looking into this problem. Please do let me know if you have any suggestions/thoughts
or comments about this issue.

Regards
Anshuman
