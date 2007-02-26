Return-Path: <SRS0+d6cead0195db3fcd630e+1282+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04718DDEC6
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 11:00:36 +1100 (EST)
Subject: Re: Make sure we populate the initroot filesystem late enough
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200612112059.kBBKx1j7022473@hera.kernel.org>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
Content-Type: text/plain
Date: Sun, 25 Feb 2007 19:00:57 -0500
Message-Id: <1172448057.3971.9.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	john stultz <johnstul@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-12-11 at 20:59 +0000, Linux Kernel Mailing List wrote:
> Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8d610dd52dd1da696e199e4b4545f33a2a5de5c6
> Commit:     8d610dd52dd1da696e199e4b4545f33a2a5de5c6
> Parent:     8993780a6e44fb4e7ed34e33458506a775356c6e
> Author:     Linus Torvalds <torvalds@woody.osdl.org>
> AuthorDate: Mon Dec 11 12:12:04 2006 -0800
> Committer:  Linus Torvalds <torvalds@woody.osdl.org>
> CommitDate: Mon Dec 11 12:12:04 2006 -0800
> 
>     Make sure we populate the initroot filesystem late enough
>     
>     We should not initialize rootfs before all the core initializers have
>     run.  So do it as a separate stage just before starting the regular
>     driver initializers.
>     
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>

This seems to be what's triggering the apparent memory corruption we've
been seeing recently -- in the case of the Fedora kernel it manifests
itself as a BUG() in cache_alloc_refill() when the pmac ide driver
initialises.

Another report was at http://lkml.org/lkml/2006/12/17/4

We've been seeing it on a Mac Mini too, and I managed to reproduce it on
my shinybook this evening by booting with 'mem=512M'.

One side-effect of this patch is to move the call to free_initrd() much
later in the init sequence, potentially after other memory management
code is assuming it's already been freed.

-- 
dwmw2
