Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id CDB2167B20
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2005 08:14:42 +1000 (EST)
Date: Thu, 7 Apr 2005 15:14:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050407221440.GT3396@smtp.west.cox.net>
References: <20050407173821.GQ3396@smtp.west.cox.net>
	<f3f5e13e4c8b3cb7b327fb51db84150d@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f3f5e13e4c8b3cb7b327fb51db84150d@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] invalid instructions in kernel mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 07, 2005 at 04:41:59PM -0500, Kumar Gala wrote:
> 
> On Apr 7, 2005, at 12:38 PM, Tom Rini wrote:
> 
> >On Thu, Mar 31, 2005 at 07:47:32PM +0200, Fillod Stephane wrote:
> >
> >> When CPU has no (classic) FPU, and math emulation is disabled,
> > > fp instructions are not allowed in kernel mode.
> > [snip]
> > > --- linux/arch/ppc/kernel/misc.S????? 26 Mar 2005 03:28:36 -0000
> > > 1.1.1.2
> > > +++ linux/arch/ppc/kernel/misc.S????? 31 Mar 2005 16:33:25 -0000
> > > @@ -1096,7 +1096,8 @@
> > >?? * and exceptions as if the cpu had performed the load or store.
> > >?? */
> > >?
> >> -#if defined(CONFIG_4xx) || defined(CONFIG_E500)
> >> +#if !(defined(CONFIG_4xx) || defined(CONFIG_E500) ||
> > > defined(CONFIG_8xx)) ||? defined(CONFIG_MATH_EMULATION)
> >> +#if defined(CONFIG_4xx) || defined(CONFIG_E500)
> >>? _GLOBAL(cvt_fd)
> >>? ???? lfs???? 0,0(r3)
> > >? ???? stfd??? 0,0(r4)
> > > @@ -1125,6 +1126,7 @@
> > >? ???? stfd??? 0,-4(r5)
> > >? ???? blr
> > >? #endif
> > > +#endif
> >
> >The problem here is, HEY! (classic) FP instrs in the kernel.? The
> > question is why?? Or rather, why are these four classic FP instrs
> > (lfs/lfd/stfd/stfs) being done on CONFIG_4xx || E500 when neither has
> > classic FP?? I think the problem here is that on !FPU
> >(which is 4xx||E500||8xx, or so), we need to rewrite these two
> > functions (yes, 8xx does emulate them if hit, but that's a tangent).
> 
> What is not clear to me is what condition causes these to get hit on an 
> e500.

They are called in align.c from fix_alignment().  As has been said, some
of the stress testing apps in LTP will trigger this.  Since the comment
around the code in question (in fix_alignent()) is
/* Single-precision FP load and store require conversions... */
perhaps it's more valid to not define these functions on e500 || 4xx,
and make the two cases in the switch there depend on !e500 && !4xx.

-- 
Tom Rini
http://gate.crashing.org/~trini/
