Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E638067B3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 05:05:58 +1000 (EST)
In-Reply-To: <20050609100437.7cdef573.ajz@cambridgebroadband.com>
References: <20050608102938.023f271f.ajz@cambridgebroadband.com>
	<d32482ab845e745a00426671eff86b9e@embeddededge.com>
	<20050609100437.7cdef573.ajz@cambridgebroadband.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fca77c4d1cd82ed8cfec528acdb6c2cb@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 9 Jun 2005 15:05:51 -0400
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: consistent_alloc() on 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 9, 2005, at 5:04 AM, Alex Zeffertt wrote:

> An example of non-cache coherency in the CPM2: In the ATM chapter of
> the 8260 UM it says that the CPM will only assert GBL and "snoop"
> buffers, Buffer Descriptors, and interrupt queues if you set TCT[GBL]
> and RCT[GBL].

Right.

> ... Presumably this means that it *does not* by-pass the
> cache if this flag is not set.

It means just what it says.  If this flag is set, CPM DMA will
snoop the cache.  If you choose not to do this, you have to
maintain cache coherency through software.

>  ..... More seriously, for address compression
> tables, and external connection tables there is no way of specifying
> that it *should* snoop - (which I assume means "use the cache").

You need to be more clear with your terms.  Only the 60x core
"uses" the cache.  The CPM is a DMA device that can utilize
cache coherency protocols if you enable that with the GBL flags.

> I have seen this causing problems.  When I map a VPI/VCI to a 
> connection
> table using the address compression table,

Where are you placing the VP-level and VC-level tables?  I assume
you are properly configuring the GMODE to indicate their locations?
Does it work properly if the tables are in DP RAM?

> With external connection tables the problem is more severe.

There are some very subtle assumptions made by the ATM
controller regarding all channel data structures.  There aren't
configuration location flags for every level of table, and assumptions
are made that tables for a connection are either internal or
external.  Be careful with that.  I either entirely use DP RAM for
everything or external memory for everything, which seemed
to work for me in the past.  Maybe I was just lucky :-)

> ....  During
> frame transmission, the core is constantly having to read and write to
> the Transmit Connection Table in order to use Auto-VC-ofF.  I couldn't
> get this to work until I added lots of "invalidate_dcache_range" and
> "flush_dcache_range" calls.

Are you sure this is really a cache problem and not a race condition
with CPM access to the CTs?  The CPM does atomic burst read/write
of the RCT/TCT entries, and buy doing cache flush operations, the
60x core does the same.


Thanks.


	-- Dan
