Subject: Re: help with asm code?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <4085483B.1090604@nortelnetworks.com>
References: <4085483B.1090604@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1082506664.2077.9.camel@gaston>
Mime-Version: 1.0
Date: Wed, 21 Apr 2004 10:17:45 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I then have some code that wants to load up one of these values and use
> it as an offset into another struct.  Coming into the following stretch
> of code, r6 contains the entry number within hrt_ak_offsets, and r4
> contains the base address of the other struct.
>
>
> 	lis	r5,hrt_ak_offsets@ha
> 	addi	r5,r5,hrt_ak_offsets@l
> 	lbzx	r6,r6,r5
> 	add	r10,r4,r6
>
>
> I'm having a small problem, in that when I run this code it hangs my
> kernel.  Any ideas what's wrong?  The values in r6 and r5 seem to match
> what I expect, but when I do the lbzx it dies.

I don't know for sure, maybe you MMU context is wrong at the time ?
(Assuming a 32 bits kernel, a 64 bits kernel need more instructions
to load the address)

How do you know it dies there and not elsewhere ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
