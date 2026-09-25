Return-Path: <linuxppc-dev+bounces-28255-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF34EC98330
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 22:28:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hs52926W7z2yDD;
	Sat, 26 Sep 2026 08:28:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790375297;
	cv=none; b=YrWx/E7OI0x/155yl+crJtcu4/uNRJyjEr/vuTeQlyDNNmxZKXpsYoHsK8nWnbtd0Bookcn1si8z+9j4uML2SR56scVvqTmIfS/jE3NkNunBQd610723o5GoF3SclvVECnYG6tjUcDW1g+6pGfpKAwYq+8zpxUU1IUwK2FcoQm5lZurVzdZtwv3x6b92QVmdhiDgC/wNJfUhTGcuCKIdx+2bQayXOqEbcTpaiMMN1lqDNGwztLwyLV1TULdDA17mpwegLg897BGL7JxYp2ZLAkbTajt6JCIuDZYAtKsxXGgxUPHa4TAlA76jtUnCoquAd1GEbG3XL1F+uoFwR88QdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790375297; c=relaxed/relaxed;
	bh=/FeqC6NsreHCzW9fFs+vzkIExlhoQtzmbN9AT65QI1Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lNyMBWAYrekQs8mLiCZUgTag1xyAGQxxoUyRCAob6tl5fX7IbdNSZtkoKFdYVPjiKQ93PbsXQjhGSGtw5IUK2OYW9qNzjCXQzGhujxe5cwOBXOx5/gzumiOj2kCB+MQOExZzEWB1er2kqYpMBP9+71lkQq/HeEZxqKGpgBvJSBskWjwpql8zfEwGY45vMrqBLiv5Ie7PxNX8yYIr2bMTECkyp/gC4NWZEKXogOJYqxTeEk3N67EeMmbUCzr4+A/KGMzwiSn1S3CPJc+FCcnKRHzV7bGPZEfqzcFNX03rOjsNnuuMmbgHr8tA3QZgJ6gt/cFQq556s2v3qAL5yZzYjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=S6120kZC; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=S6120kZC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hs5276jDCz2yD8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 08:28:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7100E6022F;
	Fri, 25 Sep 2026 22:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2B91F000FF;
	Fri, 25 Sep 2026 22:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790375292;
	bh=/FeqC6NsreHCzW9fFs+vzkIExlhoQtzmbN9AT65QI1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S6120kZCR12iXPZt0xcZL0+Wfn1gU1RZB7NUKDNkZNJefGSfG9P6RA8Epfy+rvbkU
	 xVs4fjUj0UHw+k+Gz9ZkgCGkot9F+dI1a3SWmLuTTxquEIyiCktMR74MXAiWNxdK6p
	 IPoozz5ITxp6Mrzfo2l82/2c0yVPGzL/vW8rZJG0=
Date: Fri, 25 Sep 2026 15:28:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Guo Ren
 <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster
 <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne
 <shorne@gmail.com>, Rich Felker <dalias@libc.org>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>,
 Vineet Gupta <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>, Chris
 Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Will Deacon
 <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick
 Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge
 Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Shakeel
 Butt <shakeel.butt@linux.dev>, Jonathan Corbet <corbet@lwn.net>, Randy
 Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, Hugh Dickins
 <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>,
 linux-doc@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH v5 00/12] mm: make userland page table freeing RCU-safe
Message-Id: <20260925152808.d4cae19cc002b1bba26502af@linux-foundation.org>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 21:09:35 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> The majority of architectures in the kernel defer page table freeing until
> an RCU grace period has elapsed, this series converts all remaining
> architectures to do so too and eliminates CONFIG_MMU_GATHER_RCU_TABLE_FREE
> altogether.
> 
> This is important because it enables safe lockless page table walking under
> RCU alone.
> 
> Doing so allows for reduced lock contention, avoids lock ordering concerns
> and enables fast, efficient and correct page table walking as a result.

Thanks, I've updated mm-unstable to this version.

> v5:
> * Collected tags (thanks all! :)
> * Updated 1/12 to correctly set result to SCAN_ALLOC_HUGE_PAGE_FAIL should
>   the page table allocation fail, as per Lance.
> * Updated 1/12 to rename alloc_deposit_pte() to alloc_deposit_pte_table()
>   and dropped the powerpc hash MMU paragraph from the commit message, as
>   per David.
> * Updated 9/12 to use a BH-disabling spinlock rather than an IRQ-safe one,
>   as per Matthew.
> * Updated the subject line of 11/12 to clarify that the patch removes
>   now-unneeded code, as per David.
> * Updated 12/12 documentation as per David, Lance.

Here's how v5 altered mm.git:


 Documentation/mm/process_addrs.rst |    9 +++++++--
 arch/m68k/mm/motorola.c            |   16 +++++++---------
 mm/khugepaged.c                    |    4 ++--
 3 files changed, 16 insertions(+), 13 deletions(-)

