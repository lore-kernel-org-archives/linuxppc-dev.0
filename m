Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-15.arcor-online.net
	[151.189.21.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CA5B3DDF23
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:40:55 +1000 (EST)
In-Reply-To: <1180475055.19517.206.camel@localhost.localdomain>
References: <OF611013C9.F9C3C2DB-ON862572EA.0050F570-862572EA.005197A3@us.ibm.com>
	<1180475055.19517.206.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3cbbec8c34b1beabb091c343132730d5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Wed, 30 May 2007 13:40:44 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Steve Munroe <sjmunroe@us.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Also if you want to debug this code (see long long variables 
>> correctly from
>> GDB or even see the upper 32-bits of GPRs) you will need an ABI 
>> change so
>> that GDB/DWARF knows what to do.
>
> I personally don't care about gdb seeing those or anything like that,
> those would be strictly local asm optimisations, at least that's my
> point of view on the matter.

GDB can step into asm though, it will have to know
about it for full functionality.

> I intend not to extend or change the shape of ucontext neither. I'll 
> add
> the highregs after the ucontext32 on the compat signal frame, the only
> change/addition is the use of a pad field to point to it and maybe
> setting a flag that was previously unused and always 0 to indicate that
> it's there.
>
> Do you see any possible compatibility problem there ? Do you know of 
> any
> piece of software that makes hard assumptions on the shape and size of 
> a
> complete signal frame (not just the ucontext part of it) ?

Perhaps something in a test suite somewhere; other
than that, nothing important I suspect.  Well some
version of some JVM will abuse it I'm sure ;-)


Segher
