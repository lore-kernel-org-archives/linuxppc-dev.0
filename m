Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BB44A14008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 10:03:17 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 24 Mar 2014 17:03:14 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 797EA19D8039
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 17:03:08 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2ON3B578847842
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 00:03:11 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2ON3AiM003658
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 17:03:11 -0600
Date: Mon, 24 Mar 2014 16:02:56 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: linux-mm@kvack.org
Subject: powerpc hugepage bug(s) when no valid hstates?
Message-ID: <20140324230256.GA18778@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 nyc@holomorphy.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In KVM guests on Power, if the guest is not backed by hugepages, we see
the following in the guest:

AnonHugePages:         0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:         64 kB

This seems like a configuration issue -- why is a hstate of 64k being
registered?

I did some debugging and found that the following does trigger,
mm/hugetlb.c::hugetlb_init():

        /* Some platform decide whether they support huge pages at boot
         * time. On these, such as powerpc, HPAGE_SHIFT is set to 0 when
         * there is no such support
         */
        if (HPAGE_SHIFT == 0)
                return 0;

That check is only during init-time. So we don't support hugepages, but
none of the hugetlb APIs actually check this condition (HPAGE_SHIFT ==
0), so /proc/meminfo above falsely indicates there is a valid hstate (at
least one). But note that there is no /sys/kernel/mm/hugepages meaning
no hstate was actually registered.

Further, it turns out that huge_page_order(default_hstate) is 0, so
hugetlb_report_meminfo is doing:

1UL << (huge_page_order(h) + PAGE_SHIFT - 10)

which ends up just doing 1 << (PAGE_SHIFT - 10) and since the base page
size is 64k, we report a hugepage size of 64k... And allow the user to
allocate hugepages via the sysctl, etc.

What's the right thing to do here?

1) Should we add checks for HPAGE_SHIFT == 0 to all the hugetlb APIs? It
seems like HPAGE_SHIFT == 0 should be the equivalent, functionally, of
the config options being off. This seems like a lot of overhead, though,
to put everywhere, so maybe I can do it in an arch-specific macro, that
in asm-generic defaults to 0 (and so will hopefully be compiled out?).

2) What should hugetlbfs do when HPAGE_SHIFT == 0? Should it be
mountable? Obviously if it's mountable, we can't great files there
(since the fs will report insufficient space). [1]

Thanks,
Nish

[1]
Currently, I am seeing the following when I `mount -t hugetlbfs /none
/dev/hugetlbfs`, and then simply do a `ls /dev/hugetlbfs`. I think it's
related to the fact that hugetlbfs is properly not correctly setting
itself up in this state?:

Unable to handle kernel paging request for data at address 0x00000031
Faulting instruction address: 0xc000000000245710
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: pseries_rng rng_core virtio_net virtio_pci virtio_ring virtio
CPU: 0 PID: 1807 Comm: ls Not tainted 3.14.0-rc7-00066-g774868c-dirty #14
task: c00000007e804520 ti: c00000007aed4000 task.ti: c00000007aed4000
NIP: c000000000245710 LR: c00000000024586c CTR: 0000000000000000
REGS: c00000007aed74f0 TRAP: 0300   Not tainted  (3.14.0-rc7-00066-g774868c-dirty)
MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24002484  XER: 00000000
CFAR: 00003fff91037760 DAR: 0000000000000031 DSISR: 40000000 SOFTE: 1
GPR00: c00000000024586c c00000007aed7770 c000000000d85420 c00000007d7a0010
GPR04: c000000000abcf20 c000000000ed7c78 0000000000000020 c000000000cbc880
GPR08: 0000000000000000 0000000000000000 0000000080000000 0000000000000002
GPR12: 0000000044002484 c00000000fe40000 0000000000000000 00000000100232f0
GPR16: 0000000000000001 0000000000000000 0000000000000000 c00000007d794a40
GPR20: 0000000000000000 0000000000000024 c00000007a49a200 c00000007a2bd000
GPR24: c00000007aed7bb8 c00000007d7a0090 0000000000014800 0000000000000000
GPR28: c00000007d7a0010 c00000007a49a210 c00000007d7a0150 0000000000000001
NIP [c000000000245710] .time_out_leases+0x30/0x100
LR [c00000000024586c] .__break_lease+0x8c/0x480
Call Trace:
[c00000007aed7770] [c0000000002434c0] .lease_alloc+0x20/0xe0 (unreliable)
[c00000007aed77f0] [c00000000024586c] .__break_lease+0x8c/0x480
[c00000007aed78e0] [c0000000001e0374] .do_dentry_open.isra.14+0xf4/0x370
[c00000007aed7980] [c0000000001e0624] .finish_open+0x34/0x60
[c00000007aed7a00] [c0000000001f519c] .do_last+0x56c/0xe40
[c00000007aed7b20] [c0000000001f5b68] .path_openat+0xf8/0x800
[c00000007aed7c40] [c0000000001f7810] .do_filp_open+0x40/0xb0
[c00000007aed7d70] [c0000000001e1f08] .do_sys_open+0x198/0x2e0
[c00000007aed7e30] [c00000000000a158] syscall_exit+0x0/0x98
Instruction dump:
