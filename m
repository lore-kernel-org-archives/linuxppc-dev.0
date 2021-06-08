Return-Path: <SRS0=nRCD=LC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FB9C47082
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 12:06:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373A36128D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 12:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373A36128D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FzpqR6l4Gz3bsp
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 22:06:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=kJr5yYmQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=shutemov.name
 (client-ip=2a00:1450:4864:20::22e; helo=mail-lj1-x22e.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=kJr5yYmQ; dkim-atps=neutral
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fzppw06ynz2yQw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jun 2021 22:05:42 +1000 (AEST)
Received: by mail-lj1-x22e.google.com with SMTP id c11so26670689ljd.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jun 2021 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pVytLWJPCdYWlcE4l4Eozp5bHgj273pdwA3S5444jS8=;
 b=kJr5yYmQNhP36nMdU0gRFrggHRAzIsRAFHTIw1JmvZ39mNaS6E8+WjSaikaMO4WFsR
 uj6gmLz203Tx0iwlXmM5oOQbVovdTjjiO7XYzR4JfwoRdxQqYD/SmifC56XfWkqahdnp
 GvUva4GIdTRh6HsbMZXwlEuktRZ/tIIQuIOlN2PFJ38M4nRAeMVcqxll3d4SpucWwDzc
 MnGD11K26va2F4dhht+nUL3cu0JMfs25i4I7lhoB+Gew0QlAVu7TIAfVkYr0TSrK8vRh
 20fclbfAcXb1IjQFTTqRaV0px1DiFaeoTB4OAXkgpOs7bCg+xqO3+XEfWlAaRlvMp5oS
 4n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pVytLWJPCdYWlcE4l4Eozp5bHgj273pdwA3S5444jS8=;
 b=SYW4FaCqi09hrT4WyxHdwCXCOaDRBZqlVM3VkcK4Todp5VtdaUj40Y4tftEbnopFYz
 De8VAS0r9nvqNdPumDEJJAOOcerMKo29XEX8BwQQNyUR1w/aepr2G03FeRSLj3Rx9d+R
 rSbXE+JBQbyhzvxYMl2qjLIjl/7YPhb4oTy9JZIjywuNN2tXmcle8oXUVau5gCtiB4Vj
 cVmh/AJruWBnqw0BRzsvnUgdFFHBB/XDJzyC2Dm/X3FKtM6DNHkJXrFeb9F/xbrlwW4V
 1O2fDMqOibgUqmdzGCnfiFoZ1MozNXWtr4P4+3IqKAIN9tKBgjW9KDn9ISX0IbAxR2Br
 2qSQ==
X-Gm-Message-State: AOAM533HlMdAdY0wE/l0NHeZtEuM7uRicXKXr/D6NaOlvCFVybvc98fC
 96NXIKEaf/98mczWQjIi7jaZpw==
X-Google-Smtp-Source: ABdhPJzbMTm0cxytj3h3IdFCMhnpHsgWWtYPB5Cc8+1+W8adVpLnY+b2jSlwx6m7+vCJG7orHfmJBg==
X-Received: by 2002:a2e:85c9:: with SMTP id h9mr18534093ljj.355.1623153933524; 
 Tue, 08 Jun 2021 05:05:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id a7sm1419983lfj.42.2021.06.08.05.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jun 2021 05:05:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
 id 78C67102815; Tue,  8 Jun 2021 15:05:47 +0300 (+03)
Date: Tue, 8 Jun 2021 15:05:47 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v7 01/11] mm/mremap: Fix race between MOVE_PMD mremap and
 pageout
Message-ID: <20210608120547.krz7ymie3qq2sd2r@box.shutemov.name>
References: <20210607055131.156184-1-aneesh.kumar@linux.ibm.com>
 <20210607055131.156184-2-aneesh.kumar@linux.ibm.com>
 <f789af6-8924-3b83-6f82-c662175af126@google.com>
 <87o8cgokso.fsf@linux.ibm.com>
 <20210608094222.xcpvlc3kaq5j5sh3@box.shutemov.name>
 <e7de1397-e982-9236-1545-9beb4233926f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7de1397-e982-9236-1545-9beb4233926f@linux.ibm.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, npiggin@gmail.com, linux-mm@kvack.org,
 kaleshsingh@google.com, joel@joelfernandes.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 08, 2021 at 04:47:19PM +0530, Aneesh Kumar K.V wrote:
