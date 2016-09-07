Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTWfx6GTSzDrpv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 15:07:21 +1000 (AEST)
Date: Wed, 7 Sep 2016 15:07:14 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 3/3] powerpc/mm: Speed up computation of base and actual
 page size for a HPTE
Message-ID: <20160907050714.GB21443@fergus.ozlabs.ibm.com>
References: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
 <20160902115055.GC12433@fergus.ozlabs.ibm.com>
 <877farq6nj.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <877farq6nj.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 05, 2016 at 10:34:16AM +0530, Aneesh Kumar K.V wrote:
> > +static void init_hpte_page_sizes(void)
> > +{
> > +	long int ap, bp;
> > +	long int shift, penc;
> > +
> > +	for (bp = 0; bp < MMU_PAGE_COUNT; ++bp) {
> > +		if (!mmu_psize_defs[bp].shift)
> > +			continue;	/* not a supported page size */
> > +		for (ap = bp; ap < MMU_PAGE_COUNT; ++ap) {
> > +			penc = mmu_psize_defs[bp].penc[ap];
> > +			if (penc == -1)
> > +				continue;
> > +			shift = mmu_psize_defs[ap].shift - LP_SHIFT;
> > +			if (shift <= 0)
> > +				continue;	/* should never happen */
> > +			while (penc < (1 << LP_BITS)) {
> > +				hpte_page_sizes[penc] = (ap << 4) | bp;
> > +				penc += 1 << shift;
> > +			}
> > +		}
> > +	}
> > +}
> > +
> 
> Going through this again, it is confusing . How are we differentiating
> between the below penc values
> 
>  0000 000z		>=8KB (z = 1)
>  0000 zzzz		>=64KB (zzzz = 0001)
> 
> Those are made up 'z' values.

That wouldn't be a valid set of page encodings.  If the page encoding
for 8kB pages is z=1 then then encodings for all larger page sizes
would have to have the least significant bit be a 0.  In fact none of
the POWER processors has an 8kB page size; the smallest implemented
large page size is 64kB.  Consequently the first level of decoding of
the page size on these CPUs can look at the bottom 4 bits.

The 00000000 encoding is used for 16MB pages, because 16MB was the
first large page size implemented back in the POWER4+ days, and there
was no page size field at that time, so these 8 bits were reserved and
set to zero by OSes at that time.  For compatibility, the 00000000
encoding continues to be used, so the encodings for other page sizes
always have at least one 1 in the zzzz bits.

Paul.
