Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E9C0DDDF6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 12:47:33 +1000 (EST)
Date: Tue, 3 Jun 2008 19:46:44 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <200806041205.45833.nickpiggin@yahoo.com.au>
Message-ID: <alpine.LFD.1.10.0806031932370.3473@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>
	<Pine.LNX.4.64.0806031130130.3242@t2.domain.actdsltmp>
	<alpine.LFD.1.10.0806031153360.3473@woody.linux-foundation.org>
	<200806041205.45833.nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Trent Piepho <tpiepho@freescale.com>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 4 Jun 2008, Nick Piggin wrote:
> 
> Actually, according to the document I am looking at (the AMD one), a UC
> store may pass a previous WC store.

Hmm. Intel arch manyal, Vol 3, 10.3 (page 10-7 in my version):

  "If the WC bufer is partially filled, the writes may be delayed until 
   the next ocurrence of a serializing event; such as, an SFENCE or MFENCE 
   instruction, CPUID execution, a read or write to uncached memory, ..."

Any typos mine.

Anyway, Intel certainly seems to document that WC memory is serialized by 
any access to UC memory.

But yes, I can well imagine that AMD is different, and I also heartily 
would recommend rather being safe than sorry. Putting an explicit memory 
barrier in between those accesses when you know it might make a difference 
is just a good idea. 

But basically, as far as I know the thing was designed to be invisible to 
old software: that is the whole idea behind WC memory. So the design was 
certainly intended to be that you can generally mark a framebuffer-like 
structure WC without any software _ever_ caring, as long as you keep all 
control ports in UC memory.

Of course, because burst writes from the WC buffer are <i>so</i> much more 
efficient on the PCI bus than dribbling them out one write at a time, it 
didn't take long before all the graphics cards etc wanted to <i>also</i> 
mark their command queues as WC memory, so that you could burst out the 
commands to the ring buffers as fast as possible. So now you have both 
your frame buffer *and* your command buffers mapped WC, and now ordering 
really has to be ensured in software if you access both.

[ And then there are the crazy people who mark *main memory* as WC, 
  because they don't want to pollute the cache with all the data, and then 
  you have the issue of cache coherency etc crap. Which only gets worse 
  with SMP, especially if one processor thinks it has part of memory 
  exclusively cached, and another one - or even the same one, 
  through another aliasign address - ignores the cache protocol.

  And you now get unhappy CPU's that think that there is a bug in the 
  cache protocol and they get machine check faults.

  So what started out as a "we can do accesses to the frame buffer more 
  efficiently without anybody ever even having to know or care" has 
  turned into a whole nightmare of people using it for other things, and 
  then you very much _do_ have to care! ]

And it doesn't surprise me if AMD then didn't get exactly the same 
rules. 

Oh, well.

		Linus
