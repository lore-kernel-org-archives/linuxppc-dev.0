Return-Path: <Geoff.Thorpe@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 09EFBB7299
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 06:31:06 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 819CFDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 06:31:04 +1000 (EST)
Message-ID: <4A3AA3FE.8090903@freescale.com>
Date: Thu, 18 Jun 2009 16:30:54 -0400
From: Geoff Thorpe <Geoff.Thorpe@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] RFC: powerpc: expose the multi-bit ops that underlie
	single-bit ops.
References: <1243361946-6771-1-git-send-email-Geoff.Thorpe@freescale.com>	<1245124418.12400.67.camel@pasglop>
	<4A37AC09.1020200@freescale.com>
	<1245188026.14036.17.camel@pasglop>
In-Reply-To: <1245188026.14036.17.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben et al,

Benjamin Herrenschmidt wrote:
> On Tue, 2009-06-16 at 10:28 -0400, Geoff Thorpe wrote:

[snip]

>>> Maybe we can shrink that file significantly (and avoid the risk for
>>> typos etc...) by generating them all from a macro.
>>>
>>> Something like (typed directly into the mailer :-)
>>>
>>> #define DEFINE_BITOP(op, prefix, postfix) \
>>> 	asm volatile (			  \
>>> 	prefix				  \
>>> "1:"    PPC_LLARX "%0,0,%3\n"		  \
>>> 	__stringify(op) "%1,%0,%2\n"	  \
>>> 	PPC405_ERR77(0,%3)		  \
>>> 	PPC_STLCX "%1,0,%3\n"		  \
>>> 	"bne- 1b\n"			  \
>>> 	postfix				  \
>>> 	 : "=&r" (old), "=&r" (t)
>>> 	 : "r" (mask), "r" (p)
>>> 	 : "cc", "memory")
>>>
>>> and so:
>>>
>>> static inline void set_bits(unsigned long mask, volatile unsigned long *addr)
>>> {
>>> 	unsigned long old, t;
>>>
>>> 	DEFINE_BITOP(or, "", "");
>>> }
>>>
>>> static inline void test_and_set_bits(unsigned long mask, volatile unsigned long *addr)
>>> {
>>> 	unsigned long old, t;
>>>
>>> 	DEFINE_BITOP(or, LWSYNC_ON_SMP, ISYNC_ON_SMP);
>>>
>>> 	return (old & mask) != 0;
>>> }
>>>
>>> etc...
>>
>> Sounds good, I'll try working this up and I'll send a new patch shortly.
> 
> You can also go totally mad and generate the whole function (both -s and
> non -s variants) from one macro but I wouldn't go that far :-)

I've prepared a new patch, will send it in a moment. It uses two macros
rather than one - as the test_and_***() APIs have a fundamentally
different asm because of the arguments to 'op' as well as the output
operands. However, this split made it possible to generate the entire
"inner" (single-word) function using the macro, rather than just the
inline asm part.

> 
>> So can I assume implicitly that changing the set_bits() function to add
>> the 'volatile' qualifier to the prototype (and the missing
>> PPC405_ERR77() workaround) was OK?
> 
> The PPC405_ERR77 workaround is definitely needed. The volatile, well, I
> suspect it's useless, but it will remove warnings when callers call
> these on something that is declared as volatile in the first place.
> 
> Do x86 use volatile there ? If not, then don't do it on powerpc neither,
> it could well be an historical remain. It's not functionally useful, the
> "memory" clobber in the asm takes care of telling the compiler not to
> mess around I believe.

I've left the volatile qualifier in the generated API because I didn't
feel so comfortable changing APIs, but I also added the "memory" clobber
for all cases - whereas it seems the existing set_bits(), clear_bits(),
[...] functions didn't declare this... Do you see any issue with having
the 'volatile' in the prototype as well as the clobber in the asm?

Actually, might as well just respond to the new patch instead... :-) Thx.

Cheers,
Geoff
