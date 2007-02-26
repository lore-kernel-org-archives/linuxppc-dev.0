Return-Path: <SRS0+d6cead0195db3fcd630e+1282+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34C96DDDFA
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 15:00:41 +1100 (EST)
Subject: Re: Make sure we populate the initroot filesystem late enough
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0702251940500.12485@woody.linux-foundation.org>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0702251614420.12485@woody.linux-foundation.org>
	<1172452660.3971.33.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0702251940500.12485@woody.linux-foundation.org>
Content-Type: text/plain
Date: Sun, 25 Feb 2007 23:01:06 -0500
Message-Id: <1172462466.3971.46.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	john stultz <johnstul@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-02-25 at 19:45 -0800, Linus Torvalds wrote:
> Ok. Clearly something is using that memory. That said, I *suspect* that 
> the commit that you bisected to is just showing the problem indirectly. 
> The ordering shouldn't make any difference, but it can obviously make a 
> huge difference in various allocation patterns etc, thus just showing a 
> pre-existing problem more clearly..

Indeed.

> Can you try adding something like
> 
>         memset(start, 0xf0, end - start);

Yeah, I did that before giving up on it for the day and going in search
of dinner. It changes the failure mode to a BUG() in
cache_free_debugcheck(), at line 2876 of mm/slab.c

It smells like the pages weren't actually reserved in the first place
and we were blithely allocating them. The only problem with that theory
is that the initrd doesn't seem to be getting corrupted -- and if we
were handing out its pages like that then surely _something_ would have
scribbled on it before we tried to read it.

When I head back in tomorrow morning I'll instrument free_initrd_mem()
to check that the PageReserved bit was actually set on each page, before
clearing it. And I'll make the page allocation routines check whether
they're giving out pages between initrd_start and initrd_end, etc.

-- 
dwmw2
