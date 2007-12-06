Return-Path: <SRS0+d1b41a9518e7ca16221c+1565+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 740C2DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Dec 2007 00:08:24 +1100 (EST)
Subject: Re: Kernel symbol version history
From: David Woodhouse <dwmw2@infradead.org>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
In-Reply-To: <4756CF15.2090805@dlasys.net>
References: <4756CF15.2090805@dlasys.net>
Content-Type: text/plain
Date: Thu, 06 Dec 2007 13:08:18 +0000
Message-Id: <1196946498.13978.526.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Wed, 2007-12-05 at 11:17 -0500, David H. Lynch Jr. wrote:
> This might be slightly OT here, but would anyone know where there
> might be a reference that indicates at precisely what version a given
> symbol either appeared or disappeared within the  Linux kernel ?
> 
>      As an example if a driver is supposed to work for 2.6 and 2.4 and
> uses sysfs, or cdev, or alloc_chr_dev_region or ...
>     How can one tell at what point that api or symbol appeared so that
> the proper conditionals appear within the driver.
> 
>     The last one that bit me was I made a collection of casting changes
> to address 64bit vs. 32bit targets, and found that using the C99 fixed
> size types - uint32_t, ... made life much more pleasant, after putting
> them I nobody else could build because uintptr_t did not appear until
> 2.6.24, and I still have not figured out exactly when uint32_t etc.
> appeared.

I believe the standard C99 types like uint32_t have been there for ever,
basically. Maybe not in Linux 1.0, but as far back as anyone might ever
sensibly care.

That doesn't include uintptr_t though. For that we usually use 'unsigned
long'. If ever there is an architecture where 'unsigned long' isn't big
enough for a pointer, Linux is going to break :)

>     I would think there ought to be some resource besides group memory
> to look this up ?
>     Is there a way to use git to look back through the history of a
> symbol rather than a file.

pmac /pmac/git/libertas-2.6 $ git-annotate include/linux/types.h | grep uintptr_t
142956af        (   Al Viro     2007-10-29 05:11:28 +0000       40)typedef unsigned long                uintptr_t;
pmac /pmac/git/libertas-2.6 $ git-show 142956af
commit 142956af525002c5378e7d91d81a01189841a785
Author: Al Viro <viro@ftp.linux.org.uk>
Date:   Mon Oct 29 05:11:28 2007 +0000

    fix abuses of ptrdiff_t
    
    Use of ptrdiff_t in places like
    
    -                       if (!access_ok(VERIFY_WRITE, u_tmp->rx_buf, u_tmp->len))
    +                       if (!access_ok(VERIFY_WRITE, (u8 __user *)
    +                                               (ptrdiff_t) u_tmp->rx_buf,
    +                                               u_tmp->len))
    
    is wrong; for one thing, it's a bad C (it's what uintptr_t is for; in general
    we are not even promised that ptrdiff_t is large enough to hold a pointer,
    just enough to hold a difference between two pointers within the same object).
    For another, it confuses the fsck out of sparse.
    
    Use unsigned long or uintptr_t instead.  There are several places misusing
    ptrdiff_t; fixed.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>


-- 
dwmw2
