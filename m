Return-Path: <linuxppc-dev+bounces-27506-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D5AC982CF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 17:00:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlQ9w1Mrwz2yGT;
	Thu, 17 Sep 2026 03:00:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789578020;
	cv=none; b=EgH/MidrKTixjc7Uow7XFqLhTtOz27AHxemcsjpyHqY2W0O6oV5pFQ+xwf1RiC3w7mlX0v8ixZbYZvau9znl7i0qIB+BnHhD8A1rQrKq2ZaMv+5CH7lahfBgCIjchy1fzskoDg6DIA4qaXguitlpwtTkf+yawSuH367aoquuvHI9JXBFC4IYqyhiH5kWrOeQ/SyhvnLRRsd9UrD69Jb9Iz78jp5QOCBmpawud63B+vd9xDLCHSsyd6wOkEQSFSBSvjtPCW/YZCHtCwwBv7ChxK9jkfB0S9K/qnlRl9bF0Vxap9kp3kuv6WuMc4BuB6wYVK+HbnM1nNh7W+jngebU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789578020; c=relaxed/relaxed;
	bh=JNZtWdKCogaGrWtyvhM6z027Qg7RFwkG7Shw9zuVQhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0+zYpGOivE/NwW87rl96o+XjmgbI4kXz0Dpy75j0tFoeaQTBxGWa9hdS6nFFTyPzzQV98+vCQplZ5wQuDVmhr+cqkUaGG+t+MFeaKtJqFdtuwcE97L1Bikol5/dRJP3iO27fqXFIj894E2eeGvSE2VLNp6YVo0NE60OK+aYgGX4EPxewp5EL2yNNFxhC+zC99LMJ63nEmI4TWL11CUoQC5DxpsRW2La7b2iwv/AXibSC5aB66fD0RdwQ71qjMyGJ6zjvqXpqXFzpEFyLGUGEG/zQFtpNBWBoMhI3kcgYkbUFjH3VPzL1bidMrSXH4LlR7A1+of1qBN2vciyLLs6hA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmVw4wXS; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmVw4wXS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlQ9v1v4Hz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 03:00:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 46BE4600CB;
	Wed, 16 Sep 2026 17:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4114D1F000FF;
	Wed, 16 Sep 2026 16:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789578016;
	bh=JNZtWdKCogaGrWtyvhM6z027Qg7RFwkG7Shw9zuVQhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PmVw4wXS/r9CpHfAOn2amzHMwnGPXSnlrGas83Xpi7dsydIKsArkblukiVIHwBAY6
	 ubpGfFGa7kqrykL1Pa6q3MkO4GKMCQQXpCmITVG/PeoahA3HJxtDyVnKBlsOT5y6Mm
	 wozpolIxCIhxuWjx0aQRah90ZewUiZ9k5Elj1dLiF8CCivxp3p7w6OaDY/5H9Oq45S
	 O6mv0zYlNEHZcdRLCgzvK/ZrOJVz1jz48dKYZvJ7Oi+o5KCdWId8DKOgPiN8pVOlBz
	 jm/9rlekEwQE9XCQ+GkKAffM26w81NuZfKTTB+nUUF3sGMC9I2pcmKHTHWSj4DPFxw
	 A9hfwpouwGpWQ==
Date: Wed, 16 Sep 2026 17:59:52 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster <schuster.simon@siemens-energy.com>, 
	Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
	Stafford Horne <shorne@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH v3 01/12] mm/huge_memory: zap deposited page tables after
 an RCU grace period
Message-ID: <aqrAflIQbwcNKlQL@gremlin>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
 <20260911-rcu-pagetable-freeing-v3-1-7b8c86103821@kernel.org>
 <467b6599-b73a-4f58-a29a-b6c6d1ffc3a5@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <467b6599-b73a-4f58-a29a-b6c6d1ffc3a5@kernel.org>

On Wed, Sep 16, 2026 at 04:42:04PM +0200, David Hildenbrand (Arm) wrote:
> On 9/11/26 21:36, Lorenzo Stoakes (ARM) wrote:
> > When an anonymous mapping is collapsed for THP, a PTE page table is
> > 'deposited' with the installed PMD entry.
>
> Right. Or when we allocate an anon THP.

That case doesn't interact with page walking though, as they're
just-allocated right?

