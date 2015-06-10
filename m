Return-Path: <wenweitaowenwei@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B5E431A0047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:32:16 +1000 (AEST)
Received: by pablj1 with SMTP id lj1so8051124pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2015 23:32:14 -0700 (PDT)
From: Wenwei Tao <wenweitaowenwei@gmail.com>
To: izik.eidus@ravellosystems.com, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 x86@kernel.org, viro@zeniv.linux.org.uk
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, wenweitaowenwei@gmail.com
Subject: [RFC PATCH 0/6] add defer mechanism to ksm to make it more suitable
 for Android devices
Date: Wed, 10 Jun 2015 14:27:13 +0800
Message-Id: <1433917639-31699-1-git-send-email-wenweitaowenwei@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I observe that it is unlikely for KSM to merge new pages from an area
that has already been scanned twice on Android mobile devices, so it's
a waste of power to scan these areas in high frequency. In this patchset,
a defer mechanism is introduced which is borrowed from page compaction to KSM.

A new slot list called active_slot is added into ksm_scan. MMs which have
VMA marked for merging via madvise are added (MM is new to KSM) or moved to
(MM is in the ksm_scan.mm_slot list) active_slot. In "scan_get_next_rmap_item()",
the active_slot list will be scaned firstly unless it is empty, then the mm_slot list.
MMs in the active_slot list will be scaned twice, after that they will be moved
to mm_slot list. Once scanning the mm_slot list, the defer mechanism will be activated:

a) if KSM scans "ksm_thread_pages_to_scan" pages but none of them get
merged or become unstable, increase the ksm_defer_shift(new member of ksm_scan)
by one (no more than 6 by now). And in the next "1UL << ksm_scan.ksm_defer_shift"
times KSM been scheduled or woken up it will not do the actual scan, compare
and merge job, it just schedule out.

b) if KSM scans "ksm_thread_pages_to_scan" pages and more than zero of them
get merged or become unstable, reset the ksm_defer_shift and ksm_considered
to zero.

Some applications may continue to produce new mergeable VMAs to KSM, in order
to avoid scanning VMAs of these applications that have already been scanned twice,
we use VM_HUGETLB to indicate new mergeable VMAs since hugetlb vm are not
supported by KSM.

Wenwei Tao (6):
  mm: add defer mechanism to ksm to make it more suitable
  mm: change the condition of identifying hugetlb vm
  perf: change the condition of identifying hugetlb vm
  fs/binfmt_elf.c: change the condition of identifying hugetlb vm
  x86/mm: change the condition of identifying hugetlb vm
  powerpc/kvm: change the condition of identifying hugetlb vm

 arch/powerpc/kvm/e500_mmu_host.c |    3 +-
 arch/x86/mm/tlb.c                |    3 +-
 fs/binfmt_elf.c                  |    2 +-
 include/linux/hugetlb_inline.h   |    2 +-
 include/linux/mempolicy.h        |    2 +-
 kernel/events/core.c             |    2 +-
 mm/gup.c                         |    6 +-
 mm/huge_memory.c                 |   17 ++-
 mm/ksm.c                         |  230 +++++++++++++++++++++++++++++++++-----
 mm/madvise.c                     |    6 +-
 mm/memory.c                      |    5 +-
 mm/mprotect.c                    |    6 +-
 12 files changed, 238 insertions(+), 46 deletions(-)

-- 
1.7.9.5
