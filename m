Return-Path: <dgibson@ozlabs.org>
Date: Fri, 25 May 2007 11:30:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 440 ebony patch seems to have broken 85xx build on powerpc.git
Message-ID: <20070525013005.GB11789@localhost.localdomain>
References: <4655C7A6.2050606@mvista.com>
	<2ded9f19fbaf49a89ed6e32de87f5828@kernel.crashing.org>
	<1180035543.3360.25.camel@zod.rchland.ibm.com>
	<200705242221.17790.arnd@arndb.de>
	<ab81cfaedb70d6911fcbac9c43f5cf69@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <ab81cfaedb70d6911fcbac9c43f5cf69@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 25, 2007 at 12:02:44AM +0200, Segher Boessenkool wrote:
> >>> Nothing is telling GCC what CPU to compile for, so it
> >>> will just use the compiler's default, which very likely
> >>> is not what you want.  For files that will only ever
> >>> be used on 440, the correct flags are -mcpu=440 -Wa,-m440 .
> >>
> >> We could add that to the per-file flags already, right?
> >
> > I think it should really use -mcpu=powerpc on all files.
> > The problem that Dave saw was the result of using a compiler
> > that defaults to -mcpu=8540, which uses instruction that
> > don't work on 440.
> 
> No, those options _do_ work on 440, but the -mbooke
> assembler flag disallows isel (since it is an optional
> insn).

But not on 440GP, which is what Ebony is.

> > The common files really need to be built with -mcpu flags that
> > make the code work on any system if you want to be able
> > to use just a single boot wrapper binary for all.
> 
> On any system where they can run at all, yes.  It should
> be fine to compile a 440-only file with 440-specific flags.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
