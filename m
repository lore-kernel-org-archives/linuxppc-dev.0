Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LMhX113HzF1NW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 23:46:03 +1000 (AEST)
Date: Wed, 4 Jul 2018 08:45:15 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: How is this possible - Register r30 contains 0xc2236400 instead
 of 0xc6236400
Message-ID: <20180704134515.GI16221@gate.crashing.org>
References: <09ae0460-11e7-c893-5a5f-55e55a3ef372@c-s.fr>
 <87k1qbkuw0.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k1qbkuw0.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 04, 2018 at 11:11:59PM +1000, Michael Ellerman wrote:
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
> 
> > Kernel Oops at 0xc0334d5c for reading at address 0xc2236450 which 
> > corresponds to r30 + 80
> >
> > But r30 should contain what's at r3 + 16 that is at 0xc619ec10 so r30 
> > should be c6236400 as shown below (print_hex_dump(regs->gpr[3]) added at 
> > end of __die() )
> >
> > So how can r30 contain 0xc2236400 instead ?
> 
> The simplest answer is that memory was modified between the time we
> loaded it into r30 and when you print it.
> 
> So it did contain 0xc2236400 but has since been modified to now contain
> 0xc6236400.
> 
> The thing that makes me less certain, is that c6 would be the correct
> value (I think?), so it's been modified back to the correct value, which
> seems lucky.
> 
> Mysterious.

That depends.  Is this reproducible at all?  It is a single bit flip.


Segher
