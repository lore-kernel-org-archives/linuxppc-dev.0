Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0ABB4DDF38
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 13:54:54 +1000 (EST)
Date: Thu, 23 Aug 2007 05:54:48 +0200
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: wmb vs mmiowb
Message-ID: <20070823035448.GG18788@wotan.suse.de>
References: <20070822045714.GD26374@wotan.suse.de>
	<alpine.LFD.0.999.0708221049560.30176@woody.linux-foundation.org>
	<200708221202.12403.jesse.barnes@intel.com>
	<20070823022043.GB18788@wotan.suse.de>
	<alpine.LFD.0.999.0708221953360.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.0.999.0708221953360.30176@woody.linux-foundation.org>
Cc: linux-ia64@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 07:57:56PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 23 Aug 2007, Nick Piggin wrote:
> >
> > > Irix actually had an io_unlock() routine that did this 
> > > implicitly, but iirc that was shot down for Linux...
> > 
> > Why was it shot down? Seems like a pretty good idea to me ;)
> 
> It's horrible. We'd need it for *every* single spinlock type. We have lots 
> of them. 
> 
> So the choice is between:
> 
>  - sane:
> 
> 	mmiowb()
> 
>    followed by any of the existing "spin_unlock()" variants (plain, 
>    _irq(), _bh(), _irqrestore())
> 
>  - insane: multiply our current set of unlock primitives by two, by making 
>    "io" versions for them all:
> 
> 	spin_unlock_io[_irq|_irqrestore|_bh]()
> 
> but there's actually an EVEN WORSE problem with the stupid Irix approach, 
> namely that it requires that the unlocker be aware of the exact details of 
> what happens inside the lock. If the locking is done at an outer layer, 
> that's not at all obvious!

OK, but we'd have some kind of functions that are called not to
serialise the CPUs, but to serialise the IO. It would be up to
the calling code to already provide CPU synchronisation.

serialize_io(); / unserialize_io(); / a nicer name

If we could pass in some kind of relevant resoure (eg. the IO
memory or device or something), then we might even be able to
put debug checks there to ensure two CPUs are never inside the
same critical IO section at once.

 
> In other words, Irix (once again) made a horrible and idiotic choice. 

We could make a better one. I don't think mmiowb is really insane, but
I'd worry it being confused with a regular type of barrier and that CPU
synchronisation needs to be provided for it to work or make sense.
 

> Big surprise. Irix was probably the flakiest and worst of all the 
> commercial proprietary unixes. No taste.

Is it? I've never used it ;)
