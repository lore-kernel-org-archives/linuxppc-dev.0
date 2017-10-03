Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5wLL193bzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 21:31:21 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v93ASdMi122013
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 06:31:17 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dc7m9uwk0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Oct 2017 06:31:17 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 3 Oct 2017 04:31:15 -0600
Subject: Re: [linux-next][Oops] memory hot-unplug results fault instruction
 address at /include/linux/list.h:104
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Kees Cook <keescook@chromium.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, sachinp
 <sachinp@linux.vnet.ibm.com>, stephen Rothwell <sfr@canb.auug.org.au>,
 linux-next <linux-next@vger.kernel.org>, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>
Date: Tue, 03 Oct 2017 16:01:05 +0530
In-Reply-To: <CAGXu5jKMGuc-i0vfZx3TYx4iq35PCF0T1y9zv9A=k7ieES2Qkg@mail.gmail.com>
References: <1505198479.10243.23.camel@abdul>
 <1505893239.30180.24.camel@abdul.in.ibm.com>
 <CAGXu5jKMGuc-i0vfZx3TYx4iq35PCF0T1y9zv9A=k7ieES2Qkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1507026665.3792.4.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-20 at 12:54 -0700, Kees Cook wrote:
> On Wed, Sep 20, 2017 at 12:40 AM, Abdul Haleem
> <abdhalee@linux.vnet.ibm.com> wrote:
> > On Tue, 2017-09-12 at 12:11 +0530, abdul wrote:
> >> Hi,
> >>
> >> Memory hot-unplug on PowerVM LPAR running next-20170911 results in
> >> Faulting instruction address: 0xc0000000002b56c4
> >>
> >> which maps to the below code path:
> >>
> >> 0xc0000000002b56c4 is in __rmqueue (./include/linux/list.h:104).
> >> 99     * This is only for internal list manipulation where we know
> >> 100    * the prev/next entries already!
> >> 101    */
> >> 102   static inline void __list_del(struct list_head * prev, struct
> >> list_head * next)
> >> 103   {
> >> 104           next->prev = prev;
> >> 105           WRITE_ONCE(prev->next, next);
> >> 106   }
> >> 107
> >> 108   /**
> >>
> >
> > I see another kernel Oops when running transparent hugepages
> > de-fragmentation test.
> >
> > And the faulty instruction address again pointing to same code line
> > 0xc00000000026f9f4 is in compaction_alloc (./include/linux/list.h:104)
> >
> > steps to recreate:
> > -----------------
> > 1. Enable transparent hugepages ("always")
> > 2. Turn off the defrag $ echo 0 > khugepaged/defrag
> > 3. Write random to memory path
> > 4. Set huge pages numbers
> > 5. Turn on defrag $ echo 1 > khugepaged/defrag
> >
> >
> > new trace:
> > ----------
> > Unable to handle kernel paging request for data at address
> > 0x5deadbeef0000108
> 
> This looks like use-after-list-removal, that value appears to be LIST_POISON1.
> 
> Try enabling CONFIG_DEBUG_LIST to see if you get better details?

Trace messages after enabling CONFIG_DEBUG_LIST

BUG: Bad page state in process in:imklog  pfn:6cbb3
page:f000000001b2ecc0 count:2 mapcount:0 mapping:c000000769aafd20 index:0x1
flags: 0x33ffff800001068(uptodate|lru|active|private)
raw: 033ffff800001068 c000000769aafd20 0000000000000001 00000002ffffffff
raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 c0000000feca3400
page dumped because: page still charged to cgroup
page->mem_cgroup:c0000000feca3400
bad because of flags: 0x1068(uptodate|lru|active|private)
kernel BUG at mm/vmscan.c:1556!
[c000000005da79f0] [c0000000002bfe74] __alloc_pages_nodemask+0x754/0x1160
Oops: Exception in kernel mode, sig: 5 [#1]
LE SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: xt_addrtype xt_conntrack ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 iptable_filter 
[c000000005da7bf0] [c00000000034c238] alloc_pages_vma+0xb8/0x290
[c000000005da7c60] [c0000000003102b0] __handle_mm_fault+0x1150/0x1ad0
[c000000005da7d40] [c000000000310d58] handle_mm_fault+0x128/0x210
[c000000005da7d80] [c000000000067878] __do_page_fault+0x218/0x8e0
[c000000005da7e30] [c00000000000a4a4] handle_page_fault+0x18/0x38
Instruction dump:
38210060 e8010010 7c0803a6 4e800020 60420000 3c62ff93 7ca62b78 7d244b78 
7d455378 3863edc8 4bafe4d1 60000000 <0fe00000> 38600000 4bffff60 60000000 
---[ end trace 1e619608a776e913 ]---
list_add corruption. next->prev should be prev (c00000077ff54710), but was 5deadbeef0000200. (next=f000000001b2ece0).
------------[ cut here ]------------
WARNING: CPU: 5 PID: 308 at lib/list_debug.c:25 __list_add_valid+0xa4/0xf0
Modules linked in: xt_addrtype xt_conntrack ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 iptable_filter ip_tables x_tables nf_nat nf_conntrack bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio libcrc32c vmx_crypto pseries_rng
 ip_tables x_tables nf_nat nf_conntrack bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio libcrc32c vmx_crypto pseries_rng rtc_generic autofs4
CPU: 2 PID: 1 Comm: systemd Tainted: G    B   W       4.14.0-rc2-next-20170929-autotest #2
task: c000000777e00000 task.stack: c000000777e80000
NIP:  c0000000002d5900 LR: c0000000002d586c CTR: 0000000000000000
REGS: c000000777e82c20 TRAP: 0700   Tainted: G    B   W        (4.14.0-rc2-next-20170929-autotest)
MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22248428  XER: 2000000a  
CFAR: c0000000002d587c SOFTE: 0 
GPR00: c0000000002d586c c000000777e82ea0 c0000000015ac700 ffffffffffffffea 
GPR04: 0000000000000000 c000000777e830a0 0000000000014f28 0000000000000001 
GPR08: 0000000000000000 033ffff800010008 0000000000000000 3563376431303030 
GPR12: 0000000000008800 
 rtc_generic
c00000000e741500 f000000001d7c4a0 0000000000000001 
GPR16: c000000777e833ac c000000777e830b0 0000000000000002 c000000777e830a0 
GPR20: 0000000000000000 c000000777e833c4 c000000777e82f10 0000000000000006 
GPR24: c000000777e82f50 0000000000000020 0000000000000007 c000000774193800 
GPR28: 0000000000000006 000000000000000c c000000774193820 
 autofs4
f000000001d7c560 
NIP [c0000000002d5900] isolate_lru_pages.isra.21+0x360/0x580
LR [c0000000002d586c] isolate_lru_pages.isra.21+0x2cc/0x580
Call Trace:
[c000000777e82ea0] [c0000000002d586c] isolate_lru_pages.isra.21+0x2cc/0x580 (unreliable)
[c000000777e82ff0] [c0000000002d811c] shrink_inactive_list+0x1ac/0x720
[c000000777e83130] [c0000000002d8ec8] shrink_node_memcg+0x248/0x790
[c000000777e83230] [c0000000002d9548] shrink_node+0x138/0x410
[c000000777e832f0] [c0000000002d9938] do_try_to_free_pages+0x118/0x490
[c000000777e83380] [c0000000002d9dc0] try_to_free_pages+0x110/0x2b0
[c000000777e83410] [c0000000002bfe74] __alloc_pages_nodemask+0x754/0x1160
[c000000777e83610] [c00000000034c238] alloc_pages_vma+0xb8/0x290
[c000000777e83680] [c0000000003102b0] __handle_mm_fault+0x1150/0x1ad0
[c000000777e83760] [c000000000310d58] handle_mm_fault+0x128/0x210
[c000000777e837a0] [c000000000067878] __do_page_fault+0x218/0x8e0
[c000000777e83850] [c00000000000a4a4] handle_page_fault+0x18/0x38
--- interrupt: 301 at __copy_tofrom_user_power7+0xf0/0x7cc
    LR = _copy_to_user+0x3c/0x60
[c000000777e83b40] [c000000000f0a658] num_spec.61220+0x1f3594/0x228cdc (unreliable)
[c000000777e83c40] [c00000000067d31c] _copy_to_user+0x3c/0x60
[c000000777e83c60] [c0000000003d6aa4] seq_read+0x504/0x580
[c000000777e83d00] [c00000000039b4ac] __vfs_read+0x6c/0x230
[c000000777e83da0] [c00000000039b724] vfs_read+0xb4/0x1a0
[c000000777e83de0] [c00000000039bf9c] SyS_read+0x6c/0x110
[c000000777e83e30] [c00000000000b184] system_call+0x58/0x6c
Instruction dump:
7dc57378 483b0e65 60000000 2fa30000 419efe44 fbee0008 f9df0000 fa7f0008 
fbf30000 4bfffe30 60000000 60420000 <0fe00000> 60000000 60000000 60420000 
---[ end trace 1e619608a776e914 ]---



-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
