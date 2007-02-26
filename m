Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DEFFBDE201
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 02:55:12 +1100 (EST)
Subject: Re: Make sure we populate the initroot filesystem late enough
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1172462466.3971.46.camel@shinybook.infradead.org>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0702251614420.12485@woody.linux-foundation.org>
	<1172452660.3971.33.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0702251940500.12485@woody.linux-foundation.org>
	<1172462466.3971.46.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 16:53:27 +0100
Message-Id: <1172505207.11949.15.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Sun, 2007-02-25 at 23:01 -0500, David Woodhouse wrote:

> Yeah, I did that before giving up on it for the day and going in search
> of dinner. It changes the failure mode to a BUG() in
> cache_free_debugcheck(), at line 2876 of mm/slab.c
> 
> It smells like the pages weren't actually reserved in the first place
> and we were blithely allocating them. The only problem with that theory
> is that the initrd doesn't seem to be getting corrupted -- and if we
> were handing out its pages like that then surely _something_ would have
> scribbled on it before we tried to read it.
> 
> When I head back in tomorrow morning I'll instrument free_initrd_mem()
> to check that the PageReserved bit was actually set on each page, before
> clearing it. And I'll make the page allocation routines check whether
> they're giving out pages between initrd_start and initrd_end, etc.

And check that we didn't end up stupidly having the initrd share a page
with something else ... (like not aligned end or such thingy).

Ben.
