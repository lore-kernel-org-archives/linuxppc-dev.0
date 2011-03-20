Return-Path: <hughd@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 47B14B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 20 Mar 2011 15:11:18 +1100 (EST)
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com
	[172.24.198.85]) by smtp-out.google.com with ESMTP id p2K4BALD016119
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2011 21:11:11 -0700
Received: from iwn36 (iwn36.prod.google.com [10.241.68.100])
	by wpaz21.hot.corp.google.com with ESMTP id p2K4B8S1011516
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2011 21:11:09 -0700
Received: by iwn36 with SMTP id 36so5902427iwn.36
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Mar 2011 21:11:08 -0700 (PDT)
Date: Sat, 19 Mar 2011 21:11:10 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: mmotm threatens ppc preemption again
Message-ID: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

As I warned a few weeks ago, Jeremy has vmalloc apply_to_pte_range
patches in mmotm, which again assault PowerPC's expectations, and
cause lots of noise with CONFIG_PREEMPT=y CONFIG_PREEMPT_DEBUG=y.

This time in vmalloc as well as vfree; and Peter's fix to the last
lot, which went into 2.6.38, doesn't protect against these ones.
Here's what I now see when I swapon and swapoff:

BUG: using smp_processor_id() in preemptible [00000000] code: swapon/3230
caller is .apply_to_pte_range+0x118/0x1f0
Call Trace:
[c000000029c3b870] [c00000000000f38c] .show_stack+0x6c/0x16c (unreliable)
[c000000029c3b920] [c00000000022e024] .debug_smp_processor_id+0xe4/0x11c
[c000000029c3b9b0] [c0000000000de78c] .apply_to_pte_range+0x118/0x1f0
[c000000029c3ba70] [c0000000000de988] .apply_to_pud_range+0x124/0x188
[c000000029c3bb40] [c0000000000dea90] .apply_to_page_range_batch+0xa4/0xe8
[c000000029c3bc00] [c0000000000eb2c0] .map_vm_area+0x50/0x94
[c000000029c3bca0] [c0000000000ec368] .__vmalloc_area_node+0x144/0x190
[c000000029c3bd50] [c0000000000f1738] .SyS_swapon+0x270/0x704
[c000000029c3be30] [c0000000000075a8] syscall_exit+0x0/0x40
BUG: using smp_processor_id() in preemptible [00000000] code: swapon/3230
caller is .apply_to_pte_range+0x168/0x1f0
Call Trace:
[c000000029c3b870] [c00000000000f38c] .show_stack+0x6c/0x16c (unreliable)
[c000000029c3b920] [c00000000022e024] .debug_smp_processor_id+0xe4/0x11c
[c000000029c3b9b0] [c0000000000de7dc] .apply_to_pte_range+0x168/0x1f0
[c000000029c3ba70] [c0000000000de988] .apply_to_pud_range+0x124/0x188
[c000000029c3bb40] [c0000000000dea90] .apply_to_page_range_batch+0xa4/0xe8
[c000000029c3bc00] [c0000000000eb2c0] .map_vm_area+0x50/0x94
[c000000029c3bca0] [c0000000000ec368] .__vmalloc_area_node+0x144/0x190
[c000000029c3bd50] [c0000000000f1738] .SyS_swapon+0x270/0x704
[c000000029c3be30] [c0000000000075a8] syscall_exit+0x0/0x40
Adding 1572860k swap on /dev/sdb4.  Priority:-1 extents:1 across:1572860k SS
BUG: using smp_processor_id() in preemptible [00000000] code: swapoff/3231
caller is .apply_to_pte_range+0x118/0x1f0
Call Trace:
[c0000000260d38b0] [c00000000000f38c] .show_stack+0x6c/0x16c (unreliable)
[c0000000260d3960] [c00000000022e024] .debug_smp_processor_id+0xe4/0x11c
[c0000000260d39f0] [c0000000000de78c] .apply_to_pte_range+0x118/0x1f0
[c0000000260d3ab0] [c0000000000de988] .apply_to_pud_range+0x124/0x188
[c0000000260d3b80] [c0000000000dea90] .apply_to_page_range_batch+0xa4/0xe8
[c0000000260d3c40] [c0000000000eb0d8] .remove_vm_area+0x90/0xd4
[c0000000260d3cd0] [c0000000000ec0a8] .__vunmap+0x50/0x104
[c0000000260d3d60] [c0000000000f32fc] .SyS_swapoff+0x4d8/0x5e8
[c0000000260d3e30] [c0000000000075a8] syscall_exit+0x0/0x40
BUG: using smp_processor_id() in preemptible [00000000] code: swapoff/3231
caller is .apply_to_pte_range+0x168/0x1f0
Call Trace:
[c0000000260d38b0] [c00000000000f38c] .show_stack+0x6c/0x16c (unreliable)
[c0000000260d3960] [c00000000022e024] .debug_smp_processor_id+0xe4/0x11c
[c0000000260d39f0] [c0000000000de7dc] .apply_to_pte_range+0x168/0x1f0
[c0000000260d3ab0] [c0000000000de988] .apply_to_pud_range+0x124/0x188
[c0000000260d3b80] [c0000000000dea90] .apply_to_page_range_batch+0xa4/0xe8
[c0000000260d3c40] [c0000000000eb0d8] .remove_vm_area+0x90/0xd4
[c0000000260d3cd0] [c0000000000ec0a8] .__vunmap+0x50/0x104
[c0000000260d3d60] [c0000000000f32fc] .SyS_swapoff+0x4d8/0x5e8
[c0000000260d3e30] [c0000000000075a8] syscall_exit+0x0/0x40
BUG: using smp_processor_id() in preemptible [00000000] code: swapoff/3231
caller is .__flush_tlb_pending+0x20/0xb4
Call Trace:
[c0000000260d3830] [c00000000000f38c] .show_stack+0x6c/0x16c (unreliable)
[c0000000260d38e0] [c00000000022e024] .debug_smp_processor_id+0xe4/0x11c
[c0000000260d3970] [c00000000002efbc] .__flush_tlb_pending+0x20/0xb4
[c0000000260d39f0] [c0000000000de7fc] .apply_to_pte_range+0x188/0x1f0
[c0000000260d3ab0] [c0000000000de988] .apply_to_pud_range+0x124/0x188
[c0000000260d3b80] [c0000000000dea90] .apply_to_page_range_batch+0xa4/0xe8
[c0000000260d3c40] [c0000000000eb0d8] .remove_vm_area+0x90/0xd4
[c0000000260d3cd0] [c0000000000ec0a8] .__vunmap+0x50/0x104
[c0000000260d3d60] [c0000000000f32fc] .SyS_swapoff+0x4d8/0x5e8
[c0000000260d3e30] [c0000000000075a8] syscall_exit+0x0/0x40
BUG: using smp_processor_id() in preemptible [00000000] code: swapoff/3231
caller is .native_flush_hash_range+0x3c/0x384
Call Trace:
[c0000000260d36f0] [c00000000000f38c] .show_stack+0x6c/0x16c (unreliable)
[c0000000260d37a0] [c00000000022e024] .debug_smp_processor_id+0xe4/0x11c
[c0000000260d3830] [c00000000002e2c8] .native_flush_hash_range+0x3c/0x384
[c0000000260d38e0] [c00000000002c370] .flush_hash_range+0x4c/0xc8
[c0000000260d3970] [c00000000002f02c] .__flush_tlb_pending+0x90/0xb4
[c0000000260d39f0] [c0000000000de7fc] .apply_to_pte_range+0x188/0x1f0
[c0000000260d3ab0] [c0000000000de988] .apply_to_pud_range+0x124/0x188
[c0000000260d3b80] [c0000000000dea90] .apply_to_page_range_batch+0xa4/0xe8
[c0000000260d3c40] [c0000000000eb0d8] .remove_vm_area+0x90/0xd4
[c0000000260d3cd0] [c0000000000ec0a8] .__vunmap+0x50/0x104
[c0000000260d3d60] [c0000000000f32fc] .SyS_swapoff+0x4d8/0x5e8
[c0000000260d3e30] [c0000000000075a8] syscall_exit+0x0/0x40

