Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7FD22DDEC8
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2007 01:41:23 +1000 (EST)
Date: Wed, 28 Mar 2007 10:56:35 -0500
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH] DMA 4GB boundary protection
Message-ID: <20070328155635.GA14356@lixom.net>
References: <1172872183.5310.145.camel@goblue>
	<20070303232915.GB8028@lixom.net>
	<1174511149.5225.135.camel@goblue>
	<20070322175324.GA21120@lixom.net>
	<1175026241.1398.23.camel@goblue>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1175026241.1398.23.camel@goblue>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2007 at 03:10:41PM -0500, Jake Moilanen wrote:

> I just had to realign the start_index in case it didn't start at a 4GB
> boundary.  Other than that, it worked like a champ.  I also changed to
> for loop to exit if it's the last entry.

Hmm. See below.

> +	/*
> +	 * DMA cannot cross 4 GB boundary.  Mark last entry of each 4
> +	 * GB chunk as reserved.
> +	 */
> +	if (protect4gb) {
> +		entries_per_4g = 0x100000000l >> IOMMU_PAGE_SHIFT;
> +
> +		/* Mark the last bit before a 4GB boundary as used */
> +		start_index = (tbl->it_offset << IOMMU_PAGE_SHIFT) >> 32;
> +		start_index |= (entries_per_4g - 1);

This looks broken.

The idea is to make start_index the last page before the first 4GB
boundary after it_offset. If that happens to be beyond end_index the
for loop below will never run. If it's below that, every last page in
the 4GB ranges will be marked in the loop. This will work even if the
table starts at i.e. 2GB and goes until 10GB.

With the first line above, your start_index will always be 0xfffff
(unless the offset is waay up there in the address space).

The logic I had was:

	start_index = tbl->it_offset | (entries_per_4g - 1);                                                                                   

This is also broken, since it doesn't consider it_offset in the loop
below. That was my bad, and I guess was what you tried to fix above.

What you really want is:
	
	start_index = tbl->it_offset | (entries_per_4g - 1);                                                                                   
	start_index -= tbl->it_offset;

	end_index = tbl->it_size;

Say that it_offset is at 3GB, with 4KB pages that means the value is
0xc0000. entries_per_4g is 0x100000, i.e. the logic becomes: 0xc0000 |
0xfffff = 0xfffff (- 0xc0000 = 0x3ffff), which indeed is the last page
before 4GB.

If it_offset is at 9GB, i.e. 0x240000, then we get start_index at 0x2fffff
(- 0x240000 = 0xbffff) , i.e. yet again last page before the 12GB wrap.

> +
> +		end_index = tbl->it_offset + tbl->it_size;
> +
> +		for (index = start_index; index < end_index - 1; index +=
> entries_per_4g)
> +			__set_bit(index, tbl->it_map);


-Olof