Am focusing on collapse case for that reason rather than listing all
possible places deposit can happen.

>
> >
> > This is done in order that a split can be performed without needing to
> > allocate additional memory.
> >
> > The freeing occurs in zap_deposited_table() and is done directly without
> > any delay via pte_free().
> >
> > This is currently not a problem as existing page table walks are protected
> > by the mmap or anon rmap lock.
>
> Or VMA lock?

Yup indeed, can update on respin/ask Andrew to add VMA lock here.

>
> >
> > However this becomes problematic in a future where RCU-only page table
> > walkers exist, as there is nothing to prevent a page table walker that
> > started the walk prior to collapse having its PTE table freed underneath
> > it.
>
>
> Wait, but wouldn't it be really problematic to punch a page table that is still

Punch? You mean deposit?

> being walked into the deposited list where it can just be allocated from another
> PMD->PTE split?

In general, RCU-only page table walkers are _only_ guaranteed that the page
tables are not freed from underneath them, as per the cover letter:

	"As a result, page table walks can now be performed safely under RCU without
	 any risk of page tables being freed underneath a walker.

	However, this is the only guarantee that this work provides - page table
	walkers must still ensure that page table entries are as expected
	throughout."

So this series doesn't actually have to answer that :)

But a PTE PTL -> pmd_same() check will flag anything like that,
a.k.a. pte_offset_map_lock().

The RCU lock replaces stablisation on stuff other than VMA/mmap or rmap
lock.

If the walker needs to be sure the PTE is actually valid and belongs to the
expected walk then further is required.

Alternatively (like GUP-fast) if you wanted to avoid locking at all, IRQs
off would be required paired with the tlb_remove_table_sync_one() in
collapse_huge_page().

Another strategy could be used I guess with looped checks but it gets a bit
sketchy with timing etc.

But actually maybe we can avoid all that...

>
> Note that pgtable_trans_huge_withdraw() just dequeues *some* PTE page table in
> the list attached to the PMD table.
>
> Something is odd here.

...Since this code path already allocates (the huge folio), so allocation
here isn't an issue (as long as done outside of lcosk), why not have it
also allocate a new PTE to deposit and RCU-free the existing PTE instead?

That eliminates the one place in the kernel (afaik) where a
page-table-walker-visible table can just get yoinked over somewhere else.

Then a lockless PMD check works.

E.g. something like the below?

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f49a6710933b..d9cb6b406ebb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1293,7 +1293,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
 	LIST_HEAD(compound_pagelist);
 	pmd_t *pmd, _pmd;
 	pte_t *pte = NULL;
-	pgtable_t pgtable;
+	pgtable_t pgtable = NULL;
 	struct folio *folio;
 	spinlock_t *pmd_ptl, *pte_ptl;
 	enum scan_result result = SCAN_FAIL;
@@ -1310,6 +1310,12 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
 		goto out_nolock;
 	}

+	if (is_pmd_order(order)) {
+		pgtable = pte_alloc_one(mm);
+		if (!pgtable)
+			goto out_nolock;
+	}
+
 	mmap_read_lock(mm);
 	result = hugepage_vma_revalidate(mm, pmd_addr, /*expect_anon=*/ true,
 					 &vma, cc, order);
@@ -1433,8 +1439,8 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
 	spin_lock(pmd_ptl);
 	VM_WARN_ON_ONCE(!pmd_none(*pmd));
 	if (is_pmd_order(order)) {
-		pgtable = pmd_pgtable(_pmd);
 		pgtable_trans_huge_deposit(mm, pmd, pgtable);
+		pgtable = NULL;
 		map_anon_folio_pmd_nopf(folio, pmd, vma, pmd_addr);
 	} else {
 		/*
@@ -1453,6 +1459,9 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
 	}
 	spin_unlock(pmd_ptl);

+	if (is_pmd_order(order))
+		pte_free_defer(mm, pmd_pgtable(_pmd));
+
 	folio = NULL;

 	result = SCAN_SUCCEED;
@@ -1463,6 +1472,8 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
 		anon_vma_unlock_write(vma->anon_vma);
 	mmap_write_unlock(mm);
 out_nolock:
+	if (pgtable)
+		pte_free(mm, pgtable);
 	if (folio)
 		folio_put(folio);
 	trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result, order);


>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo

