Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 5820267A6D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 05:05:50 +1100 (EST)
Date: Mon, 21 Mar 2005 11:05:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050321180548.GU8345@smtp.west.cox.net>
References: <20050321163904.GT8345@smtp.west.cox.net>
	<4ae19fb229974e099a8472158be9482f@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4ae19fb229974e099a8472158be9482f@freescale.com>
Cc: Kumar Gala <galak@freescale.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] ppc32: Report chip version in common /proc/cpuinfo
	handling
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Mar 21, 2005 at 11:21:28AM -0600, Kumar Gala wrote:
> 
> On Mar 21, 2005, at 10:39 AM, Tom Rini wrote:
> 
> >On Fri, Mar 18, 2005 at 06:26:52PM -0600, Kumar Gala wrote:
> >
> >>
> >> You asked me to look at doing the following.? I just want to make 
> >sure
> >> this is what we want to do (and call it).? I'm a little concerned 
> >that
> >> 'chip' is not necessary the right name in light of TSI10x and MV64x60
> >> being described by ppc_sys in the future.
> >
> >"chip" or "chip(set)" or anything else is fine with me (I'm horrible at
> > names).? But I don't like:
> >
> >> +#if defined (CONFIG_85xx) || defined (CONFIG_83xx)
> >> +???? if (cur_ppc_sys_spec->ppc_sys_name)
> >> +???? ??????? seq_printf(m, "chip\t\t: %s\n", 
> >cur_ppc_sys_spec->ppc_sys_name);
> >> +#endif
> >
> >ifdef'ing this.? If the field is set, we should print it.
> 
> The only reason this is ifdef'd is that cur_ppc_sys_spec does not 
> always exist on all platforms built.

Oh boy, I sense an <asm-ppc/serial.h> in the making.  Please tell me
it's at least not possible that someone could stick an 85xx and an
MV64x60 together.  So we want the enum there to do sanity checking,
right?

-- 
Tom Rini
http://gate.crashing.org/~trini/
