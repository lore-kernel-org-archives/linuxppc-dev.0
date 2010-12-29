Return-Path: <hughd@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08E86B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 10:05:23 +1100 (EST)
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com
	[172.24.198.65]) by smtp-out.google.com with ESMTP id oBTMsvMc029833
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Dec 2010 14:54:58 -0800
Received: from iwn2 (iwn2.prod.google.com [10.241.68.66])
	by wpaz1.hot.corp.google.com with ESMTP id oBTMsuC2029528
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Dec 2010 14:54:56 -0800
Received: by iwn2 with SMTP id 2so11301975iwn.21
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Dec 2010 14:54:56 -0800 (PST)
Date: Wed, 29 Dec 2010 14:54:49 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Ben Herrenschmidt <benh@kernel.crashing.org>
Subject: PowerPC BUG: using smp_processor_id() in preemptible code
Message-ID: <alpine.LSU.2.00.1012291413360.22939@sister.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linuxppc-dev@lists.ozlabs.org,
	Nick Piggin <npiggin@kernel.dk>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With recent 2.6.37-rc, with CONFIG_PREEMPT=y CONFIG_DEBUG_PREEMPT=y
on the PowerPC G5, I get spammed by BUG warnings each time I swapoff:

BUG: using smp_processor_id() in preemptible [00000000] code: swapoff/3974
caller is .hpte_need_flush+0x4c/0x2e8
Call Trace:
[c0000001b4a3f830] [c00000000000f3cc] .show_stack+0x6c/0x16c (unreliable)
[c0000001b4a3f8e0] [c00000000023eda0] .debug_smp_processor_id+0xe4/0x11c
[c0000001b4a3f970] [c00000000002f2f4] .hpte_need_flush+0x4c/0x2e8
[c0000001b4a3fa30] [c0000000000e7ef8] .vunmap_pud_range+0x148/0x200
[c0000001b4a3fb10] [c0000000000e8058] .vunmap_page_range+0xa8/0xd4
[c0000001b4a3fbb0] [c0000000000e80a4] .free_unmap_vmap_area+0x20/0x38
[c0000001b4a3fc40] [c0000000000e8138] .remove_vm_area+0x7c/0xb4
[c0000001b4a3fcd0] [c0000000000e8308] .__vunmap+0x50/0x104
[c0000001b4a3fd60] [c0000000000ef3fc] .SyS_swapoff+0x59c/0x6a8
[c0000001b4a3fe30] [c0000000000075a8] syscall_exit+0x0/0x40

I notice hpte_need_flush() itself acknowledges
 * Must be called from within some kind of spinlock/non-preempt region...

Though I didn't actually bisect, I believe this is since Jeremy's
64141da587241301ce8638cc945f8b67853156ec "vmalloc: eagerly clear ptes
on vunmap", which moves a call to vunmap_page_range() from one place
(which happened to be inside a spinlock) to another (where it's not).

I guess my warnings would be easily silenced by moving that call to
vunmap_page_range() down just inside the spinlock below it; but I'm
dubious that that's the right fix - it looked as if there are other
paths through vmalloc.c where vunmap_page_range() has been getting
called without preemption disabled, long before Jeremy's change,
just paths that I never happen to go down in my limited testing.

For the moment I'm using the obvious patch below to keep it quiet;
but I doubt that this is the right patch either.  I'm hoping that
ye who understand the importance of hpte_need_flush() will be best
able to judge what to do.  Or might there be other architectures
expecting to be unpreemptible there?

Thanks,
Hugh

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -37,11 +37,13 @@ static void vunmap_pte_range(pmd_t *pmd,
 {
 	pte_t *pte;
 
+	preempt_disable(); /* Stop __vunmap() triggering smp_processor_id() in preemptible from hpte_need_flush() */
 	pte = pte_offset_kernel(pmd, addr);
 	do {
 		pte_t ptent = ptep_get_and_clear(&init_mm, addr, pte);
 		WARN_ON(!pte_none(ptent) && !pte_present(ptent));
 	} while (pte++, addr += PAGE_SIZE, addr != end);
+	preempt_enable();
 }
 
 static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end)
