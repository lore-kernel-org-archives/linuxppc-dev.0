Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45A3967B64
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 20:11:23 +1000 (EST)
Date: Fri, 10 Jun 2005 11:11:09 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Dan Malek <dan@embeddededge.com>
Message-Id: <20050610111109.09f8ac46.ajz@cambridgebroadband.com>
In-Reply-To: <fca77c4d1cd82ed8cfec528acdb6c2cb@embeddededge.com>
References: <20050608102938.023f271f.ajz@cambridgebroadband.com>
	<d32482ab845e745a00426671eff86b9e@embeddededge.com>
	<20050609100437.7cdef573.ajz@cambridgebroadband.com>
	<fca77c4d1cd82ed8cfec528acdb6c2cb@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi Dan,


> 
> You need to be more clear with your terms.  Only the 60x core
> "uses" the cache.  The CPM is a DMA device that can utilize
> cache coherency protocols if you enable that with the GBL flags.
> 


Ah, I see.  If the CPM DMA is configured to "snoop" the cache then that
doesn't mean it "uses" the cache - it just tells the cache when data
needs to flush - namely before DMA writes.

> > I have seen this causing problems.  When I map a VPI/VCI to a 
> > connection
> > table using the address compression table,
> 
> Where are you placing the VP-level and VC-level tables?  I assume
> you are properly configuring the GMODE to indicate their locations?
> Does it work properly if the tables are in DP RAM?
> 


I've got the VP-level tables in DPRAM (as recommended by the UM) and the
VC-level tables in external memory (as required by UM).  The EVPT bit in
GMODE is cleared to indicate VP tables in DPRAM.

The first few cells received after writing the mapping are
definitely going to the raw cell queue.  This doesn't happen if I flush
the cache line following core writes to the VC-level table.  This
suggests to me that the CPM DMA is not employing the cache coherency
protocol when accessing the address compression tables.  This is not a
surprise since the UM only claims to be able to do "snooping" for
buffers, BDs, and interrupt tables.



> > With external connection tables the problem is more severe.
> 
> There are some very subtle assumptions made by the ATM
> controller regarding all channel data structures.  There aren't
> configuration location flags for every level of table, and assumptions
> are made that tables for a connection are either internal or
> external.  Be careful with that.  I either entirely use DP RAM for
> everything or external memory for everything, which seemed
> to work for me in the past.  Maybe I was just lucky :-)


The UM definitely claims you can have a mixture of internal channels and
external channels.  If you want a lot of simultaneous channels open you
are forced to use both since the number of internal channels is limited
by (a) the amount of DPRAM available, and (b) the design limit of 256.

> 
> > ....  During
> > frame transmission, the core is constantly having to read and write
> > to the Transmit Connection Table in order to use Auto-VC-ofF.  I
> > couldn't get this to work until I added lots of
> > "invalidate_dcache_range" and"flush_dcache_range" calls.
> 
> Are you sure this is really a cache problem and not a race condition
> with CPM access to the CTs?  The CPM does atomic burst read/write
> of the RCT/TCT entries, and buy doing cache flush operations, the
> 60x core does the same.
> 

Well it looks to me that for address compression tables and external
connection tables the CPM DMA is not employing it's cache coherency
mechanisms.  This mechanism probably just boils down to the CPM saying
to the cache "I want to write to ptr, please flush any pending writes
then invalidate the line".  By adding calls to
flush/invalidate_dcache_range in my code I am doing the cache coherency
mechanism in software instead.  It would be a lot easier though if I
could just allocate uncached memory....


Thanks for your help,

Alex
