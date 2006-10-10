Return-Path: <dgibson@ozlabs.org>
Date: Tue, 10 Oct 2006 10:23:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: powerpc: Fix make rules for dtc
Message-ID: <20061010002303.GB8209@localhost.localdomain>
References: <20061004033753.GB20636@localhost.localdomain>
	<3711678A-7AA9-493F-B046-2F459604C028@kernel.crashing.org>
	<20061009002945.GA2259@localhost.localdomain>
	<811124BA-A99B-46B9-9A16-4111D937468E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <811124BA-A99B-46B9-9A16-4111D937468E@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 09, 2006 at 04:21:31PM +0200, Segher Boessenkool wrote:
> >>>  clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
> >>> -		$(obj)/empty.c
> >>> +		$(obj)/empty.c *.dtb
> >>
> >> If this wildcard works at all, it will still do the wrong thing:
> >> deleting all .dtb files (even the ones that the Makefile cannot
> >> create again, e.g., the user put them in the tree manually) is
> >> at best not very polite.
> >
> > It certainly works at all
> 
> My problem with it is the := which might be expanded at the wrong
> time.  Or maybe that won't glob the *.dtb yet, who knows.  

*I* know, because I checked the Kbuild rules first, and verified that
globs are legal in the clean-files variable.

> It's
> not obviously "working" either way.

> > (the preceding $(obj)/empty.c, however, is
> > wrong, I've sent a separate patch for that).  One could say the same
> > thing for *.o in clean targets,
> 
> Yes, and that's a very well-known problem.
> 
> > though I guess adding .dtb files is
> > rather more likely.  However, I can't seen an obvious way of
> > generating a list of the re-creatable dtbs, without an explicit
> > listing of every file in arch/powerpc/boot/dts which sounds like a bit
> > of a pain.  Suggestions?
> 
> You shouldn't clean _all_ dtb's that you could build, only the dtb's
> that you _did_ build.  You already have a rule for what dtb's to
> build I assume; just copy the logic from there.

No.  clean rules never work this way, because if you change the config
between building and cleaning, things won't get cleaned (which is why
clean rules are just about the only place one uses globs in makefiles,
rather than expanding variables appropriately).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
