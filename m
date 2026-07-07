Return-Path: <linuxppc-dev+bounces-23749-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A96CC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 22:36:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvx0j73VMz2xnp;
	Wed, 08 Jul 2026 08:36:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2001:4860:4864:20::2f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783444152;
	cv=pass; b=I5jfy3CUy2Wf8+H8HFBhqKYGeSuuHYOyJ18oPTmxGhD32QoLjlK+rMkW8SDVZxR34REvDPFBwPgrLPwHjoMdbk497fiIGKcZnqVJa7NtYDD4yEDZqeAje8ej6BWjRS1ywTwtQtrgEd98eJBif4yagxoIek+Y7TbA+Yq7qFmf6frthaOH31piXQhNSPxkV0zW81N0JfIbsHF6RtEiYpaSJuzQolUuU7JeDeewKLxBVTZKLy9Z4+IEzdba6sERNhfNUhMhkn/kaRIT0miXAdrs6i40ZHNZ0nUnSfiWO3KT1Jsw/ZPjmWdLHaw/EXgtNMwADQCExPSRj9IhG5lr9YA47Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783444152; c=relaxed/relaxed;
	bh=O9lfVufk5V6ONvrwxd5qwRqQ5dHF658hNKhamzFjYII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAF+AYp5eDf7GBMbsgJdELOXGnZuv46d6y6D8KZIEDD4Trkwcy0Bu93/oATK1t1GsLKjRAEXbG1vLVo5ySNuKTuHd3R79boxuCDUmBS21gc3Os11poIRrgBhlXmVfvcSlQo94Iv2bmlkh0noe+XNrESHBF1Ft+V+m2T0GWymYkT8RoH7T5/tZqAGsrHYOiL56yPJEqZ9Lo6lCd78BofJcjzyJOvxd0/ugwALpnhBWN89fNbZmmLOoabHpBfRhALUxDKdpcNbf/aQoAjddl2tWCBBUMugjQBiey0R+NHiHAVuXWIl+0s5pE5h283y96JYYELju7d1qe4rhHACe+dzOw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sevzucQ8; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com; envelope-from=devnexen@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sevzucQ8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com; envelope-from=devnexen@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvnkv1SNPz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 03:09:10 +1000 (AEST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-44865cf3010so2580030fac.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 10:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783444143; cv=none;
        d=google.com; s=arc-20260327;
        b=VMpiZ3iAF+0Tjl06McLp/muYz6FdCooAhJENUTbZfl90Vc6Nh3z8RP5pjRN9JvkG9v
         CqNEm3MzuVdilLLNyCNnnK0U6TfUNYMhFxghZh8Mu1YGtCnv1gqIJbFeXDb2AK4o5quT
         9c9efL01X9ehJNvfqNl3V4ThuziHajv6x/5XBEtr5xxL/NZk8p9CEaZyLt7Nrsbg4Fwx
         c1WhKB3W2pXs5jY0tEsCdKa/UQwLLLXGwd63I0lNLveAOBq1Fpc2dG+BlIFkoQIP0j9M
         2dcJc2ij86Sns26BDtjmMmJmSV4cxR/FQfLnFEeUsMojskg0/y6/LnFwE3UPAaDIAnrZ
         88SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O9lfVufk5V6ONvrwxd5qwRqQ5dHF658hNKhamzFjYII=;
        fh=GJ0q83slR2sKgySBuLWtzP3n9ZldTvQ/DhvHU3Qnrck=;
        b=FjcSDBUzhvuS8sIffAWyAE407VMoAsebvCY8jALhu/RWmjeev1qg4T0H4u1I5M8HoW
         442zGDVwQ8kvSh9OMjeQ3uwhr0Ko6vmfE3IJUY4BVE1tp2fwwGZCOrP2mhB/la9q/6RE
         2EB9pPiQcyI5K1wp5OTxQWRFRecOYcOE+YOTt+du/4yEdpCOwzeom2y2lQyRWnEf3q1U
         E2EX3YbFAmj9Hz0lbvdTojyN0u5CqKfNIWitIsFj8Z21t/r1o4+Okrw4GByMj2nvRoBm
         ddQSCrhCfBHfEY08StUQ/WB90UjKGQHloOLIBr6OVxGo8kxl/c03YyJllaJ2OEy7QeoN
         fEdQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783444143; x=1784048943; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O9lfVufk5V6ONvrwxd5qwRqQ5dHF658hNKhamzFjYII=;
        b=sevzucQ80yTzuMvW+cQbZBnfQUeK9a6RQmBD+faoDo5ER9PYHx/7xK2oUp6C0UcLRs
         0orkQx1rgEO8X193+P5oQO7OM+KbjKDqiJHEIs2Im2/WnY4YpI5JovW5nTiCWKbPvUDg
         GAjmeovo+GPmJmHDY/x4ji480ctDRBMIet3Nbkm6nXz+7CgHRcH/ujSVIpbTnbR7aHJW
         U/Y96mRlKnO/7O94HPhAHcsF6H2p+shkIGGLCjPHLAanYgFFRqeZ7Yuap4/nxNLaNJ62
         EJ5ht0p30kL9qUPZ1sH8TBegMwHIh4SiAer90R1Xy/Yhs+4GlZmW7euTzQ9wJwhst9cD
         /NYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783444143; x=1784048943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9lfVufk5V6ONvrwxd5qwRqQ5dHF658hNKhamzFjYII=;
        b=Qi5PNcLvSwOMiK7CzXtV25tqSPIoU2zUHDp/KscWEVUFzqVuwtQIFqlWnxQdEY9Laf
         J5EC6Or0wP6LXjr1Hfvuq6gYhSQFGTCXigEDQ+gbtikaHt/ybmh3zw2+Gx486GDNCXkD
         RN8Ig/dFDoVVQSXa+YvvlrimbnsB4Kv0tyWoeQQ9dUixnVq2oI/TAdqFyxAYxbVQOK9j
         XHKYIU3xOILGm9qhus6Rza1/J+geHVSm8Mcjq/bFQG6WU3vOeY/95e0uVtaKwup70i/3
         xd+MImtcYIC1W8FXseU6EJ2Qv2EukWqEWyVoI9kSdvJB0yViNjhuiO2u4BGuX8u0gMFL
         SQfw==
X-Forwarded-Encrypted: i=1; AFNElJ8KfnXNrm6h2Y3HTGuirYmFgO7uvgEoXNIr9yvtJq6yKz3Sc+AsL5DFd8dJrR7fXyW+CC7GN/vObq0nSeQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzTe33A0tT1sNmiEgUc60nLnwOYKOfZSvFOSbvvGjCc4dc5AjO8
	SAOYVWgixDiWVxXn9VS4xm9TCRj+d0U+48kFe75uBHnqzhfAMWONwfbaDvFvmLJfqXYn0XYoN8X
	Hg0nNMaBR2cPGo0F+jF8QAgFjA1LDe0w=
X-Gm-Gg: AfdE7clST6tuv0cVCWX+HQnUvpDOtyNUOSgXz9N+9zrljSqC8gvfnJQiEfR5Zj8/Rq1
	KRz47zZqq1ArkxSfcS945iMJq69vvS1CR0EZSrACEFNobOD1wm1+WWM4yhLk9gdUqh1q621KNdT
	H5VBoOkB+NV6NdoTPOHF+r//bFa+sOXElyrnWOHrOM+sTmfUXKL/OzieIk1CRhl4hqCxn+cipsy
	Wh8unOowZBfUbRw8nR3qvHsubdXrt89anwQfXTlbmac7tXnTOI2Oa6SBxI15VUZ2lPVs+aeI7po
	MPZNUJORVI+IICwXI9HnjyOImL0=
X-Received: by 2002:a05:687c:1d0:10b0:451:25f2:da63 with SMTP id
 586e51a60fabf-45125f37d48mr1081836fac.6.1783444142894; Tue, 07 Jul 2026
 10:09:02 -0700 (PDT)
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
References: <20260706203128.162335-1-devnexen@gmail.com> <ak0YI9KjSstnj9rJ@lucifer>
In-Reply-To: <ak0YI9KjSstnj9rJ@lucifer>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 7 Jul 2026 18:08:49 +0100
X-Gm-Features: AVVi8CeAguKb-2D6-6uZGOkqLgTNCfKzyhQ0b9NrJMamMVdmP0NqOcPU8DLT3gM
Message-ID: <CA+XhMqzvFtLq1OT-qh207aJhSf+okdE8o8Joe8e_KBvdCjcQfQ@mail.gmail.com>
Subject: Re: [PATCH v8] mm: pgtable: free kernel page tables via RCU to fix
 ptdump UAF
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dev Jain <dev.jain@arm.com>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Sure thing :)

