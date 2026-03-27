Return-Path: <linuxppc-dev+bounces-18844-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627A410A62D1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:14:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhkjp5mXvz2ygY;
	Fri, 27 Mar 2026 13:14:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::ac"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577678;
	cv=none; b=Lkunjgerdk3gw+p5KUGKEq4Gn+kumF1zfAIg9YA0B4Nl8x4tRzOJ0hAzhLfiWXhTC7pnd1JxyGRJKzFmMX8OLTCwZzb9TXUAwCEAzaVs8pH+EWttl+KsdH8yMvNXFUVLKjppwoJg2HXZn1Qtxy0VCMT4/97EbwbQMwwrbRKl/mz8loiMSmiKuQ62OSg4NSihofaN8/LTvGqF91NtpUNqtpcoqosAZ4G14doxUapqtXNqtl6asHTgR5oGk3CzjoNVh7HG0epqXRWZKaKsrak27k9hcrcdQHU189RAASnh4IJOt5NvM8JI9rgIN5vRsh2ql4TpP/ie2SiumJFJxjUC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577678; c=relaxed/relaxed;
	bh=gq6tDrxRofpN6+43DO4pHo2Q1I5IOP1Q0YNLsagiUNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mc1EN+7b5GvluDpI+wb0ifqRETq/cVVyQyUgCW0pjeUVDiRNwZI2huyRcGbX3pNiEBCotA43DyGvY6nCskgO8DEyJW+FH6xCD6olVptMP9HcHXdFxMaAbwNy9sSyg9J1nvQqJ9j856OWpf3fL7UZrxr+W+cdRXz94P9SFCSyAK3Y5cDaZMHZE8UsrCKCrRjpbzjgnhdaFifwiugHglyzo+NLBdoAHu4NxdlPXWwvo0euMpy++DQUEZY5N7TtrVrZ/rQsrkXwLrBuytCF5ldmyeQcHiM1Zu1/upuJ64kDKjz7OfTe8XPk3pHjzEuiYad/a7x0ObLNwYghtlxajDSqWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VUFU+eLw; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::ac; helo=out-172.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VUFU+eLw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ac; helo=out-172.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhkjk2TKqz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:14:33 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gq6tDrxRofpN6+43DO4pHo2Q1I5IOP1Q0YNLsagiUNI=;
	b=VUFU+eLwBHZnCPCULhR3UiCG+mPLv3VmPsoMvQwjSw9IWmiWbGwuqsAtcYuN4fo3wd7f7w
	Tc/IkWLPWH4pZrCRj+4GCIAqRfFJq8dsdmTP7e5SMVyyryroVjX046opVWlz5P3JjcqDR0
	IPgagIj1g1KpLo1sApRx8TxcJV1nKXU=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	willy@infradead.org,
	linux-mm@kvack.org
Cc: fvdl@google.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>
Subject: [v3 00/24] mm: thp: lazy PTE page table allocation at PMD split time
Date: Thu, 26 Mar 2026 19:08:42 -0700
Message-ID: <20260327021403.214713-1-usama.arif@linux.dev>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When the kernel creates a PMD-level THP mapping for anonymous pages, it
pre-allocates a PTE page table via pgtable_trans_huge_deposit(). This
page table sits unused in a deposit list for the lifetime of the THP
mapping, only to be withdrawn when the PMD is split or zapped. Every
anonymous THP therefore wastes 4KB of memory unconditionally. On large
servers where hundreds of gigabytes of memory are mapped as THPs, this
adds up: roughly 200MB wasted per 100GB of THP memory. This memory
could otherwise satisfy other allocations, including the very PTE page
table allocations needed when splits eventually occur.

This series removes the pre-deposit and allocates the PTE page table
lazily — only when a PMD split actually happens. Since a large number
of THPs are never split (they are zapped wholesale when processes exit or
munmap the full range), the allocation is avoided entirely in the common
case.

The pre-deposit pattern exists because split_huge_pmd was designed as an
operation that must never fail: if the kernel decides to split, it needs
a PTE page table, so one is deposited in advance. But "must never fail"
is an unnecessarily strong requirement. A PMD split is typically triggered
by a partial operation on a sub-PMD range — partial munmap, partial
mprotect, COW on a pinned folio, GUP with FOLL_SPLIT_PMD, and similar.
All of these operations already have well-defined error handling for
allocation failures (e.g., -ENOMEM, VM_FAULT_OOM). Allowing split to
fail and propagating the error through these existing paths is the natural
thing to do. Furthermore, if the system cannot satisfy a single order-0
allocation for a page table, it is under extreme memory pressure and
failing the operation is the correct response.

