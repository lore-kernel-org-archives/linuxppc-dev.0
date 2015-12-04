Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5FA81A0E39
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 04:14:01 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: more POLL... fun
Date: Fri, 04 Dec 2015 18:13:54 +0100
Message-ID: <2220761.5EzR0eY4bg@wuerfel>
In-Reply-To: <20151204152133.GI22011@ZenIV.linux.org.uk>
References: <20151127050026.GX22011@ZenIV.linux.org.uk>
 <3199712.spOmaGJUoN@wuerfel> <20151204152133.GI22011@ZenIV.linux.org.uk>
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

On Friday 04 December 2015 15:21:33 Al Viro wrote:
> On Fri, Dec 04, 2015 at 10:16:50AM +0100, Arnd Bergmann wrote:
> 
> > I don't remember why we put in fasync support, but I have checked the libspe
> > implementation and found that it doesn't use it (not a big surprise there).
> > It always uses epoll() to get notifications from spufs, and based on your
> > explanation I assume everything else (there may have been one or two users
> > that used the low-level interfaces rather than libspe) did too.
> 
> OK...  So should we just rip ->{mfc,ibox,wbox}_fasync out, along with all
> three kill_fasync() and ->fasync() instances in there?  We obviously need to
> leave spufs_{mfc,ibox,wbox}_callback() in place for the sake of those
> wake_up_all(&ctx->{mfc,ibox,wbox}_wq); in them...
> 
> I mean, fasync in there obviously never been used at all - it never delivered
> a single SIGIO, and the first user to try would get the BUG_ON() in fcntl.c
> instead.  Since nobody complained in more than 10 years...

Yes, I think that would be best. Do you want me to send that patch, or do
you prefer to do it yourself? In theory that patch should also go into stable
kernels, but I suspect nobody who still owns a machine that is able to run
this code will ever upgrade to a stable release, so we probably don't need
that.

	Arnd
