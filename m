Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-15.arcor-online.net
	[151.189.21.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 60D90DDF40
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 22:30:41 +1000 (EST)
In-Reply-To: <77D9DB04-FAD3-48EF-9159-5EA92BB366E5@freescale.com>
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
	<40815D64-3AD7-49C6-9A58-C7848691D940@kernel.crashing.org>
	<eaf1132805a9531b5131ca51d3e8d9c8@kernel.crashing.org>
	<77D9DB04-FAD3-48EF-9159-5EA92BB366E5@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e828d1001d889137bdb8bdab956f39f2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Wed, 30 May 2007 14:30:34 +0200
To: Becky Bruce <becky.bruce@freescale.com>
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

>> If what you're
>> saying is true in the 2.03 POWER ISA, even for server
>> class implementations, that would be very unfortunate.
>
> I believe Category:Server implementations are required to behave as 
> you expect.  Category:Embedded implementations may have different 
> behavior.  Like it or not, BookE *is* part of the Power architecture, 
> and there are going to be 64-bit implementations of BookE that we need 
> to take into account.

Sure.  How about we worry about this when support for
such CPUs is added _at all_ to Linux; for this issue,
the only required change would be to refuse the prctl()
call, right?

>> If you mean Book I 1.5.2, that is for embedded class
>> (i.e., BookE) CPUs only.
>
> I think that's exactly what Kumar's talking about. The assumption that 
> all 64-bit Power processors will use those upper bits in some 
> meaningful way is not valid.  Also, ld and std do not architecturally 
> "just work" on BookE implementations running in 32b mode.  Those 
> instructions are part of the 64-bit category in 2.03, and may illop on 
> BookE processors running in 32b mode.

Sounds like it will be a lovely effort to add support for
such CPUs to Linux.


Segher
