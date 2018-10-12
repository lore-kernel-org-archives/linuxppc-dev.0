Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3002C6783C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 13:25:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB97120865
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 13:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB97120865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42WpW62JvQzF3Tl
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 00:25:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=abdhalee@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WpSq5k79zF3T3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 00:23:55 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9CDKlF7002415
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 09:23:52 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n2shqfe88-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 09:23:51 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Fri, 12 Oct 2018 07:23:50 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 12 Oct 2018 07:23:47 -0600
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9CDNk1X27983960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Oct 2018 06:23:46 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07E686A05D;
 Fri, 12 Oct 2018 07:23:46 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C6086A04D;
 Fri, 12 Oct 2018 07:23:42 -0600 (MDT)
Received: from [9.79.187.207] (unknown [9.79.187.207])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 12 Oct 2018 07:23:41 -0600 (MDT)
Subject: Re: [BUG][linux-next][ppc] kernel panic - not syncing:
 stack-protector: Kernel stack is corrupted in: __schedule+0x978/0xa80
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Date: Fri, 12 Oct 2018 18:53:40 +0530
In-Reply-To: <e711011c-9cba-5166-37e3-e228877cbea8@c-s.fr>
References: <1539330331.17569.32.camel@abdul.in.ibm.com>
 <1539330499.17569.33.camel@abdul.in.ibm.com>
 <eef38553-779a-c7f5-500f-145dbf4b6a49@c-s.fr>
 <1539340304.17569.35.camel@abdul.in.ibm.com>
 <e711011c-9cba-5166-37e3-e228877cbea8@c-s.fr>
Content-Type: multipart/mixed; boundary="=-sRef+233esjGrZ0b5wQW"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18101213-0012-0000-0000-000016C6EF27
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009865; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01101589; UDB=6.00570043; IPR=6.00881634; 
 MB=3.00023727; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-12 13:23:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101213-0013-0000-0000-000054BA7C99
Message-Id: <1539350620.17569.39.camel@abdul.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-12_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810120133
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 manvanth <manvanth@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, npiggin <npiggin@gmail.com>,
 linux-next <linux-next@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--=-sRef+233esjGrZ0b5wQW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2018-10-12 at 12:36 +0200, Christophe LEROY wrote:
> 
> Le 12/10/2018 à 12:31, Abdul Haleem a écrit :
> > On Fri, 2018-10-12 at 10:08 +0200, Christophe LEROY wrote:
> >>
> >> Le 12/10/2018 à 09:48, Abdul Haleem a écrit :
> >>> On Fri, 2018-10-12 at 13:15 +0530, Abdul Haleem wrote:
> >>>> Greeting's
> >>>>
> >>>> Today's linux-next fails to boot on powerpc bare-metal with this error
> >>>>
> >>>> POWER8 performance monitor hardware support registered
> >>>> rcu: Hierarchical SRCU implementation.
> >>>> smp: Bringing up secondary CPUs ...
> >>>> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: __schedule+0x978/0xa80
> >>>> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc7-next-20181010-autotest-autotest #1
> >>>> Call Trace:
> >>>> [c000001fed5b3bf0] [c000000000a0ef3c] dump_stack+0xb0/0xf4 (unreliable)
> >>>> [c000001fed5b3c30] [c0000000000f9d68] panic+0x140/0x308
> >>>> [c000001fed5b3cc0] [c0000000000f9844] __stack_chk_fail+0x24/0x30
> >>>> [c000001fed5b3d20] [c000000000a2c3a8] __schedule+0x978/0xa80
> >>>> [c000001fed5b3e00] [c000000000a2c9b4] schedule_idle+0x34/0x60
> >>>> [c000001fed5b3e30] [c00000000013d344] do_idle+0x224/0x3d0
> >>>> [c000001fed5b3ec0] [c00000000013d6e0] cpu_startup_entry+0x30/0x50
> >>>> [c000001fed5b3ef0] [c000000000047f34] start_secondary+0x4d4/0x520
> >>>> [c000001fed5b3f90] [c00000000000b370] start_secondary_prolog+0x10/0x14
> >>>> Rebooting in 10 seconds..
> >>>>
> >>>> Machine: Power 8 bare-metal
> >>>> kernel version: 4.19.0-rc7-next-20181010
> >>>> gcc version: 4.8.5 20150623
> >>>> config attach
> >>>
> >>> Attaching the kernel config file
> >>>
> >>
> >> # Linux/powerpc 4.11.0-rc4 Kernel Configuration
> >>
> >> This is not the correct config file. Can you send the .config ?
> > 
> > CONFIG_HAVE_STACKPROTECTOR=y
> > CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> > CONFIG_STACKPROTECTOR=y
> > CONFIG_STACKPROTECTOR_STRONG=y
> > 
> > ah yes, I have attached the correct config now.
> 
> Ok,
> 
> Could you please try and add a call to function boot_init_stack_canary() 
> in function start_secondary() in arch/powerpc/kernel/smp.c just before 
> the call to cpu_startup_entry() ?

Yes, it works. kernel boots fine with above changes to arch/powerpc/kernel/smp.c

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 61c1fad..6c356e7 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -35,6 +35,7 @@
 #include <linux/profile.h>
 #include <linux/processor.h>
 
+#include <linux/stackprotector.h>
 #include <asm/ptrace.h>
 #include <linux/atomic.h>
 #include <asm/irq.h>
@@ -1088,6 +1089,8 @@ void start_secondary(void *unused)
        /* We can enable ftrace for secondary cpus now */
        this_cpu_enable_ftrace();
 
+       boot_init_stack_canary();
+
        cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 
        BUG();


Attaching the boot logs 4.19.0-rc7-next-20181011 kernel

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre



--=-sRef+233esjGrZ0b5wQW
Content-Disposition: attachment; filename="bootlogs.txt"
Content-Type: text/plain; name="bootlogs.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

OPAL: Switch to little-endian OS
kexec: Starting switchover sequence.
hash-mmu: Page sizes from device-tree:
hash-mmu: base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=0
hash-mmu: base_shift=12: shift=16, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=7
hash-mmu: base_shift=12: shift=24, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=56
hash-mmu: base_shift=16: shift=16, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=1
hash-mmu: base_shift=16: shift=24, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=8
hash-mmu: base_shift=20: shift=20, sllp=0x0130, avpnm=0x00000000, tlbiel=0, penc=2
hash-mmu: base_shift=24: shift=24, sllp=0x0100, avpnm=0x00000001, tlbiel=0, penc=0
hash-mmu: base_shift=34: shift=34, sllp=0x0120, avpnm=0x000007ff, tlbiel=0, penc=3
Using 1TB segments
hash-mmu: Initializing hash mmu with SLB
Linux version 4.19.0-rc7-next-20181011-autotest-dirty (root@ltc-garri5.pok.stglabs.ibm.com) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-28) (GCC)) #2 SMP Fri Oct 12 08:47:18 EDT 2018
Found initrd at 0xc000000002580000:0xc000000003b296dd
OPAL: Found non-mapped LPC bus on chip 0
Using PowerNV machine description
bootconsole [udbg0] enabled
CPU maps initialized for 8 threads per core
-----------------------------------------------------
ppc64_pft_size    = 0x0
phys_mem_size     = 0x4000000000
dcache_bsize      = 0x80
icache_bsize      = 0x80
cpu_features      = 0x000000ff8f5db1a7
  possible        = 0x0000fbffcf5fb1a7
  always          = 0x00000003800081a1
