Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E24EBDDFB1
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 21:16:00 +1100 (EST)
Date: Wed, 4 Mar 2009 11:15:55 +0100
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 2/2] powerpc: replace isync with lwsync
Message-ID: <20090304101555.GD27043@wotan.suse.de>
References: <20090219171229.GJ1747@wotan.suse.de>
	<20090219172133.GK1747@wotan.suse.de>
	<1236139451.6696.10.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1236139451.6696.10.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 04, 2009 at 03:04:11PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2009-02-19 at 18:21 +0100, Nick Piggin wrote:
> > OK, here is this patch again. You didn't think I'd let a 2% performance
> > improvement be forgotten? :)
> > 
> > Anyway, patch won't work well on architecture without lwsync, but I won't
> > bother fixing that kind of thing and making it merge worthy until you
> > guys say something positive about it.
> > 
> > 20 runs of tbench on the G5
> > 
> > unpatched AVG=920.37 STD=2.36
> >   patched AVG=938.89 STD=3.33
> > 
> > (throughput in MB/s) This is a 1.9% throughput increase.
> 
> Definitely worth it believe. We could use a macro that uses michael new
> improvements on the CPU features code pathing so that the isync gets
> changed to lwsync on some CPUs based on the availability of it.

OK. I guess the interesting part about this is that I can't find any
IBM documentation for lwsync capable CPUs that suggest using this
pattern for acquire locking. It would be interesting to know whether
it helps other CPUs... 
