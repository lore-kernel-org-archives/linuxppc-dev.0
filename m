Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8FA467DFA
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2005 19:48:25 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frank van Maarseveen <frankvm@frankvm.com>
In-Reply-To: <20050803131848.GA10954@janus>
References: <20050803131848.GA10954@janus>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 11:44:08 +0200
Message-Id: <1123148649.30257.59.camel@gaston>
Mime-Version: 1.0
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

On Wed, 2005-08-03 at 15:18 +0200, Frank van Maarseveen wrote:
> I think "cmplwi" expects an immediate vale as last operand
> around line 255 of arch/ppc/boot/common/util.S:
> 
> 	addi	r4,r4,_etext@l		# r8 = &_etext
> 1:	dcbf	r0,r3			# Flush the data cache
> 	icbi	r0,r3			# Invalidate the instruction cache
> 	addi	r3,r3,0x10		# Increment by one cache line
> 	cmplwi	cr0,r3,r4		# Are we at the end yet?
> 	               ^^
> 	blt	1b			# No, keep flushing and invalidating
> 
> I guess it should have been:
> 
> 	cmplw	cr0,r3,r4		# Are we at the end yet?

Yup, looks like a real bug to me, Tom ?

Ben.
