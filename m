Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 079C7679EB
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Mar 2006 11:07:56 +1100 (EST)
Subject: Re: Unmapping pages from the linear addressing without HIGHMEM support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20006.1142083702@www079.gmx.net>
References: <1142032411.4057.31.camel@localhost.localdomain>
	<20006.1142083702@www079.gmx.net>
Content-Type: text/plain; charset=utf-8
Date: Sun, 12 Mar 2006 11:07:41 +1100
Message-Id: <1142122062.4057.59.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-03-11 at 14:28 +0100, Gerhard Pircher wrote:
> > --- Ursprüngliche Nachricht ---
> > Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > An: Gerhard Pircher <gerhard_pircher@gmx.net>
> > Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> > Betreff: Re: Unmapping pages from the linear addressing
> > without HIGHMEM support
> > Datum: Sat, 11 Mar 2006 10:13:30 +1100
> > 
> > > That would mean I cannot reuse the code in dma-mapping.c, right?
> > > Killing the BAT mappings or limiting the memory size covered by the
> > > BATs seems to be fairly easy, but I guess I have to setup my own page
> > > table for the reserved DMA memory area and implement my own
> > > alloc_pages() function!?
> > 
> > No, just limit the size of the BAT mapping and mark some of the top
> > pages of the address space reserved... That should be enough.
> > 
> Okay, I will try that first. Marking some of the pages as reserved sounds
> like the code you implemented for the uninorth_agp driver with this
> "agp_special_page". I guess I still have to modify the code in dma_mapping.c
> to use the reserved address space for the consistent memory allocation
> (CONSISTENT_BASE, CONSISTENT_END)?

Probably. I'm not sure about that code, I think those
CONSISTENT_BASE/END are only virtual addresses, the code still alocates
real pages below that from anywhere in memory, you may have to change
that, or maybe just 1:1 map that reserved area non-cacheable, and change
dma-mapping.c to not allocate any physical pages but just pick the one
matching the virtual ones it just allocated...;

Ben.
