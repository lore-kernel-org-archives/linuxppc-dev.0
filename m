Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 44BD72C0089
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 16:18:38 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 5 Dec 2013 15:18:35 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E28BE2CE8053
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 16:18:25 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB550Bvm8323528
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Dec 2013 16:00:12 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB55IPvZ032651
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Dec 2013 16:18:25 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>, Mel Gorman <mgorman@suse.de>,
 Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH -V2 3/5] mm: Move change_prot_numa outside
 CONFIG_ARCH_USES_NUMA_PROT_NONE
In-Reply-To: <1386126782.16703.137.camel@pasglop>
References: <1384766893-10189-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1384766893-10189-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1386126782.16703.137.camel@pasglop>
Date: Thu, 05 Dec 2013 10:48:13 +0530
Message-ID: <87a9gfri3u.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mm@kvack.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Adding Mel and Rik to cc:

Benjamin Herrenschmidt <benh@au1.ibm.com> writes:

> On Mon, 2013-11-18 at 14:58 +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> change_prot_numa should work even if _PAGE_NUMA != _PAGE_PROTNONE.
>> On archs like ppc64 that don't use _PAGE_PROTNONE and also have
>> a separate page table outside linux pagetable, we just need to
>> make sure that when calling change_prot_numa we flush the
>> hardware page table entry so that next page access  result in a numa
>> fault.
>
> That patch doesn't look right...
>
> You are essentially making change_prot_numa() do whatever it does (which
> I don't completely understand) *for all architectures* now, whether they
> have CONFIG_ARCH_USES_NUMA_PROT_NONE or not ... So because you want that
> behaviour on powerpc book3s64, you change everybody.
>
> Is that correct ?


Yes. 

>
> Also what exactly is that doing, can you explain ? From what I can see,
> it calls back into the core of mprotect to change the protection to
> vma->vm_page_prot, which I would have expected is already the protection
> there, with the added "prot_numa" flag passed down.

it set the _PAGE_NUMA bit. Now we also want to make sure that when
we set _PAGE_NUMA, we would get a pagefault on that so that we can track
that fault as a numa fault. To ensure that, we had the below BUILD_BUG

	BUILD_BUG_ON(_PAGE_NUMA != _PAGE_PROTNONE);
        

But other than that the function doesn't really have any dependency on
_PAGE_PROTNONE. The only requirement is when we set _PAGE_NUMA, the
architecture should do enough to ensure that we get a page fault. Now on
ppc64 we does that by clearlying hpte entry and also clearing
_PAGE_PRESENT. Since we have _PAGE_PRESENT cleared hash_page will return
1 and we get to page fault handler.

>
> Your changeset comment says "On archs like ppc64 [...] we just need to
> make sure that when calling change_prot_numa we flush the
> hardware page table entry so that next page access  result in a numa
> fault."
>
> But change_prot_numa() does a lot more than that ... it does
> pte_mknuma(), do we need it ? I assume we do or we wouldn't have added
> that PTE bit to begin with...
>
> Now it *might* be allright and it might be that no other architecture
> cares anyway etc... but I need at least some mm folks to ack on that
> patch before I can take it because it *will* change behaviour of other
> architectures.
>

Ok, I can move the changes below #ifdef CONFIG_NUMA_BALANCING ? We call
change_prot_numa from task_numa_work and queue_pages_range(). The later
may be an issue. So doing the below will help ?

-#ifdef CONFIG_ARCH_USES_NUMA_PROT_NONE
+#ifdef CONFIG_NUMA_BALANCING


-aneesh
