Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A5258DE293
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 09:18:56 +1100 (EST)
Date: Thu, 25 Jan 2007 13:55:15 -0800 (PST)
Message-Id: <20070125.135515.106769311.davem@davemloft.net>
To: greg@kroah.com
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070125215307.GB3126@kroah.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125215307.GB3126@kroah.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: kyle@parisc-linux.org, linuxppc-dev@ozlabs.org, brice@myri.com,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	ebiederm@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Greg KH <greg@kroah.com>
Date: Thu, 25 Jan 2007 13:53:07 -0800

> On Thu, Jan 25, 2007 at 07:34:07PM +1100, Michael Ellerman wrote:
> > OK, here's a first cut at moving ops based MSI into the generic code. I'm
> > posting this now to make sure I'm not heading off into the weeds.
> > 
> > The fifth patch contain the guts of it, I've included the MPIC and
> > RTAS backends as examples. In fact they actually work.
> > 
> > In order to smoothly merge this with the old MSI code, the two will need to
> > coexist in the tree for at least a few commits, so I've added (invisible)
> > Kconfig symbols to allow that.
> > 
> > I plan to merge the Intel code by:
> >  * copying it into drivers/pci/msi/intel.c with zero changes.
> >  * providing a minimal shim to connect the ops code to the intel code.
> >  * at this point the code should be functional but ugly as hell.
> >  * via a longish series of patches, adapt the intel code to better match
> >    the new ops code.
> >  * this should allow us to bisect through to find any mistakes.
> > 
> > If people think that's crazy and or stupid please let me know :)
> 
> At first glance, this looks sane.  I'll apply the first 4 patches to my
> trees, and hold off on the rest until you have the intel patches
> finished.

I'll also look into a sparc64 implementation as soon as I find the
time.
