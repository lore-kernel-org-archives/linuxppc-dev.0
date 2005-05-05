Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id E382867B33
	for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2005 02:29:31 +1000 (EST)
Date: Thu, 5 May 2005 09:29:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050505162925.GB1221@smtp.west.cox.net>
References: <20050505152709.GA1221@smtp.west.cox.net>
	<bc56e4a30aef8a46e88cee672a315fdc@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bc56e4a30aef8a46e88cee672a315fdc@freescale.com>
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

On Thu, May 05, 2005 at 11:22:38AM -0500, Kumar Gala wrote:
> 
> On May 5, 2005, at 10:27 AM, Tom Rini wrote:
> 
> >On Thu, May 05, 2005 at 10:12:42AM -0500, Kumar Gala wrote:
> > >
> >> On May 5, 2005, at 9:23 AM, Tom Rini wrote:
> > >
> >> >On Thu, May 05, 2005 at 09:00:50AM -0500, Kumar Gala wrote:
> > > > >
> > > >> On May 5, 2005, at 7:24 AM, Dan Malek wrote:
> > > > >
> > > >> >
> > > > > >
> > > > > >On May 5, 2005, at 1:22 AM, Paul Mackerras wrote:
> > > > > > > If you think we should have -mcpu=xxx on the command line 
> >for
> >> >4xx,
> > > > > > > 44x, 8xx, etc., then that's fine, but that is a separate 
> >problem
> > > >> >from
> > > > > > > what my patch was addressing (one which my patch might make 
> >it
> > > >> >easier
> > > > > > > to fix, though).
> > > > > >
> > > > > >I think that is exactly what we want, although I don't know how
> >> >that is
> > > > > > separate from the patch you sent.? My original comment was the
> >> >patch
> > > > > > fixes the problem for only one of the cpu cores, not all of 
> >them.?
> > > >> >Which
> > > > > > then led into the subsequent suggestion of making the biarch 
> >work
> > > > > > like the past compilers, and we must specific the flags for 
> >POWER4
> > > > > > instead of the other way around.? Without explicit -mcpu 
> >flags,
> >> >the
> > > > > > existing compiler behavior is just fine .....? but, I guess 
> >I'd be
> > > > > >standing
> > > > > > in the way of progress to want this :-)
> > > > >
> > > >> I agree with Dan here.? I think we should go ahead and extend the
> >> >patch
> > > >> to set -mcpu and -mtune flags for the list of processors we have 
> >in
> > > >> "Processor Type".? If I'm building a kernel for e500 or 4xx I 
> >might
> >> >as
> > > >> well get a kernel that is tuned a bit more for the subarch.?
> > > >
> > > > This is fine.
> >> >
> > > >> Additionally, there should be some expert override ability, so 
> >if I
> > > >> really want to do -mcpu=7455 -mtune=7455 I can.
> > > >
> > > >Gack, no!? It's quite a pain to go from CONFIG_FOO="string" into
> >> >useable
> > > > Makefile bits that the one we did have back in 2.4 is gone.? That 
> >also
> > > > implies gcc finally knows something about these cores that might 
> >be
> > > > useful, which I don't think is the case, nor is it likely to be.? 
> >But
> >> >if
> > > > we did want it, we'd probably go the route x86 has.
> > >
> >> I'm not saying it has to be done via a CONFIG option, all I'm saying 
> >is
> >> if I want to explicitly use GCC then I would hope we could somehow
> >> disable it being override.
> >
> >If you're not doing it via CONFIG, that leaves manual (which is always
> > an option) or seeing if passing CFLAGS on the cmdline overrides 
> >things,
> > or adds to them.
> 
> Thats all I really want.  Just for us to make sure if I want to do 
> -mcpu=7455 -mtune=7455 I'm able to and it actually does what I told it 
> to do.  I'm not sure if GCC is consistent on how it handles args that 
> are duplicated.  For example what will happen with the following:
> 
> gcc -mcpu=750 -mtune=7450 -mcpu=603 -mtune=603
> 
> Is this -mcpu=750 -mtune=7450 or -mcpu=603 -mtune=603

Last one wins, modulo gcc bugs, is the rule I believe.

-- 
Tom Rini
http://gate.crashing.org/~trini/
