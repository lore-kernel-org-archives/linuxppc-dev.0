Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C3606A329
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bQ0FX6HN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7npW0PlBz2yQH;
	Tue, 20 Oct 2026 07:54:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792443250;
	cv=none; b=ie6oZy0DTrIrRUhkNhJ/OpGW60AmPSCsZPn+ahzugP58v+DOuux/h+N40iPVFxfmI1LuCntNrO8xvERyha2MnjHYOg1Q+R+/2wyPr458mKJ1NVk5xRZc0lAsPNBbG8uK2bfUwPs0XeqHAkFjmRClJRCH7P9q2Wb5MoOVWYT/wb6+jzrJVG4PuPH23atQmEDVOgf5j8sYtuyoisE2FS7oJouBjiZIMgGC7eRO2LduwDqBn5+fjkqweXRHMCOf/1P7bv2cKV3lQuEW/BMCa/R7QICE4jfEtjN3RBjmxYNKICoorrpdhIk5j002fq+pULZpTaQGr2WjqII4MqLsHtXLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792443250; c=relaxed/relaxed;
	bh=ccM+tB35AWZe4vsxbl8ZkFdtD87yJwwquhmHcKeVI9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0a56C28KdXcvm5NoyTjhIWR4Yb1ELbbfrHVACSdxYP32xHKeUg58dlzkLQJkQObVCoycvmsuTXk5D6wieXt6Nh7MiL5xoDHjzb5G0MgNLziyK7XoZrfe1BaFqV4MR/T86ABJ3MuRvRa5dtN/uHV2/DUXYzegcpRLpmYekW67xfYv3U3oNLsm8kQl5yMUTt/r31d7E1dTj7uVQMoeu3ge5yvNRjJ4GXh5rVAuMa0yJwXsg7lUHGgtzJm+4MeWUodsDfYe9WIAb2WgAWEqJw8vP6GkSYZPYWSZ2Z/6Dvf6+BeG13RCKoIiHBJ/qW+ooaTajrb+3I/ue1TyqZPW9V+pA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bQ0FX6HN; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bQ0FX6HN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7npM2dp7z2xjv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 07:54:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ccM+tB35AWZe4vsxbl8ZkFdtD87yJwwquhmHcKeVI9Q=; b=bQ0FX6HNdwX6jQVJyiY2V8qoHk
	qEKvQn56Rz+5qUg+/xuZ5c5AHOqLGgFPgYRkABo2a8WSA0LF32w8pgJeEhf5P7Jz61DsECOxY/MxF
	m+hCkw9dp8jp2awnLdTlDFXwypE4jU3MuOmm/9LNoFA0ob6txwVFmC8m3BsUKsLxwCHuIiapFDMp1
	XcKLe/CDAX4zBGQYBBKUAOWM+r7fza84Fn3dcCYlngrtRLEQBAawai8+8qzMJ8ud799ZBU4krm5eN
	Qn6T5a240aAOGNuJ9FgPwruEv5DudjjPVlz2LeJxFgBQGdB2w+e9u5+wep7Oyt4Xt1uzRao0DjETO
	WtIyCGvA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIuMO-0000000B396-13ug;
	Mon, 19 Oct 2026 20:53:32 +0000
Date: Mon, 19 Oct 2026 21:53:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Hongru Zhang <zhanghongru06@gmail.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, surenb@google.com, david@kernel.org,
	liam@infradead.org, mhocko@suse.com, rppt@kernel.org,
	shakeel.butt@linux.dev, vbabka@kernel.org, zhaonanzhe@xiaomi.com,
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	linux-s390@vger.kernel.org, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
	Hongru Zhang <zhanghongru@xiaomi.com>
Subject: Re: [PATCH v6] mm: retry page faults once under the per-VMA lock
Message-ID: <ataDTEZIKOYtwhUF@casper.infradead.org>
References: <20260911025613.1220845-1-zhanghongru@xiaomi.com>
 <arFYRAa-i7CIwmHL@gremlin>
 <arF-E3Nsw9ZliH0t@casper.infradead.org>
 <arI_w2wTfA00Mgy9@gremlin>
 <armexcXDiG8ryZd6@casper.infradead.org>
 <CAGsJ_4xuFi7K+crAcFQ998SxXS0xPM6QeA34JV+6+Sy005rXLg@mail.gmail.com>
 <ar7MsOb6IJLt4eLo@casper.infradead.org>
 <ar-o1TrOMGrrcxLX@gremlin>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar-o1TrOMGrrcxLX@gremlin>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 02, 2026 at 02:12:35PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Thu, Oct 01, 2026 at 10:12:16PM +0100, Matthew Wilcox wrote:
> > So what I didn't realise is that fork() waits for page faults to finish.
> > I don't think that's necessary, so we can just stop doing that (whitespace
> > damaged):
> > I think this is safe.  I've booted a kernel with this change, and
> 
> I'm afraid it's not safe :)
> 
> We already actually did this (by mistake I think?) before. See commit
> fb49c455323f ("fork: lock VMAs of the parent process when forking") - we shipped
> that in 6.4.0 -> 6.4.2 and it corrupted memory all over the place.
> 
> Reports + a consistent reproducer:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=217624
> https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org/
> https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec2a34c@applied-asynchrony.com/

