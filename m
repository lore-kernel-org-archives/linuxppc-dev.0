Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <200509270905.29545.michael@ellerman.id.au>
References: <Pine.LNX.4.61.0509231408170.3791@nylon.am.freescale.net>
	<200509261157.37514.michael@ellerman.id.au>
	<1127774755.15882.104.camel@gaston>
	<200509270905.29545.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 09:31:31 +1000
Message-Id: <1127777491.15882.106.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: merged asm/cputable.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > There is a small issue here: You turn identify_cpu into C code. However,
> > on ppc32, this is called with the kernel not yet relocated (before
> > prom_init even !). Same with the feature fixup. On ppc32, in order to
> > run C code that early, it needs to be in -mrelocatable bits of code
> > (like prom_init) or use RELOC macros (ugh !).
> 
> We could keep the bulk of the patch (turn cur_cpu_spec into a struct) but 
> still do identify_cpu() in asm, although it would seem like a step backward.

We can do it in C in ppc32 if we use proper RELOC() macros, or do it in
an -mrelocatable piece of code like prom_init (but I'd like to avoid
that).

> Do people think it's "better" to have one unified asm implementation, or one 
> in asm for ppc32 and one in C for ppc64?

We should only need one implementation for both I suppose.

Ben
