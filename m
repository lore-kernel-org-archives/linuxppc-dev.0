Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6E7567B23
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 23:39:59 +1000 (EST)
In-Reply-To: <JPEALJAFNGDDLOPNDIEEAEHJDCAA.joakim.tjernlund@lumentis.se>
References: <JPEALJAFNGDDLOPNDIEEAEHJDCAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <86dfdfc8a80cde21c19c09403139ae3b@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 8 Apr 2005 09:39:47 -0400
To: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8xx v2.6 TLB problems and suggested workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 8, 2005, at 4:01 AM, Joakim Tjernlund wrote:

> I was looking at the DTLB Error excetion(p. 7-15) in the MPC860 User's 
> Manual. There

Yeah, well what the manual says and what really happens seems to be
two different things.

> .... There is also a 8xx specific test with bit 3(0x1000000) in 
> fault.c but
> bit 3 is always zero according the MPC860 Manual for a DTLB Error.

Read the comment.  It really happens.  I spent lots and lots of time 
sorting
out how the 8xx works, setting up precise test cases and examining the
results.  Stop reading the manual too closely and create test cases to
see what exactly happens.

> Then we end up with bit 1(invalid TLB) and bit 6(store operation) set. 
> Maybe one
> could make the DTLB Error handler test if bit 1 is set and then branch 
> to
> DataAccess and then deal with the problem in fault.c?

No.  That is adding even more code to the "normal" path.  The TLB miss
should simply take a value from memory and load it into the TLB.  
Nothing
more.  It should emulate what a hardware implementation would do ...
eight instructions, no branches, if done properly :-)

Thanks.


	-- Dan
