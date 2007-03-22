Return-Path: <moilanen@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13D75DDF5E
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 04:51:22 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2MHpIqB009210
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 13:51:18 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2MHonI2282860
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 13:50:49 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2MHonYG014888
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 13:50:49 -0400
Subject: Re: [PATCH] DMA 4GB boundary protection
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070322175324.GA21120@lixom.net>
References: <1172872183.5310.145.camel@goblue>
	<20070303232915.GB8028@lixom.net> <1174511149.5225.135.camel@goblue>
	<20070322175324.GA21120@lixom.net>
Content-Type: text/plain
Date: Thu, 22 Mar 2007 12:47:45 -0500
Message-Id: <1174585665.5225.139.camel@goblue>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-03-22 at 12:53 -0500, Olof Johansson wrote:
> On Wed, Mar 21, 2007 at 04:05:48PM -0500, Jake Moilanen wrote:
> 
> > @@ -480,6 +495,21 @@ struct iommu_table *iommu_init_table(str
> >  	ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
> >  #endif
> >  
> > +	/*
> > +	 * DMA cannot cross 4 GB boundary.  Mark first entry of each 4
> > +	 * GB chunk as reserved.
> > +	 */
> > +	if (protect4gb) {
> > +		start_addr = tbl->it_offset << IOMMU_PAGE_SHIFT;
> > +		/* go up to next 4GB boundary */
> > +		start_addr = (start_addr + 0x00000000ffffffffl) >> 32;
> > +		end_addr = (tbl->it_offset + tbl->it_size) << IOMMU_PAGE_SHIFT;
> > +		for (index = start_addr; index < end_addr; index += (1l << 32)) {
> > +			/* Reserve 4GB entry */
> > +			__set_bit((index >> IOMMU_PAGE_SHIFT) - tbl->it_offset,
> > tbl->it_map);
> > +		}
> > +	}
> > +
> 
> 
> This is done a bit more complicated than it has to be. The >> 32 is a
> red flag as well.
> 
> I would also like it to be the last page in the range, not the first
> (since otherwise you'll reserve even if the window is less than 4GB.
> 
> Something like (untested):
> 
> 	entries_per_4g = 0x100000000 >> IOMMU_PAGE_SHIFT;
> 
> 	/* Mark the last bit before a 4GB boundary as used */
> 	start_index = tbl->it_offset | (entries_per_4g - 1);
> 	end_index = tbl->it_offset + tbl->it_size;
> 
> 	for (index = start_index; index < end_index; index += entries_per_4g)
> 		__set_bit(index, tbl->it_map);
> 
> Is easier to follow.

Yup, I like that better.  I'll give it a run.

Jake
