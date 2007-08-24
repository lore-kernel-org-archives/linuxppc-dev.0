Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (ns1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44522DDE43
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 13:13:02 +1000 (EST)
Date: Fri, 24 Aug 2007 05:12:57 +0200
From: Nick Piggin <npiggin@suse.de>
To: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: wmb vs mmiowb
Message-ID: <20070824031257.GD6989@wotan.suse.de>
References: <20070822045714.GD26374@wotan.suse.de>
	<alpine.LFD.0.999.0708221049560.30176@woody.linux-foundation.org>
	<1187854035.5972.4.camel@localhost.localdomain>
	<200708230956.17049.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200708230956.17049.jesse.barnes@intel.com>
Cc: linux-ia64@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 23, 2007 at 09:56:16AM -0700, Jesse Barnes wrote:
> On Thursday, August 23, 2007 12:27 am Benjamin Herrenschmidt wrote:
> > > Of course, the normal memory barrier would usually be a
> > > "spin_unlock()" or something like that, not a "wmb()". In fact, I
> > > don't think the powerpc implementation (as an example of this) will
> > > actually synchronize with anything *but* a spin_unlock().
> >
> > We are even more sneaky in the sense that we set a per-cpu flag on
> > any MMIO write and do the sync automatically in spin_unlock() :-)
> 
> Yeah, that's a reasonable thing to do, and in fact I think there's code 
> to do something similar when a task is switched out (this keeps user 
> level drivers from having do mmiowb() type things).

It might be worth doing that and removing mmiowb completely. Or, if
that's too expensive, I'd like to see an API that is more explicitly
for keeping IOs inside critical sections.


> FWIW, I think I had an earlier version of the patch that used the name 
> pioflush() or something similar, the only confusing thing about that 
> name is that the primitive doesn't actually force I/Os down to the 
> device level, just to the closest bridge.

Yeah, that's what I found when trying to think of a name ;) It is
like an intermediate-level flush for the platform code, but from the
POV of the driver writer, it is nothing of the sort ;)
 
