Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B5FB1A0048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 21:55:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 21:55:00 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A6D8B3578054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 21:54:56 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8LBsmh341680968
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 21:54:56 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8LBsO6f022119
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 21:54:24 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 18/31] powerpc/mm: Increase the pte frag size.
In-Reply-To: <1442833578.11901.2.camel@kernel.crashing.org>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442823285.2819.1.camel@kernel.crashing.org>
 <87mvwgduuj.fsf@linux.vnet.ibm.com>
 <1442833578.11901.2.camel@kernel.crashing.org>
Date: Mon, 21 Sep 2015 17:23:57 +0530
Message-ID: <878u80gf8q.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2015-09-21 at 14:15 +0530, Aneesh Kumar K.V wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>> 
>> > On Mon, 2015-09-21 at 12:10 +0530, Aneesh Kumar K.V wrote:
>> > > /*
>> > > - * We use a 2K PTE page fragment and another 2K for storing
>> > > - * real_pte_t hash index
>> > > + * We use a 2K PTE page fragment and another 4K for storing
>> > > + * real_pte_t hash index. Rounding the entire thing to 8K
>> > >   */
>> > 
>> > Isn't this a LOT of memory wasted ? Page tables have a non
>> > -negligible
>> > footprint, we were already wasting half, now we are wasting 3/4 no
>> > ?
>> > 
>> 
>> The actual math is, we used to allocate 16 PTE page from a 64K page
>> before. We now do 8 pte page from a 64K linux page.
>
> Really ? I remember we were allocating exactly twice more, ie a 64K PTE
> page was made of 32K of PTEs and 32K of extensions. I might not be
> properly parsing either your above sentence or your comment, the way
> you spell it it sounds like you are allocating now even more ...
>

That was the case before we did THP. So at that point we had
#define PTE_INDEX_SIZE  12

We changed that to
#define PTE_INDEX_SIZE  8

in commit 419df06eea5bfa815e3a78e0aad6cfb320c1654f
"powerpc: Reduce the PTE_INDEX_SIZE" and also added the concept called
pte fragments inorder to reduce space wastage in
5c1f6ee9a31cbdac90bbb8ae1ba4475031ac74b4 "powerpc: Reduce PTE table
memory wastage "

>
>> > Ie, in most cases on modern machines we never use the other
>> > "half"...
>> > 
>> 
>> That is true. We will use this only when we use 4K subpage. But I am
>> not sure there is a better solution. Also, we should find this
>> slightly
>> imporve our contention on ptl lock. With SPLIT_PTLOCK we now have
>> less
>> number of pte page using the same spin lock.
>
> You keep talking about "number of pte page" ... not sure what that
> actually means.

The page that contain pte entries. Or the last level of the linux page
table. or we could call them pte fragments. We need to allocate one
full page at lowest level, because we want to use split ptlock. Now
for keeping the pte_t entries, we will just be using 2K space. Rest of
the space can be reused. We did that in commit 
5c1f6ee9a31cbdac90bbb8ae1ba4475031ac74b4 . Now all those pmd entries
that have pte page (pte fragments) coming from the same 64K page
will also end up sharing the same ptlock.


>
> In any case, shouldn't we consider something more like what we do for
> subpage protection and just segregate the 4k stuff in a completely
> separate tree which we can allocate on-demand so that we don't allocate
> any of it if there is no demotion ?
>

We could definitely try that. That would mean another set of memory
allocation only for 4K and I was not sure we want that. For
example current subpage protection code path is rarely used and we may
not really be able to find out if we break it.

-aneesh
