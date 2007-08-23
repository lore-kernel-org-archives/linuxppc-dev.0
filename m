Return-Path: <torvalds@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 51C9ADDF24
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 12:58:40 +1000 (EST)
Date: Wed, 22 Aug 2007 19:57:56 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: wmb vs mmiowb
In-Reply-To: <20070823022043.GB18788@wotan.suse.de>
Message-ID: <alpine.LFD.0.999.0708221953360.30176@woody.linux-foundation.org>
References: <20070822045714.GD26374@wotan.suse.de>
	<alpine.LFD.0.999.0708221049560.30176@woody.linux-foundation.org>
	<200708221202.12403.jesse.barnes@intel.com>
	<20070823022043.GB18788@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
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



On Thu, 23 Aug 2007, Nick Piggin wrote:
>
> > Irix actually had an io_unlock() routine that did this 
> > implicitly, but iirc that was shot down for Linux...
> 
> Why was it shot down? Seems like a pretty good idea to me ;)

It's horrible. We'd need it for *every* single spinlock type. We have lots 
of them. 

So the choice is between:

 - sane:

	mmiowb()

   followed by any of the existing "spin_unlock()" variants (plain, 
   _irq(), _bh(), _irqrestore())

 - insane: multiply our current set of unlock primitives by two, by making 
   "io" versions for them all:

	spin_unlock_io[_irq|_irqrestore|_bh]()

but there's actually an EVEN WORSE problem with the stupid Irix approach, 
namely that it requires that the unlocker be aware of the exact details of 
what happens inside the lock. If the locking is done at an outer layer, 
that's not at all obvious!

In other words, Irix (once again) made a horrible and idiotic choice. 

Big surprise. Irix was probably the flakiest and worst of all the 
commercial proprietary unixes. No taste.

		Linus
