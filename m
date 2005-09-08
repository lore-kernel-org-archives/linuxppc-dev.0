Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [209.128.68.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2D9F681E8
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Sep 2005 11:42:15 +1000 (EST)
Date: Wed, 7 Sep 2005 22:04:28 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050908010428.GC8882@dmt.cnet>
References: <Pine.LNX.4.61.0508261415080.29975@nylon.am.freescale.net>
	<f0351d402e64b569bbcfc16fa921d860@embeddededge.com>
	<20050826213144.GE5541@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050826213144.GE5541@smtp.west.cox.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Kumar Gala <galak@freescale.com>
Subject: Re: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 26, 2005 at 02:31:44PM -0700, Tom Rini wrote:
> On Fri, Aug 26, 2005 at 04:13:04PM -0400, Dan Malek wrote:
> > 
> > On Aug 26, 2005, at 3:15 PM, Kumar Gala wrote:
> > 
> > >While ppc32 has the CONFIG_HZ Kconfig option, it wasnt actually being
> > >used. Connect it up and set all platforms to 250Hz.  This pretty much
> > >mimics the ppc64 patch from Anton Blanchard.
> > 
> > Why do we keep cranking up this clock frequency?  Do we really need
> > it running that fast?  Is it time for someone with RTOS experience to
> > implement a real scheduled clock queue in Linux instead of just
> > wasting interrupts decrementing a counter waiting for the next
> > event to expire?  :-)  If the user "ticks" are still 100 Hz, don't we 
> > need
> > something that is an integer multiple of that for at least an attempt
> > at getting it close to what a user would request?
> 
> So 250 is supposed to be the best choice of power vs latency and such.
> But hey, there's nothing stopping us from setting all of the embedded
> configs back down to 100 :)

Yep. 

Kumar, can you please change your patch to make CONFIG_8xx use 100Hz?

There was a significant performance increase from doing that (vs 1000Hz)
on a 48Mhz 8xx with small cache.