cpu_user_features = 0xdc0065c2 0xef000000
mmu_features      = 0x7c006001
firmware_features = 0x0000000110000000
htab_address      = 0x(____ptrval____)
htab_hash_mask    = 0x1fffff
-----------------------------------------------------
cma: Reserved 13120 MiB at 0x0000003cac000000
numa:   NODE_DATA [mem 0x1fff972300-0x1fff97bfff]
numa:   NODE_DATA [mem 0x3fff0c2300-0x3fff0cbfff]
rfi-flush: ori type flush available
count-cache-flush: software flush disabled.
stf-barrier: hwsync barrier available
Initializing IODA2 PHB (/pciex@3fffe40000000)
PCI host bridge /pciex@3fffe40000000 (primary) ranges:
 MEM 0x00003fe000000000..0x00003fe07ffeffff -> 0x0000000080000000 
 MEM 0x0000200000000000..0x000020ffffffffff -> 0x0000200000000000 (M64 #0..15)
 Using M64 #15 as default window
  256 (255) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x10000000000 [segment=0x100000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x800)
Initializing IODA2 PHB (/pciex@3fffe40100000)
PCI host bridge /pciex@3fffe40100000  ranges:
 MEM 0x00003fe080000000..0x00003fe0fffeffff -> 0x0000000080000000 
 MEM 0x0000210000000000..0x000021ffffffffff -> 0x0000210000000000 (M64 #0..15)
 Using M64 #15 as default window
  256 (255) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x10000000000 [segment=0x100000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x1000)
Initializing IODA2 PHB (/pciex@3fffe40200000)
PCI host bridge /pciex@3fffe40200000  ranges:
 MEM 0x00003fe100000000..0x00003fe17ffeffff -> 0x0000000080000000 
 MEM 0x0000220000000000..0x000022ffffffffff -> 0x0000220000000000 (M64 #0..15)
 Using M64 #15 as default window
  256 (255) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x10000000000 [segment=0x100000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x1800)
Initializing IODA2 PHB (/pciex@3fffe40300000)
PCI host bridge /pciex@3fffe40300000  ranges:
 MEM 0x00003fe180000000..0x00003fe1fffeffff -> 0x0000000080000000 
 MEM 0x0000230000000000..0x000023ffffffffff -> 0x0000230000000000 (M64 #0..15)
 Using M64 #15 as default window
  256 (255) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x10000000000 [segment=0x100000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x2000)
Initializing IODA2 PHB (/pciex@3fffe40400000)
PCI host bridge /pciex@3fffe40400000  ranges:
 MEM 0x00003fe200000000..0x00003fe27ffeffff -> 0x0000000080000000 
 MEM 0x0000240000000000..0x000024ffffffffff -> 0x0000240000000000 (M64 #0..15)
 Using M64 #15 as default window
  256 (255) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x10000000000 [segment=0x100000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x4800)
Initializing IODA2 PHB (/pciex@3fffe40500000)
PCI host bridge /pciex@3fffe40500000  ranges:
 MEM 0x00003fe280000000..0x00003fe2fffeffff -> 0x0000000080000000 
 MEM 0x0000250000000000..0x000025ffffffffff -> 0x0000250000000000 (M64 #0..15)
 Using M64 #15 as default window
  256 (255) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x10000000000 [segment=0x100000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x5000)
Initializing IODA2 PHB (/pciex@3fffe40600000)
PCI host bridge /pciex@3fffe40600000  ranges:
 MEM 0x00003fe300000000..0x00003fe37ffeffff -> 0x0000000080000000 
 MEM 0x0000260000000000..0x000026ffffffffff -> 0x0000260000000000 (M64 #0..15)
 Using M64 #15 as default window
  256 (255) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x10000000000 [segment=0x100000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x5800)
Initializing IODA2 PHB (/pciex@3fffe40700000)
PCI host bridge /pciex@3fffe40700000  ranges:
 MEM 0x00003fe380000000..0x00003fe3fffeffff -> 0x0000000080000000 
 MEM 0x0000270000000000..0x000027ffffffffff -> 0x0000270000000000 (M64 #0..15)
 Using M64 #15 as default window
  256 (255) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x10000000000 [segment=0x100000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x6000)
Initializing NPU_NVLINK PHB (/pciex@3fff000400000)
PCI host bridge /pciex@3fff000400000  ranges:
 MEM 0x0003fff000410000..0x0003fff00049ffff -> 0x0003fff000410000 
  Not support M64 window
  004 (000) PE's M32: 0xa0000 [segment=0x28000]
Initializing NPU_NVLINK PHB (/pciex@3fff001400000)
PCI host bridge /pciex@3fff001400000  ranges:
 MEM 0x0003fff001410000..0x0003fff00149ffff -> 0x0003fff001410000 
  Not support M64 window
  004 (000) PE's M32: 0xa0000 [segment=0x28000]
OPAL nvram setup, 589824 bytes
barrier-nospec: using ORI speculation barrier
Zone ranges:
  DMA      [mem 0x0000000000000000-0x0000003fffffffff]
  DMA32    empty
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000001fffffffff]
  node   1: [mem 0x0000002000000000-0x0000003fffffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000001fffffffff]
Initmem setup node 1 [mem 0x0000002000000000-0x0000003fffffffff]
random: get_random_u64 called from start_kernel+0xac/0x624 with crng_init=0
percpu: Embedded 4 pages/cpu @(____ptrval____) s167448 r0 d94696 u262144
Built 2 zonelists, mobility grouping on.  Total pages: 4190208
Policy zone: DMA
Kernel command line: rw root=/dev/mapper/ca_ltc--garri5-root 
log_buf_len individual max cpu contribution: 8192 bytes
log_buf_len total cpu_extra contributions: 1302528 bytes
log_buf_len min size: 262144 bytes
log_buf_len: 2097152 bytes
early log buf free: 250784(95%)
Memory: 254167360K/268435456K available (10496K kernel code, 1536K rwdata, 2880K rodata, 2752K init, 1389K bss, 833216K reserved, 13434880K cma-reserved)
SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=160, Nodes=2
rcu: Hierarchical RCU implementation.
rcu: 	RCU restricting CPUs from NR_CPUS=2048 to nr_cpu_ids=160.
	Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=160
NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
ICS OPAL backend registered
clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
clocksource: timebase mult[1f40000] shift[24] registered
Console: colour dummy device 80x25
console [hvc0] enabled
console [hvc0] enabled
bootconsole [udbg0] disabled
bootconsole [udbg0] disabled
mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
pid_max: default: 163840 minimum: 1280
Dentry cache hash table entries: 16777216 (order: 11, 134217728 bytes)
Inode-cache hash table entries: 8388608 (order: 10, 67108864 bytes)
Mount-cache hash table entries: 262144 (order: 5, 2097152 bytes)
Mountpoint-cache hash table entries: 262144 (order: 5, 2097152 bytes)
*** VALIDATE proc ***
*** VALIDATE cgroup1 ***
*** VALIDATE cgroup2 ***
EEH: PowerNV platform initialized
POWER8 performance monitor hardware support registered
rcu: Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
smp: Brought up 2 nodes, 160 CPUs
numa: Node 0 CPUs: 0-79
numa: Node 1 CPUs: 80-159
Using standard scheduler topology
devtmpfs: initialized
kworker/u321:0 (815) used greatest stack depth: 12400 bytes left
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
futex hash table entries: 65536 (order: 7, 8388608 bytes)
NET: Registered protocol family 16
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1539350042.440:1): state=initialized audit_enabled=0 res=1
cpuidle: using governor menu
pstore: Registered nvram as persistent store backend
PCI: Probing PCI hardware
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [mem 0x3fe000000000-0x3fe07ffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0000:00: root bus resource [mem 0x200000000000-0x20fdffffffff 64bit pref]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:01:00.0: BAR0 [mem size 0x00004000 64bit]: requesting alignment to 0x10000
pci 0000:00:00.0: PCI bridge to [bus 01]
PCI host bridge to bus 0001:00
pci_bus 0001:00: root bus resource [mem 0x3fe080000000-0x3fe0fffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0001:00: root bus resource [mem 0x210000000000-0x21fdffffffff 64bit pref]
pci_bus 0001:00: root bus resource [bus 00-ff]
pci 0001:01:00.0: BAR0 [mem size 0x00001000 64bit]: requesting alignment to 0x10000
pci 0001:01:00.0: BAR2 [mem size 0x00004000 64bit]: requesting alignment to 0x10000
pci 0001:01:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x8 link at 0001:00:00.0 (capable of 63.008 Gb/s with 8 GT/s x8 link)
pci 0001:01:00.1: BAR0 [mem size 0x00001000 64bit]: requesting alignment to 0x10000
pci 0001:01:00.1: BAR2 [mem size 0x00004000 64bit]: requesting alignment to 0x10000
pci 0001:00:00.0: PCI bridge to [bus 01]
PCI host bridge to bus 0002:00
pci_bus 0002:00: root bus resource [mem 0x3fe100000000-0x3fe17ffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0002:00: root bus resource [mem 0x220000000000-0x22fdffffffff 64bit pref]
pci_bus 0002:00: root bus resource [bus 00-ff]
pci 0002:01:00.0: 63.008 Gb/s available PCIe bandwidth, limited by 8 GT/s x8 link at 0002:00:00.0 (capable of 126.016 Gb/s with 8 GT/s x16 link)
pci 0002:00:00.0: PCI bridge to [bus 01]
PCI host bridge to bus 0003:00
pci_bus 0003:00: root bus resource [mem 0x3fe180000000-0x3fe1fffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0003:00: root bus resource [mem 0x230000000000-0x23fdffffffff 64bit pref]
pci_bus 0003:00: root bus resource [bus 00-ff]
pci 0003:00:00.0: PCI bridge to [bus 01-ff]
PCI host bridge to bus 0008:00
pci_bus 0008:00: root bus resource [mem 0x3fe200000000-0x3fe27ffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0008:00: root bus resource [mem 0x240000000000-0x24fdffffffff 64bit pref]
pci_bus 0008:00: root bus resource [bus 00-ff]
pci 0008:00:00.0: PCI bridge to [bus 01]
PCI host bridge to bus 0009:00
pci_bus 0009:00: root bus resource [mem 0x3fe280000000-0x3fe2fffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0009:00: root bus resource [mem 0x250000000000-0x25fdffffffff 64bit pref]
pci_bus 0009:00: root bus resource [bus 00-ff]
pci 0009:00:00.0: PCI bridge to [bus 01-07]
pci 0009:01:00.0: PCI bridge to [bus 02-07]
pci 0009:03:00.0: BAR2 [mem size 0x00002000 64bit]: requesting alignment to 0x10000
pci 0009:03:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x1 link at 0009:02:01.0 (capable of 7.876 Gb/s with 8 GT/s x1 link)
pci 0009:02:01.0: PCI bridge to [bus 03]
pci 0009:04:00.0: BAR5 [mem size 0x00000800]: requesting alignment to 0x10000
pci 0009:04:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x2 link at 0009:02:02.0 (capable of 15.752 Gb/s with 8 GT/s x2 link)
pci 0009:02:02.0: PCI bridge to [bus 04]
pci 0009:02:03.0: PCI bridge to [bus 05-06]
pci_bus 0009:06: extended config space not accessible
pci 0009:05:00.0: PCI bridge to [bus 06]
pci 0009:07:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x1 link at 0009:02:04.0 (capable of 7.876 Gb/s with 8 GT/s x1 link)
random: fast init done
pci 0009:02:04.0: PCI bridge to [bus 07]
PCI host bridge to bus 000a:00
pci_bus 000a:00: root bus resource [mem 0x3fe300000000-0x3fe37ffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 000a:00: root bus resource [mem 0x260000000000-0x26fdffffffff 64bit pref]
pci_bus 000a:00: root bus resource [bus 00-ff]
pci 000a:01:00.0: 63.008 Gb/s available PCIe bandwidth, limited by 8 GT/s x8 link at 000a:00:00.0 (capable of 126.016 Gb/s with 8 GT/s x16 link)
pci 000a:00:00.0: PCI bridge to [bus 01]
PCI host bridge to bus 000b:00
pci_bus 000b:00: root bus resource [mem 0x3fe380000000-0x3fe3fffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 000b:00: root bus resource [mem 0x270000000000-0x27fdffffffff 64bit pref]
pci_bus 000b:00: root bus resource [bus 00-ff]
pci 000b:00:00.0: PCI bridge to [bus 01-ff]
PCI host bridge to bus 0004:00
pci_bus 0004:00: root bus resource [mem 0x3fff000410000-0x3fff00049ffff]
pci_bus 0004:00: root bus resource [bus 00-ff]
PCI host bridge to bus 0005:00
pci_bus 0005:00: root bus resource [mem 0x3fff001410000-0x3fff00149ffff]
pci_bus 0005:00: root bus resource [bus 00-ff]
pci 0000:00:00.0: BAR 8: assigned [mem 0x3fe000000000-0x3fe0007fffff]
pci 0000:01:00.0: BAR 6: assigned [mem 0x3fe000000000-0x3fe00001ffff pref]
pci 0000:01:00.0: BAR 0: assigned [mem 0x3fe000020000-0x3fe000023fff 64bit]
pci 0000:01:00.0: BAR 4: assigned [mem 0x3fe000030000-0x3fe00003ffff 64bit]
pci 0000:00     : [PE# fe] Secondary bus 0 associated with PE#fe
pci 0000:01     : [PE# fd] Secondary bus 1 associated with PE#fd
pci 0000:01     : [PE# fd] Setting up 32-bit TCE table at 0..80000000
IOMMU table initialized, virtual merging enabled
pci 0000:01     : [PE# fd] Setting up window#0 0..7fffffff pg=1000
pci 0000:01     : [PE# fd] Enabling 64-bit DMA bypass
iommu: Adding device 0000:01:00.0 to group 0
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [mem 0x3fe000000000-0x3fe07fefffff]
pci 0001:00:00.0: BAR 8: assigned [mem 0x3fe080000000-0x3fe0807fffff]
pci 0001:01:00.0: BAR 6: assigned [mem 0x3fe080000000-0x3fe08003ffff pref]
pci 0001:01:00.1: BAR 6: assigned [mem 0x3fe080040000-0x3fe08007ffff pref]
pci 0001:01:00.0: BAR 0: assigned [mem 0x3fe080080000-0x3fe080080fff 64bit]
pci 0001:01:00.0: BAR 2: assigned [mem 0x3fe080090000-0x3fe080093fff 64bit]
pci 0001:01:00.1: BAR 0: assigned [mem 0x3fe0800a0000-0x3fe0800a0fff 64bit]
pci 0001:01:00.1: BAR 2: assigned [mem 0x3fe0800b0000-0x3fe0800b3fff 64bit]
pci 0001:01:00.0: BAR 4: no space for [io  size 0x0100]
pci 0001:01:00.0: BAR 4: failed to assign [io  size 0x0100]
pci 0001:01:00.1: BAR 4: no space for [io  size 0x0100]
pci 0001:01:00.1: BAR 4: failed to assign [io  size 0x0100]
pci 0001:00     : [PE# fe] Secondary bus 0 associated with PE#fe
pci 0001:01     : [PE# fd] Secondary bus 1 associated with PE#fd
pci 0001:01     : [PE# fd] Setting up 32-bit TCE table at 0..80000000
pci 0001:01     : [PE# fd] Setting up window#0 0..7fffffff pg=1000
pci 0001:01     : [PE# fd] Enabling 64-bit DMA bypass
iommu: Adding device 0001:01:00.0 to group 1
iommu: Adding device 0001:01:00.1 to group 1
pci 0001:00:00.0: PCI bridge to [bus 01]
pci 0001:00:00.0:   bridge window [mem 0x3fe080000000-0x3fe0ffefffff]
pci_bus 0001:00: Some PCI device resources are unassigned, try booting with pci=realloc
pci 0002:00:00.0: BAR 9: assigned [mem 0x220000000000-0x2205ffffffff 64bit pref]
pci 0002:00:00.0: BAR 8: assigned [mem 0x3fe100000000-0x3fe100ffffff]
pci 0002:01:00.0: BAR 1: assigned [mem 0x220000000000-0x2203ffffffff 64bit pref]
pci 0002:01:00.0: BAR 3: assigned [mem 0x220400000000-0x220401ffffff 64bit pref]
pci 0002:01:00.0: BAR 0: assigned [mem 0x3fe100000000-0x3fe100ffffff]
pci 0002:00     : [PE# fe] Secondary bus 0 associated with PE#fe
pci 0002:01     : [PE# 00] Secondary bus 1 associated with PE#0
pci 0002:01     : [PE# 00] Setting up 32-bit TCE table at 0..80000000
pci 0002:01     : [PE# 00] Setting up window#0 0..7fffffff pg=1000
pci 0002:01     : [PE# 00] Enabling 64-bit DMA bypass
iommu: Adding device 0002:01:00.0 to group 2
pci 0002:00:00.0: PCI bridge to [bus 01]
pci 0002:00:00.0:   bridge window [mem 0x3fe100000000-0x3fe17fefffff]
pci 0002:00:00.0:   bridge window [mem 0x220000000000-0x22fdfff0ffff 64bit pref]
pci 0003:00     : [PE# fe] Secondary bus 0 associated with PE#fe
pci 0003:00:00.0: PCI bridge to [bus 01-ff]
pci 0008:00:00.0: BAR 9: assigned [mem 0x240000000000-0x2400ffffffff 64bit pref]
pci 0008:00:00.0: BAR 8: assigned [mem 0x3fe200000000-0x3fe2007fffff]
pci 0008:01:00.0: BAR 0: assigned [mem 0x240000000000-0x2400007fffff 64bit pref]
pci 0008:01:00.0: BAR 2: assigned [mem 0x240000800000-0x240000ffffff 64bit pref]
pci 0008:01:00.1: BAR 0: assigned [mem 0x240001000000-0x2400017fffff 64bit pref]
pci 0008:01:00.1: BAR 2: assigned [mem 0x240001800000-0x240001ffffff 64bit pref]
pci 0008:01:00.2: BAR 0: assigned [mem 0x240002000000-0x2400027fffff 64bit pref]
pci 0008:01:00.2: BAR 2: assigned [mem 0x240002800000-0x240002ffffff 64bit pref]
pci 0008:01:00.3: BAR 0: assigned [mem 0x240003000000-0x2400037fffff 64bit pref]
pci 0008:01:00.3: BAR 2: assigned [mem 0x240003800000-0x240003ffffff 64bit pref]
pci 0008:01:00.0: BAR 6: assigned [mem 0x3fe200000000-0x3fe20003ffff pref]
pci 0008:01:00.1: BAR 6: assigned [mem 0x3fe200040000-0x3fe20007ffff pref]
pci 0008:01:00.2: BAR 6: assigned [mem 0x3fe200080000-0x3fe2000bffff pref]
pci 0008:01:00.3: BAR 6: assigned [mem 0x3fe2000c0000-0x3fe2000fffff pref]
pci 0008:01:00.0: BAR 4: assigned [mem 0x240004000000-0x24000400ffff 64bit pref]
pci 0008:01:00.1: BAR 4: assigned [mem 0x240004010000-0x24000401ffff 64bit pref]
pci 0008:01:00.2: BAR 4: assigned [mem 0x240004020000-0x24000402ffff 64bit pref]
pci 0008:01:00.3: BAR 4: assigned [mem 0x240004030000-0x24000403ffff 64bit pref]
pci 0008:00     : [PE# fe] Secondary bus 0 associated with PE#fe
pci 0008:01     : [PE# 00] Secondary bus 1 associated with PE#0
pci 0008:01     : [PE# 00] Setting up 32-bit TCE table at 0..80000000
pci 0008:01     : [PE# 00] Setting up window#0 0..7fffffff pg=1000
pci 0008:01     : [PE# 00] Enabling 64-bit DMA bypass
iommu: Adding device 0008:01:00.0 to group 3
iommu: Adding device 0008:01:00.1 to group 3
iommu: Adding device 0008:01:00.2 to group 3
iommu: Adding device 0008:01:00.3 to group 3
pci 0008:00:00.0: PCI bridge to [bus 01]
pci 0008:00:00.0:   bridge window [mem 0x3fe200000000-0x3fe27fefffff]
pci 0008:00:00.0:   bridge window [mem 0x240000000000-0x24fdfff0ffff 64bit pref]
pci 0009:00:00.0: BAR 9: assigned [mem 0x250000000000-0x2500ffffffff 64bit pref]
pci 0009:00:00.0: BAR 8: assigned [mem 0x3fe280000000-0x3fe282ffffff]
pci 0009:01:00.0: BAR 9: assigned [mem 0x250000000000-0x2500ffffffff 64bit pref]
pci 0009:01:00.0: BAR 8: assigned [mem 0x3fe280000000-0x3fe2827fffff]
pci 0009:01:00.0: BAR 0: assigned [mem 0x3fe282800000-0x3fe28283ffff]
pci 0009:01:00.0: BAR 7: no space for [io  size 0x2000]
pci 0009:01:00.0: BAR 7: failed to assign [io  size 0x2000]
pci 0009:02:04.0: BAR 9: assigned [mem 0x250000000000-0x2500ffffffff 64bit pref]
pci 0009:02:01.0: BAR 8: assigned [mem 0x3fe280000000-0x3fe2807fffff]
pci 0009:02:02.0: BAR 8: assigned [mem 0x3fe280800000-0x3fe280ffffff]
pci 0009:02:03.0: BAR 8: assigned [mem 0x3fe281000000-0x3fe2827fffff]
pci 0009:02:02.0: BAR 7: no space for [io  size 0x1000]
pci 0009:02:02.0: BAR 7: failed to assign [io  size 0x1000]
pci 0009:02:03.0: BAR 7: no space for [io  size 0x1000]
pci 0009:02:03.0: BAR 7: failed to assign [io  size 0x1000]
pci 0009:03:00.0: BAR 0: assigned [mem 0x3fe280000000-0x3fe28000ffff 64bit]
pci 0009:03:00.0: BAR 2: assigned [mem 0x3fe280010000-0x3fe280011fff 64bit]
pci 0009:00     : [PE# fe] Secondary bus 0 associated with PE#fe
pci 0009:03     : [PE# fd] Secondary bus 3 associated with PE#fd
pci 0009:03     : [PE# fd] Setting up 32-bit TCE table at 0..80000000
pci 0009:03     : [PE# fd] Setting up window#0 0..7fffffff pg=1000
pci 0009:03     : [PE# fd] Enabling 64-bit DMA bypass
iommu: Adding device 0009:03:00.0 to group 4
pci 0009:02:01.0: PCI bridge to [bus 03]
pci 0009:02:01.0:   bridge window [mem 0x3fe280000000-0x3fe2807fffff]
pci 0009:04:00.0: BAR 5: assigned [mem 0x3fe280800000-0x3fe2808007ff]
pci 0009:04:00.0: BAR 6: assigned [mem 0x3fe280810000-0x3fe28081ffff pref]
pci 0009:04:00.0: BAR 4: no space for [io  size 0x0020]
pci 0009:04:00.0: BAR 4: failed to assign [io  size 0x0020]
pci 0009:04:00.0: BAR 0: no space for [io  size 0x0008]
pci 0009:04:00.0: BAR 0: failed to assign [io  size 0x0008]
pci 0009:04:00.0: BAR 2: no space for [io  size 0x0008]
pci 0009:04:00.0: BAR 2: failed to assign [io  size 0x0008]
pci 0009:04:00.0: BAR 1: no space for [io  size 0x0004]
pci 0009:04:00.0: BAR 1: failed to assign [io  size 0x0004]
pci 0009:04:00.0: BAR 3: no space for [io  size 0x0004]
pci 0009:04:00.0: BAR 3: failed to assign [io  size 0x0004]
pci 0009:04     : [PE# fc] Secondary bus 4 associated with PE#fc
pci 0009:04     : [PE# fc] Setting up 32-bit TCE table at 0..80000000
pci 0009:04     : [PE# fc] Setting up window#0 0..7fffffff pg=1000
pci 0009:04     : [PE# fc] Enabling 64-bit DMA bypass
iommu: Adding device 0009:04:00.0 to group 5
pci 0009:02:02.0: PCI bridge to [bus 04]
pci 0009:02:02.0:   bridge window [mem 0x3fe280800000-0x3fe280ffffff]
pci 0009:05:00.0: BAR 8: assigned [mem 0x3fe281000000-0x3fe2827fffff]
pci 0009:05:00.0: BAR 7: no space for [io  size 0x1000]
pci 0009:05:00.0: BAR 7: failed to assign [io  size 0x1000]
pci 0009:06:00.0: BAR 0: assigned [mem 0x3fe281000000-0x3fe281ffffff]
pci 0009:06:00.0: BAR 1: assigned [mem 0x3fe282000000-0x3fe28201ffff]
pci 0009:06:00.0: BAR 2: no space for [io  size 0x0080]
pci 0009:06:00.0: BAR 2: failed to assign [io  size 0x0080]
pci 0009:06     : [PE# fb] Secondary bus 6..6 associated with PE#fb
pci 0009:06     : [PE# fb] Setting up 32-bit TCE table at 0..80000000
pci 0009:06     : [PE# fb] Setting up window#0 0..7fffffff pg=1000
pci 0009:06     : [PE# fb] Enabling 64-bit DMA bypass
iommu: Adding device 0009:06:00.0 to group 6
pci 0009:05:00.0: PCI bridge to [bus 06]
pci 0009:05:00.0:   bridge window [mem 0x3fe281000000-0x3fe2827fffff]
pci 0009:05     : [PE# fa] Secondary bus 5 associated with PE#fa
pci 0009:02:03.0: PCI bridge to [bus 05-06]
pci 0009:02:03.0:   bridge window [mem 0x3fe281000000-0x3fe2827fffff]
pci 0009:07:00.0: BAR 0: assigned [mem 0x250000000000-0x25000000ffff 64bit pref]
pci 0009:07:00.0: BAR 2: assigned [mem 0x250000010000-0x25000001ffff 64bit pref]
pci 0009:07:00.0: BAR 4: assigned [mem 0x250000020000-0x25000002ffff 64bit pref]
pci 0009:07:00.1: BAR 0: assigned [mem 0x250000030000-0x25000003ffff 64bit pref]
pci 0009:07:00.1: BAR 2: assigned [mem 0x250000040000-0x25000004ffff 64bit pref]
pci 0009:07:00.1: BAR 4: assigned [mem 0x250000050000-0x25000005ffff 64bit pref]
pci 0009:07     : [PE# 00] Secondary bus 7 associated with PE#0
pci 0009:07     : [PE# 00] Setting up 32-bit TCE table at 0..80000000
pci 0009:07     : [PE# 00] Setting up window#0 0..7fffffff pg=1000
pci 0009:07     : [PE# 00] Enabling 64-bit DMA bypass
iommu: Adding device 0009:07:00.0 to group 7
iommu: Adding device 0009:07:00.1 to group 7
pci 0009:02:04.0: PCI bridge to [bus 07]
pci 0009:02:04.0:   bridge window [mem 0x250000000000-0x2500ffffffff 64bit pref]
pci 0009:02     : [PE# f9] Secondary bus 2 associated with PE#f9
pci 0009:01:00.0: PCI bridge to [bus 02-07]
pci 0009:01:00.0:   bridge window [mem 0x3fe280000000-0x3fe2ffefffff]
pci 0009:01:00.0:   bridge window [mem 0x250000000000-0x25fdfff0ffff 64bit pref]
pci 0009:01     : [PE# f8] Secondary bus 1 associated with PE#f8
pci 0009:00:00.0: PCI bridge to [bus 01-07]
pci 0009:00:00.0:   bridge window [mem 0x3fe280000000-0x3fe2ffefffff]
pci 0009:00:00.0:   bridge window [mem 0x250000000000-0x25fdfff0ffff 64bit pref]
pci_bus 0009:00: Some PCI device resources are unassigned, try booting with pci=realloc
pci 000a:00:00.0: BAR 9: assigned [mem 0x260000000000-0x2605ffffffff 64bit pref]
pci 000a:00:00.0: BAR 8: assigned [mem 0x3fe300000000-0x3fe300ffffff]
pci 000a:01:00.0: BAR 1: assigned [mem 0x260000000000-0x2603ffffffff 64bit pref]
pci 000a:01:00.0: BAR 3: assigned [mem 0x260400000000-0x260401ffffff 64bit pref]
pci 000a:01:00.0: BAR 0: assigned [mem 0x3fe300000000-0x3fe300ffffff]
pci 000a:00     : [PE# fe] Secondary bus 0 associated with PE#fe
cpi 000a:1   0 : [P E 00#] Secodanry bus 1  [PE# 03] Associated device to PE
pci 0004:00:00.1: Associating to existing PE 3
pci 0004:00:01.0: [PE# 02] Associated device to PE
pci 0004:00:01.1: Associating to existing PE 2
pci 0005:00:00.0: [PE# 03] Associated device to PE
pci 0005:00:00.1: Associating to existing PE 3
pci 0005:00:01.0: [PE# 02] Associated device to PE
pci 0005:00:01.1: Associating to existing PE 2
pci 0002:01     : [PE# 00] Attached NPU 0004:00:01.0
iommu: Adding device 0004:00:01.0 to group 2
pci 0002:01     : [PE# 00] Attached NPU 0004:00:01.1
iommu: Adding device 0004:00:01.1 to group 2
pci 000a:01     : [PE# 00] Attached NPU 0005:00:01.0
iommu: Adding device 0005:00:01.0 to group 8
pci 000a:01     : [PE# 00] Attached NPU 0005:00:01.1
iommu: Adding device 0005:00:01.1 to group 8
pci 0000:00:00.0: enabling device (0101 -> 0103)
pci 0001:00:00.0: enabling device (0101 -> 0103)
pci 0002:00:00.0: enabling device (0101 -> 0103)
pci 0008:00:00.0: enabling device (0101 -> 0103)
pci 0009:00:00.0: enabling device (0101 -> 0103)
pci 0009:01:00.0: enabling device (0141 -> 0143)
pci 0009:02:01.0: enabling device (0141 -> 0143)
pci 0009:02:02.0: enabling device (0141 -> 0143)
pci 0009:02:03.0: enabling device (0141 -> 0143)
pci 0009:05:00.0: enabling device (0141 -> 0143)
pci 0009:02:04.0: enabling device (0141 -> 0143)
pci 000a:00:00.0: enabling device (0101 -> 0103)
EEH: PCI Enhanced I/O Error Handling Enabled
powernv-rng: Registering arch random hook.
HugeTLB registered 16.0 MiB page size, pre-allocated 0 pages
HugeTLB registered 16.0 GiB page size, pre-allocated 0 pages
random: crng init done
pci 0009:06:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
pci 0009:06:00.0: vgaarb: bridge control possible
pci 0009:06:00.0: vgaarb: setting as boot device (VGA legacy resources not available)
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
clocksource: Switched to clocksource timebase
*** VALIDATE hugetlbfs ***
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 65536 (order: 4, 1048576 bytes)
TCP established hash table entries: 524288 (order: 6, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
UDP hash table entries: 65536 (order: 5, 2097152 bytes)
UDP-Lite hash table entries: 65536 (order: 5, 2097152 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pci 0009:03:00.0: enabling device (0140 -> 0142)
pci 0009:03:00.0: xHCI HW did not halt within 16000 usec status = 0x0
pci 0009:03:00.0: quirk_usb_early_handoff+0x0/0xd50 took 15807 usecs
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 22144K
workingset: timestamp_bits=38 max_order=22 bucket_order=0
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
pstore: using deflate compression
Block laye rSCS Iegerinc (bs)g drivr veersion .4 lo0aed (dmajor 25registered
io scheduler kyber registered
pci 0009:06:00.0: enabling device (0141 -> 0143)
Using unsupported 1024x768 (null) at 3fe281010000, depth=32, pitch=4096
Console: switching to colour frame buffer device 128x48
fb0: Open Firmware frame buffer device on /pciex@3fffe40500000/pci@0/pci@0/pci@3/pci@0/vga@0
hvc0: raw protocol on /ibm,opal/consoles/serial@0 (boot console)
hvc0: No interrupts property, using OPAL event
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
brd: module loaded
loop: module loaded
Uniform Multi-Platform E-IDE driver
ide-gd driver 1.18
ide-cd driver 5.00
ipr: IBM Power RAID SCSI Device Driver version: 2.6.4 (March 14, 2017)
ahci 0009:04:00.0: enabling device (0541 -> 0543)
ahci 0009:04:00.0: Using 64-bit DMA iommu bypass
ahci 0009:04:00.0: AHCI 0001.0000 32 slots 4 ports 6 Gbps 0xf impl SATA mode
ahci 0009:04:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
scsi host0: ahci
scsi host1: ahci
scsi host2: ahci
scsi host3: ahci
ata1: SATA max UDMA/133 abar m2048@0x3fe280800000 port 0x3fe280800100 irq 482
ata2: SATA max UDMA/133 abar m2048@0x3fe280800000 port 0x3fe280800180 irq 482
ata3: SATA max UDMA/133 abar m2048@0x3fe280800000 port 0x3fe280800200 irq 482
ata4: SATA max UDMA/133 abar m2048@0x3fe280800000 port 0x3fe280800280 irq 482
libphy: Fixed MDIO Bus: probed
tg3.c:v3.137 (May 11, 2014)
tg3 0009:07:00.0: enabling device (0140 -> 0142)
tg3 0009:07:00.0: Using 64-bit DMA iommu bypass
tg3 0009:07:00.0 eth0: Tigon3 [partno(BCM95718) rev 5717100] (PCI Express) MAC address 70:e2:84:14:0a:92
tg3 0009:07:00.0 eth0: attached PHY is 5718C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
tg3 0009:07:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
tg3 0009:07:00.0 eth0: dma_rwctrl[00000000] dma_mask[64-bit]
tg3 0009:07:00.1: enabling device (0140 -> 0142)
tg3 0009:07:00.1: Using 64-bit DMA iommu bypass
tg3 0009:07:00.1 eth1: Tigon3 [partno(BCM95718) rev 5717100] (PCI Express) MAC address 70:e2:84:14:0a:93
tg3 0009:07:00.1 eth1: attached PYH is5 718C [    3.625299] rtc-opal opal-
                                                                          [    3.629796] device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
powernv-cpufreq: cpufreq pstate min 0xffffffc5 nominal 0xffffffdd max 0x0
powernv-cpufreq: Workload Optimized Frequency is enabled in the platform
nx_compress_powernv: coprocessor found on chip 0, CT 3 CI 1
nx_compress_powernv: coprocessor found on chip 1, CT 3 CI 2
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
oprofile: using timer interrupt.
ipip: IPv4 and MPLS over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
drmem: No dynamic reconfiguration memory found
registered taskstats version 1
console [netcon0] enabled
netconsole: network logging started
rtc-opal opal-rtc: setting system clock to 2018-10-12 13:14:05 UTC (1539350045)
ata4: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata2.00: ATA-10: ST1000NX0313         00LY266 00LY265IBM, BE33, max UDMA/133
ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
ata1.00: ATA-10: ST1000NX0313         00LY266 00LY265IBM, BE33, max UDMA/133
ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
ata2.00: configured for UDMA/133
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST1000NX0313    BE33 PQ: 0 ANSI: 5

scsi 1:0:0:0: Direct-Access     ATA      ST1000NX0313     BE33 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 1:0:0:0: [sdb] 4096-byte physical blocks
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI removable disk
sd 1:0:0:0: [sdb] Attached SCSI removable disk
Freeing unused kernel memory: 2752K
This architecture does not have kernel memory protection.
Run /init as init process
systemd[1]: Failed to insert module 'autofs4'
systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
systemd[1]: Detected architecture ppc64-le.
systemd[1]: Running in initial RAM disk.

Welcome to CentOS Linux 7 (AltArch) dracut-033-535.el7 (Initramfs)!

[    4.074884] systemd[1]: Set hostname to <localhost.localdomain>.
[  OK  ] Reached target Timers.
[    4.124400] systemd[1]: Reached target Timers.
[    4.124445] systemd[1]: Starting Timers.
[  OK  ] Reached target Local File Systems.
[    4.124697] systemd[1]: Reached target Local File Systems.
[    4.124875] systemd[1]: Starting Local File Systems.
[  OK  ] Reached target Swap.
[    4.125050] systemd[1]: Reached target Swap.
[    4.125078] systemd[1]: Starting Swap.
[  OK  ] Created slice Root Slice.
[  OK  ] Listening on Journal Socket.
[  OK  ] Created slice System Slice.
[  OK  ] Reached target Slices.
         Starting dracut cmdline hook...
         Starting Setup Virtual Console...
         Starting Create list of required st... nodes for the current kernel...
         Starting Journal Service...
[  OK  ] Listening on udev Control Socket.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Reached target Sockets.
         Starting Apply Kernel Variables...
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Apply Kernel Variables.
[[    4.273389] s  OK  etfont (2787) used greatest stac] k depth: 10656 bStarted Create Sytes left
tatic Device Nodes in /dev.
[  OK  ] Started Journal Service.
[  OK  ] Started dracut cmdline hook.
         Starting dracut pre-udev hook...
[  OK  ] Started dracut pre-udev hook.
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Kernel Device Manager.
         Starting udev Coldplug all Devices...
[  OK  ] Started Setup Virtual Console.
nvme nvme0: pci function 0000:01:00.0
nvme 0000:01:00.0: enabling device (0140 -> 0142)
nvme 0000:01:00.0: Using 64-bit DMA iommu bypass
tg3 0009:07:00.0 enP9p7s0f0: renamed from eth0
bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bnx2x 1.712[    4.396593] Emulex LightPulse Fibre Channel SCSI driver 12.0.0.7
Copyright (C) 2017-2018 Broadcom. All Rights Reserved. The term "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.
lpfc 0001:01:00.0: enabling device (0140 -> 0142)
lpfc 0001:01:00.0: Using 64-bit DMA iommu bypass
scsi host4: Emulex LPe12000 PCIe Fibre Channel Adapter on PCI bus 01 device 00 irq 493
synth uevent: /devices/vio: failed to send uevent
vio vio: uevent: failed to send synthetic uevent
bnx2x 0008:01:00.0: enabling device (0140 -> 0142)
ead cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 1:0:0:0: [sdb] 4096-byte physical blocks
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI removable disk
sd 1:0:0:0: [sdb] Attached SCSI removable disk
Freeing unused kernel memory: 2752K
This architecture does not have kernel memory protection.
Run /init as init process
systemd[1]: Failed to insert module 'autofs4'
systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    4.074596] systemd[1]: Detected architecture ppc64-le.
[    4.074613] systemd[1]: Running in initial RAM disk.

Welcome to CentOS Linux 7 (AltArch) dracut-033-535.el7 (Initramfs)!

[    4.074884] systemd[1]: Set hostname to <localhost.localdomain>.
[  OK  ] Reached target Timers.
[    4.124400] systemd[1]: Reached target Timers.
[    4.124445] systemd[1]: Starting Timers.
[  OK  ] Reached target Local File Systems.
[    4.124697] systemd[1]: Reached target Local File Systems.
[    4.124875] systemd[1]: Starting Local File Systems.
[  OK  ] Reached target Swap.
[    4.125050] systemd[1]: Reached target Swap.
[    4.125078] systemd[1]: Starting Swap.
[  OK  ] Created slice Root Slice.
[  OK  ] Listening on Journal Socket.
[  OK  ] Created slice System Slice.
[  OK  ] Reached target Slices.
         Starting dracut cmdline hook...
         Starting Setup Virtual Console...
         Starting Create list of required st... nodes for the current kernel...
         Starting Journal Service...
[  OK  ] Listening on udev Control Socket.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Reached target Sockets.
         Starting Apply Kernel Variables...
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Apply Kernel Variables.
[[    4.273389] s  OK  etfont (2787) used greatest stac] k depth: 10656 bStarted Create Sytes left
tatic Device Nodes in /dev.
[  OK  ] Started Journal Service.
[  OK  ] Started dracut cmdline hook.
         Starting dracut pre-udev hook...
[  OK  ] Started dracut pre-udev hook.
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Kernel Device Manager.
         Starting udev Coldplug all Devices...
[  OK  ] Started Setup Virtual Console.
nvme nvme0: pci function 0000:01:00.0
nvme 0000:01:00.0: enabling device (0140 -> 0142)
nvme 0000:01:00.0: Using 64-bit DMA iommu bypass
tg3 0009:07:00.0 enP9p7s0f0: renamed from eth0
bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bnx2x 1.712.30-0 (2014/02/10)
bnx2x 0008:01:00.0: msix capability found
Emulex LightPulse Fibre Channel SCSI driver 12.0.0.7
Copyright (C) 2017-2018 Broadcom. All Rights Reserved. The term "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.
lpfc 0001:01:00.0: enabling device (0140 -> 0142)
lpfc 0001:01:00.0: Using 64-bit DMA iommu bypass
scsi host4: Emulex LPe12000 PCIe Fibre Channel Adapter on PCI bus 01 device 00 irq 493
synth uevent: /devices/vio: failed to send uevent
vio vio: uevent: failed to send synthetic uevent
bnx2x 0008:01:00.0: enabling device (0140 -> 0142)
bnx2x 0008:01:00.0: Using 64-bit DMA iommu bypass
bnx2x 0008:01:00.0: part number 0-0-0-0
[  OK  ] Started udev Coldplug all Devices.
[  OK  ] Reached target System Initialization.
         Starting dracut initqueue hook...
         Starting Show Plymouth Boot Screen...
[  OK  ] Started Show Plymouth Boot Screen.
[  OK  ] Reached target Paths.
[  OK  ] Reached target Basic System.
bnx2x 0008:01:00.0: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
tg3 0009:07:00.1 enP9p7s0f1: renamed from eth1
bnx2x 0008:01:00.1: msix capability found
bnx2x 0008:01:00.1: enabling device (0140 -> 0142)
bnx2x 0008:01:00.1: Using 64-bit DMA iommu bypass
bnx2x 0008:01:00.1: part number 0-0-0-0
bnx2x 0008:01:00.1: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
bnx2x 0008:01:00.2: msix capability found
bnx2x 0008:01:00.2: enabling device (0140 -> 0142)
bnx2x 0008:01:00.2: Using 64-bit DMA iommu bypass
bnx2x 0008:01:00.2: part number 0-0-0-0
bnx2x 0008:01:00.2: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
bnx2x 0008:01:00.3: msix capability found
bnx2x 0008:01:00.3: enabling device (0140 -> 0142)
bnx2x 0008:01:00.3: Using 64-bit DMA iommu bypass
bnx2x 0008:01:00.3: part number 0-0-0-0
bnx2x 0008:01:00.3: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
bnx2x 0008:01:00.0 enP8p1s0f0: renamed from eth0
bnx2x 0008:01:00.1 enP8p1s0f1: renamed from eth1
bnx2x 0008:01:00.3 enP8p1s0f3: renamed from eth3
bnx2x 0008:01:00.2 enP8p1s0f2: renamed from eth2
print_req_error: critical medium error, dev nvme0n1, sector 0
Buffer I/O error on dev nvme0n1, logical block 0, async page read
print_req_error: critical medium error, dev nvme0n1, sector 0
Buffer I/O error on dev nvme0n1, logical block 0, async page read
 nvme0n1: unable to read partition table
print_req_error: critical medium error, dev nvme0n1, sector 0
print_req_error: critical medium error, dev nvme0n1, sector 0
Buffer I/O error on dev nvme0n1, logical block 0, async page read
lpfc 0001:01:00.1: enabling device (0140 -> 0142)
lpfc 0001:01:00.1: Using 64-bit DMA iommu bypass
scsi host5: Emulex LPe12000 PCIe Fibre Channel Adapter on PCI bus 01 device 01 irq 494
lpfc 0001:01:00.0: 0:1303 Link Up Event x1 received Data: x1 x1 x20 x0 x0 x0 0
scsi 4:0:0:0: Direct-Access     IBM      2145             0000 PQ: 0 ANSI: 6
sd 4:0:0:0: Power-on or device reset occurred
sd 4:0:0:0: Attached scsi generic sg2 type 0
scsi 4:0:1:0: Direct-Access     IBM      2145             0000 PQ: 0 ANSI: 6
sd 4:0:0:0: [sdc] 209715200 512-byte logical blocks: (107 GB/100 GiB)
sd 4:0:1:0: Attached scsi generic sg3 type 0
sd 4:0:1:0: Power-on or device reset occurred
sd 4:0:0:0: [sdc] Write Protect is off
sd 4:0:0:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
sd 4:0:1:0: [sdd] 209715200 512-byte logical blocks: (107 GB/100 GiB)
sd 4:0:1:0: [sdd] Write Protect is off
sd 4:0:1:0: [sdd] Write cache: disabled, read cache: enabled, supports DPO and FUA
 sdc: sdc1 sdc2 sdc3
 sdd: sdd1 sdd2 sdd3
sd 4:0:0:0: [sdc] Attached SCSI disk
sd 4:0:1:0: [sdd] Attached SCSI disk
sd 4:0:0:0: Power-on or device reset occurred
sd 4:0:1:0: Power-on or device reset occurred
print_req_error: critical medium error, dev nvme0n1, sector 0
print_req_error: critical medium error, dev nvme0n1, sector 0
print_req_error: critical medium error, dev nvme0n1, sector 0
print_req_error: critical medium error, dev nvme0n1, sector 0
print_req_error: critical medium error, dev nvme0n1, sector 0
print_req_error: critical medium error, dev nvme0n1, sector 0
[  OK  ] Found device /dev/mapper/ca_ltc--garri5-root.
         Starting File System Check on /dev/mapper/ca_ltc--garri5-root...
[  OK  ] Started File System Check on /dev/mapper/ca_ltc--garri5-root.
[  OK  ] Started dracut initqueue hook.
         Mounting /sysroot...
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
SGI XFS with ACLs, security attributes, no debug enabled
XFS (dm-5): Mounting V5 Filesystem
lpfc 0001:01:00.1: 1:1303 Link Up Event x1 received Data: x1 x1 x20 x0 x0 x0 0
XFS (dm-5): Starting recovery (logdev: internal)
scsi 5:0:0:0: Direct-Access     IBM      2145             0000 PQ: 0 ANSI: 6
sd 5:0:0:0: Power-on or device reset occurred
sd 5:0:0:0: Attached scsi generic sg4 type 0
scsi 5:0:1:0: Direct-Access     IBM      2145             0000 PQ: 0 ANSI: 6
sd 5:0:0:0: [sde] 209715200 512-byte logical blocks: (107 GB/100 GiB)
sd 5:0:0:0: [sde] Write Protect is off
sd 5:0:1:0: Attached scsi generic sg5 type 0
sd 5:0:1:0: Power-on or device reset occurred
sd 5:0:0:0: [sde] Write cache: disabled, read cache: enabled, supports DPO and FUA
sd 5:0:1:0: [sdf] 209715200 512-byte logical blocks: (107 GB/100 GiB)
sd 5:0:1:0: [sdf] Write Protect is off
sd 5:0:1:0: [sdf] Write cache: disabled, read cache: enabled, supports DPO and FUA
 sde: sde1 sde2 sde3
 sdf: sdf1 sdf2 sdf3
sd 5:0:0:0: [sde] Attached SCSI disk
sd 5:0:1:0: [sdf] Attached SCSI disk
XFS (dm-5): Ending recovery (logdev: internal)
mount (6240) used greatest stack depth: 9552 bytes left
[  OK  ] Mounted /sysroot.
[  OK  ] Reached target Initrd Root File System.
         Starting Reload Configuration from the Real Root...
[  OK  ] Started Reload Configuration from the Real Root.
[  OK  ] Reached target Initrd File Systems.
[  OK  ] Reached target Initrd Default Target.
         Starting dracut pre-pivot and cleanup hook...
[  OK  ] Started dracut pre-pivot and cleanup hook.
         Starting Cleaning Up and Shutting Down Daemons...
[  OK  ] Stopped target Timers.
         Starting Plymouth switch root service...
[  OK  ] Stopped Cleaning Up and Shutting Down Daemons.
[  OK  ] Stopped dracut pre-pivot and cleanup hook.
         Stopping dracut pre-pivot and cleanup hook...
[  OK  ] Stopped target Remote File Systems.
[  OK  ] Stopped target Remote File Systems (Pre).
[  OK  ] Stopped dracut initqueue hook.
         Stopping dracut initqueue hook...
[  OK  ] Stopped target Initrd Default Target.
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped target Slices.
[  OK  ] Stopped target System Initialization.
[  OK  ] Stopped Apply Kernel Variables.
         Stopping Apply Kernel Variables...
[  OK  ] Stopped udev Coldplug all Devices.
         Stopping udev Coldplug all Devices...
         Stopping udev Kernel Device Manager...
[  OK  ] Stopped target Local File Systems.
[  OK  ] Stopped target Swap.
[  OK  ] Stopped target Paths.
[  OK  ] Stopped target Sockets.
[  OK  ] Started Plymouth switch root service.
[  OK  ] Stopped udev Kernel Device Manager.
[  OK  ] Stopped Create Static Device Nodes in /dev.
         Stopping Create Static Device Nodes in /dev...
[  OK  ] Stopped Create list of required sta...ce nodes for the current kernel.
         Stopping Create list of required st... nodes for the current kernel...
[  OK  ] Stopped dracut pre-udev hook.
         Stopping dracut pre-udev hook...
[  OK  ] Stopped dracut cmdline hook.
         Stopping dracut cmdline hook...
[  OK  ] Closed udev Kernel Socket.
[  OK  ] Closed udev Control Socket.
         Starting Cleanup udevd DB...
[  OK  ] Started Cleanup udevd DB.
[  OK  ] Reached target Switch Root.
         Starting Switch Root...
[   11.425408] systemd-journald[2786]: Received SIGTERM from PID 1 (systemd).
[   11.533242] systemd: 24 output lines suppressed due to ratelimiting
[   12.128089] systemd[1]: Inserted module 'autofs4'
[   12.180852] systemd[1]: Inserted module 'ip_tables'

Welcome to CentOS Linux 7 (AltArch)!

[   12.600037] systemd-sysv-generator[6436]: stat() failed on /etc/rc.d/init.d/autotest: No such file or directory
[  OK  ] Stopped Switch Root.
[  OK  ] Stopped Journal Service.
         Starting Journal Service...
[  OK  ] Reached target Host and Network Name Lookups.
[  OK  ] Listening on udev Control Socket.
[  OK  ] Listening on Delayed Shutdown Socket.
[  OK  ] Created slice system-selinux\x2dpol...grate\x2dlocal\x2dchanges.slice.
[  OK  ] Set up automount Arbitrary Executab...ats File System Automount Point.
         Mounting POSIX Message Queue File System...
         Starting Create list of required st... nodes for the current kernel...
[  OK  ] Created slice system-getty.slice.
[  OK  ] Stopped File System Check on Root Device.
         Stopping File System Check on Root Device...
         Starting Collect Read-Ahead Data...
[  OK  ] Listening on Device-mapper event daemon FIFOs.
[  OK  ] Listening on LVM2 poll daemon socket.
[  OK  ] Created slice system-serial\x2dgetty.slice.
         Mounting Huge Pages File System...
         Starting Replay Read-Ahead Data...
[  OK  ] Created slice User and Session Slice.
[  OK  ] Reached target Slices.
         Mounting Debug File System...
         Mounting NFSD configuration filesystem...
[  OK  ] Listening on LVM2 metadata daemon socket.
         Starting Monitoring of LVM2 mirrors... dmeventd or progress polling...
[  OK  ] Stopped target Switch Root.
[  OK  ] Stopped target Initrd Root File System.
[  OK  ] Stopped target Initrd File Systems.
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Mounted Debug File System.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Started Journal Service.
[   13.819446] systemd-readahead[6475]: Failed to create fanotify object: Function not implemented
[  OK  ] Started Collect Read-Ahead Data.
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
[  OK  ] Started Replay Read-Ahead Data.
         Starting Set Up Additional Binary Formats...
[   14.173354] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
         Starting Load legacy module configuration...
         Starting Apply Kernel Variables...
         Starting Remount Root and Kernel File Systems...
         Starting Create Static Device Nodes in /dev...
[  OK  ] Mounted NFSD configuration filesystem.
         Mounting Arbitrary Executable File Formats File System...
[  OK  ] Started LVM2 metadata daemon.
         Starting LVM2 metadata daemon...
[  OK  ] Started Remount Root and Kernel File Systems.
         Starting Flush Journal to Persistent Storage...
         Starting Configure read-only root support...
         Starting Load/Save Random Seed...
         Starting udev Coldplug all Devices...
[  OK  ] Mounted Arbitrary Executable File Formats File System.
[  OK  ] Started Create Static Device Nodes in /dev.
[  OK  ] Started Load/Save Random Seed.
         Starting udev Kernel Device Manager...
[   14.546059] systemd-journald[6472]: Received request to flush runtime journal from PID 1
[  OK  ] Started Flush Journal to Persistent Storage.
[  OK  ] Started Set Up Additional Binary Formats.
[  OK  ] Started Apply Kernel Variables.
[   14.806130] synth uevent: /devices/vio: failed to send uevent
[   14.806135] vio vio: uevent: failed to send synthetic uevent
[  OK  ] Started udev Coldplug all Devices.
         Starting udev Wait for Complete Device Initialization...
         Starting Device-Mapper Multipath Device Controller...
[  OK  ] Started Load legacy module configuration.
[  OK  ] Started udev Kernel Device Manager.
[  OK  ] Started Configure read-only root support.
powernv_rng: Registered powernv hwrng.
print_req_error: critical medium error, dev nvme0n1, sector 0
print_req_error: critical medium error, dev nvme0n1, sector 0
Buffer I/O error on dev nvme0n1, logical block 0, async page read
[  OK  ] Started Device-Mapper Multipath Device Controller.
print_req_error: critical medium error, dev nvme0n1, sector 0
sd 5:0:0:0: Power-on or device reset occurred
sd 5:0:1:0: Power-on or device reset occurred
[  OK  ] Found device /dev/hvc0.
print_req_error: critical medium error, dev nvme0n1, sector 0
print_req_error: critical medium error, dev nvme0n1, sector 0
print_req_error: critical medium error, dev nvme0n1, sector 0
crypto_register_alg 'aes' = 0
crypto_register_alg 'cbc(aes)' = 0
crypto_register_alg 'ctr(aes)' = 0
crypto_register_alg 'xts(aes)' = 0
[  OK  ] Found device /dev/mapper/ca_ltc--garri5-home.
[  OK  ] Found device /dev/mapper/ca_ltc--garri5-swap.
[  OK  ] Created slice system-lvm2\x2dpvscan.slice.
         Starting LVM2 PV scan on device 8:3...
         Activating swap /dev/mapper/ca_ltc--garri5-swap...
[   16.866315] tg3 0009:07:00.0 net0: renamed from enP9p7s0f0
[  OK  ] Found device ST1000NX0313_00LY266_00LY265IBM 2.
[  OK  ] Started Monitoring of LVM2 mirrors,...ng dmeventd or progress polling.
[  OK  ] Reached target Local File Systems (Pre).
         Mounting /boot...
         Mounting /home...
[   17.258442] Adding 4194240k swap on /dev/mapper/ca_ltc--garri5-swap.  Priority:-2 extents:1 across:4194240k 
[  OK  ] Activated swap /dev/mapper/ca_ltc--garri5-swap.
[  OK  ] Reached target Swap.
[   17.282200] device-mapper: multipath service-time: version 0.3.0 loaded
[   17.298104] XFS (sda2): Mounting V5 Filesystem
[   17.333010] XFS (dm-4): Mounting V5 Filesystem
         Starting LVM2 PV scan on device 253:9...
[   17.437537] device-mapper: table: 253:6: multipath: error getting device
[   17.437574] device-mapper: ioctl: error adding target to table
[  OK  ] Started LVM2 PV scan on device 253:9.
[  OK  ] Started udev Wait for Complete Device Initialization.
         Starting Activation of DM RAID sets...
[   18.171520] XFS (sda2): Starting recovery (logdev: internal)
[  OK  ] Started Activation of DM RAID sets.
[  OK  ] Reached target Encrypted Volumes.
[   18.530217] XFS (dm-4): Starting recovery (logdev: internal)
[   18.582464] XFS (sda2): Ending recovery (logdev: internal)
[  OK  ] Mounted /boot.
[   18.631444] XFS (dm-4): Ending recovery (logdev: internal)
[  OK  ] Mounted /home.
[  OK  ] Reached target Local File Systems.
         Starting Preprocess NFS configuration...
         Starting Tell Plymouth To Write Out Runtime Data...
         Starting Import network configuration from initramfs...
[  OK  ] Started Preprocess NFS configuration.
[  OK  ] Started Tell Plymouth To Write Out Runtime Data.
[  OK  ] Started LVM2 PV scan on device 8:3.
[  OK  ] Started Import network configuration from initramfs.
         Starting Create Volatile Files and Directories...
[  OK  ] Started Create Volatile Files and Directories.
         Mounting RPC Pipe File System...
         Starting Security Auditing Service...
[  OK  ] Mounted RPC Pipe File System.
[  OK  ] Reached target rpc_pipefs.target.
         Starting NFSv4 ID-name mapping service...
[  OK  ] Started NFSv4 ID-name mapping service.
[  OK  ] Started Security Auditing Service.
         Starting Update UTMP about System Boot/Shutdown...
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[  OK  ] Reached target System Initialization.
[  OK  ] Listening on Open-iSCSI iscsid Socket.
[  OK  ] Listening on RPCbind Server Activation Socket.
[  OK  ] Listening on Virtual machine lock manager socket.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Listening on Open-iSCSI iscsiuio Socket.
[  OK  ] Reached target Paths.
[  OK  ] Listening on Virtual machine log manager socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
         Starting Ipmievd Daemon...
         Starting System Logging Service...
         Starting Authorization Manager...
         Starting GSSAPI Proxy Daemon...
[  OK  ] Started D-Bus System Message Bus.
         Starting D-Bus System Message Bus...
         Starting Dump dmesg to /var/log/dmesg...
[  OK  ] Started ABRT Automated Bug Reporting Tool.
         Starting ABRT Automated Bug Reporting Tool...
         Starting Resets System Activity Logs...
[  OK  ] Started libstoragemgmt plug-in server daemon.
         Starting libstoragemgmt plug-in server daemon...
[  OK  ] Started irqbalance daemon.
         Starting irqbalance daemon...
         Starting Install ABRT coredump hook...
         Starting Rollback uncommitted netcf...rk config change transactions...
         Starting Login Service...
[  OK  ] Started Self Monitoring and Reporting Technology (SMART) Daemon.
         Starting Self Monitoring and Reporting Technology (SMART) Daemon...
[  OK  ] Started Hardware RNG Entropy Gatherer Daemon.
         Starting Hardware RNG Entropy Gatherer Daemon...
[  OK  ] Started ABRT kernel log watcher.
         Starting ABRT kernel log watcher...
         Starting NTP client/server...
[  OK  ] Reached target Timers.
[  OK  ] Started System Logging Service.
[FAILED] Failed to start Ipmievd Daemon.
See 'systemctl status ipmievd.service' for details.
[  OK  ] Started GSSAPI Proxy Daemon.
[  OK  ] Started Dump dmesg to /var/log/dmesg.
[  OK  ] Started Resets System Activity Logs.
[  OK  ] Started Rollback uncommitted netcf network config change transactions.
         Starting Network Manager...
[  OK  ] Reached target NFS client services.
[  OK  ] Started Login Service.
[  OK  ] Started NTP client/server.
[  OK  ] Started Install ABRT coredump hook.
[  OK  ] Started Authorization Manager.
[  OK  ] Started Network Manager.
         Starting Network Manager Wait Online...
         Starting Network Manager Script Dispatcher Service...
[  OK  ] Started Network Manager Script Dispatcher Service.
         Starting Hostname Service...
[  OK  ] Started Hostname Service.
bnx2x 0008:01:00.0 enP8p1s0f0: using MSI-X  IRQs: sp 483  fp[0] 485 ... fp[7] 513
bnx2x 0008:01:00.0 enP8p1s0f0: NIC Link is Up, 10000 Mbps full duplex, Flow control: ON - receive & transmit
bnx2x 0008:01:00.1 enP8p1s0f1: using MSI-X  IRQs: sp 452  fp[0] 454 ... fp[7] 426
bnx2x 0008:01:00.1 enP8p1s0f1: NIC Link is Up, 10000 Mbps full duplex, Flow control: ON - receive & transmit
bnx2x 0008:01:00.2 enP8p1s0f2: using MSI-X  IRQs: sp 427  fp[0] 429 ... fp[7] 436
bnx2x 0008:01:00.3 enP8p1s0f3: using MSI-X  IRQs: sp 437  fp[0] 439 ... fp[7] 446
tg3 0009:07:00.0 net0: Link is up at 1000 Mbps, full duplex
tg3 0009:07:00.0 net0: Flow control is on for TX and on for RX
tg3 0009:07:00.0 net0: EEE is disabled
[*     ] A start job is running for Network ...ger Wait Online (15s / no limit)[   30.065135] bnx2x 0008:01:00.2 enP8p1s0f2: NIC Link is Up, 1000 Mbps full duplex, Flow control: none
[**    ] A start job is running for Network ...ger Wait Online (16s / no limit)[   30.615139] bnx2x 0008:01:00.3 enP8p1s0f3: NIC Link is Up, 1000 Mbps full duplex, Flow control: none
[FAILED] Failed to start Network Manager Wait Online.
See 'systemctl status NetworkManager-wait-online.service' for details.
         Starting LSB: Bring up/down networking...
[  OK  ] Started LSB: Bring up/down networking.
[  OK  ] Reached target Network.
         Starting Postfix Mail Transport Agent...
         Starting OpenSSH server daemon...
[  OK  ] Reached target Network is Online.
         Starting NFS Mount Daemon...
         Starting NFS status monitor for NFSv2/3 locking....
         Starting Logout off all iSCSI sessions on shutdown...
         Starting Dynamic System Tuning Daemon...
[  OK  ] Started Logout off all iSCSI sessions on shutdown.
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
         Starting Crash recovery kernel arming...
         Starting Virtualization daemon...
         Starting The nginx HTTP and reverse proxy server...
         Starting Permit User Sessions...
         Starting Availability of block devices...
[  OK  ] Started Permit User Sessions.
[  OK  ] Started Availability of block devices.
[  OK  ] Started IBM Performance Management for PowerLinux Systems.
         Starting IBM Performance Management for PowerLinux Systems...
[  OK  ] Started Command Scheduler.
         Starting Command Scheduler...
[  OK  ] Started Job spooling tools.
         Starting Job spooling tools...
         Starting Wait for Plymouth Boot Screen to Quit...
         Starting Terminate Plymouth Boot Screen...
[FAILED] Failed to start Crash recovery kernel arming.
See 'systemctl status kdump.service' for details.
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 45-second grace period (net f000001f)
tun: Universal TUN/TAP device driver, 1.6
virbr0: port 1(virbr0-nic) entered blocking state
virbr0: port 1(virbr0-nic) entered disabled state
device virbr0-nic entered promiscuous mode

CentOS Linux 7 (AltArch)
Kernel 4.19.0-rc7-next-20181011-autotest-dirty on an ppc64le

garri5 login: 

--=-sRef+233esjGrZ0b5wQW--

