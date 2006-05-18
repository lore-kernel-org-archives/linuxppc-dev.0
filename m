Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id A976367A45
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 11:08:28 +1000 (EST)
Date: Wed, 17 May 2006 18:08:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/5] powerpc: Make early xmon logic immune to location of
	early parsing
Message-ID: <20060518010826.GO22868@smtp.west.cox.net>
References: <1147852841.148164.91320074069.qpush@concordia>
	<20060517212955.GA31362@smtp.west.cox.net>
	<1147910586.7360.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1147910586.7360.8.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 18, 2006 at 10:03:05AM +1000, Michael Ellerman wrote:
> On Wed, 2006-05-17 at 14:29 -0700, Tom Rini wrote:
> > On Wed, May 17, 2006 at 06:00:41PM +1000, Michael Ellerman wrote:
> > 
> > > Currently early_xmon() calls directly into debugger() if xmon=early is passed.
> > > This ties the invocation of early xmon to the location of parse_early_param(),
> > > which might change.
> > > 
> > > Tested on P5 LPAR and F50.
> > > 
> > > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > 
> > Please no, parse_early_param() is there so things like xmon or kgdb can
> > be dropped into as soon as we're able to parse any params that might be
> > usable early on.
> 
> Sure, did you read the rest of the series? I want to parse parameters
> eariler, so early that xmon isn't ready to run when we parse them, so I
> have to defer jumping into xmon until after xmon is initialised. The net
> effect on when xmon runs is zero. Or did I miss your point?

My point would be that xmon should either be fixed to work that early or
parse things a bit later as a regular param.  I know the current system
is flawed but I really don't like the idea (especially as a comaintainer
of kgdb) of having to do a special plug here or there for one param
because we parse early stuff too early, but regular stuff not early
enough (which is why Andrew Morton got me to poke at the early param
stuff a while back and then I think Rusty did something better, or
something along those lines, anyhow).

I'm just trying to avoid getting back into the situation we had before
parse_early_param().

-- 
Tom Rini
