Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A65DADDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 10:59:10 +1000 (EST)
Date: Wed, 29 Aug 2007 02:59:04 +0200
From: Nick Piggin <npiggin@suse.de>
To: Brent Casavant <bcasavan@sgi.com>
Subject: Re: wmb vs mmiowb
Message-ID: <20070829005904.GB25335@wotan.suse.de>
References: <20070822045714.GD26374@wotan.suse.de>
	<alpine.LFD.0.999.0708221049560.30176@woody.linux-foundation.org>
	<200708221202.12403.jesse.barnes@intel.com>
	<20070823022043.GB18788@wotan.suse.de>
	<alpine.LFD.0.999.0708221953360.30176@woody.linux-foundation.org>
	<20070823042038.GI18788@wotan.suse.de>
	<alpine.LFD.0.999.0708230915000.30176@woody.linux-foundation.org>
	<1187886462.5972.17.camel@localhost.localdomain>
	<20070824030904.GC6989@wotan.suse.de>
	<20070828151737.P5403@pkunk.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828151737.P5403@pkunk.americas.sgi.com>
Cc: linuxppc-dev@ozlabs.org, linux-ia64@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 28, 2007 at 03:56:28PM -0500, Brent Casavant wrote:
> On Fri, 24 Aug 2007, Nick Piggin wrote:
> 
> > And all platforms other than sn2 don't appear to reorder IOs after
> > they leave the CPU, so only sn2 needs to do the mmiowb thing before
> > spin_unlock.
> 
> I'm sure all of the following is already known to most readers, but
> I thought the paragraph above might potentially cause confusion as
> to the nature of the problem mmiowb() is solving on SN2.  So for
> the record...
> 
> SN2 does not reorder IOs issued from a single CPU (that would be
> insane).  Neither does it reorder IOs once they've reached the IO
> fabric (equally insane).  From an individual CPU's perspective, all
> IOs that it issues to a device will arrive at that device in program
> order.

This is why I think mmiowb() is not like a Linux memory barrier.

And I presume that the device would see IOs and regular stores from
a CPU in program order, given the correct wmb()s? (but maybe I'm
wrong... more below).


> (In this entire message, all IOs are assumed to be memory-mapped.)
> 
> The problem mmiowb() helps solve on SN2 is the ordering of IOs issued
> from multiple CPUs to a single device.  That ordering is undefined, as
> IO transactions are not ordered across CPUs.  That is, if CPU A issues
> an IO at time T, and CPU B at time T+1, CPU B's IO may arrive at the
> IO fabric before CPU A's IO, particularly if CPU B happens to be closer
> than CPU B to the target IO bridge on the NUMA network.
> 
> The simplistic method to solve this is a lock around the section
> issuing IOs, thereby ensuring serialization of access to the IO
> device.  However, as SN2 does not enforce an ordering between normal
> memory transactions and memory-mapped IO transactions, you cannot
> be sure that an IO transaction will arrive at the IO fabric "on the
> correct side" of the unlock memory transaction using this scheme.

Hmm. So what if you had the following code executed by a single CPU:

writel(data, ioaddr);
wmb(); 
*mem = 10;

Will the device see the io write before the store to mem?


> Enter mmiowb().
> 
> mmiowb() causes SN2 to drain the pending IOs from the current CPU's
> node.  Once the IOs are drained the CPU can safely unlock a normal
> memory based lock without fear of the unlock's memory write passing
> any outstanding IOs from that CPU.

mmiowb needs to have the disclaimer that it's probably wrong if called
outside a lock, and it's probably wrong if called between two io writes
(need a regular wmb() in that case). I think some drivers are getting
this wrong.
