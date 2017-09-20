Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxs9Z6scwzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 17:40:50 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8K7cmwF121007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 03:40:48 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d3cmv874q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 03:40:48 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Wed, 20 Sep 2017 03:40:47 -0400
Subject: Re: [linux-next][Oops] memory hot-unplug results fault instruction
 address at /include/linux/list.h:104
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, stephen Rothwell
 <sfr@canb.auug.org.au>, Kees Cook <keescook@chromium.org>, linux-next
 <linux-next@vger.kernel.org>, Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 20 Sep 2017 13:10:39 +0530
In-Reply-To: <1505198479.10243.23.camel@abdul>
References: <1505198479.10243.23.camel@abdul>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1505893239.30180.24.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-09-12 at 12:11 +0530, abdul wrote:
> Hi,
> 
> Memory hot-unplug on PowerVM LPAR running next-20170911 results in
> Faulting instruction address: 0xc0000000002b56c4
> 
> which maps to the below code path:
> 
> 0xc0000000002b56c4 is in __rmqueue (./include/linux/list.h:104).
> 99	 * This is only for internal list manipulation where we know
> 100	 * the prev/next entries already!
> 101	 */
> 102	static inline void __list_del(struct list_head * prev, struct
> list_head * next)
> 103	{
> 104		next->prev = prev;
> 105		WRITE_ONCE(prev->next, next);
> 106	}
> 107	
> 108	/**
> 

I see another kernel Oops when running transparent hugepages
de-fragmentation test.

And the faulty instruction address again pointing to same code line
0xc00000000026f9f4 is in compaction_alloc (./include/linux/list.h:104)

steps to recreate:
-----------------
1. Enable transparent hugepages ("always")
2. Turn off the defrag $ echo 0 > khugepaged/defrag
3. Write random to memory path 
4. Set huge pages numbers 
5. Turn on defrag $ echo 1 > khugepaged/defrag


new trace:
----------
Unable to handle kernel paging request for data at address
0x5deadbeef0000108
Faulting instruction address: 0xc00000000026f9f4
Oops: Kernel access of bad area, sig: 11 [#1]
LE SMP NR_CPUS=2048 NUMA PowerNV
Dumping ftrace buffer: 
   (ftrace buffer empty)
Modules linked in: bridge iptable_mangle ipt_MASQUERADE
nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4
nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4
xt_tcpudp tun stp llc kvm_hv kvm iptable_filter vmx_crypto
powernv_op_panel powernv_rng leds_powernv rng_core ipmi_powernv
led_class ipmi_devintf ipmi_msghandler binfmt_misc nfsd ip_tables
x_tables autofs4 [last unloaded: bridge]
CPU: 52 PID: 803 Comm: kcompactd1 Not tainted
4.13.0-next-20170915-autotest #1
task: c0000007f2380000 task.stack: c0000007f2400000
NIP:  c00000000026f9f4 LR: c0000000002d1328 CTR: c00000000026f980
REGS: c0000007f24037d0 TRAP: 0380   Not tainted
(4.13.0-next-20170915-autotest)
MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 22822088  XER:
00000000  
CFAR: c0000000002d1324 SOFTE: 1 
GPR00: c0000000002d1328 c0000007f2403a50 c0000000010bd500
f000000003dcd100 
GPR04: c0000007f2403c90 c0000007f2403af0 f0000000021628a0
5deadbeef0000100 
GPR08: 5deadbeef0000200 5deadbeef0000200 5deadbeef0000100
0000000000000060 
GPR12: c00000000026f980 c00000000fd51e00 f000000002163700
0000000020000000 
GPR16: 0000000000000000 0000000080000000 0000000000000000
c00000000026c3d0 
GPR20: 0000000000000003 0000000000000001 c0000007f2403ca0
c0000007f2403c90 
GPR24: c00000000026f980 0000000000000000 f0000000021636c0
f000000003dcd100 
GPR28: 5deadbeef0000100 5deadbeef0000200 0000000000000001
c0000007f2403c90 
NIP [c00000000026f9f4] compaction_alloc+0x74/0x350
LR [c0000000002d1328] migrate_pages+0x268/0x10c0
Call Trace:
[c0000007f2403a50] [c000000000239584] free_hot_cold_page+0x2b4/0x310
(unreliable)
[c0000007f2403ad0] [c0000000002d1328] migrate_pages+0x268/0x10c0
[c0000007f2403bc0] [c000000000270814] compact_zone+0x294/0xb30
[c0000007f2403c70] [c0000000002714c8] kcompactd_do_work+0x168/0x300
[c0000007f2403d40] [c000000000271718] kcompactd+0xb8/0x250
[c0000007f2403dc0] [c0000000001102f0] kthread+0x160/0x1a0
[c0000007f2403e30] [c00000000000bc60] ret_from_kernel_thread+0x5c/0x7c
Instruction dump:
419e008c 3d405dea e87f0000 614adbee 794a07c6 654af000 e9030008 e8e30000 
3863ffe0 7d495378 614a0100 61290200 <f9070008> f8e80000 f9430020
f9230028 
---[ end trace 27b8c4e55ceebc7d ]---

> 
> Machine Type: Power 8 PowerVM LPAR
> Kernel version: 4.13.0-next-20170911
> config file : attached 
> 
> 
> dmesg logs
> ---------
> 
> Unable to handle kernel paging request for data at address
> 0x5deadbeef0000108
> Faulting instruction address: 0xc0000000002b56c4
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE SMP NR_CPUS=2048 NUMA pSeries
> Modules linked in: xt_addrtype xt_conntrack ipt_MASQUERADE
> nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
> nf_nat_ipv4 iptable_filter ip_tables x_tables nf_nat nf_conntrack bridge
> stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio libcrc32c
> rtc_generic vmx_crypto pseries_rng autofs4
> CPU: 5 PID: 846 Comm: avocado Not tainted 4.13.0-next-20170911 #1
> task: c000000771c02e00 task.stack: c000000771c88000
> NIP:  c0000000002b56c4 LR: c0000000002b7738 CTR: c0000000003587b0
> REGS: c000000771c8b2c0 TRAP: 0380   Not tainted  (4.13.0-next-20170911)
> MSR:  800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR:
> 84228828  XER: 20000000  
> CFAR: c0000000002b7734 SOFTE: 0 
> GPR00: c0000000002b7738 c000000771c8b540 c000000001598a00
> 0000000000000000 
> GPR04: f000000001d2cce0 0000000000000001 5deadbeef0000100
> 5deadbeef0000200 
> GPR08: 5deadbee00000000 c00000077ff54710 0000000000000000
> 0000000000000060 
> GPR12: 0000000024242824 c00000000e743480 000000077eb90000
> c00000077fc68978 
> GPR16: c00000077ff54600 0000000040000000 0000000000000000
> 0000000020000000 
> GPR20: 0000000000000002 c00000077fc68998 c0000000010d8978
> 0000000000000000 
> GPR24: 0000000000000001 0000000000000040 c00000077ff54600
> f000000001d2ccc0 
> GPR28: 0000000000000010 0000000000000000 0000000000000001
> 0000000000000000 
> NIP [c0000000002b56c4] __rmqueue+0xd4/0x680
> LR [c0000000002b7738] get_page_from_freelist+0x798/0xe30
> Call Trace:
> [c000000771c8b540] [c000000771c8b570] 0xc000000771c8b570 (unreliable)
> [c000000771c8b5f0] [c0000000002b7738] get_page_from_freelist+0x798/0xe30
> [c000000771c8b700] [c0000000002b868c] __alloc_pages_nodemask
> +0x23c/0x1120
> [c000000771c8b8f0] [c000000000358924] new_node_page+0x174/0x200
> [c000000771c8b950] [c00000000035f230] migrate_pages+0x2d0/0x1160
> [c000000771c8ba30] [c00000000035b2a4] __offline_pages.constprop.6
> +0x8c4/0xa80
> [c000000771c8bb70] [c0000000007e2288] memory_subsys_offline+0xa8/0x110
> [c000000771c8bba0] [c0000000007b4414] device_offline+0x104/0x140
> [c000000771c8bbe0] [c0000000007e207c] store_mem_state+0x17c/0x190
> [c000000771c8bc20] [c0000000007aea68] dev_attr_store+0x68/0xa0
> [c000000771c8bc60] [c0000000004576e0] sysfs_kf_write+0x80/0xb0
> [c000000771c8bca0] [c0000000004563ec] kernfs_fop_write+0x17c/0x250
> [c000000771c8bcf0] [c00000000039183c] __vfs_write+0x6c/0x230
> [c000000771c8bd90] [c000000000391c50] vfs_write+0xd0/0x270
> [c000000771c8bde0] [c000000000391fec] SyS_write+0x6c/0x110
> [c000000771c8be30] [c00000000000b184] system_call+0x58/0x6c
> Instruction dump:
> 39290100 7c9a482a 7d3a4a14 7fa92040 3764ffe0 419e01d8 41c201d4 3d005dea 
> e8e40008 e8c40000 6108dbee 790807c6 <f8e60008> 6508f000 f8c70000
> 7d094378 
> ---[ end trace bb48ce522c150b9a ]---
> INFO: rcu_sched detected stalls on CPUs/tasks: 
>         2-...: (1 GPs behind) idle=80a/140000000000000/0
> softirq=1760/1761 fqs=281 
>         (detected by 13, t=5280 jiffies, g=3469, c=3468, q=4)
> 
> Regard's
> Abdul Haleem
> IBM Linux Technology Center.


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
