Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18466.40208.94904.902495@cargo.ozlabs.ibm.com>
Date: Thu, 8 May 2008 16:26:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions and
	-Os
In-Reply-To: <BFB7B7A0-6EA9-467D-B23E-B0D46EF6BA54@kernel.crashing.org>
References: <Pine.LNX.4.64.0805020920120.1141@blarg.am.freescale.net>
	<20080502150753.GA7753@ld0162-tx32.am.freescale.net>
	<F62A680D-C2D8-42B0-B4D6-F3A00F228EB1@kernel.crashing.org>
	<03e9cbca081bff8f6db9862bf3d8d028@kernel.crashing.org>
	<BFB7B7A0-6EA9-467D-B23E-B0D46EF6BA54@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> We'll hopefully this thread might spark either an explanation for why  
> we aren't just linking libgcc in a statement that says we should and  
> we can remove the code that implements libgcc functionality.

I've just reviewed the code in the 32-bit and 64-bit PowerPC versions
of libgcc.  It's pretty huge (half a megabyte or so in total) but
fortunately most of the bulk is in the decimal floating-point support,
which I largely ignored (though I did notice in passing that it calls
libc functions including strchr, strtof, and sprintf).

On 64-bit I don't see anything there that I would expect we would
need.  There are some things that are in there because some processors
have particular instructions that others don't, for example popcountb
(which is in the V2.05 architecture but not earlier versions), so gcc
can generate either the instruction or a call to the libgcc function,
depending on what sort of processor you're compiling for.  However, in
those cases, we'd want our own version of the libgcc function so that
we could use our CPU feature mechanism to give us the new instruction
on those CPUs that have it.

On 32-bit, it's pretty much just the 64-bit arithmetic routines that
we would need from libgcc (shifts, compares, multiply, divide,
modulo).  I'm not too impressed with the quality of the code there,
for example, the 64-bit signed divide routine is 299 instructions,
which seems enormous to me.  It's all generated from portable C code
by gcc.  I think I can do a smaller and faster 64-bit divide routine
in assembler, for instance.

So on the whole I don't think we want to link with libgcc, although I
don't feel very strongly about it.

Paul.
