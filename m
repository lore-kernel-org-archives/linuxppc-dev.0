Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-15.arcor-online.net
	[151.189.21.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 820F2DDFB0
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 22:36:39 +1000 (EST)
In-Reply-To: <1180526992.19517.277.camel@localhost.localdomain>
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
	<OF611013C9.F9C3C2DB-ON862572EA.0050F570-862572EA.005197A3@us.ibm.com>
	<18012.61822.197988.279764@cargo.ozlabs.ibm.com>
	<ce91696e7837282dd93df408461a64fb@kernel.crashing.org>
	<1180526470.19517.274.camel@localhost.localdomain>
	<fa74d8c78910a77c011f9e72dd750d19@kernel.crashing.org>
	<1180526992.19517.277.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <99b98cc08b91cb5b12fe37c07b3533b8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Wed, 30 May 2007 14:36:31 +0200
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

>>> Actually, it's the opposite... the prctl becomes a problem if you
>> have
>>> libs wanting to use 64 bits for optims
>>
>> The host application, or the dynamic loader, can call
>> the prctl() when it loads the DSO that needs it.
>
> Provided you know it does... and with static binaries it gets harder...

A mechanism like what is done for executable stacks
can be used, so you end up with something in the ELF
headers that tells you.  Not that I like this particular
mechanism.

>> In almost all cases this should all be transparent
>> for the user IMHO, based on some ELF flag.
>
> You reckon ? I was wondering about that ... maybe we should define some
> ELF personality for that ...
>
> But that means that existing programs wouldn't get it even while some
> libs they depend on might have such optims without the program knowing
> about it ...

Like I said, the dynamic loader should do the work
in such cases.

> Also, if I can avoid changing glibc ... (you know how hard it is !)

No really?  Tell me about it?  :-)


Segher
