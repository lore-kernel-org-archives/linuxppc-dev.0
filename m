Return-Path: <johnnyb@eskimo.com>
Received: from ultra7.eskimo.com (ultra7.eskimo.com [204.122.16.70])
	by ozlabs.org (Postfix) with ESMTP id 2BEDC67B74
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jul 2006 23:23:41 +1000 (EST)
Date: Tue, 25 Jul 2006 06:23:30 -0700 (PDT)
From: Jonathan Bartlett <johnnyb@eskimo.com>
To: Alan Modra <amodra@bigpond.net.au>
Subject: Re: Why the "opd" section?
In-Reply-To: <20060725021558.GG6872@bubble.grove.modra.org>
Message-ID: <Pine.SUN.4.58.0607250612510.14690@eskimo.com>
References: <Pine.SUN.4.58.0607232059070.699@eskimo.com>
	<20060725021558.GG6872@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> OPD is an array of function pointers.  Function pointers on powerpc64
> are not just simple pointers to some code;  They specify the code entry
> point, the TOC pointer, and the static chain pointer (unused by C).
> To call a function, you need to know all these values because functions
> do not initialise their own TOC pointer.  This allows for more efficient
> code.  The compiler/linker can omit the TOC pointer load when both
> caller and callee are known to share the same TOC.  (In many ways, the
> TOC is like the powerpc32 GOT.  powerpc32 -fpic/PIC code initialises the
> GOT pointer on entry to every function, even when caller and callee are
> known to have the same GOT pointer.)

So, why is it only in the 64-bit ELF?  Is it just because it's a newer
idea?

Also, I tried compiling this piece of code in its own file:

int addtwo(int a)
{
        int b = addone(a);
        return addone(b);
}

I compiled it with "gcc -m64 -shared -fPIC -O3 -S tmp.c"

The resulting code had the following as it's compilation:

        mflr 0
        std 0,16(1)
        stdu 1,-112(1)
        bl addone
        nop
        bl addone
        nop
        addi 1,1,112
        ld 0,16(1)
        mtlr 0
        blr

It seems to be branching _directly_ to the opd entry, instead of the
address pointed to by the opd entry.  Also, the TOC pointer is never used,
despite the fact that these were separately compiled.  Or is this taken
care of by the linker?  Under what conditions would the TOC pointer be
different?

I'm new to PPC assembly, and a little confused.  So any help would be
appreciated.

Thanks for your time,

Jon
