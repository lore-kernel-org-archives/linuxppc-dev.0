Return-Path: <linuxppc-dev+bounces-19853-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A91F588C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2026 13:25:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzmTH6cT1z2ynn;
	Mon, 20 Apr 2026 23:25:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776691555;
	cv=none; b=YnDYRbTH9WjjFEwuKDwDZoWmoVc6EZdInwS5yDIBMfbmZYbWgwK1bm9N+8wDx+GvQ5HIQzjjktZ5Dni6Eam3kqkVzUGg2Ve/F6sZSY3z5KVJAHi7jsBrQnPfYgmRYjrxUqFjVPwcWpIKGYOYc9e6GIajJXA8cEANwuU69l9J/C661u/84eD3S/zLfxadmNwuOP3+lrQqfJAbjBaoeChOUJOlEKN8Wji4bk+yVurO76FlQlQuEWTM1k/q6UXlV2ylVG2qU6LcXR41vR+g32qLMMfNo0AOdYxAzPCNt0nTOJyDkfd823tDbRQGxc1YZDe/Ni8h/3bE9i2x+Ncw1KB/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776691555; c=relaxed/relaxed;
	bh=wtbGWexhUOAXUsW5Ev/ZlF5+HHODbWIXT86xXGASD4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4r0VcQ3ncwM7JB1B9vyeybNUX2wF64DtQykblfCE564Y179uO7VGDDbWiUsEEl8QJ3K5tPJJx0X5OmBAf0aR25QhR4WnUKWYHDR5wYOkzlFiMyAIahVEF+f6M17WNRsWi/vOI81wJDr2pW/hNr//MS3OLhPSJA5HFj/ub9SkBVgAwyCTP8mpWqiHpUJp9u+XZYCNi+ICFK8DhXPCV0E7dRe50btPJNFYQhfMdbE4yKLgaKXMV0QjTReNWeAqRCtlkDcyKd50l9agR06Ly3MFwoabh9XPrzT/H54YkLqtj5imy4/ew/yD9fKsGi1bz/S014NRIVOwdzWyp3cN3hreQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YEmIsrH/; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YEmIsrH/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzmTH0sVJz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 23:25:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 69DA343A4B;
	Mon, 20 Apr 2026 13:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF52C19425;
	Mon, 20 Apr 2026 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691553;
	bh=QdN5eaOozdE57zvJQCptJpEJ1Y01sSXA/t3uhiyUcqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YEmIsrH/WmB/Fn/vM7lkqpqeWRinlzbK5dp2YlGRZbG1gdbc/Qa/O5Q4OuZOYrYZM
	 kNfY8kiLZBR4WVlD12FWhiHylmXkSCgmqqtEObkETDsE4MeXFvYfA7L9MG5EEtpTFb
	 p8/HZcAon0WasPJvFvK0aUxnV8UGZUA2agBadnQ4CZ6vnZN79jKHh3GFNjo3W1HsVn
	 kzj2uEvsTNBdhkd9D9MOLFDmJXDQAdmhRjznxgojG1RAxOGC0Iovwbmq1f/HQ88t57
	 oI2kCaeXL3erVLjUc+j3pFw5sYBBhVTutR0v529TldKfy0Tq/cYmx/AOSg1aE95MtB
	 HB6h1Ba8wkMmA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.18] powerpc/64s: Fix _HPAGE_CHG_MASK to include _PAGE_SPECIAL bit
Date: Mon, 20 Apr 2026 09:18:10 -0400
Message-ID: <20260420132314.1023554-96-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
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
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0
Content-Transfer-Encoding: 8bit

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

[ Upstream commit 68b1fa0ed5c84769e4e60d58f6a5af37e7273b51 ]

commit af38538801c6a ("mm/memory: factor out common code from vm_normal_page_*()"),
added a VM_WARN_ON_ONCE for huge zero pfn.

