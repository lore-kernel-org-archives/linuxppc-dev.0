Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 564F02C009A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2013 19:31:02 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 2 Dec 2013 14:00:55 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E64E83940058
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2013 14:00:53 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB28Un3K40304872
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Dec 2013 14:00:49 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB28UoBb028559
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Dec 2013 14:00:50 +0530
Message-ID: <1386059435.2578.13.camel@ThinkPad-T5421>
Subject: [RFC PATCH powerpc 1/2] fix using page adddress as the page
 stucture pointer in __pte_free_tlb()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 03 Dec 2013 16:30:35 +0800
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

It seems that in __pte_free_tlb (non 64K page code path), we wrongly
pass the page address as the page structure pointer to
pgtable_page_dtor(), which needs the page structure pointer as the
argument.

The change also fixes following bug on next-1128:

[    0.563113] Unable to handle kernel paging request for data at address 0x00000000
[    0.563121] Faulting instruction address: 0xc0000000001d8e30
[    0.563128] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.563132] PREEMPT SMP NR_CPUS=16 NUMA pSeries
[    0.563143] Modules linked in:
[    0.563150] CPU: 9 PID: 1 Comm: init Not tainted 3.13.0-rc1-next-20131128-dirty #1
[    0.563157] task: c0000001fed40000 ti: c0000001fed3c000 task.ti: c0000001fed3c000
[    0.563163] NIP: c0000000001d8e30 LR: c0000000001da4e8 CTR: c00000000018ed28
[    0.563171] REGS: c0000001fed3f060 TRAP: 0300   Not tainted  (3.13.0-rc1-next-20131128-dirty)
[    0.563177] MSR: 8000000000009032 <SF,EE,ME,IR,DR,RI>  CR: 24222982  XER: 20000001
[    0.563197] CFAR: c0000000001d8e0c DAR: 0000000000000000 DSISR: 42000000 SOFTE: 1 
GPR00: 0000000000000000 c0000001fed3f2e0 c000000000d4ce98 c0000001fe01f500 
GPR04: f000000000000000 0000000000000000 c0000000001a9980 0000000000000000 
GPR08: 0000000000b69000 0000000000040000 c0000001fc550108 0000000000000000 
GPR12: 0000000044779982 c00000000f33eb00 0000002000000000 1000000000000000 
GPR16: c000000000000000 0000000000000001 c0000001fcbd8000 c0000001fa4b83f8 
GPR20: 00000000ffffffff 00003fffffe00000 c0000001fa0a8ff8 0000000000000000 
GPR24: 0000000000000029 c0000001fed3c000 0000000000210d00 0000000000000001 
GPR28: 0000000000000000 0000000000000000 c0000001fe01f500 f000000000000000 
[    0.563299] NIP [c0000000001d8e30] .__slab_free+0xc8/0x42c
[    0.563306] LR [c0000000001da4e8] .kmem_cache_free+0x1d4/0x364
[    0.563311] Call Trace:
[    0.563316] [c0000001fed3f2e0] [6db6db6db6db6db7] 0x6db6db6db6db6db7 (unreliable)
[    0.563325] [c0000001fed3f410] [c0000000001da4e8] .kmem_cache_free+0x1d4/0x364
[    0.563334] [c0000001fed3f4d0] [c0000000001a9980] .ptlock_free+0x2c/0x44
[    0.563342] [c0000001fed3f550] [c0000000001aec98] .free_pgd_range+0x340/0x3d8
[    0.563350] [c0000001fed3f680] [c0000000001ee6b8] .shift_arg_pages+0x130/0x1a0
[    0.563358] [c0000001fed3f7c0] [c0000000001ee888] .setup_arg_pages+0x160/0x214
[    0.563366] [c0000001fed3f870] [c000000000257664] .load_elf_binary+0x540/0x168c
[    0.563374] [c0000001fed3f9d0] [c0000000001ecf28] .search_binary_handler+0xcc/0x238
[    0.563382] [c0000001fed3fa80] [c0000000002551e8] .load_script+0x26c/0x290
[    0.563390] [c0000001fed3fb90] [c0000000001ecf28] .search_binary_handler+0xcc/0x238
[    0.563397] [c0000001fed3fc40] [c0000000001ef1f4] .do_execve_common+0x6b4/0xa0c
[    0.563406] [c0000001fed3fd20] [c0000000001ef634] .do_execve+0x40/0x58
[    0.563414] [c0000001fed3fdb0] [c00000000000bdb4] .kernel_init+0x74/0x158
[    0.563422] [c0000001fed3fe30] [c00000000000a0ec] .ret_from_kernel_thread+0x5c/0x70
[    0.563429] Instruction dump:
[    0.563433] 635a0d00 3b600001 2fbc0000 41fe0014 e8810070 7f83e378 486543c1 60000000 
[    0.563450] e81e0022 829f0018 92810090 eaff0010 <7efd012a> a1210090 8aa10093 3809ffff 
[    0.563469] ---[ end trace 3be1fd3d950f1716 ]---

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgalloc-64.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index 6940128..d7543c2 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -151,7 +151,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 	struct page *page = page_address(table);
 
 	tlb_flush_pgtable(tlb, address);
-	pgtable_page_dtor(page);
+	pgtable_page_dtor(table);
 	pgtable_free_tlb(tlb, page, 0);
 }
 