Designing functions like split_huge_pmd as operations that cannot fail
has a subtle but real cost to code quality. It forces a pre-allocation
pattern - every THP creation path must deposit a page table, and every
split or zap path must withdraw one, creating a hidden coupling between
widely separated code paths.

This also serves as a code cleanup. On every architecture except powerpc
with hash MMU, the deposit/withdraw machinery becomes dead code. The
series removes the generic implementations in pgtable-generic.c and the
s390/sparc overrides, replacing them with no-op stubs guarded by
arch_needs_pgtable_deposit(), which evaluates to false at compile time
on all non-powerpc architectures.

The series is structured as follows:

Patches 1-2:    Infrastructure — make split functions return int and
                propagate errors from vma_adjust_trans_huge() through
                __split_vma, vma_shrink, and commit_merge.

Patches 3-15:   Handle split failure at every call site — copy_huge_pmd,
                do_huge_pmd_wp_page, zap_pmd_range, wp_huge_pmd,
                change_pmd_range (mprotect), follow_pmd_mask (GUP),
                walk_pmd_range (pagewalk), move_page_tables (mremap),
                move_pages (userfaultfd), device migration,
                pagemap_scan_thp_entry (proc), powerpc subpage_prot,
                and dax_iomap_pmd_fault (DAX). The code will become
                effective in Patch 17 when split functions start
                returning -ENOMEM.

Patch 16:       Add __must_check to __split_huge_pmd(), split_huge_pmd()
                and split_huge_pmd_address() so the compiler warns on
                unchecked return values.

Patch 17:       The actual change — allocate PTE page tables lazily at
                split time instead of pre-depositing at THP creation.
                This is when split functions will actually start returning
                -ENOMEM.

Patch 18:       Remove the now-dead deposit/withdraw code on
                non-powerpc architectures.

Patch 19:       Add THP_SPLIT_PMD_FAILED vmstat counter for monitoring
                split failures.

Patches 20-24:  Selftests covering partial munmap, mprotect, mlock,
                mremap, and MADV_DONTNEED on THPs to exercise the
                split paths.

The error handling patches are placed before the lazy allocation patch so
that every call site is already prepared to handle split failures before
the failure mode is introduced. This makes each patch independently safe
to apply and bisect through.

The patches were tested with CONFIG_DEBUG_ATOMIC_SLEEP and CONFIG_DEBUG_VM
enabled. The test results are below:

TAP version 13
1..5
# Starting 5 tests from 1 test cases.
#  RUN           thp_pmd_split.partial_munmap ...
# thp_pmd_split_test.c:60:partial_munmap:thp_split_pmd: 0 -> 1
# thp_pmd_split_test.c:62:partial_munmap:thp_split_pmd_failed: 0 -> 0
#            OK  thp_pmd_split.partial_munmap
ok 1 thp_pmd_split.partial_munmap
#  RUN           thp_pmd_split.partial_mprotect ...
# thp_pmd_split_test.c:60:partial_mprotect:thp_split_pmd: 1 -> 2
# thp_pmd_split_test.c:62:partial_mprotect:thp_split_pmd_failed: 0 -> 0
#            OK  thp_pmd_split.partial_mprotect
ok 2 thp_pmd_split.partial_mprotect
#  RUN           thp_pmd_split.partial_mlock ...
# thp_pmd_split_test.c:60:partial_mlock:thp_split_pmd: 2 -> 3
# thp_pmd_split_test.c:62:partial_mlock:thp_split_pmd_failed: 0 -> 0
#            OK  thp_pmd_split.partial_mlock
ok 3 thp_pmd_split.partial_mlock
#  RUN           thp_pmd_split.partial_mremap ...
# thp_pmd_split_test.c:60:partial_mremap:thp_split_pmd: 3 -> 4
# thp_pmd_split_test.c:62:partial_mremap:thp_split_pmd_failed: 0 -> 0
#            OK  thp_pmd_split.partial_mremap
ok 4 thp_pmd_split.partial_mremap
#  RUN           thp_pmd_split.partial_madv_dontneed ...
# thp_pmd_split_test.c:60:partial_madv_dontneed:thp_split_pmd: 4 -> 5
# thp_pmd_split_test.c:62:partial_madv_dontneed:thp_split_pmd_failed: 0 -> 0
#            OK  thp_pmd_split.partial_madv_dontneed
ok 5 thp_pmd_split.partial_madv_dontneed
# PASSED: 5 / 5 tests passed.
# Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0

