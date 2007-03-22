Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57F77DDFEA
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 09:52:15 +1100 (EST)
In-Reply-To: <20070322175324.GA21120@lixom.net>
References: <1172872183.5310.145.camel@goblue>
	<20070303232915.GB8028@lixom.net>
	<1174511149.5225.135.camel@goblue>
	<20070322175324.GA21120@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <438dfe13f572740e899f10b6219b6833@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] DMA 4GB boundary protection
Date: Thu, 22 Mar 2007 23:52:02 +0100
To: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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

As a very minor optimisation, avoid reserving the last page
of the I/O window if it ends on a 4GB boundary?


Segher
