Return-Path: <benh@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ABFFA2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 12:00:15 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Sun, 16 Jun 2013 11:46:09 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DCC712CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 12:00:11 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5G1jXa845351000
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 11:45:33 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5G20Bsr002739
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 12:00:11 +1000
Message-ID: <1371348007.21896.62.camel@pasglop>
Subject: Re: [PATCH -V10 00/15] THP support for PPC64
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sun, 16 Jun 2013 12:00:07 +1000
In-Reply-To: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Andrea Arcangeli <aarcange@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-05 at 20:58 +0530, Aneesh Kumar K.V wrote:
> This is the second patchset needed to support THP on ppc64. Some of
> the changes
> included in this series are tricky in that it changes the powerpc
> linux page table
> walk subtly. We also overload few of the pte flags for ptes at PMD
> level (huge
> page PTEs).
> 
> The related mm/ changes are already merged to Andrew's -mm tree.

[Andrea, question for you near the end ]

So I'm trying to understand how you handle races between hash_page
and collapse.

The generic collapse code does:

	_pmd = pmdp_clear_flush(vma, address, pmd);

Which expects the architecture to essentially have stopped any
concurrent walk by the time it returns.

Your implementation of the above does this:

		pmd = *pmdp;
		pmd_clear(pmdp);
		/*
		 * Now invalidate the hpte entries in the range
		 * covered by pmd. This make sure we take a
		 * fault and will find the pmd as none, which will
		 * result in a major fault which takes mmap_sem and
		 * hence wait for collapse to complete. Without this
		 * the __collapse_huge_page_copy can result in copying
		 * the old content.
		 */
		flush_tlb_pmd_range(vma->vm_mm, &pmd, address);

So we clear the pmd after making a copy of it. This will eventually
prevent a tablewalk but only eventually, once that store becomes visible
to other processors, which may take a while. Then you proceed to flush
the hash table for all the underlying PTEs.

So at this point, hash_page might *still* see the old pmd. Unless I
missed something, you did nothing that will prevent that (the only way
to lock against hash_page is really an IPI & wait or to take the PTE's
busy and make them !present or something). So as far as I can tell,
a concurrent hash_page can still sneak into the hash some "small"
entries after you have supposedly flushed them.

In addition, my reading of __collapse_huge_page_isolate() is that it
expects page_young() to be stable at that point, while because of the
above, a concurrent hash_page() might still be setting _PAGE_ACCESSED
(and _PAGE_DIRTY).

So it might be that you have a sneaky way to perform the synchronization
that I have missed :-) But so far I haven't seen it....

Also, a more general question from Andrea. Looking at the code, I was
originally thinking that there is a similar race with dirty. But then
I noticed that the collapse code doesn't look at dirty at all on the sub
pages, it just ignores it. That stroke me as broken until I also noticed
that you seem to always make the THPs dirty....

Is there a reason for that rather than harvesting dirty in the sub pages
and making the THP's dirty the logical OR of the small pages one ?

I understand that anonymous memory is often either zero or dirty, but
I suppose it can be clear with content as well as a result of swap out
and back in, no ? Or is there other reasons why THPs must be dirty
always ?

Cheers,
Ben.
