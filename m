Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B881DE07F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 04:59:36 +1000 (EST)
In-Reply-To: <eaf1132805a9531b5131ca51d3e8d9c8@kernel.crashing.org>
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
	<40815D64-3AD7-49C6-9A58-C7848691D940@kernel.crashing.org>
	<eaf1132805a9531b5131ca51d3e8d9c8@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <77D9DB04-FAD3-48EF-9159-5EA92BB366E5@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Tue, 29 May 2007 14:04:02 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Steve Munroe <sjmunroe@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 29, 2007, at 9:38 AM, Segher Boessenkool wrote:

>> But we can't do that any more since the architecture specifically
>> allows for the 'upper bits' not to have valid data in them.
>
> That's not PowerPC, that's BookE ;-P

Is anybody within kicking distance of Segher? ;-P

> If what you're
> saying is true in the 2.03 POWER ISA, even for server
> class implementations, that would be very unfortunate.

I believe Category:Server implementations are required to behave as  
you expect.  Category:Embedded implementations may have different  
behavior.  Like it or not, BookE *is* part of the Power architecture,  
and there are going to be 64-bit implementations of BookE that we  
need to take into account.

>
> Or perhaps you misread, there are a few insns that
> have undefined results in the high half word.  Could
> you give a reference please?
>
> If you mean Book I 1.5.2, that is for embedded class
> (i.e., BookE) CPUs only.

I think that's exactly what Kumar's talking about. The assumption  
that all 64-bit Power processors will use those upper bits in some  
meaningful way is not valid.  Also, ld and std do not architecturally  
"just work" on BookE implementations running in 32b mode.  Those  
instructions are part of the 64-bit category in 2.03, and may illop  
on BookE processors running in 32b mode.

Cheers,
-Becky
