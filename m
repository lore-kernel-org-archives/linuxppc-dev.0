Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0118.outbound.protection.outlook.com [207.46.100.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 766AB1A1E57
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 13:08:47 +1000 (AEST)
Message-ID: <1441163312.4966.145.camel@freescale.com>
Subject: Re: [PATCH V7 1/3] genalloc:support memory-allocation with
 bytes-alignment to genalloc
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xie Xiaobo-R63061
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Yang-Leo-R58472 <LeoLi@freescale.com>, "paulus@samba.org"
 <paulus@samba.org>
Date: Tue, 1 Sep 2015 22:08:32 -0500
In-Reply-To: <SN1PR0301MB155067ACD55BCDED1768F8E29B690@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1441011520-15424-1-git-send-email-qiang.zhao@freescale.com>
 <1441153816.4966.109.camel@freescale.com>
 <SN1PR0301MB1550752EBCD1B8DECF06483A9B690@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1441160299.4966.122.camel@freescale.com>
 <SN1PR0301MB1550A4CF93D8FA91377DD3F09B690@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1441161203.4966.126.camel@freescale.com>
 <SN1PR0301MB155067ACD55BCDED1768F8E29B690@SN1PR0301MB1550.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-09-01 at 22:05 -0500, Zhao Qiang-B45475 wrote:
> On Wed, 2015-09-02 at 10:33AM -0500, Wood Scott-B07421 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, September 02, 2015 10:33 AM
> > To: Zhao Qiang-B45475
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> > Yang-Leo-R58472; paulus@samba.org
> > Subject: Re: [PATCH V7 1/3] genalloc:support memory-allocation with
> > bytes-alignment to genalloc
> > 
> > On Tue, 2015-09-01 at 21:29 -0500, Zhao Qiang-B45475 wrote:
> > > On Wed, 2015-09-02 at 10:18AM -0500, Wood Scott-B07421 wrote:
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Wednesday, September 02, 2015 10:18 AM
> > > > To: Zhao Qiang-B45475
> > > > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > > > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org;
> > > > Li Yang-Leo-R58472; paulus@samba.org
> > > > Subject: Re: [PATCH V7 1/3] genalloc:support memory-allocation with
> > > > bytes-alignment to genalloc
> > > > 
> > > > On Tue, 2015-09-01 at 21:10 -0500, Zhao Qiang-B45475 wrote:
> > > > > On Wed, 2015-09-02 at 08:38AM +0800, Wood Scott-B07421 wrote:
> > > > > > -----Original Message-----
> > > > > > From: Wood Scott-B07421
> > > > > > Sent: Wednesday, September 02, 2015 8:30 AM
> > > > > > To: Zhao Qiang-B45475
> > > > > > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > > > > > lauraa@codeaurora.org; Xie Xiaobo-R63061;
> > > > > > benh@kernel.crashing.org; Li Yang-Leo-R58472; paulus@samba.org
> > > > > > Subject: Re: [PATCH V7 1/3] genalloc:support memory-allocation
> > > > > > with bytes-alignment to genalloc
> > > > > > 
> > > > > > On Mon, 2015-08-31 at 16:58 +0800, Zhao Qiang wrote:
> > > > > > > Bytes alignment is required to manage some special RAM, so add
> > > > > > > gen_pool_first_fit_align to genalloc, meanwhile add
> > > > > > > gen_pool_alloc_data to pass data to
> > > > > > > gen_pool_first_fit_align(modify gen_pool_alloc as a wrapper)
> > > > > > > 
> > > > > > > Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
> > > > > > > ---
> > > > > > > Changes for v6:
> > > > > > >       - patches set v6 include a new patch because of using
> > > > > > >       - genalloc to manage QE MURAM, patch 0001 is the new
> > > > > > >       - patch, adding bytes alignment for allocation for use.
> > > > > > > Changes for v7:
> > > > > > >       - cpm muram also need to use genalloc to manage, it has
> > > > > > >         a function to reserve a specific region of muram,
> > > > > > >         add offset to genpool_data for start addr to be
> > allocated.
> > > > > > 
> > > > > > This seems to be describing more than just the changes in this
> > patch.
> > > > > > What does also handling cpm have to do with this patch?  Are you
> > > > > > adding support for reserving a specific region in this patch?  I
> > > > > > don't see it, and in any case it should go in a different patch.
> > > > > 
> > > > > Yes, I added. The code below can support the function.
> > > > >       offset_bit = (alignment->offset + (1UL << order) - 1) >>
> > order;
> > > > >       return bitmap_find_next_zero_area(map, size, start +
> > > > > offset_bit,
> > > > nr,
> > > > >                         align_mask);
> > > > > 
> > > > > CPM has an function cpm_muram_alloc_fixed, needing to allocate
> > > > > muram from a Specific offset. So I add the code and add offset to
> > struct data.
> > > > 
> > > > I thought the offset was related to the previous discussion of
> > > > checking for allocation failure.  Are you using it to implement
> > > > alloc_fixed()?  If so, please don't.  Besides the awkward
> > > > implementation (what does it logically have to do with
> > > > gen_pool_first_fit_align?), it does not appear to be correct -
> > > > - what happens with multiple chunks?  What happens if part of the
> > > > region the caller is trying to reserve is already taken?  Implement
> > > > a proper function to reserve a fixed genalloc region.
> > > 
> > > This offset is totally different with the workaround OFFSET!
> > 
> > There's a reason why we write changelogs that describe what the patch is
> > doing, and avoid combining logically distinct changes in the same patch.
> > 
> > > This offset is the offset of the muram.
> > 
> > The offset of the muram relative to what?  Or do you mean the offset into
> > muram?
> 
> Yes, the offset into muram.
> 
> > 
> > > CPM need to allocate block from a specific offset due to hardware
> > > restriction.
> > > So I must handle this offset in genalloc.
> > 
> > Again, if you need to be able to mark a specific range reserved, add a
> > function that does that properly.  Don't try to hack it in the way you
> > did.
> 
> Add a function? Do you mean add a new alloc function or new algo?
> If you mean new algo, CPM use both align algo and new algo, set 
> Different algos in different muram_alloc func? 

I was thinking that it was a sufficiently different operation that it 
warranted its own independent function, but I suppose you could do it as an 
algorithm that only accepts the requested range and returns failure for all 
other chunks (as well as if the range is unavailable).  It would not be 
related at all to the aligned-alloc algorithm.

-Scott
