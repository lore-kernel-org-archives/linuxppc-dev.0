Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431E51A0C65
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2015 20:16:59 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: more POLL... fun
Date: Fri, 04 Dec 2015 10:16:50 +0100
Message-ID: <3199712.spOmaGJUoN@wuerfel>
In-Reply-To: <20151204063825.GH22011@ZenIV.linux.org.uk>
References: <20151127050026.GX22011@ZenIV.linux.org.uk>
 <20151130030427.GY22011@ZenIV.linux.org.uk>
 <20151204063825.GH22011@ZenIV.linux.org.uk>
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

On Friday 04 December 2015 06:38:25 Al Viro wrote:
> On cross-builds the __poll_t annotations had caught something interesting:
> void spufs_mfc_callback(struct spu *spu)
> {
> 	....
>                 mask = 0;
>                 if (free_elements & 0xffff)
>                         mask |= POLLOUT;
>                 if (tagstatus & ctx->tagwait)
>                         mask |= POLLIN;
> 
>                 kill_fasync(&ctx->mfc_fasync, SIGIO, mask);
> 	....
> }
> 
> That's arch/powerpc/platforms/cell/spufs/file.c.  WTF is kill_fasync()
> getting as the last argument here?  Valid values are
> #define POLL_IN         (__SI_POLL|1)   /* data input available */
> #define POLL_OUT        (__SI_POLL|2)   /* output buffers available */
> #define POLL_MSG        (__SI_POLL|3)   /* input message available */
> #define POLL_ERR        (__SI_POLL|4)   /* i/o error */
> #define POLL_PRI        (__SI_POLL|5)   /* high priority input available */
> #define POLL_HUP        (__SI_POLL|6)   /* device disconnected */
> 
> Use of POLLIN, POLLOUT, etc. here is wrong - kill_fasync() will step into
>                         BUG_ON((reason & __SI_MASK) != __SI_POLL);
> in send_sigio_to_task().  Other two callers of kill_fasync() in that file
> are trivially fixed by switching to POLL_IN and POLL_OUT; with this one
> I've no idea what had been intended.
> 
> What's more, I really wonder if it had _ever_ been tested - these kill_fasync()
> calls had been introduced in
> commit 8b3d6663c6217e4f50cc3720935a96da9b984117
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Tue Nov 15 15:53:52 2005 -0500
> 
>     [PATCH] spufs: cooperative scheduler support
> more than 5 years after that BUG_ON() had been added - it goes back to
> +                       /* Make sure we are called with one of the POLL_*
> +                          reasons, otherwise we could leak kernel stack into
> +                          userspace.  */
> +                       if ((reason & __SI_MASK) != __SI_POLL)
> +                               BUG();
> in 2.3.99pre-10-3, on May 25 2000.
> 
> What the hell am I missing here?  Has that code been DOA and never used by
> anyone in all the decade it had been in mainline?

I don't remember why we put in fasync support, but I have checked the libspe
implementation and found that it doesn't use it (not a big surprise there).
It always uses epoll() to get notifications from spufs, and based on your
explanation I assume everything else (there may have been one or two users
that used the low-level interfaces rather than libspe) did too.

	Arnd