I work around them with the patch below, but would prefer not to disable
preemption on all architectures there.  Though I'm not a huge fan of
apply_to_pte_range myself (I feel it glosses over differences, such as
how often one needs to let preemption in): I wouldn't mind if we left
vmalloc as is without it.

Hugh

--- mmotm/mm/memory.c
+++ fixed/mm/memory.c
@@ -2021,9 +2021,11 @@ static int apply_to_pte_range(struct mm_
 	int err;
 	spinlock_t *uninitialized_var(ptl);
 
-	pte = (mm == &init_mm) ?
-		pte_alloc_kernel(pmd, addr) :
-		pte_alloc_map_lock(mm, pmd, addr, &ptl);
+	if (mm == &init_mm) {
+		pte = pte_alloc_kernel(pmd, addr);
+		preempt_disable();
+	} else
+		pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
 		return -ENOMEM;
 
@@ -2033,7 +2035,9 @@ static int apply_to_pte_range(struct mm_
 	err = fn(pte, (end - addr) / PAGE_SIZE, addr, data);
 	arch_leave_lazy_mmu_mode();
 
-	if (mm != &init_mm)
+	if (mm == &init_mm)
+		preempt_enable();
+	else
 		pte_unmap_unlock(pte, ptl);
 	return err;
 }
