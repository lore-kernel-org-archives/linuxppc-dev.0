Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 874BC68A11
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 20:19:42 +1100 (EST)
Date: Wed, 11 Jan 2006 01:19:39 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20060111091939.GD28843@gate.ebshome.net>
References: <17348.35120.840409.283964@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0601102238530.15824-100000@gate.crashing.org>
	<17348.37558.434652.697604@cargo.ozlabs.ibm.com>
	<20060111071032.GA28843@gate.ebshome.net>
	<17348.50913.414568.263736@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17348.50913.414568.263736@cargo.ozlabs.ibm.com>
Cc: linuxppc64-dev@ozlabs.org, Kumar Gala <galak@gate.crashing.org>,
	sjmunroe@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] implement AT_PLATFORM for powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 11, 2006 at 07:50:41PM +1100, Paul Mackerras wrote:
> Eugene Surovegin writes:
> 
> > I checked 44x user manuals I have:
> > 
> > 440GP doesn't have isel
> > 440GX, 440EP, 440SP, 440SPe, 440GR have it.
> 
> Thanks, that's helpful.  Do you know if 440{GX,EP,SP,SPe,GR} implement
> all of the 32-bit user-mode instructions in Book E?

Manuals claim that the following processors implement "... the full, 
32-bit fixed-point subset of the Book-E Enhanced PowerPC Architecture":

440GP, 440GX, 440EP, 440GR, 440SP.

I failed to find similar claim in 440SPe manual, though.

> How do mbar and msync work on those processors?  As mbar and msync (as
> defined in Book E) or as eieio and sync?

Here is an excerpt from user manual (I checked 440GP, 440GX, 440SP, 
440SPe, 440EP, 440GR manuals and they all contain the same text):

	Programming Notes

The msync instruction is execution synchronizing, and guarantees that 
all storage accesses initiated by instructions executed prior to  the 
msync have completed before any instructions after the msync begin 
execution. On the other hand, architecturally the mbar instruction 
merely orders storage accesses, and does not perform execution 
synchronization. Therefore, non-storage access instructions after mbar 
could complete before the storage access instructions which were 
executed prior to mbar have actually completed their storage accesses. 
However, the PPC440xx implements the mbar instruction identically to 
the msync instruction, and thus both are execution synchronizing.

	Architecture Note

mbar replaces the PowerPC eieio instruction. mbar uses the same opcode 
as eieio; PowerPC applications which used eieio will get the function 
of mbar when executed on a PowerPC Book-E implementation. mbar is 
architecturally "stronger" than eieio, in that eieio forced separate 
ordering amongst different categories of storage accesses, while mbar 
forces such ordering amongst all storage accesses as a single category.

msync replaces the PowerPC sync instruction. msync uses the same  
opcode as sync; PowerPC applications which used sync get the function 
of msync when executed on a PowerPC Book-E implementation. msync is 
architecturally identical to the version of sync specified by an  
earlier version of the PowerPC architecture.

> Do the 440* processors in fact claim Book E compliance?

Hmm, cannot tell :).

-- 
Eugene
