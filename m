Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB7C01A0048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 21:06:34 +1000 (AEST)
Message-ID: <1442833578.11901.2.camel@kernel.crashing.org>
Subject: Re: [PATCH 18/31] powerpc/mm: Increase the pte frag size.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 21 Sep 2015 21:06:18 +1000
In-Reply-To: <87mvwgduuj.fsf@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442823285.2819.1.camel@kernel.crashing.org>
 <87mvwgduuj.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-21 at 14:15 +0530, Aneesh Kumar K.V wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Mon, 2015-09-21 at 12:10 +0530, Aneesh Kumar K.V wrote:
> > > /*
> > > - * We use a 2K PTE page fragment and another 2K for storing
> > > - * real_pte_t hash index
> > > + * We use a 2K PTE page fragment and another 4K for storing
> > > + * real_pte_t hash index. Rounding the entire thing to 8K
> > >   */
> > 
> > Isn't this a LOT of memory wasted ? Page tables have a non
> > -negligible
> > footprint, we were already wasting half, now we are wasting 3/4 no
> > ?
> > 
> 
> The actual math is, we used to allocate 16 PTE page from a 64K page
> before. We now do 8 pte page from a 64K linux page.

Really ? I remember we were allocating exactly twice more, ie a 64K PTE
page was made of 32K of PTEs and 32K of extensions. I might not be
properly parsing either your above sentence or your comment, the way
you spell it it sounds like you are allocating now even more ...


> > Ie, in most cases on modern machines we never use the other
> > "half"...
> > 
> 
> That is true. We will use this only when we use 4K subpage. But I am
> not sure there is a better solution. Also, we should find this
> slightly
> imporve our contention on ptl lock. With SPLIT_PTLOCK we now have
> less
> number of pte page using the same spin lock.

You keep talking about "number of pte page" ... not sure what that
actually means.

In any case, shouldn't we consider something more like what we do for
subpage protection and just segregate the 4k stuff in a completely
separate tree which we can allocate on-demand so that we don't allocate
any of it if there is no demotion ?

Cheers,
Ben.

> -aneesh
