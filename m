Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 61A6467CA8
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 09:38:08 +1100 (EST)
Date: Tue, 12 Dec 2006 16:38:03 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Message-Id: <20061212163803.01d9c63e.kim.phillips@freescale.com>
In-Reply-To: <A2576248-6DF4-44BE-99D2-0D8477865B17@kernel.crashing.org>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>
	<1165648490.1103.117.camel@localhost.localdomain>
	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>
	<20061211155155.26868ca6.kim.phillips@freescale.com>
	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>
	<20061211201055.21031c9b.kim.phillips@freescale.com>
	<1165890570.11914.5.camel@localhost.localdomain>
	<457F1F6E.4020502@freescale.com>
	<1165960058.11914.72.camel@localhost.localdomain>
	<7152860A-27A3-4C08-B6A5-DFA57A63ACED@kernel.crashing.org>
	<20061212162416.06f0dd76.kim.phillips@freescale.com>
	<A2576248-6DF4-44BE-99D2-0D8477865B17@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 12 Dec 2006 16:28:38 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Dec 12, 2006, at 4:24 PM, Kim Phillips wrote:
> 
> > On Tue, 12 Dec 2006 16:06:41 -0600
> > Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> >>
> >>> I do prefer the middle ground approach he (and you) proposed to
> >>> have an
> >>> "mpc83xx_generic" in the compatible property and match on that, but
> >>> I'm
> >>> not 100% certain we are really there yet and I would have been a bit
> >>> more comfortable limiting that to known fsl boards. But you are the
> >>> guys
> >>> to maintain those things, so do as you like there.
> >>
> >> I'm against the idea of "mpc83xx_generic" if they want to introduce a
> >> "mpc83xx_freescale" or "mpc83xx_fsl_generic" I'm fine with that, but
> >> there is not such thing as a "mpc83xx_generic".
> >
> > I took a look at the TQM8349 code, and it looks like it will be  
> > identical in the platform code space.  That would subtract the  
> > 'fsl' part from the equation.  How about 'mpc83xx_eval'?  btw, this  
> > would be taking us back to the original patch, which I like since I  
> > personally don't want to see one file per eval board (I could ifdef  
> > protect platforms in machdefs.c if that works for you).
> 
> What's the issue with a file per board if all it has is the ppc_md/ 
> define_machine() in it.  Someone explain to me why this is a bad thing?
> 
well it depends on what you do with the _probe()s.  If you have multiple define_machine definitions built in, the generic probe will always succeed to match on the first machine probe_machine() tests, which may or may not be the machine it's currently running on.

Kim