I wonder if we still need this.  The commit message says:

    A concurrent page fault on a page newly marked read-only by the page
    copy might trigger wp_page_copy() and a anon_vma_prepare(vma) on the
    source vma, defeating the anon_vma_clone() that wasn't done because the
    parent vma originally didn't have an anon_vma, but we now might end up
    copying a pte entry for a page that has one.

But we're holding the mmap_lock for write here, and we need to hold the
mmap_lock for read in order to change a vma->anon_vma (asserted in
__anon_vma_prepare() with mmap_assert_locked()).

At the time of this commit, lock_vma_under_rcu() contained:

        /* find_mergeable_anon_vma uses adjacent vmas which are not locked */
        if (!vma->anon_vma && !vma_is_tcp(vma))
                goto inval;

so we really did have to wait for read holders to finish the fault.
But commit a373baed5a9d deferred the check for a NULL anon VMA until we
actually needed it, so I think commit fb49c455323f's logic was invalidated
by a373baed5a9d.

Maybe I'm wrong.  This is all a bit out of my normal area.

> Also we have asserts for this lock in copy_page_range() and
> copy_hugetlb_page_range() which will now fail (and possibly more further down
> the stack?)

Possibly we have to adjust some assertions to check that either we have
the VMA locked or we have the MM write locked.  That doesn't seem
unreasonable.

> > My argument for why it's safe is that a thread which takes a page
> > fault during fork() might have taken the page fault either before or
> > after fork().  The faults will definitely happen in the parent process.
> > They may or may not have happened in the child process, which can't
> > possibly care whether or not they've happened.
> 
> The problem isn't the child it's the parent - copy_page_range() _modifies_ the
> _parent_'s page tables in-place, on assumption that nothing else can access
> them (for CoW).

I was perhaps unclear.  What I mean is that the child may or may not
observe them as having happened.

> And actually nowadays things are _even_ worse, you could also have concurrent
> page faults, MADV_DONTNEED, MADV_FREE, MADV_GUARD_INSTALL/REMOVE, UFFDIO_COPY +
> UFFDIO_MOVE (yikes) all of which might introduce new issues + would have to be
> audited too.

Yup.

> So - it turns out a lot of stuff implicitly assumes VMA write lock now:
> 
> 1. CoW - deferred TLB flush race
> 
> (The issue above)
> 
> https://lore.kernel.org/all/20230705171213.2843068-2-surenb@google.com/
> 
> This happens because __copy_present_ptes() does wrprotect_ptes() on the parent
> without a TLB flush (that's deferred until the end of the fork).
> 
> But unfortunately without a VMA write lock something can then replace the page
> table entry in the meantime and you can end up with data loss as a result.

Is it that fb49c455323f commit message is insufficient and we need to
prevent simultaneous fork/page fault for other reasons, then?

> Same issue exists with hugetlb wp too. And god only knows with uffd wp :)
> 
> 2. THP - can destroy parent THP mappings
> 
> copy_pmd_range() does:
> 
> 	if (pmd_is_huge(*src_pmd)) { copy_huge_pmd(); ... }
> 	if (pmd_none_or_clear_bad(src_pmd))
> 		continue;
> 
> Without the write lock, a concurrent fault can install a huge PMD via
> do_huge_pmd_anonymous_page() or filemap_map_pmd()/do_set_pmd().
> 
> The issue is that pmd_bad() fires for leaf PMD (ugh) on at least x86 and arm64,
> meaning that'll clear the page table entry.
> 
> I think Hugh left a comment alluding to this before:
> 
> 	 * copy_pmd_range()'s prior pmd_none_or_clear_bad(src_pmd), and the
> 	 * error handling here, assume that exclusive mmap_lock on dst and src
> 	 * protects anon from unexpected THP transitions; ...
> 
> It's like the mess around pmd_trans_unstable() :(

... could we fix this by taking the ptlock during the copy operation?

> 3. copy_pte_range() skips the required pmd_same() recheck assuming write lock
> 
> It uses pte_offset_map_rw_nolock() with a dummy pmdval and:
> 
> 	 * We already hold the exclusive mmap_lock, the copy_pte_range() and
> 	 * retract_page_tables() are using vma->anon_vma to be exclusive, so
> 	 * the PTE page is stable, and there is no need to get pmdval and do
> 	 * pmd_same() check.
> 
> (Probably needs updating for VMA write lock...)
> 
> 4. The asserts
> 
> Mentioned above!
> 
> I suspect there's more as well.
> 
> Some of it could be changed, but it'd all be at the cost of behaving very
> strangely (no VMA lock but mmap write lock) while manipulating things.
> 
> And I am not really happy with changing page table entries in the parent VMA
> (for CoW) without a VMA write lock held.
> 
> I also wonder whether it would achieve all that much really - the issue is with
> holding the VMA lock across I/O, anything else that tries to grab a write lock
> is going to end up being the new thing that's blocked (mprotect, munmap, mremap,
> mlock etc.)
> 
> I think doing something like this would need a very significant redesign and I'm
> not convinced it's one that really achieves what we want given all the other
> cases that'd get blocked by the VMA lock being held still.
> 
> --
> Cheers, Lorenzo

