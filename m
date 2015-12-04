Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B25D1A0CCE
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 02:21:39 +1100 (AEDT)
Date: Fri, 4 Dec 2015 15:21:33 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: more POLL... fun
Message-ID: <20151204152133.GI22011@ZenIV.linux.org.uk>
References: <20151127050026.GX22011@ZenIV.linux.org.uk>
 <20151130030427.GY22011@ZenIV.linux.org.uk>
 <20151204063825.GH22011@ZenIV.linux.org.uk>
 <3199712.spOmaGJUoN@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3199712.spOmaGJUoN@wuerfel>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 04, 2015 at 10:16:50AM +0100, Arnd Bergmann wrote:

> I don't remember why we put in fasync support, but I have checked the libspe
> implementation and found that it doesn't use it (not a big surprise there).
> It always uses epoll() to get notifications from spufs, and based on your
> explanation I assume everything else (there may have been one or two users
> that used the low-level interfaces rather than libspe) did too.

OK...  So should we just rip ->{mfc,ibox,wbox}_fasync out, along with all
three kill_fasync() and ->fasync() instances in there?  We obviously need to
leave spufs_{mfc,ibox,wbox}_callback() in place for the sake of those
wake_up_all(&ctx->{mfc,ibox,wbox}_wq); in them...

I mean, fasync in there obviously never been used at all - it never delivered
a single SIGIO, and the first user to try would get the BUG_ON() in fcntl.c
instead.  Since nobody complained in more than 10 years...
