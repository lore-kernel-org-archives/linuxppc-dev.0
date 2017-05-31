Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ua0-x22c.google.com (mail-ua0-x22c.google.com
 [IPv6:2607:f8b0:400c:c08::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdKc9264czDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 05:02:49 +1000 (AEST)
Received: by mail-ua0-x22c.google.com with SMTP id u10so15049320uaf.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 12:02:49 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <alpine.LSU.2.11.1705311112290.1839@eggly.anvils>
References: <alpine.LSU.2.11.1705301151090.2133@eggly.anvils>
 <87h9014j7t.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1705310906570.14920@east.gentwo.org>
 <alpine.LSU.2.11.1705311112290.1839@eggly.anvils>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 31 May 2017 21:02:25 +0200
Message-ID: <CA+7wUswSJ5-Ck1u9gWbCskBA2NsE9e=u+m0Us-4wBYwDwYxjZA@mail.gmail.com>
Subject: Re: 4.12-rc ppc64 4k-page needs costly allocations
To: Hugh Dickins <hughd@google.com>
Cc: Christoph Lameter <cl@linux.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 31, 2017 at 8:44 PM, Hugh Dickins <hughd@google.com> wrote:
> [ Merging two mails into one response ]
>
> On Wed, 31 May 2017, Christoph Lameter wrote:
>> On Tue, 30 May 2017, Hugh Dickins wrote:
>> > SLUB: Unable to allocate memory on node -1, gfp=0x14000c0(GFP_KERNEL)
>> >   cache: pgtable-2^12, object size: 32768, buffer size: 65536, default order: 4, min order: 4
>> >   pgtable-2^12 debugging increased min order, use slub_debug=O to disable.
>>
>> > I did try booting with slub_debug=O as the message suggested, but that
>> > made no difference: it still hoped for but failed on order:4 allocations.
>>
>> I am curious as to what is going on there. Do you have the output from
>> these failed allocations?
>
> I thought the relevant output was in my mail.  I did skip the Mem-Info
> dump, since that just seemed noise in this case: we know memory can get
> fragmented.  What more output are you looking for?
>
>>
>> > I wanted to try removing CONFIG_SLUB_DEBUG, but didn't succeed in that:
>> > it seemed to be a hard requirement for something, but I didn't find what.
>>
>> CONFIG_SLUB_DEBUG does not enable debugging. It only includes the code to
>> be able to enable it at runtime.
>
> Yes, I thought so.
>
>>
>> > I did try CONFIG_SLAB=y instead of SLUB: that lowers these allocations to
>> > the expected order:3, which then results in OOM-killing rather than direct
>> > allocation failure, because of the PAGE_ALLOC_COSTLY_ORDER 3 cutoff.  But
>> > makes no real difference to the outcome: swapping loads still abort early.
>>
>> SLAB uses order 3 and SLUB order 4??? That needs to be tracked down.
>>
>> Ahh. Ok debugging increased the object size to an order 4. This should be
>> order 3 without debugging.
>
> But it was still order 4 when booted with slub_debug=O, which surprised me.
> And that surprises you too?  If so, then we ought to dig into it further.
>
>>
>> Why are the slab allocators used to create slab caches for large object
>> sizes?
>
> There may be more optimal ways to allocate, but I expect that when
> the ppc guys are writing the code to handle both 4k and 64k page sizes,
> kmem caches offer the best span of possibility without complication.
>
>>
>> > Relying on order:3 or order:4 allocations is just too optimistic: ppc64
>> > with 4k pages would do better not to expect to support a 128TB userspace.
>>
>> I thought you had these huge 64k page sizes?
>
> ppc64 does support 64k page sizes, and they've been the default for years;
> but since 4k pages are still supported, I choose to use those (I doubt
> I could ever get the same load going with 64k pages).

4k is pretty much required on ppc64 when it comes to nouveau:

https://bugs.freedesktop.org/show_bug.cgi?id=94757

2cts