--- a/arch/m68k/mm/motorola.c~b
+++ a/arch/m68k/mm/motorola.c
@@ -181,7 +181,7 @@ static void *add_pointer_table(struct mm
 	new = PD_PTABLE(pt_addr);
 
 	PD_MARKBITS(new) = ptable_mask(type) - 1;
-	scoped_guard(spinlock_irqsave, &ptable_lock)
+	scoped_guard(spinlock_bh, &ptable_lock)
 		list_add(new, &ptable_list[type]);
 
 	return (pmd_t *)pt_addr;
@@ -191,16 +191,15 @@ void *get_pointer_table(struct mm_struct
 {
 	unsigned int tmp, off;
 	unsigned long mask;
-	unsigned long flags;
 	ptable_desc *dp;
 	void *ret;
 
-	spin_lock_irqsave(&ptable_lock, flags);
+	spin_lock_bh(&ptable_lock);
 	dp = ptable_list[type].next;
 	mask = list_empty(&ptable_list[type]) ? 0 : PD_MARKBITS(dp);
 
 	if (mask == 0) {
-		spin_unlock_irqrestore(&ptable_lock, flags);
+		spin_unlock_bh(&ptable_lock);
 		return add_pointer_table(mm, type);
 	}
 
@@ -213,7 +212,7 @@ void *get_pointer_table(struct mm_struct
 	}
 
 	ret = ptdesc_address(PD_PTDESC(dp)) + off;
-	spin_unlock_irqrestore(&ptable_lock, flags);
+	spin_unlock_bh(&ptable_lock);
 	return ret;
 }
 
@@ -223,9 +222,8 @@ int free_pointer_table(void *table, int
 	unsigned long ptable = (unsigned long)table;
 	unsigned long pt_addr = ptable & PAGE_MASK;
 	unsigned int mask = 1U << ((ptable - pt_addr)/ptable_size(type));
-	unsigned long flags;
 
-	spin_lock_irqsave(&ptable_lock, flags);
+	spin_lock_bh(&ptable_lock);
 
 	dp = PD_PTABLE(pt_addr);
 	if (PD_MARKBITS (dp) & mask)
@@ -236,7 +234,7 @@ int free_pointer_table(void *table, int
 	if (PD_MARKBITS(dp) == ptable_mask(type)) {
 		/* all tables in ptdesc are free, free ptdesc */
 		list_del(dp);
-		spin_unlock_irqrestore(&ptable_lock, flags);
+		spin_unlock_bh(&ptable_lock);
 
 		mmu_page_dtor((void *)pt_addr);
 		pagetable_dtor_free(virt_to_ptdesc((void *)pt_addr));
@@ -249,7 +247,7 @@ int free_pointer_table(void *table, int
 		list_move(dp, &ptable_list[type]);
 	}
 
-	spin_unlock_irqrestore(&ptable_lock, flags);
+	spin_unlock_bh(&ptable_lock);
 	return 0;
 }
 
--- a/Documentation/mm/process_addrs.rst~b
+++ a/Documentation/mm/process_addrs.rst
@@ -541,8 +541,13 @@ We establish basic locking rules when in
   after an RCU grace period has elapsed. However, any entry found must be
   revalidated after the page table lock is taken (such as the
   :c:func:`!pmd_same` recheck performed by :c:func:`!pte_offset_map_lock`)
-  before it is acted upon. Changing an entry requires the page table
-  lock and one of the locks that excludes teardown (mmap or VMA lock).
+  before it is acted upon. Changing an entry requires the page table lock
+  and one of the locks that excludes teardown (any one of the mmap, VMA or
+  rmap locks).
+* When traversing page tables under RCU alone it is important to take care
+  when operating upon leaf entries - if the value is operated upon (for
+  instance getting the folio associated with a PTE) an appropriate lock must
+  be taken to prevent concurrent modification.
 * Reads from and writes to page table entries must be *appropriately*
   atomic. See the section on atomicity below for details.
 * Populating previously empty entries requires that the mmap or VMA locks are
--- a/mm/khugepaged.c~b
+++ a/mm/khugepaged.c
@@ -1278,7 +1278,7 @@ static enum scan_result alloc_charge_fol
 	return SCAN_SUCCEED;
 }
 
-static pgtable_t alloc_deposit_pte(struct mm_struct *mm)
+static pgtable_t alloc_deposit_pte_table(struct mm_struct *mm)
 {
 	/*
 	 * khugepaged is run from a kernel thread, so need to manually set the
@@ -1328,7 +1328,7 @@ static enum scan_result collapse_huge_pa
 	}
 
 	if (is_pmd_order(order)) {
-		pgtable = alloc_deposit_pte(mm);
+		pgtable = alloc_deposit_pte_table(mm);
 		if (!pgtable) {
 			result = SCAN_ALLOC_HUGE_PAGE_FAIL;
 			goto out_nolock;
_


