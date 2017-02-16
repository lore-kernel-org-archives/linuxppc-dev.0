Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP58c6rzgzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 16:59:44 +1100 (AEDT)
In-Reply-To: <20151204173031.GJ22011@ZenIV.linux.org.uk>
To: Al Viro <viro@ZenIV.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: more POLL... fun
Message-Id: <3vP58c692tz9s8V@ozlabs.org>
Date: Thu, 16 Feb 2017 16:59:44 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-12-04 at 17:30:31 UTC, Al Viro wrote:
> On Fri, Dec 04, 2015 at 06:13:54PM +0100, Arnd Bergmann wrote:
> 
> > Yes, I think that would be best. Do you want me to send that patch, or do
> > you prefer to do it yourself? In theory that patch should also go into stable
> > kernels, but I suspect nobody who still owns a machine that is able to run
> > this code will ever upgrade to a stable release, so we probably don't need
> > that.
> 
> Probably better if it goes through ppc tree - the only relationship it has
> to VFS is broken calls of kill_fasync() in now-removed code...  Something
> like this, perhaps?
> 
> [spufs] get rid of broken fasync stuff
>  
> In all the years it's been in the tree it had never been used by
> anything - it would instantly trigger BUG_ON() in fs/fcntl.c due
> to bogus band argument passed to kill_fasync().  Since nobody
> had ever used it in ten years, let's just rip it out and be
> done with that.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7d7be3aa08fa338e84eb235805ee18

cheers
