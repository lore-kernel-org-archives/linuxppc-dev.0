Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com (holomorphy.com [66.93.40.71])
	by ozlabs.org (Postfix) with ESMTP id 012DEDDECC
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 18:23:13 +1100 (EST)
Date: Sun, 25 Feb 2007 22:59:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Make sure we populate the initroot filesystem late enough
Message-ID: <20070226065943.GA3037@holomorphy.com>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0702251614420.12485@woody.linux-foundation.org>
	<1172452660.3971.33.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0702251940500.12485@woody.linux-foundation.org>
	<1172462466.3971.46.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1172462466.3971.46.camel@shinybook.infradead.org>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
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

On Sun, Feb 25, 2007 at 11:01:06PM -0500, David Woodhouse wrote:
> Yeah, I did that before giving up on it for the day and going in search
> of dinner. It changes the failure mode to a BUG() in
> cache_free_debugcheck(), at line 2876 of mm/slab.c
> It smells like the pages weren't actually reserved in the first place
> and we were blithely allocating them. The only problem with that theory
> is that the initrd doesn't seem to be getting corrupted -- and if we
> were handing out its pages like that then surely _something_ would have
> scribbled on it before we tried to read it.
> When I head back in tomorrow morning I'll instrument free_initrd_mem()
> to check that the PageReserved bit was actually set on each page, before
> clearing it. And I'll make the page allocation routines check whether
> they're giving out pages between initrd_start and initrd_end, etc.

Another few things to try would be inserting checks in page_alloc.c for
pages in that specific range before some flag set in free_initrd_mem()
is set, and (conflicting with that, though easily reconciled) unmapping
initrd memory in free_initrd_mem() instead of freeing it.


-- wli
