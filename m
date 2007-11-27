Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A3E82DDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 02:20:20 +1100 (EST)
Date: Tue, 27 Nov 2007 09:23:17 -0600
From: Olof Johansson <olof@lixom.net>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
Message-ID: <20071127152317.GA5230@lixom.net>
References: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
	<20071120175416.GA4389@loki.buserror.net>
	<B82E6C31-8BB7-4348-9426-B18A971172A9@kernel.crashing.org>
	<Pine.LNX.4.62.0711211407260.12720@pademelon.sonytel.be>
	<Pine.LNX.4.62.0711271555520.5847@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0711271555520.5847@pademelon.sonytel.be>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 27, 2007 at 03:56:53PM +0100, Geert Uytterhoeven wrote:
> On Wed, 21 Nov 2007, Geert Uytterhoeven wrote:
> > On Tue, 20 Nov 2007, Kumar Gala wrote:
> > > On Nov 20, 2007, at 11:54 AM, Scott Wood wrote:
> > > > On Mon, Nov 19, 2007 at 09:36:57PM -0600, Kumar Gala wrote:
> > > >> isel (Integer Select) is a new user space instruction in the
> > > >> PowerISA 2.04 spec.  Not all processors implement it so lets emulate
> > > >> to ensure code built with isel will run everywhere.
> > > >
> > > > Given that the instruction is meant to be a performance enhancement,
> > > > we should probably warn the first few times it's emulated, so the user
> > > > knows they should change their toolchain setup if possible.
> > > 
> > > The same is true of mcrxr, popcntb, and possibly string ld/st.
> > > 
> > > Feel free to submit a patch that warns about their usage.
> > 
> > Something like this?
> 
> New version below.
> 
> Do we want it in sysfs? Or should we use debugfs instead?

I like this, and I'd say it's useful to have in sysfs. Few production
systems enable debugfs, and this is something that could be useful to
have access to there.

> Subject: powerpc: Keep track of emulated instructions
> 
> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> 
> powerpc: Keep track of emulated instructions
> 
> Counters for the various classes of emulated instructions are available under
> /sys/devices/system/cpu/cpu*/emulated/.
> Optionally, rate-limited warnings can be printed to the console when
> instructions are emulated.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  arch/powerpc/Kconfig.debug     |   10 ++++++
>  arch/powerpc/kernel/align.c    |   17 ++++++++--
>  arch/powerpc/kernel/sysfs.c    |   64 ++++++++++++++++++++++++++++++++++++++++-
>  arch/powerpc/kernel/traps.c    |   17 +++++++++-
>  include/asm-powerpc/emulator.h |   60 ++++++++++++++++++++++++++++++++++++++

This name stood out as being a bit too generic, emulator could mean
system support for running under some sort of emulator as well. How
about emulated_ops.h?

> +config DEBUG_WARN_EMULATED
> +	bool "Warn if emulated instructions are used"
> +	depends on DEBUG_KERNEL && SYSFS
> +	help
> +	  This option will cause messages to be printed if an instruction is
> +	  emulated.
> +	  Counters for emulated instruction usages are always available under
> +	  /sys/devices/system/cpu/cpu*/emulated/, irrespective of the state
> +	  of this option.

How about making it a sysctl instead, so it can be flipped at runtime
(but default off)?


-Olof
