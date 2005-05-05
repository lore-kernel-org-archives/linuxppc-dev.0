Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id E994567AC6
	for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2005 00:23:56 +1000 (EST)
Date: Thu, 5 May 2005 07:23:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050505142354.GZ1221@smtp.west.cox.net>
References: <7de437cded3ef3b030898889bf65e8c9@embeddededge.com>
	<49ea49620ccd32ef3032da76db24ad5d@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49ea49620ccd32ef3032da76db24ad5d@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 05, 2005 at 09:00:50AM -0500, Kumar Gala wrote:
> 
> On May 5, 2005, at 7:24 AM, Dan Malek wrote:
> 
> >
> >
> >On May 5, 2005, at 1:22 AM, Paul Mackerras wrote:
> > > If you think we should have -mcpu=xxx on the command line for 4xx,
> > > 44x, 8xx, etc., then that's fine, but that is a separate problem 
> >from
> > > what my patch was addressing (one which my patch might make it 
> >easier
> > > to fix, though).
> >
> >I think that is exactly what we want, although I don't know how that is
> > separate from the patch you sent.? My original comment was the patch
> > fixes the problem for only one of the cpu cores, not all of them.? 
> >Which
> > then led into the subsequent suggestion of making the biarch work
> > like the past compilers, and we must specific the flags for POWER4
> > instead of the other way around.? Without explicit -mcpu flags, the
> > existing compiler behavior is just fine .....? but, I guess I'd be
> >standing
> > in the way of progress to want this :-)
> 
> I agree with Dan here.  I think we should go ahead and extend the patch 
> to set -mcpu and -mtune flags for the list of processors we have in 
> "Processor Type".  If I'm building a kernel for e500 or 4xx I might as 
> well get a kernel that is tuned a bit more for the subarch.  

This is fine.

> Additionally, there should be some expert override ability, so if I 
> really want to do -mcpu=7455 -mtune=7455 I can.

Gack, no!  It's quite a pain to go from CONFIG_FOO="string" into useable
Makefile bits that the one we did have back in 2.4 is gone.  That also
implies gcc finally knows something about these cores that might be
useful, which I don't think is the case, nor is it likely to be.  But if
we did want it, we'd probably go the route x86 has.

-- 
Tom Rini
http://gate.crashing.org/~trini/
