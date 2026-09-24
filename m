Return-Path: <linuxppc-dev+bounces-28096-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48F7C98310
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:55:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr5jK4071z2y7Y;
	Thu, 24 Sep 2026 17:55:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790236517;
	cv=none; b=Gm4BrlTVs2flA7U9Xab44uP8TceZaWeMV7sJQK7B7gV7R3zhVky/74pqlknVXkDvIYywavHdEGNe+kpjp7W44p3rvYFoh0NIB1VQTIPZ8pnjwqTSzpwjmIaSNEMbP3sVPfK4uwk6a6gdObkGQn3Ha0dZB5w/8///x5CO8EQQmgrtmta1NptUPa3qekKmEhShUvh8QbQdWcZp+D+GfVP/3nY0Y6YmP8urn43iZ/rV0QILdbnSaRTAmsEHvceJm7TVKY+k1mD5zNxbkI4x3RePM/yV0OUicbgDQZDzgDcfIYpaz1E1VR59w7J8sGX7XGgIUAuBe0Qz8fO6yDWl88N7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790236517; c=relaxed/relaxed;
	bh=8XF4GERg8wBeW3ubUb+zC5tRVKKAYGhsksCUCrCMyIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL/zS0Y6iSqK0nk9IgsZVSE/8qfXhvXmteFMreDpHxyEsx6rHtPB6rPaC4g/CQE56fItwFr8EstFjEO++Ky/ofxjegYyYE7Q+XsYPkKqQYtn4twf0iZMVNEhttMVFU+mIOKJkQ+SicSYUMNj7mtSPAMqgdC9rN9uRQeWWs00/Nsnxxkjc1UhxxN6Stmoblfj54/YaRsPZIRb3SgV/5K7HtIFoX3vea3U1/6TBu5GIaFZex9bzcZpzWa5+e/KNKMDGcRF27tmbvW7pzQvJingU8tGWmdpIIAbOgQHCyhaCzPwxPYGIGHAlabHcEDP/NHk45LrhL9vrKEakbsFgiHr3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvFYpHpV; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvFYpHpV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr5jJ2MTMz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 17:55:16 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9B8AA42B38;
	Thu, 24 Sep 2026 07:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7BC1F000FF;
	Thu, 24 Sep 2026 07:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790236512;
	bh=8XF4GERg8wBeW3ubUb+zC5tRVKKAYGhsksCUCrCMyIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lvFYpHpVMwPBfEiIuvmYeJUUzULg6cdEWSx4iWYVWk727A5rZV5bpt/5Sjkl2pSTJ
	 +koGcSegVzDsG20kO8t41OXmh6KWyi8RNfZl2ErJwNIuTh23tjzoeT8Dv37tsGeg79
	 61gp8tpMx2xIK3zP8kYJIEm2UGPz0MsuiqmNKxY9v5C+ubE70585sEQgHP0rrKt73G
	 695MVjPFlFxGNvVaOlYp2A83auWFA74egHtR5nruPWwDU0nzqWrYwTTl+K4hgYPEPV
	 DQ3pwEy3zgSLOIKKJ8W+2SiDFy6P5qvxi1PY+qb9cXOQdaC3iHQ+VtthIr/FlkyQ/I
	 POZQV/h73LJFA==
Date: Thu, 24 Sep 2026 08:54:49 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org, 
	guoren@kernel.org, bcain@kernel.org, geert@linux-m68k.org, dinguyen@kernel.org, 
	schuster.simon@siemens-energy.com, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, 
	shorne@gmail.com, dalias@libc.org, glaubitz@physik.fu-berlin.de, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, linux@armlinux.org.uk, 
	vgupta@kernel.org, monstr@monstr.eu, chris@zankel.net, jcmvbkbc@gmail.com, 
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org, 
	davem@davemloft.net, andreas@gaisler.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, catalin.marinas@arm.com, mark.rutland@arm.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	arnd@arndb.de, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com, 
	ysato@users.sourceforge.jp, shakeel.butt@linux.dev, corbet@lwn.net, rdunlap@infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, hughd@google.com, 
	qi.zheng@linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 12/12] mm: change the contract for free_pgtables(),
 update docs
