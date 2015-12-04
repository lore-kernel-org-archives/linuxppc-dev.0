Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 624CE1A0DD9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 04:34:52 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>, mpe@ellerman.id.au
Subject: Re: more POLL... fun
Date: Fri, 04 Dec 2015 18:34:33 +0100
Message-ID: <1528094.JohtZ1HIQC@wuerfel>
In-Reply-To: <20151204173031.GJ22011@ZenIV.linux.org.uk>
References: <20151127050026.GX22011@ZenIV.linux.org.uk>
 <2220761.5EzR0eY4bg@wuerfel> <20151204173031.GJ22011@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 04 December 2015 17:30:31 Al Viro wrote:
> On Fri, Dec 04, 2015 at 06:13:54PM +0100, Arnd Bergmann wrote:
> 
> > Yes, I think that would be best. Do you want me to send that patch, or do
> > you prefer to do it yourself? In theory that patch should also go into stable
> > kernels, but I suspect nobody who still owns a machine that is able to run
> > this code will ever upgrade to a stable release, so we probably don't need
> > that.
> 
> Probably better if it goes through ppc tree - the only relationship it has
> to VFS is broken calls of kill_fasync() in now-removed code...

Right.

>  Something like this, perhaps?
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
> ---

Looks all good, thanks!

Acked-by: Arnd Bergmann <arnd@arndb.de>