> On 6/8/21 3:12 PM, Kirill A. Shutemov wrote:
> > On Tue, Jun 08, 2021 at 01:22:23PM +0530, Aneesh Kumar K.V wrote:
> > > 
> > > Hi Hugh,
> > > 
> > > Hugh Dickins <hughd@google.com> writes:
> > > 
> > > > On Mon, 7 Jun 2021, Aneesh Kumar K.V wrote:
> > > > 
> > > > > CPU 1				CPU 2					CPU 3
> > > > > 
> > > > > mremap(old_addr, new_addr)      page_shrinker/try_to_unmap_one
> > > > > 
> > > > > mmap_write_lock_killable()
> > > > > 
> > > > > 				addr = old_addr
> > > > > 				lock(pte_ptl)
> > > > > lock(pmd_ptl)
> > > > > pmd = *old_pmd
> > > > > pmd_clear(old_pmd)
> > > > > flush_tlb_range(old_addr)
> > > > > 
> > > > > *new_pmd = pmd
> > > > > 									*new_addr = 10; and fills
> > > > > 									TLB with new addr
> > > > > 									and old pfn
> > > > > 
> > > > > unlock(pmd_ptl)
> > > > > 				ptep_clear_flush()
> > > > > 				old pfn is free.
> > > > > 									Stale TLB entry
> > > > > 
> > > > > Fix this race by holding pmd lock in pageout. This still doesn't handle the race
> > > > > between MOVE_PUD and pageout.
> > > > > 
> > > > > Fixes: 2c91bd4a4e2e ("mm: speed up mremap by 20x on large regions")
> > > > > Link: https://lore.kernel.org/linux-mm/CAHk-=wgXVR04eBNtxQfevontWnP6FDm+oj5vauQXP3S-huwbPw@mail.gmail.com
> > > > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > > > 
> > > > This seems very wrong to me, to require another level of locking in the
> > > > rmap lookup, just to fix some new pagetable games in mremap.
> > > > 
> > > > But Linus asked "Am I missing something?": neither of you have mentioned
> > > > mremap's take_rmap_locks(), so I hope that already meets your need.  And
> > > > if it needs to be called more often than before (see "need_rmap_locks"),
> > > > that's probably okay.
> > > > 
> > > > Hugh
> > > > 
> > > 
> > > Thanks for reviewing the change. I missed the rmap lock in the code
> > > path. How about the below change?
> > > 
> > >      mm/mremap: hold the rmap lock in write mode when moving page table entries.
> > >      To avoid a race between rmap walk and mremap, mremap does take_rmap_locks().
> > >      The lock was taken to ensure that rmap walk don't miss a page table entry due to
> > >      PTE moves via move_pagetables(). The kernel does further optimization of
> > >      this lock such that if we are going to find the newly added vma after the
> > >      old vma, the rmap lock is not taken. This is because rmap walk would find the
> > >      vmas in the same order and if we don't find the page table attached to
> > >      older vma we would find it with the new vma which we would iterate later.
> > >      The actual lifetime of the page is still controlled by the PTE lock.
> > >      This patch updates the locking requirement to handle another race condition
> > >      explained below with optimized mremap::
> > >      Optmized PMD move
> > >          CPU 1                           CPU 2                                   CPU 3
> > >          mremap(old_addr, new_addr)      page_shrinker/try_to_unmap_one
> > >          mmap_write_lock_killable()
> > >                                          addr = old_addr
> > >                                          lock(pte_ptl)
> > >          lock(pmd_ptl)
> > >          pmd = *old_pmd
> > >          pmd_clear(old_pmd)
> > >          flush_tlb_range(old_addr)
> > >          *new_pmd = pmd
> > >                                                                                  *new_addr = 10; and fills
> > >                                                                                  TLB with new addr
> > >                                                                                  and old pfn
> > >          unlock(pmd_ptl)
> > >                                          ptep_clear_flush()
> > >                                          old pfn is free.
> > >                                                                                  Stale TLB entry
> > >      Optmized PUD move:
> > >          CPU 1                           CPU 2                                   CPU 3
> > >          mremap(old_addr, new_addr)      page_shrinker/try_to_unmap_one
> > >          mmap_write_lock_killable()
> > >                                          addr = old_addr
> > >                                          lock(pte_ptl)
> > >          lock(pud_ptl)
> > >          pud = *old_pud
> > >          pud_clear(old_pud)
> > >          flush_tlb_range(old_addr)
> > >          *new_pud = pud
> > >                                                                                  *new_addr = 10; and fills
> > >                                                                                  TLB with new addr
> > >                                                                                  and old pfn
> > >          unlock(pud_ptl)
> > >                                          ptep_clear_flush()
> > >                                          old pfn is free.
> > >                                                                                  Stale TLB entry
> > >      Both the above race condition can be fixed if we force mremap path to take rmap lock.
> > >      Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > 
> > Looks like it should be enough to address the race.
> > 
> > It would be nice to understand what is performance overhead of the
> > additional locking. Is it still faster to move single PMD page table under
> > these locks comparing to moving PTE page table entries without the locks?
> > 
> 
> The improvements provided by optimized mremap as captured in patch 11 is
> large.
> 
> mremap HAVE_MOVE_PMD/PUD optimization time comparison for 1GB region:
> 1GB mremap - Source PTE-aligned, Destination PTE-aligned
>   mremap time:      2292772ns
> 1GB mremap - Source PMD-aligned, Destination PMD-aligned
>   mremap time:      1158928ns
> 1GB mremap - Source PUD-aligned, Destination PUD-aligned
>   mremap time:        63886ns
> 
> With additional locking, I haven't observed much change in those numbers.
> But that could also be because there is no contention on these locks when
> this test is run?

Okay, it's good enough: contention should not be common and it's okay to
pay a price for correctness.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