On Tue, 7 Jul 2026 at 16:19, Lorenzo Stoakes <ljs@kernel.org> wrote:
>
> Hi David C,
>
> This has been through a lot of revisions so I think for the sake of expediency
> the best solution here is for me to grab this and fiddle with it a bit then post
> it out myself.
>
> TO BE VERY CLEAR - I will keep your authorship and attribution :), and simply
> stick my name on a Co-developed-by tag.
>
> So this will remain your patch.
>
> Cheers, Lorenzo
>
> On Mon, Jul 06, 2026 at 09:31:27PM +0100, David Carlier wrote:
> > ptdump_walk_pgd() walks the kernel page tables under get_online_mems().
> > That does not stop vmalloc from freeing a kernel PTE page underneath the
> > walk.
> >
> > When vmap_try_huge_pmd() promotes a range to a huge PMD it collapses the
> > existing PTE table and frees it via pmd_free_pte_page(). On x86, riscv and
> > powerpc this runs without the init_mm mmap lock; only arm64 takes it, and
> > not on the block-split path. So ptdump can dereference a just-freed PTE
> > page, which is the use after free syzbot hit in ptdump_pte_entry().
> >
> > The race is not new. ptdump walks the whole kernel address space, including
> > ranges other code is actively mapping, so it reads page tables it does not
> > own. Commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
> > tables") only widened the window; the Fixes tag points there for that
> > reason.
> >
> > Every other walker works on a range it owns and is the only one mutating
> > it: set_memory() on arm64/riscv/loongarch, the arm64 block-split path, the
> > openrisc DMA path and the hugetlb_vmemmap remap. Nothing frees those ranges
> > concurrently, so they cannot race and do not need RCU. ptdump is the only
> > walker that traverses ranges it does not own.
> >
> > Defer the free by an RCU grace period. pagetable_free_kernel() now frees
> > via call_rcu() in both the async and non-async configs. The async path
> > still flushes the TLB first, then queues the per-page RCU free. The page
> > stays valid until any walk that may have observed it drops its RCU read
> > lock.
> >
> > x86, arm64 and riscv reach pagetable_free_kernel() for the collapsed PTE
> > page (the ptdesc carries PT_kernel), so the deferral covers them. powerpc
> > uses its own fragment allocator: pte_free_kernel() there frees the page
> > synchronously via pte_fragment_free() and the ptdesc is not flagged kernel,
> > so defer the kernel case in pte_fragment_free() as well. arm64 also takes
> > init_mm.mmap_lock around the free under a static key; that is now redundant
> > with the RCU deferral but left in place.
> >
> > On the read side walk_page_range_debug() walks the init_mm range in bounded
> > chunks, taking rcu_read_lock() around each chunk and calling cond_resched()
> > between them. It uses the lockless walker as the mmap lock is no longer
> > held, and pgd_addr_end() to bound each chunk without overflowing at the top
> > of the address space. A walker either sees the cleared PMD and skips, or
> > keeps the page alive until it drops the lock. The owned-range walkers are
> > unchanged.
> >
> > Stop taking mmap_write_lock() in ptdump_walk_pgd() for init_mm. It never
> > guarded against this free -- most architectures free the collapsed PTE
> > table without it -- and RCU now provides the synchronisation. efi_mm and
> > current->mm page tables are not RCU-freed, so they keep the mmap write
> > lock.
> >
> > ptdump callbacks run under RCU within a chunk, so they must not sleep. The
> > arch note_page() and effective_prot() callbacks only format into the
> > preallocated seq_file buffer; the only GFP_KERNEL marker setup runs before
> > the walk, and cond_resched() happens between chunks, outside the read lock.
> >
> > Fixes: 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables")
> > Reported-by: syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/6a287988.39669fcc.33b062.00a0.GAE@google.com/T/
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> > v8: fix four issues raised by the Gemini review of v7 (relayed by Andrew).
> >     - the init_mm walk called walk_kernel_page_table_range(), which
> >       asserts init_mm.mmap_lock -- but that lock is now dropped; use the
> >       lockless walker instead.
> >     - only stop taking mmap_write_lock() for init_mm; efi_mm and
> >       current->mm are not RCU-freed and keep it.
> >     - bound each chunk with pgd_addr_end() so the last chunk does not
> >       overflow at the top of the address space.
> >     - powerpc frees kernel PTE pages synchronously via pte_fragment_free()
> >       and never sets PT_kernel, so it bypassed the RCU deferral; defer the
> >       kernel case there too.
> > v7: no code change; add version tag and per-revision changelog (Dev).
> > v6: chunk the init_mm walk in walk_page_range_debug() and take
> >     rcu_read_lock() per chunk (reverting v5's caller-side lock + assert)
> >     so the read section stays bounded on large kernel address spaces and
> >     can cond_resched() between chunks; drop the now-redundant
> >     mmap_write_lock() in ptdump_walk_pgd().
> > v5: reframe changelog around the pre-existing race and range ownership;
> >     correct the mmap-lock description (arm64 is the exception, not x86);
> >     move rcu_read_lock() into ptdump_walk_pgd() and assert it in
> >     walk_page_range_debug(); drop walk_kernel_page_table_range_rcu(); fix
> >     the pgtable-generic.c comment; document the no-sleep audit of the
> >     callbacks.
> > v4: defer the free in both the async and non-async configs, not just the
> >     async one; add a walk_kernel_page_table_range_rcu() helper.
> > v3: take rcu_read_lock() in the init_mm branch of walk_page_range_debug().
> > v2: use call_rcu() instead of synchronize_rcu().
> >  arch/powerpc/mm/pgtable-frag.c |  7 ++++++-
> >  include/linux/mm.h             |  7 -------
> >  mm/pagewalk.c                  | 36 +++++++++++++++++++++++++++++-----
> >  mm/pgtable-generic.c           | 22 ++++++++++++++++++++-
> >  mm/ptdump.c                    | 11 +++++++++--
> >  5 files changed, 67 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> > index ae742564a3d5..1e1e88f831f7 100644
> > --- a/arch/powerpc/mm/pgtable-frag.c
> > +++ b/arch/powerpc/mm/pgtable-frag.c
> > @@ -123,7 +123,12 @@ void pte_fragment_free(unsigned long *table, int kernel)
> >
> >       BUG_ON(atomic_read(&ptdesc->pt_frag_refcount) <= 0);
> >       if (atomic_dec_and_test(&ptdesc->pt_frag_refcount)) {
> > -             if (kernel || !folio_test_clear_active(ptdesc_folio(ptdesc)))
> > +             /*
> > +              * Kernel page tables may be walked locklessly under RCU by
> > +              * ptdump, so defer their free by a grace period too, like the
> > +              * lockless-GUP case below for user tables.
> > +              */
> > +             if (!kernel && !folio_test_clear_active(ptdesc_folio(ptdesc)))
> >                       pte_free_now(&ptdesc->pt_rcu_head);
> >               else
> >                       call_rcu(&ptdesc->pt_rcu_head, pte_free_now);
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 485df9c2dbdd..79408a17a1b0 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3695,14 +3695,7 @@ static inline void __pagetable_free(struct ptdesc *pt)
> >       __free_pages(page, compound_order(page));
> >  }
> >
> > -#ifdef CONFIG_ASYNC_KERNEL_PGTABLE_FREE
> >  void pagetable_free_kernel(struct ptdesc *pt);
> > -#else
> > -static inline void pagetable_free_kernel(struct ptdesc *pt)
> > -{
> > -     __pagetable_free(pt);
> > -}
> > -#endif
> >  /**
> >   * pagetable_free - Free pagetables
> >   * @pt:      The page table descriptor
> > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > index 3ae2586ff45b..fc2fe014ac8c 100644
> > --- a/mm/pagewalk.c
> > +++ b/mm/pagewalk.c
> > @@ -620,7 +620,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
> >   * Note: Be careful to walk the kernel pages tables, the caller may be need to
> >   * take other effective approaches (mmap lock may be insufficient) to prevent
> >   * the intermediate kernel page tables belonging to the specified address range
> > - * from being freed (e.g. memory hot-remove).
> > + * from being freed (e.g. memory hot-remove, vmap huge page promotion).
> >   */
> >  int walk_kernel_page_table_range(unsigned long start, unsigned long end,
> >               const struct mm_walk_ops *ops, pgd_t *pgd, void *private)
> > @@ -643,7 +643,7 @@ int walk_kernel_page_table_range(unsigned long start, unsigned long end,
> >   * Use this function to walk the kernel page tables locklessly. It should be
> >   * guaranteed that the caller has exclusive access over the range they are
> >   * operating on - that there should be no concurrent access, for example,
> > - * changing permissions for vmalloc objects.
> > + * changing permissions for vmalloc objects, or vmap huge page promotion.
> >   */
> >  int walk_kernel_page_table_range_lockless(unsigned long start, unsigned long end,
> >               const struct mm_walk_ops *ops, pgd_t *pgd, void *private)
> > @@ -692,9 +692,35 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
> >       };
> >
> >       /* For convenience, we allow traversal of kernel mappings. */
> > -     if (mm == &init_mm)
> > -             return walk_kernel_page_table_range(start, end, ops,
> > -                                                 pgd, private);
> > +     if (mm == &init_mm) {
> > +             unsigned long addr = start;
> > +
> > +             /*
> > +              * Walk in bounded chunks so the RCU read lock is never held
> > +              * across the whole kernel address space.  A kernel page table
> > +              * freed via pagetable_free_kernel() stays valid until the walk
> > +              * that may have observed it drops the lock; releasing the lock
> > +              * between chunks is safe as no page table pointer is held
> > +              * across the gap. The mmap lock is not held, so use the
> > +              * lockless walker; RCU, not the lock, keeps the table alive.
> > +              */
> > +             while (addr < end) {
> > +                     unsigned long next = pgd_addr_end(addr, end);
> > +                     int err;
> > +
> > +                     rcu_read_lock();
> > +                     err = walk_kernel_page_table_range_lockless(addr, next, ops,
> > +                                                                 pgd, private);
> > +                     rcu_read_unlock();
> > +                     if (err)
> > +                             return err;
> > +
> > +                     addr = next;
> > +                     cond_resched();
> > +             }
> > +             return 0;
> > +     }
> > +
> >       if (start >= end || !walk.mm)
> >               return -EINVAL;
> >       if (!check_ops_safe(ops))
> > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > index b91b1a98029c..7a32e4821957 100644
> > --- a/mm/pgtable-generic.c
> > +++ b/mm/pgtable-generic.c
> > @@ -410,6 +410,13 @@ pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
> >       goto again;
> >  }
> >
> > +static void kernel_pgtable_free_rcu(struct rcu_head *head)
> > +{
> > +     struct ptdesc *pt = container_of(head, struct ptdesc, pt_rcu_head);
> > +
> > +     __pagetable_free(pt);
> > +}
> > +
> >  #ifdef CONFIG_ASYNC_KERNEL_PGTABLE_FREE
> >  static void kernel_pgtable_work_func(struct work_struct *work);
> >
> > @@ -434,8 +441,15 @@ static void kernel_pgtable_work_func(struct work_struct *work)
> >       spin_unlock(&kernel_pgtable_work.lock);
> >
> >       iommu_sva_invalidate_kva_range(PAGE_OFFSET, TLB_FLUSH_ALL);
> > +
> > +     /*
> > +      * Debug walkers (ptdump) may walk ranges they do not own and race this
> > +      * free, so they walk under rcu_read_lock(). Free after a grace period:
> > +      * a walker either already saw the cleared PMD, or keeps the page alive
> > +      * until it drops the RCU lock.
> > +      */
> >       list_for_each_entry_safe(pt, next, &page_list, pt_list)
> > -             __pagetable_free(pt);
> > +             call_rcu(&pt->pt_rcu_head, kernel_pgtable_free_rcu);
> >  }
> >
> >  void pagetable_free_kernel(struct ptdesc *pt)
> > @@ -446,4 +460,10 @@ void pagetable_free_kernel(struct ptdesc *pt)
> >
> >       schedule_work(&kernel_pgtable_work.work);
> >  }
> > +#else
> > +void pagetable_free_kernel(struct ptdesc *pt)
> > +{
> > +     /* Defer the free by a grace period; see kernel_pgtable_work_func(). */
> > +     call_rcu(&pt->pt_rcu_head, kernel_pgtable_free_rcu);
> > +}
> >  #endif
> > diff --git a/mm/ptdump.c b/mm/ptdump.c
> > index 973020000096..537be9995e1a 100644
> > --- a/mm/ptdump.c
> > +++ b/mm/ptdump.c
> > @@ -177,13 +177,20 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
> >       const struct ptdump_range *range = st->range;
> >
> >       get_online_mems();
> > -     mmap_write_lock(mm);
> > +     /*
> > +      * init_mm is walked locklessly under RCU by walk_page_range_debug().
> > +      * efi_mm / current->mm page tables are not RCU-freed, so hold the
> > +      * mmap write lock to keep them stable against concurrent teardown.
> > +      */
> > +     if (mm != &init_mm)
> > +             mmap_write_lock(mm);
> >       while (range->start != range->end) {
> >               walk_page_range_debug(mm, range->start, range->end,
> >                                     &ptdump_ops, pgd, st);
> >               range++;
> >       }
> > -     mmap_write_unlock(mm);
> > +     if (mm != &init_mm)
> > +             mmap_write_unlock(mm);
> >       put_online_mems();
> >
> >       /* Flush out the last page */
> > --
> > 2.53.0
> >

