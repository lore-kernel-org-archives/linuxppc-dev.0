Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41E8A67A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 19:04:49 +1000 (EST)
Date: Thu, 9 Jun 2005 10:04:37 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Dan Malek <dan@embeddededge.com>
Message-Id: <20050609100437.7cdef573.ajz@cambridgebroadband.com>
In-Reply-To: <d32482ab845e745a00426671eff86b9e@embeddededge.com>
References: <20050608102938.023f271f.ajz@cambridgebroadband.com>
	<d32482ab845e745a00426671eff86b9e@embeddededge.com>
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

On Wed, 8 Jun 2005 12:12:01 -0400
Dan Malek <dan@embeddededge.com> wrote:

> 
> On Jun 8, 2005, at 5:29 AM, Alex Zeffertt wrote:
> 
> > Does anybody know why it isn't built for 6xx cores?
> 
> Because 6xx cores are cache coherent and there shouldn't
> be any need for "uncached" memory regions.
> 
> > I'm working on the ATM driver and it seems that certain external
> > memory areas accessed by the PQII CPM by-pass the cache.
> 
> That's news to me, and I've written lots of CPM drivers, including
> ATM. Do you have a specific example?
> 

Hi Dan,

An example of non-cache coherency in the CPM2: In the ATM chapter of
the 8260 UM it says that the CPM will only assert GBL and "snoop"
buffers, Buffer Descriptors, and interrupt queues if you set TCT[GBL]
and RCT[GBL].  Presumably this means that it *does not* by-pass the
cache if this flag is not set.  More seriously, for address compression
tables, and external connection tables there is no way of specifying
that it *should* snoop - (which I assume means "use the cache").

I have seen this causing problems.  When I map a VPI/VCI to a connection
table using the address compression table, the first few cells received
do NOT get mapped.  I thought this might be a result of the CPM
by-passing the cache so I added a "flush_dcache_range" after writing to
the address compression tables.  When I did this the problem went away.

With external connection tables the problem is more severe.  During
frame transmission, the core is constantly having to read and write to
the Transmit Connection Table in order to use Auto-VC-ofF.  I couldn't
get this to work until I added lots of "invalidate_dcache_range" and
"flush_dcache_range" calls.  However, doing this is (i) inefficient, and
(ii) *very* error prone.

Alex
