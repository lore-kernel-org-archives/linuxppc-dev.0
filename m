Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4FD1DDDE2E
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 05:33:02 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l73JYGid027102
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 15:34:16 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l73JWx3v252618
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 15:32:59 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l73JWxZJ025180
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 15:32:59 -0400
Date: Fri, 3 Aug 2007 14:32:58 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Page faults blowing up ... [was Re: [PATCH] Fix special PTE code for
	secondary hash bucket
Message-ID: <20070803193258.GA9613@austin.ibm.com>
References: <18098.61003.38084.554299@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18098.61003.38084.554299@cargo.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, benh@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 03, 2007 at 06:58:51PM +1000, Paul Mackerras wrote:
> The code for mapping special 4k pages on kernels using a 64kB base
> page size was missing the code for doing the RPN (real page number)
> manipulation when inserting the hardware PTE in the secondary hash
> bucket.  It needs the same code as has already been added to the
> code that inserts the HPTE in the primary hash bucket.  This adds it.

So what are the symptoms of hitting this? Does this affect only 
recent kernels, or old ones too?

I'm hitting the craziest bug I've seen in a while, I get some
corrputed value in a register: 0x80000000077b21e0  which sure looks
like an address with 0x8... instead of 0xc... and, what is even
stranger, I find that 0xc0000000077b21e0 is pointing at the data
that I *should have had* in the register!  And theres some other
oddball stuff hinting that a page fault handler ran and blew up:

3:mon> d c0000000077b21e0
c0000000077b21e0 e00000008004b224 0674100900000080  |.......$.t......|

Well, howdy doody, there's the value that should have been in r3 ....

c0000000077b21f0 c4008e0000000000 0000000049424d00  |............IBM.|

IBM ???

c0000000077b2200 5048003006000000 0000000000000000  |PH.0............|
c0000000077b2210 0000000000000000 4800000300000000  |........H.......|
c0000000077b2220 0000000000000000 0000000000000000  |................|
c0000000077b2230 5548001806000000 1000400000000000  |UH........@.....|
c0000000077b2240 0000200000000000 4d43002806000000  |.. .....MC.(....|
c0000000077b2250 0000000000000001 00c3000000000000  |................|
c0000000077b2260 e00000008004b224 0000000000000000  |.......$........|
c0000000077b2270 d0000000000d32c0 8000000000101032  |......2........2|

hey .. wait .. d0000000000d32c0 is the faulting adddress; whats it doing here ???
... and 8000000000101032 is the value of the MSR ... why is that here ??

c0000000077b2280 0000000000000000 0000000000000000  |................|
c0000000077b2290 0000000000000000 0000000000000000  |................|


Any hints or tips appreciated ... btw, I should mention
I'm seeing this exact same bug on both 2.6.9 (RHEL4) and 
on 2.6.16 (SLES10) so... wtf ??? why now ? 

--linas
