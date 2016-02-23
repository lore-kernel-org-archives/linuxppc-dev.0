Return-Path: <gerald.schaefer@de.ibm.com>
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FC381A05CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 05:19:18 +1100 (AEDT)
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gerald.schaefer@de.ibm.com>;
 Tue, 23 Feb 2016 18:19:15 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8C73B2190019
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 18:18:56 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1NIJC5V15663336
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 18:19:12 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1NIJ9dn006031
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 11:19:11 -0700
Date: Tue, 23 Feb 2016 19:19:07 +0100
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Kirill A. Shutemov"
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
Message-ID: <20160223191907.25719a4d@thinkpad>
In-Reply-To: <20160223103221.GA1418@node.shutemov.name>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name>
 <56BE00E7.1010303@de.ibm.com> <20160212181640.4eabb85f@thinkpad>
 <20160223103221.GA1418@node.shutemov.name>
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

On Tue, 23 Feb 2016 13:32:21 +0300
"Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> On Fri, Feb 12, 2016 at 06:16:40PM +0100, Gerald Schaefer wrote:
> > On Fri, 12 Feb 2016 16:57:27 +0100
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> > 
> > > > I'm also confused by pmd_none() is equal to !pmd_present() on s390. Hm?
> > > 
> > > Don't know, Gerald or Martin?
> > 
> > The implementation frequently changes depending on how many new bits Martin
> > needs to squeeze out :-)
> > We don't have a _PAGE_PRESENT bit for pmds, so pmd_present() just checks if the
> > entry is not empty. pmd_none() of course does the opposite, it checks if it is
> > empty.
> 
> I still worry about pmd_present(). It looks wrong to me. I wounder if
> patch below makes a difference.
> 
> The theory is that the splitting bit effetely masked bogus pmd_present():
> we had pmd_trans_splitting() in all code path and that prevented mm from
> touching the pmd. Once pmd_trans_splitting() has gone, mm proceed with the
> pmd where it shouldn't and here's a boom.

Well, I don't think pmd_present() == true is bogus for a trans_huge pmd under
splitting, after all there is a page behind the the pmd. Also, if it was
bogus, and it would need to be false, why should it be marked !pmd_present()
only at the pmdp_invalidate() step before the pmd_populate()? It clearly
is pmd_present() before that, on all architectures, and if there was any
problem/race with that, setting it to !pmd_present() at this stage would
only (marginally) reduce the race window.

BTW, PowerPC and Sparc seem to do the same thing in pmdp_invalidate(),
i.e. they do not set pmd_present() == false, only mark it so that it would
not generate a new TLB entry, just like on s390. After all, the function
is called pmdp_invalidate(), and I think the comment in mm/huge_memory.c
before that call is just a little ambiguous in its wording. When it says
"mark the pmd notpresent" it probably means "mark it so that it will not
generate a new TLB entry", which is also what the comment is really about:
prevent huge and small entries in the TLB for the same page at the same
time.

FWIW, and since the ARM arch-list is already on cc, I think there is
an issue with pmdp_invalidate() on ARM, since it also seems to clear
the trans_huge (and formerly trans_splitting) bit, which actually makes
the pmd !pmd_present(), but it violates the other requirement from the
comment:
"the pmd_trans_huge and pmd_trans_splitting must remain set at all times
on the pmd until the split is complete for this pmd"

> 
> I'm not sure that the patch is correct wrt yound/old pmds and I have no
> way to test it...
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 64ead8091248..2eeb17ab68ac 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -490,7 +490,7 @@ static inline int pud_bad(pud_t pud)
> 
>  static inline int pmd_present(pmd_t pmd)
>  {
> -	return pmd_val(pmd) != _SEGMENT_ENTRY_INVALID;
> +	return !(pmd_val(pmd) & _SEGMENT_ENTRY_INVALID);
>  }
> 
>  static inline int pmd_none(pmd_t pmd)

No, that would not work well with young rw and ro pmds. We do now
have an extra free bit in the pmd on s390, after the removal of the
splitting bit, so we could try to implement pmd_present() with that
sw bit, but that would also require several not-so-trivial changes
to the other code in arch/s390/include/asm/pgtable.h.

I'll check with Martin, maybe it is actually trivial, then we can
do a quick test it to rule that one out.
