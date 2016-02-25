Return-Path: <steve.capper@linaro.org>
Received: from mail-ig0-x22f.google.com (mail-ig0-x22f.google.com
 [IPv6:2607:f8b0:4001:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA1341A0342
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 02:49:36 +1100 (AEDT)
Received: by mail-ig0-x22f.google.com with SMTP id y8so17120413igp.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 07:49:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160223184658.GA27281@arm.com>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name>
 <56BE00E7.1010303@de.ibm.com> <20160212181640.4eabb85f@thinkpad>
 <20160223103221.GA1418@node.shutemov.name>
 <20160223191907.25719a4d@thinkpad> <20160223184658.GA27281@arm.com>
Date: Thu, 25 Feb 2016 15:49:33 +0000
Message-ID: <CAPvkgC3gfmgA9aCvCeqReKhjpkT5Y-qk-2fNO8puDjUs9EWzVw@mail.gmail.com>
Subject: Re: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
From: Steve Capper <steve.capper@linaro.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Catalin Marinas <catalin.marinas@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 Steve Capper <steve.capper@arm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23 February 2016 at 18:47, Will Deacon <will.deacon@arm.com> wrote:
> [adding Steve, since he worked on THP for 32-bit ARM]

Apologies for my late reply...

>
> On Tue, Feb 23, 2016 at 07:19:07PM +0100, Gerald Schaefer wrote:
>> On Tue, 23 Feb 2016 13:32:21 +0300
>> "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
>> > The theory is that the splitting bit effetely masked bogus pmd_present():
>> > we had pmd_trans_splitting() in all code path and that prevented mm from
>> > touching the pmd. Once pmd_trans_splitting() has gone, mm proceed with the
>> > pmd where it shouldn't and here's a boom.
>>
>> Well, I don't think pmd_present() == true is bogus for a trans_huge pmd under
>> splitting, after all there is a page behind the the pmd. Also, if it was
>> bogus, and it would need to be false, why should it be marked !pmd_present()
>> only at the pmdp_invalidate() step before the pmd_populate()? It clearly
>> is pmd_present() before that, on all architectures, and if there was any
>> problem/race with that, setting it to !pmd_present() at this stage would
>> only (marginally) reduce the race window.
>>
>> BTW, PowerPC and Sparc seem to do the same thing in pmdp_invalidate(),
>> i.e. they do not set pmd_present() == false, only mark it so that it would
>> not generate a new TLB entry, just like on s390. After all, the function
>> is called pmdp_invalidate(), and I think the comment in mm/huge_memory.c
>> before that call is just a little ambiguous in its wording. When it says
>> "mark the pmd notpresent" it probably means "mark it so that it will not
>> generate a new TLB entry", which is also what the comment is really about:
>> prevent huge and small entries in the TLB for the same page at the same
>> time.
>>
>> FWIW, and since the ARM arch-list is already on cc, I think there is
>> an issue with pmdp_invalidate() on ARM, since it also seems to clear
>> the trans_huge (and formerly trans_splitting) bit, which actually makes
>> the pmd !pmd_present(), but it violates the other requirement from the
>> comment:
>> "the pmd_trans_huge and pmd_trans_splitting must remain set at all times
>> on the pmd until the split is complete for this pmd"
>
> I've only been testing this for arm64 (where I'm yet to see a problem),
> but we use the generic pmdp_invalidate implementation from
> mm/pgtable-generic.c there. On arm64, pmd_trans_huge will return true
> after pmd_mknotpresent. On arm, it does look to be buggy, since it nukes
> the entire entry... Steve?

pmd_mknotpresent on arm looks inconsistent with the other
architectures and can be changed.

Having had a look at the usage, I can't see it causing an immediate
problem (that needs to be addressed by an emergency patch).
We don't have a notion of splitting pmds (so there is no splitting
information to lose), and the only usage I could see of
pmd_mknotpresent was:

pmdp_invalidate(vma, haddr, pmd);
pmd_populate(mm, pmd, pgtable);

In mm/huge_memory.c, around line 3588.

So we invalidate the entry (which puts down a faulting entry from
pmd_mknotpresent and invalidates tlb), then immediately put down a
table entry with pmd_populate.

I have run a 32-bit ARM test kernel and exacerbated THP splits (that's
what took me time), and I didn't notice any problems with 4.5-rc5.

Cheers,
-- 
Steve

>
> Will
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
