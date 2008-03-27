Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6FFBDE582
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 02:40:01 +1100 (EST)
Date: Thu, 27 Mar 2008 10:39:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in the
	device tree.
Message-ID: <20080327153952.GC18728@ld0162-tx32.am.freescale.net>
References: <200803261217.46671.laurentp@cse-semaphore.com>
	<200803261220.43039.laurentp@cse-semaphore.com>
	<47EA80ED.1030202@freescale.com>
	<200803271010.33825.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200803271010.33825.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 27, 2008 at 10:10:33AM +0100, Laurent Pinchart wrote:
> On Wednesday 26 March 2008 17:59, Scott Wood wrote:
> > This breaks the bootwrapper console.
> 
> And of course I forgot about that :-)
> 
> The boot wrapper code doesn't have any dpram allocator. Any objection against 
> using a chunk of dpram at a fixed location ? What about at the beginning of 
> the dpram ? The DTS muram node would then exclude a chunk of dpram at offset 
> 0x0000 instead of 0x1100.

I'm not entirely comfortable with using a chunk outside of what's in the
muram node, and assuming that it's for the SMC pram -- what if there's
microcode or something there?

Since udbg is only for debugging, and is marked as potentially dangerous,
how about just using the end of muram (as described in the device tree)? 
If the muram is fully allocated, it won't happen until after the real
serial console is initialized.

-Scott