Message-ID: <arTXJXUhjNTWz9Ga@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-12-fe1ad1f1e303@kernel.org>
 <20260924032625.28555-1-lance.yang@linux.dev>
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
In-Reply-To: <20260924032625.28555-1-lance.yang@linux.dev>

On Thu, Sep 24, 2026 at 11:26:25AM +0800, Lance Yang wrote:
>
> On Tue, Sep 22, 2026 at 04:35:43PM +0100, Lorenzo Stoakes (ARM) wrote:
> >Now that page tables are freed after an RCU grace period, it is safe for
> >read-only page table walkers to walk page table ranges that are being
> >concurrently torn down, provided the mm is kept alive via mmgrab().
> >
> >It is however unsafe for writers to do so, as they must obtain an
> >appropriate lock to do so safely.
> >
> >Update the pte_offset_map_lock()'s comment block to reflect this.
> >
> >Similarly update the process addresses documentation.
> >
> >Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> >Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >---
> > Documentation/mm/process_addrs.rst |  6 ++++++
> > mm/pgtable-generic.c               | 15 +++++++++++----
> > 2 files changed, 17 insertions(+), 4 deletions(-)
> >
> >diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
> >index a7296f251799..b1f4f44d75eb 100644
> >--- a/Documentation/mm/process_addrs.rst
> >+++ b/Documentation/mm/process_addrs.rst
> >@@ -537,6 +537,12 @@ We establish basic locking rules when interacting with page tables:
> > * When changing a page table entry the page table lock for that page table
> >   **must** be held, except if you can safely assume nobody can access the page
> >   tables concurrently (such as on invocation of :c:func:`!free_pgtables`).
> >+* Page tables may be *walked* under RCU alone, as page tables are freed only
> >+  after an RCU grace period has elapsed. However, any entry found must be
> >+  revalidated after the page table lock is taken (such as the
> >+  :c:func:`!pmd_same` recheck performed by :c:func:`!pte_offset_map_lock`)
> >+  before it is acted upon. Changing an entry requires the page table
> >+  lock and one of the locks that excludes teardown (mmap or VMA lock).
>
> What about rmap walkers? try_to_unmap() clears PTEs under the rmap lock
> and PTL, without an mmap or VMA lock.

That's an abomination but yep will update.

>
> Cheers, Lance
>
> > * Reads from and writes to page table entries must be *appropriately*
> >   atomic. See the section on atomicity below for details.
> > * Populating previously empty entries requires that the mmap or VMA locks are
> >diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> >index b91b1a98029c..a127e3e8f9b9 100644
> >--- a/mm/pgtable-generic.c
> >+++ b/mm/pgtable-generic.c
> >@@ -385,10 +385,17 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
> >  * Note: "RO" / "RW" expresses the intended semantics, not that the *kmap* will
> >  * be read-only/read-write protected.
> >  *
> >- * Note that free_pgtables(), used after unmapping detached vmas, or when
> >- * exiting the whole mm, does not take page table lock before freeing a page
> >- * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
> >- * pte_offset_map() and co once the vma is detached from mm or mm_users is zero.
> >+ * Note that free_pgtables(), used after unmapping detached vmas or when exiting
> >+ * the whole mm, does not take a page table lock before freeing a page table.
> >+ *
> >+ * As page table freeing itself is RCU-safe, page table readers can safely run
> >+ * concurrently with page table teardown.
> >+ *
> >+ * However, writers CANNOT as, without a lock being held, nothing prevents
> >+ * concurrent teardown.
> >+ *
> >+ * Also note that the PGD itself is freed at mmdrop() time, not under RCU - so
> >+ * the walker must keep the mm alive either by pinning the mm or the VMA.
> >  */
> > pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
> > 			   unsigned long addr, spinlock_t **ptlp)
> >
> >--
> >2.55.0
> >
> >

--
Cheers, Lorenzo

