Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id ACA9467E98
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Aug 2005 10:50:52 +1000 (EST)
Date: Mon, 8 Aug 2005 17:50:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050809005050.GF3187@smtp.west.cox.net>
References: <20050803131848.GA10954@janus> <1123148649.30257.59.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1123148649.30257.59.camel@gaston>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: bug in arch/ppc/boot/common/util.S: cmplwi  cr0,r3,r4 ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 04, 2005 at 11:44:08AM +0200, Benjamin Herrenschmidt wrote:
> On Wed, 2005-08-03 at 15:18 +0200, Frank van Maarseveen wrote:
> > I think "cmplwi" expects an immediate vale as last operand
> > around line 255 of arch/ppc/boot/common/util.S:
> > 
> > 	addi	r4,r4,_etext@l		# r8 = &_etext
> > 1:	dcbf	r0,r3			# Flush the data cache
> > 	icbi	r0,r3			# Invalidate the instruction cache
> > 	addi	r3,r3,0x10		# Increment by one cache line
> > 	cmplwi	cr0,r3,r4		# Are we at the end yet?
> > 	               ^^
> > 	blt	1b			# No, keep flushing and invalidating
> > 
> > I guess it should have been:
> > 
> > 	cmplw	cr0,r3,r4		# Are we at the end yet?
> 
> Yup, looks like a real bug to me, Tom ?

Sounds correct to me.  I wonder why the assembler hasn't barfed, or is
is translating the ascii values of r4.  I'll pass this along once 2.6.14
opens just because the code has been that way for so many years, I don't
think it's a critical bug.

-- 
Tom Rini
http://gate.crashing.org/~trini/
