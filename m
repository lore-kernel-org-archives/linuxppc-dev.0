Return-Path: <sowmini.varadhan@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 450021A2B09
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 10:19:53 +1100 (AEDT)
Date: Mon, 23 Mar 2015 19:19:43 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Generic IOMMU pooled allocator
Message-ID: <20150323231943.GC21966@oracle.com>
References: <20150322192726.GB19474@oracle.com>
 <20150323.122922.887448418154237329.davem@davemloft.net>
 <20150323165406.GG14061@oracle.com>
 <20150323.150508.149509757161802782.davem@davemloft.net>
 <1427150202.4770.248.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427150202.4770.248.camel@kernel.crashing.org>
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (03/24/15 09:36), Benjamin Herrenschmidt wrote:
> 
>  - One pool only
> 
>  - Whenever the allocation is before the previous hint, do a flush, that
> should only happen if a wrap around occurred or in some cases if the
> device DMA mask forced it. I think we always update the hint whenever we
> successfully allocate from the small pools.

right, I believe this is close to what I discussed in the previous
thread, and approx what I have in patchv5, except that the flush 
indirection can be passed as a function pointer, or via the table_ops.

> 
>  - Deal with the largealloc case. That's the contentious issue, see
> below.
  :
> The largealloc issue is a different can of worms. We can try adding an
> option to disable the largealloc business completely (instead of hard
> wiring the "15", make that a variable and define that 0 means no
> largealloc pool).

What I've tried to do is to have a bool large_pool arg passed
to iommu_tbl_pool_init. In my observation (instrumented for scsi, ixgbe), 
we never allocate more than 4 pages at a time, so I pass in 
large_pool == false for all the sparc platforms. 

> Or we can decide that large allocs are rare (typically
> pci_alloc_consistent, ie, driver init time), and thus always flush on
> them (or rather on free of a large chunk). David, what's your take
> there ? I have a feeling that should work fine without a noticeable
> performance issue...
> 
> I would also keep a "dirty" flag set on any free and cleared on any
> flush to avoid more spurrious flushes, but here too the benefit might be
> in the noise.
