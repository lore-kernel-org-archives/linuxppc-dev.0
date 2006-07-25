Return-Path: <amodra@bigpond.net.au>
Received: from omta01ps.mx.bigpond.com (omta01ps.mx.bigpond.com
	[144.140.82.153]) by ozlabs.org (Postfix) with ESMTP id E3D3867A3A
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jul 2006 00:06:35 +1000 (EST)
Date: Tue, 25 Jul 2006 23:36:34 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Jonathan Bartlett <johnnyb@eskimo.com>
Subject: Re: Why the "opd" section?
Message-ID: <20060725140634.GH6872@bubble.grove.modra.org>
References: <Pine.SUN.4.58.0607232059070.699@eskimo.com>
	<20060725021558.GG6872@bubble.grove.modra.org>
	<Pine.SUN.4.58.0607250612510.14690@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SUN.4.58.0607250612510.14690@eskimo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 25, 2006 at 06:23:30AM -0700, Jonathan Bartlett wrote:
> > OPD is an array of function pointers.  Function pointers on powerpc64
> > are not just simple pointers to some code;  They specify the code entry
> > point, the TOC pointer, and the static chain pointer (unused by C).
> > To call a function, you need to know all these values because functions
> > do not initialise their own TOC pointer.  This allows for more efficient
> > code.  The compiler/linker can omit the TOC pointer load when both
> > caller and callee are known to share the same TOC.  (In many ways, the
> > TOC is like the powerpc32 GOT.  powerpc32 -fpic/PIC code initialises the
> > GOT pointer on entry to every function, even when caller and callee are
> > known to have the same GOT pointer.)
> 
> So, why is it only in the 64-bit ELF?  Is it just because it's a newer
> idea?

The idea isn't exactly new.  It's more the case that the powerpc32 ABI
is so old.

> Also, I tried compiling this piece of code in its own file:
> 
> int addtwo(int a)
> {
>         int b = addone(a);
>         return addone(b);
> }
> 
> I compiled it with "gcc -m64 -shared -fPIC -O3 -S tmp.c"
> 
> The resulting code had the following as it's compilation:
> 
>         mflr 0
>         std 0,16(1)
>         stdu 1,-112(1)
>         bl addone
>         nop
>         bl addone
>         nop
>         addi 1,1,112
>         ld 0,16(1)
>         mtlr 0
>         blr
> 
> It seems to be branching _directly_ to the opd entry, instead of the
> address pointed to by the opd entry.  Also, the TOC pointer is never used,
> despite the fact that these were separately compiled.  Or is this taken
> care of by the linker?  Under what conditions would the TOC pointer be
> different?

Yes, you're right.  It does look to be branching directly to the opd
entry at the assembly level.  It of course won't do that because
powerpc64-ld is clever enough to realise that doing so would never make
any sense.  Instead, ld does the OPD lookup and modifies the "bl" insns
to go directly to the function's code entry if the TOC vallue of caller
and callee is identical, or to go via a linker generated stub if they
are different.

A number of different stubs might be used.  For a large statically
linked program where TOC size exceeds 64k, ld groups functions such that
each group uses a TOC of less than 64k, and inserts r2 adjusting stubs
between calls from one group to another.  For calls to shared library
functions, ld inserts plt call stubs that load an opd entry from the
plt.  See binutils bfd/elf64-ppc.c if you want all the gory details on
stubs.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
