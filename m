Return-Path: <joakim.tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2772667B23
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 00:30:08 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Date: Fri, 8 Apr 2005 16:29:51 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEEIEHNDCAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <86dfdfc8a80cde21c19c09403139ae3b@embeddededge.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: 8xx v2.6 TLB problems and suggested workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Dan Malek [mailto:dan@embeddededge.com]
> 
> On Apr 8, 2005, at 4:01 AM, Joakim Tjernlund wrote:
> 
> > I was looking at the DTLB Error excetion(p. 7-15) in the MPC860 User's 
> > Manual. There
> 
> Yeah, well what the manual says and what really happens seems to be
> two different things.

Yep, the manual really sucks sometimes. The manual errata is huge
so it would be more than welcome if Freesacle actually updated the
maunal with the errata items.

> 
> > .... There is also a 8xx specific test with bit 3(0x1000000) in 
> > fault.c but
> > bit 3 is always zero according the MPC860 Manual for a DTLB Error.
> 
> Read the comment.  It really happens.  I spent lots and lots of time 
> sorting
> out how the 8xx works, setting up precise test cases and examining the
> results.  Stop reading the manual too closely and create test cases to
> see what exactly happens.

OK, fine. Just wanted to hear that.

> 
> > Then we end up with bit 1(invalid TLB) and bit 6(store operation) set. 
> > Maybe one
> > could make the DTLB Error handler test if bit 1 is set and then branch 
> > to
> > DataAccess and then deal with the problem in fault.c?
> 
> No.  That is adding even more code to the "normal" path.  The TLB miss
> should simply take a value from memory and load it into the TLB.  
> Nothing
> more.  It should emulate what a hardware implementation would do ...
> eight instructions, no branches, if done properly :-)

I was talking about the TLB Error handler. The TLB Miss handler should be kept as small
as possible.

Any ideas on how to fix the problem Marcelo reported?

 Jocke

> 
> Thanks.
> 
> 
> 	-- Dan
> 
