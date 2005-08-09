Return-Path: <hollis@penguinppc.org>
Received: from smtpauth04.mail.atl.earthlink.net
	(smtpauth04.mail.atl.earthlink.net [209.86.89.64])
	by ozlabs.org (Postfix) with ESMTP id CCEE167F79
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Aug 2005 12:40:22 +1000 (EST)
In-Reply-To: <20050809005050.GF3187@smtp.west.cox.net>
References: <20050803131848.GA10954@janus> <1123148649.30257.59.camel@gaston>
	<20050809005050.GF3187@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c54114a19f775043b9c77082f01cd253@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Mon, 8 Aug 2005 21:20:33 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Subject: Re: bug in arch/ppc/boot/common/util.S: cmplwi  cr0,r3,r4 ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Aug 8, 2005, at 7:50 PM, Tom Rini wrote:

> On Thu, Aug 04, 2005 at 11:44:08AM +0200, Benjamin Herrenschmidt wrote:
>> On Wed, 2005-08-03 at 15:18 +0200, Frank van Maarseveen wrote:
>>> I think "cmplwi" expects an immediate vale as last operand
>>> around line 255 of arch/ppc/boot/common/util.S:
>>>
>>> 	addi	r4,r4,_etext@l		# r8 = &_etext
>>> 1:	dcbf	r0,r3			# Flush the data cache
>>> 	icbi	r0,r3			# Invalidate the instruction cache
>>> 	addi	r3,r3,0x10		# Increment by one cache line
>>> 	cmplwi	cr0,r3,r4		# Are we at the end yet?
>>> 	               ^^
>>> 	blt	1b			# No, keep flushing and invalidating
>>>
>>> I guess it should have been:
>>>
>>> 	cmplw	cr0,r3,r4		# Are we at the end yet?
>>
>> Yup, looks like a real bug to me, Tom ?
>
> Sounds correct to me.  I wonder why the assembler hasn't barfed, or is
> is translating the ascii values of r4.

include/asm-ppc/ppc_asm.h:
#define r4      4

Unfortunately -mregnames is quite stupid, so that wouldn't have helped 
us here either.

-Hollis
