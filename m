Return-Path: <hughd@google.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdKCf62jYzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 04:45:02 +1000 (AEST)
Received: by mail-pf0-x230.google.com with SMTP id m17so14840509pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 11:45:02 -0700 (PDT)
Date: Wed, 31 May 2017 11:44:52 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Christoph Lameter <cl@linux.com>
cc: Michael Ellerman <mpe@ellerman.id.au>, Hugh Dickins <hughd@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: 4.12-rc ppc64 4k-page needs costly allocations
In-Reply-To: <alpine.DEB.2.20.1705310906570.14920@east.gentwo.org>
Message-ID: <alpine.LSU.2.11.1705311112290.1839@eggly.anvils>
References: <alpine.LSU.2.11.1705301151090.2133@eggly.anvils>
 <87h9014j7t.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1705310906570.14920@east.gentwo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ Merging two mails into one response ]

On Wed, 31 May 2017, Christoph Lameter wrote:
> On Tue, 30 May 2017, Hugh Dickins wrote:
> > SLUB: Unable to allocate memory on node -1, gfp=0x14000c0(GFP_KERNEL)
> >   cache: pgtable-2^12, object size: 32768, buffer size: 65536, default order: 4, min order: 4
> >   pgtable-2^12 debugging increased min order, use slub_debug=O to disable.
> 
> > I did try booting with slub_debug=O as the message suggested, but that
> > made no difference: it still hoped for but failed on order:4 allocations.
> 
> I am curious as to what is going on there. Do you have the output from
> these failed allocations?

I thought the relevant output was in my mail.  I did skip the Mem-Info
dump, since that just seemed noise in this case: we know memory can get
fragmented.  What more output are you looking for?

> 
> > I wanted to try removing CONFIG_SLUB_DEBUG, but didn't succeed in that:
> > it seemed to be a hard requirement for something, but I didn't find what.
> 
> CONFIG_SLUB_DEBUG does not enable debugging. It only includes the code to
> be able to enable it at runtime.

Yes, I thought so.

> 
> > I did try CONFIG_SLAB=y instead of SLUB: that lowers these allocations to
> > the expected order:3, which then results in OOM-killing rather than direct
> > allocation failure, because of the PAGE_ALLOC_COSTLY_ORDER 3 cutoff.  But
> > makes no real difference to the outcome: swapping loads still abort early.
> 
> SLAB uses order 3 and SLUB order 4??? That needs to be tracked down.
> 
> Ahh. Ok debugging increased the object size to an order 4. This should be
> order 3 without debugging.

But it was still order 4 when booted with slub_debug=O, which surprised me.
And that surprises you too?  If so, then we ought to dig into it further.

> 
> Why are the slab allocators used to create slab caches for large object
> sizes?

There may be more optimal ways to allocate, but I expect that when
the ppc guys are writing the code to handle both 4k and 64k page sizes,
kmem caches offer the best span of possibility without complication.

> 
> > Relying on order:3 or order:4 allocations is just too optimistic: ppc64
> > with 4k pages would do better not to expect to support a 128TB userspace.
> 
> I thought you had these huge 64k page sizes?

ppc64 does support 64k page sizes, and they've been the default for years;
but since 4k pages are still supported, I choose to use those (I doubt
I could ever get the same load going with 64k pages).

Hugh