This can lead to the following call stack.

 ------------[ cut here ]------------
 WARNING: mm/memory.c:735 at vm_normal_page_pmd+0xf0/0x140, CPU#19: hmm-tests/3366
 NIP [c00000000078d0c0] vm_normal_page_pmd+0xf0/0x140
 LR [c00000000078d060] vm_normal_page_pmd+0x90/0x140
 Call Trace:
 [c00000016f56f850] [c00000000078d060] vm_normal_page_pmd+0x90/0x140 (unreliable)
 [c00000016f56f8a0] [c0000000008a9e30] change_huge_pmd+0x7c0/0x870
 [c00000016f56f930] [c0000000007b2bc4] change_protection+0x17a4/0x1e10
 [c00000016f56fba0] [c0000000007b3440] mprotect_fixup+0x210/0x4c0
 [c00000016f56fc30] [c0000000007b3c3c] do_mprotect_pkey+0x54c/0x780
 [c00000016f56fdb0] [c0000000007b3ed8] sys_mprotect+0x68/0x90
 [c00000016f56fdf0] [c00000000003ae40] system_call_exception+0x190/0x500
 [c00000016f56fe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec

This happens when we call mprotect -> change_huge_pmd()
mprotect()
  change_pmd_range()
    pmd_modify(oldpmd, newprot) 	# this clears _PAGE_SPECIAL for zero huge pmd
	    pmdv = pmd_val(pmd);
	    pmdv &= _HPAGE_CHG_MASK;	# -> gets cleared here
	    return pmd_set_protbits(__pmd(pmdv), newprot);
    can_change_pmd_writable(vma, vmf->address, pmd)
      vm_normal_page_pmd(vma, addr, pmd)
        __vm_normal_page()
          VM_WARN_ON(is_zero_pfn(pfn) || is_huge_zero_pfn(pfn));  # this get hits as _PAGE_SPECIAL for zero huge pmd was cleared.

It can be easily reproduced with the following testcase:
	p = mmap(NULL, 2 * hpage_pmd_size, PROT_READ, MAP_PRIVATE |
		 MAP_ANONYMOUS, -1, 0);
	madvise((void *)p, 2 * hpage_pmd_size, MADV_HUGEPAGE);
	aligned = (char*)(((unsigned long)p + hpage_pmd_size - 1) &
				~(hpage_pmd_size - 1));
	(void)(*(volatile char*)aligned);  // read fault, installs huge zero PMD
	mprotect((void *)aligned, hpage_pmd_size, PROT_READ | PROT_WRITE);

This patch adds _PAGE_SPECIAL to _HPAGE_CHG_MASK similar to
_PAGE_CHG_MASK, as we don't want to clear this bit when calling
pmd_modify() while changing protection bits.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/7416f5cdbcfeaad947860fcac488b483f1287172.1773078178.git.ritesh.list@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete picture. Let me compile the full analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `powerpc/64s`
- Action verb: "Fix" - explicitly a bug fix
- Summary: Fix `_HPAGE_CHG_MASK` to include `_PAGE_SPECIAL` bit,
  preventing it from being stripped during `pmd_modify()`

**Step 1.2: Tags**
- No `Fixes:` tag (expected for this pipeline)
- No `Cc: stable@vger.kernel.org` (expected)
- `Signed-off-by: Ritesh Harjani (IBM)` - the author
- `Tested-by: Venkat Rao Bagalkote` - independently tested
- `Signed-off-by: Madhavan Srinivasan` - powerpc subsystem maintainer
- `Link:` to patch.msgid.link with the original submission

**Step 1.3: Commit Body**
The commit describes a concrete bug: when `mprotect()` is called on a
mapping with a huge zero PMD, `pmd_modify()` strips `_PAGE_SPECIAL`
because `_HPAGE_CHG_MASK` doesn't include it. This causes
`vm_normal_page_pmd()` to hit a `VM_WARN_ON` for zero huge pfn. A
complete call trace is provided, along with a simple reproducible
testcase.

**Step 1.4: Hidden Bug Fix?**
Not hidden at all - this is an explicitly stated fix with "Fix" in the
subject.

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- Single file changed: `arch/powerpc/include/asm/book3s/64/pgtable.h`
- Net change: 2 lines changed (adding `_PAGE_SPECIAL |` to the mask,
  reformatting)
- Effectively a 1-token addition to a preprocessor bitmask

**Step 2.2: Code Flow Change**
Before: `_HPAGE_CHG_MASK` does not include `_PAGE_SPECIAL`, so
`pmd_modify()` clears this bit.
After: `_HPAGE_CHG_MASK` includes `_PAGE_SPECIAL`, preserving it through
`pmd_modify()`.

**Step 2.3: Bug Mechanism**
Logic/correctness fix. The `_PAGE_CHG_MASK` (for regular PTEs) already
includes `_PAGE_SPECIAL` at line 123-125 of the same file. The
`_HPAGE_CHG_MASK` (for huge PMDs) was missing it, creating an
inconsistency where `pmd_modify()` strips `_PAGE_SPECIAL` while
`pte_modify()` preserves it.

**Step 2.4: Fix Quality**
- Obviously correct: makes the huge page mask match the regular page
  mask
- Minimal and surgical: single bit addition to a bitmask
- Zero regression risk: preserving a bit that should always be preserved
- Historical precedent: commit fbc78b07ba53 (2009) fixed the same issue
  for `_PAGE_CHG_MASK`

## PHASE 3: GIT HISTORY

**Step 3.1: Blame**
The `_HPAGE_CHG_MASK` definition was introduced by commit
`2e8735198af039` (Aneesh Kumar K.V, 2016-04-29) when powerpc moved
common PTE bits to `book3s/64/pgtable.h`. The `_PAGE_SPECIAL` was
missing from `_HPAGE_CHG_MASK` from the very beginning while it was
present in `_PAGE_CHG_MASK`. The bug has existed since 2016, meaning all
active stable trees have this bug.

**Step 3.2: Fixes Tag**
No explicit `Fixes:` tag, but the buggy commit is `2e8735198af039` which
exists in all active stable trees (v4.8+).

**Step 3.3: Related Changes**
- Commit `548cb932051fb` ("x86/mm: Fix PAT bit missing from page
  protection modify mask") - analogous fix on x86 for a similar issue
  with `_PAGE_PAT` missing from the modify mask. This shows this is a
  known class of bugs.
- Commit `fbc78b07ba53` ("powerpc/mm: Fix _PAGE_CHG_MASK to protect
  _PAGE_SPECIAL") from 2009 - exact same type of fix but for the regular
  PTE mask.

**Step 3.4: Author**
Ritesh Harjani is a regular powerpc contributor at IBM with many commits
in this subsystem.

**Step 3.5: Dependencies**
This commit is fully standalone. No prerequisites needed.

## PHASE 4: MAILING LIST

- b4 dig could not find the exact commit hash (it's not yet in the
  mainline tree referenced by b4).
- The `Link:` tag points to `patch.msgid.link/7416f5cdbcfeaad947860fcac4
  88b483f1287172.1773078178.git.ritesh.list@gmail.com`
- Lore was inaccessible due to anti-bot protection.
- The commit was accepted by the powerpc maintainer Madhavan Srinivasan,
  indicating proper review.

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1-5.4: Key Functions**
- `pmd_modify()` in `arch/powerpc/mm/book3s64/pgtable.c:277` uses
  `_HPAGE_CHG_MASK` to filter bits.
- `pud_modify()` at line 286 also uses `_HPAGE_CHG_MASK`.
- These are called from `change_huge_pmd()` in `mm/huge_memory.c:2625`
  during `mprotect()`.
- `change_huge_pmd()` then calls `can_change_pmd_writable()` which calls
  `vm_normal_page_pmd()`.
- `vm_normal_page_pmd()` calls `__vm_normal_page()` which has a
  `VM_WARN_ON_ONCE` for zero pfns.

The call chain is: `sys_mprotect()` -> `do_mprotect_pkey()` ->
`mprotect_fixup()` -> `change_protection()` -> `change_pmd_range()` ->
`change_huge_pmd()` -> `pmd_modify()` (loses `_PAGE_SPECIAL`) ->
`can_change_pmd_writable()` -> `vm_normal_page_pmd()` -> `VM_WARN_ON`.

This is reachable from any unprivileged userspace `mprotect()` call on a
THP-backed mapping.

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1:** The buggy `_HPAGE_CHG_MASK` definition has been present
since v4.8 (2016). All active stable trees contain this bug.

**Step 6.2:** The fix will apply cleanly - the `_HPAGE_CHG_MASK`
definition is stable and hasn't changed significantly (last modification
by `d438d273417055` removed `_PAGE_DEVMAP`).

**Step 6.3:** No related fix has been applied to stable for this issue.

## PHASE 7: SUBSYSTEM CONTEXT

- Subsystem: `powerpc/64s` - architecture-specific memory management
- Criticality: IMPORTANT - affects all powerpc book3s 64-bit systems
  using THP
- The code touches page table bit handling, a critical part of the
  memory subsystem

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1:** Affects users of powerpc book3s 64-bit systems with THP
enabled.

**Step 8.2:** Triggered by `mprotect()` on a huge zero page mapping. The
reproducer is simple: mmap + madvise(MADV_HUGEPAGE) + read fault +
mprotect. Any unprivileged user can trigger it.

**Step 8.3:** Failure mode: Kernel warning (VM_WARN_ON), incorrect page
treatment (zero page treated as normal page after mprotect). MEDIUM-HIGH
severity - causes kernel splats and potentially incorrect memory
management decisions.

**Step 8.4:**
- BENEFIT: HIGH - fixes a bug triggerable from userspace via common
  operations, prevents kernel warnings and incorrect page handling
- RISK: VERY LOW - single bit addition to a bitmask, obviously correct
  by analogy with `_PAGE_CHG_MASK`
- Ratio: Strongly favorable

## PHASE 9: FINAL SYNTHESIS

**Evidence FOR backporting:**
- Fixes a real bug with concrete reproducer and call trace
- Single-bit addition to a bitmask - trivially small and obviously
  correct
- Makes `_HPAGE_CHG_MASK` consistent with `_PAGE_CHG_MASK` (which
  already has `_PAGE_SPECIAL`)
- Historical precedent: same fix for regular PTEs (2009) and for x86
  (2023)
- Tested independently, accepted by subsystem maintainer
- Bug exists in all stable trees since 2016
- Zero regression risk

**Evidence AGAINST backporting:**
- The `VM_WARN_ON` that makes this most visible (from `af38538801c6a`)
  is only in recent kernels (6.18+)
- powerpc does not define `pmd_special()` (returns false generically),
  so the full mechanism is subtle

**Stable Rules Checklist:**
1. Obviously correct? **YES** - trivial consistency fix
2. Fixes a real bug? **YES** - `_PAGE_SPECIAL` incorrectly stripped
   during `pmd_modify()`
3. Important issue? **YES** - kernel warning + incorrect page handling
4. Small and contained? **YES** - 1 line in 1 file
5. No new features? **YES**
6. Applies cleanly? **YES**

## Verification

- [Phase 1] Parsed tags: Signed-off-by powerpc maintainer, Tested-by
  from IBM tester
- [Phase 2] Diff analysis: adding `_PAGE_SPECIAL` to `_HPAGE_CHG_MASK`
  bitmask, 1 effective line
- [Phase 3] git blame: buggy `_HPAGE_CHG_MASK` introduced in commit
  2e8735198af039 (2016, v4.8+)
- [Phase 3] git show 548cb932051fb: confirmed analogous x86 fix for
  `_PAGE_PAT` missing from modify mask
- [Phase 3] git show fbc78b07ba53: confirmed 2009 fix adding
  `_PAGE_SPECIAL` to `_PAGE_CHG_MASK` (the PTE equivalent)
- [Phase 3] git show 2e8735198af039: confirmed original code movement
  commit, _HPAGE_CHG_MASK missing _PAGE_SPECIAL from the start
- [Phase 4] b4 dig -c af38538801c6a: found the vm_normal_page
  refactoring series (v1-v3 by David Hildenbrand)
- [Phase 5] Traced call chain: mprotect -> change_huge_pmd -> pmd_modify
  (strips bit) -> can_change_pmd_writable -> vm_normal_page_pmd ->
  VM_WARN_ON
- [Phase 5] Verified _HPAGE_CHG_MASK used in pmd_modify()
  (pgtable.c:282) and pud_modify() (pgtable.c:291)
- [Phase 5] Verified _PAGE_CHG_MASK already includes _PAGE_SPECIAL
  (pgtable.h:123-125)
- [Phase 6] Buggy code present since v4.8 (2016) - all active stable
  trees affected
- [Phase 6] File has had minimal changes to _HPAGE_CHG_MASK area - clean
  apply expected
- [Phase 7] Confirmed powerpc selects ARCH_HAS_PTE_SPECIAL but not
  ARCH_SUPPORTS_HUGE_PFNMAP
- [Phase 8] Reproducer is trivial userspace mmap+mprotect sequence
- UNVERIFIED: Could not access lore.kernel.org discussion due to anti-
  bot protection

**YES**

 arch/powerpc/include/asm/book3s/64/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 1a91762b455d9..e0b78fa36d160 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -107,8 +107,8 @@
  * in here, on radix we expect them to be zero.
  */
 #define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
-			 _PAGE_ACCESSED | H_PAGE_THP_HUGE | _PAGE_PTE | \
-			 _PAGE_SOFT_DIRTY)
+			 _PAGE_ACCESSED | H_PAGE_THP_HUGE | _PAGE_SPECIAL | \
+			 _PAGE_PTE | _PAGE_SOFT_DIRTY)
 /*
  * user access blocked by key
  */
-- 
2.53.0


