Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6FA5067B60
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Jul 2006 04:19:14 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6SIJBsN004079
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 14:19:11 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6SIJAXe185842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 12:19:11 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6SIJAlH016326
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 12:19:10 -0600
Date: Fri, 28 Jul 2006 13:19:09 -0500
To: Alan Modra <amodra@bigpond.net.au>
Subject: Re: Why the "opd" section?
Message-ID: <20060728181909.GS7448@austin.ibm.com>
References: <Pine.SUN.4.58.0607232059070.699@eskimo.com>
	<20060725021558.GG6872@bubble.grove.modra.org>
	<Pine.SUN.4.58.0607250612510.14690@eskimo.com>
	<20060725140634.GH6872@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060725140634.GH6872@bubble.grove.modra.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 25, 2006 at 11:36:34PM +0930, Alan Modra wrote:
> > 
> > So, why is it only in the 64-bit ELF?  Is it just because it's a newer
> > idea?
> 
> The idea isn't exactly new.  It's more the case that the powerpc32 ABI
> is so old.

The basic idea/structure of the TOC was fixed in 1988, when the 
linkage conventions for the pre-powerpc POWER were being speced.

I have no idea why the ppc32 ABI wouldn't have used this.

> >         mflr 0
> >         std 0,16(1)
> >         stdu 1,-112(1)
> >         bl addone
> >         nop
> >         bl addone
> >         nop
> >         addi 1,1,112
> >         ld 0,16(1)
> >         mtlr 0
> >         blr
> > 
> Yes, you're right.  It does look to be branching directly to the opd
> entry at the assembly level.  It of course won't do that because
> powerpc64-ld is clever enough to realise that doing so would never make
> any sense.  Instead, ld does the OPD lookup and modifies the "bl" insns
> to go directly to the function's code entry if the TOC vallue of caller
> and callee is identical, or to go via a linker generated stub if they
> are different.

I beleive the no-op provides the space for the needed extra insns when 
the linker goes to fix this up. If you disassemble the exectuable for 
the case where addone is in some shared library, you'd see the bl replaced 
by bl .glink (I think its called .glink, I don't remember), with the 
.glink code fiddling with loading the right r2 TOC pointer as needed.
I've forgotten the details.

I vaguely remember yet another interesting trick, where the linker inserts
some dynamic-link stubs -- and so, when the subroutine is called for the
very first time ever, some additional linkage is done by the stub. I
have no idea if the current gcc/glibc do this.


--linas
