Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8CCBCDDEFF
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 15:18:38 +1000 (EST)
Date: Tue, 24 Apr 2007 09:18:31 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 2/2] POWERPC: Remove global CPM mappings
Message-ID: <20070424091831.1793fa26@localhost.localdomain>
In-Reply-To: <5AC8BD28-125C-4552-97E9-D35E85D0E555@embeddedalley.com>
References: <20070423223649.4955.77579.stgit@localhost.localdomain>
	<20070423223910.4955.18106.stgit@localhost.localdomain>
	<5AC8BD28-125C-4552-97E9-D35E85D0E555@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 23 Apr 2007 21:26:59 -0400
Dan Malek wrote:

> 
> On Apr 23, 2007, at 6:39 PM, Vitaly Bordug wrote:
> 
> >
> > Gets rid or direct IMMR accesses/dereferences for PQ SoC targets and
> > relevant drivers.
> 
> Can we find a way to do this without the constant
> ioremapping and unmapping?  It's a quick and
> dirty hack, but it would be nice if we could map once
> during an initialization, keep the pointer around
> and at least use it within the file context.  I know it
> doesn't cost much, but all of these cycles add up,
> and someday ioremap could grow into something
> more complex.  Please?

Well, I know the solution is not ideal, neither it is final,
but it is a step forward in cleaning up CPM-related stuff.
In many drivers it used to be just modifications of immr->foo, 
which fills driver with pleasant board-specific ifdefs and gives hard time 
to figure out with something's not working as expected.

At first I was thinking of make_everybody_happy solution, 
but with the whole kernel moving forward even brilliant ideas tend to 
stay at draft stage (well, you know that much better than me:) )
> 
> The whole of the CPM supporting functions need this,
> it could be mapped once and shared at least among
> them.  Any drivers that use the IMMR should also be
> cleaner about managing this space as they would
> any other mapped resource that is typically done
> only once for the life of the driver.
> 

I know it can be more efficient. And I am looking at this way, but it just cannot
be achieved via single step. TODO list includes rehaul of GPIO (with long-time-grown 
feature_call + device tree bindings that were implemented for 8360 but looks reasonable), muxing, etc.

Also I had to take care of arch/ppc since most affected cpm-related drivers (as well as targets) exist and 
work both at ppc/ and powerpc/. 
> There are also many different methods used that
> I don't understand the reason.  Sometimes the
> mappings are hidden in macros, sometimes done
> in a function that is called, other times ioremap()
> is called explicitly.  It just looks, well....  icky.  :-)
> 

This patch just fixes what already exist in kernel, removing the global IMMR pointer and bringing all remaining code paths to the same need_stuff->immr_map->use_it->immr_unmap model. IOW , wraps up what has began before. This ppc/powerpc scatter makes it pretty tricky to move drivers forward without ugly code to handle both 
or leaving one of the ways aside, and this approach gives sane code that works in both cases. Current code is messy at some parts, and this what I am trying to address (with current patch and upcomings).

Thanks for looking at it!

-Vitaly
