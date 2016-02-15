Return-Path: <gerald.schaefer@de.ibm.com>
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 488221A0354
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 03:41:29 +1100 (AEDT)
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gerald.schaefer@de.ibm.com>;
 Mon, 15 Feb 2016 16:41:26 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id EAAA51B0804B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 16:41:40 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1FGfPaX8847628
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 16:41:25 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1FGfMUe016863
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 09:41:24 -0700
Date: Mon, 15 Feb 2016 17:41:19 +0100
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Christian Borntraeger
 <borntraeger@de.ibm.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org, Martin Schwidefsky
 <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [BUG] random kernel crashes after THP rework on s390 (maybe
 also on PowerPC and ARM)
Message-ID: <20160215174119.53b56b86@thinkpad>
In-Reply-To: <20160212231510.GB15142@node.shutemov.name>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name>
 <56BE00E7.1010303@de.ibm.com> <20160212181640.4eabb85f@thinkpad>
 <20160212231510.GB15142@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 13 Feb 2016 01:15:10 +0200
"Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> 
> I'm trying to wrap my head around the issue and I don't think missing
> serialization with gup_fast is the cause -- we just don't need it
> anymore.
> 
> Previously, __split_huge_page_splitting() required serialization against
> gup_fast to make sure nobody can obtain new reference to the page after
> __split_huge_page_splitting() returns. This was a way to stabilize page
> references before starting to distribute them from head page to tail
> pages.
> 
> With new refcounting, we don't care about this. Splitting PMD is now
> decoupled from splitting underlying compound page. It's okay to get new
> pins after split_huge_pmd(). To stabilize page references during
> split_huge_page() we rely on setting up migration entries once all
> pmds are split into page table entries.
> 
> The theory that serialization against gup_fast is not a root cause of the
> crashes is consistent no crashes on arm64. Problem is somewhere else.

Hmm, ok, I just relied on the commit message of commit fecffad25458, which
talks about "pmdp_clear_flush() will do IPI as needed for fast_gup", as well
as the comments in mm/gup.c, which also still talk about IPIs and THP
splitting.

If IPI serialization with fast_gup is not needed anymore for THP splitting,
please fix at least the comments in mm/gup.c.

> 
> > > (It also does some some other magic to the attach_count, which might hold off
> > > finish_arch_post_lock_switch while some flushing is happening, but this should
> > > be unrelated here)
> > > 
> > > 
> > > > I'm also confused by pmd_none() is equal to !pmd_present() on s390. Hm?
> > > 
> > > Don't know, Gerald or Martin?
> > 
> > The implementation frequently changes depending on how many new bits Martin
> > needs to squeeze out :-)
> 
> One bit was freed up by the commit you've pointed to as a cause.
> I wounder If it's possible that screw up something while removing it? I
> don't see it, but who knows.
> 
> Could you check if revert of fecffad25458 helps?

I tried reverting fecffad25458, plus re-adding a call to pmdp_splitting_flush()
in __split_huge_pmd_locked(), and I could still reproduce the crashes, so I
guess it really isn't related to fast_gup vs. THP splitting.

> 
> And could you share how crashes looks like? I haven't seen backtraces yet.
> 
> > We don't have a _PAGE_PRESENT bit for pmds, so pmd_present() just checks if the
> > entry is not empty. pmd_none() of course does the opposite, it checks if it is
> > empty.
> 
