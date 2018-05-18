Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nX1s0RgDzF2Cb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 01:21:04 +1000 (AEST)
Date: Fri, 18 May 2018 10:20:27 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] powerpc/lib: inline memcmp() for small constant
 sizes
Message-ID: <20180518152027.GD17342@gate.crashing.org>
References: <cover.1526553552.git.christophe.leroy@c-s.fr>
 <8a6f90d882c8b60e5fa0826cd23dd70a92075659.1526553552.git.christophe.leroy@c-s.fr>
 <20180517135551.GT17342@gate.crashing.org>
 <7a2c3de9-4223-ec47-b3c0-1336c9cdbeee@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7a2c3de9-4223-ec47-b3c0-1336c9cdbeee@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 18, 2018 at 12:35:48PM +0200, Christophe Leroy wrote:
> On 05/17/2018 03:55 PM, Segher Boessenkool wrote:
> >On Thu, May 17, 2018 at 12:49:58PM +0200, Christophe Leroy wrote:
> >>In my 8xx configuration, I get 208 calls to memcmp()
> >Could you show results with a more recent GCC?  What version was this?
> 
> It was with the latest GCC version I have available in my environment, 
> that is GCC 5.4. Is that too old ?

Since GCC 7 the compiler knows how to do this, for powerpc; in GCC 8
it has improved still.

> It seems that version inlines memcmp() when length is 1. All other 
> lengths call memcmp()

Yup.

> c000d018 <tstcmp4>:
> c000d018:	80 64 00 00 	lwz     r3,0(r4)
> c000d01c:	81 25 00 00 	lwz     r9,0(r5)
> c000d020:	7c 69 18 50 	subf    r3,r9,r3
> c000d024:	4e 80 00 20 	blr

This is incorrect, it does not get the sign of the result correct.
Say when comparing 0xff 0xff 0xff 0xff to 0 0 0 0.  This should return
positive, but it returns negative.

For Power9 GCC does

        lwz 3,0(3)
        lwz 9,0(4)
        cmpld 7,3,9
        setb 3,7

and for Power7/Power8,

        lwz 9,0(3)
        lwz 3,0(4)
        subfc 3,3,9
        popcntd 3,3
        subfe 9,9,9
        or 3,3,9

(and it gives up for earlier CPUs, there is no nice simple code sequence
as far as we know.  Code size matters when generating inline code).

(Generating code for -m32 it is the same, just w instead of d in a few
places).

> c000d09c <tstcmp8>:
> c000d09c:	81 25 00 04 	lwz     r9,4(r5)
> c000d0a0:	80 64 00 04 	lwz     r3,4(r4)
> c000d0a4:	81 04 00 00 	lwz     r8,0(r4)
> c000d0a8:	81 45 00 00 	lwz     r10,0(r5)
> c000d0ac:	7c 69 18 10 	subfc   r3,r9,r3
> c000d0b0:	7d 2a 41 10 	subfe   r9,r10,r8
> c000d0b4:	7d 2a fe 70 	srawi   r10,r9,31
> c000d0b8:	7d 48 4b 79 	or.     r8,r10,r9
> c000d0bc:	4d a2 00 20 	bclr+   12,eq
> c000d0c0:	7d 23 4b 78 	mr      r3,r9
> c000d0c4:	4e 80 00 20 	blr

> This shows that on PPC32, the 8 bytes comparison is not optimal, I will 
> improve it.

It's not correct either (same problem as with length 4).


Segher