The patches are based off of mm-unstable as of 25 Mar
git hash: d6f51e38433489eb22cb65d1bf72ac7993c5bdec

RFC v2 -> v3: https://lore.kernel.org/all/de0dc7ec-7a8d-4b1a-a419-1d97d2e4d510@linux.dev/
- Rebased on top of mm-unstable as of 25 Mar.
- handle split_huge_pmd failure in pagemap_scan
- handle split_huge_pmd failure in subpage_prot
- handle split_huge_pmd failure in dax_iomap_pmd_fault (cannot
  actually fail for file-backed DAX, but needed for __must_check
  compliance)
- Added a folio_put(folio) on the split failure path in
  migrate_vma_split_unmapped_folio() (Nico Pache)
— Added #if defined(CONFIG_TRANSPARENT_HUGEPAGE) guards
  around THP_SPLIT_PMD_FAILED vmstat counter.

Usama Arif (24):
  mm: thp: make split_huge_pmd functions return int for error
    propagation
  mm: thp: propagate split failure from vma_adjust_trans_huge()
  mm: thp: handle split failure in copy_huge_pmd()
  mm: thp: handle split failure in do_huge_pmd_wp_page()
  mm: thp: handle split failure in zap_pmd_range()
  mm: thp: handle split failure in wp_huge_pmd()
  mm: thp: retry on split failure in change_pmd_range()
  mm: thp: handle split failure in follow_pmd_mask()
  mm: handle walk_page_range() failure from THP split
  mm: thp: handle split failure in mremap move_page_tables()
  mm: thp: handle split failure in userfaultfd move_pages()
  mm: thp: handle split failure in device migration
  mm: proc: handle split_huge_pmd failure in pagemap_scan
  powerpc/mm: handle split_huge_pmd failure in subpage_prot
  fs/dax: handle split_huge_pmd failure in dax_iomap_pmd_fault
  mm: huge_mm: Make sure all split_huge_pmd calls are checked
  mm: thp: allocate PTE page tables lazily at split time
  mm: thp: remove pgtable_trans_huge_{deposit/withdraw} when not needed
  mm: thp: add THP_SPLIT_PMD_FAILED counter
  selftests/mm: add THP PMD split test infrastructure
  selftests/mm: add partial_mprotect test for change_pmd_range
  selftests/mm: add partial_mlock test
  selftests/mm: add partial_mremap test for move_page_tables
  selftests/mm: add madv_dontneed_partial test

 arch/powerpc/include/asm/book3s/64/pgtable.h  |  12 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |  24 +-
 arch/s390/include/asm/pgtable.h               |   6 -
 arch/s390/mm/pgtable.c                        |  41 ---
 arch/sparc/include/asm/pgtable_64.h           |   6 -
 arch/sparc/mm/tlb.c                           |  36 ---
 fs/dax.c                                      |   9 +-
 fs/proc/task_mmu.c                            |   6 +-
 include/linux/huge_mm.h                       |  51 +--
 include/linux/pgtable.h                       |  16 +-
 include/linux/vm_event_item.h                 |   1 +
 mm/debug_vm_pgtable.c                         |   4 +-
 mm/gup.c                                      |  10 +-
 mm/huge_memory.c                              | 222 +++++++++-----
 mm/khugepaged.c                               |   7 +-
 mm/memory.c                                   |  26 +-
 mm/migrate_device.c                           |  39 ++-
 mm/mprotect.c                                 |  11 +-
 mm/mremap.c                                   |   8 +-
 mm/pagewalk.c                                 |   8 +-
 mm/pgtable-generic.c                          |  32 --
 mm/rmap.c                                     |  46 ++-
 mm/userfaultfd.c                              |   8 +-
 mm/vma.c                                      |  37 ++-
 mm/vmstat.c                                   |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../testing/selftests/mm/thp_pmd_split_test.c | 290 ++++++++++++++++++
 tools/testing/vma/include/stubs.h             |   9 +-
 28 files changed, 685 insertions(+), 282 deletions(-)
 create mode 100644 tools/testing/selftests/mm/thp_pmd_split_test.c

-- 
2.52.0


