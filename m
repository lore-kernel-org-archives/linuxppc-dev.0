Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA4A2DDFAC
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 00:49:35 +1100 (EST)
In-Reply-To: <20070320035005.GB21124@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172757.GC29784@ld0162-tx32.am.freescale.net>
	<20070320035005.GB21124@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e07db139f025494f172389e2773a2e32@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 03/17] bootwrapper: Add xlate_reg(),
	and use it to find serial registers.
Date: Wed, 21 Mar 2007 14:49:30 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> xlate_reg() uses the ranges properties of a node's parentage to find 
>> the
>> absolute physical address of the node's registers.
>>
>> The ns16550 driver uses this when no virtual-reg property is found.
>
> This is a pretty large chunk of code for use on just some platforms.
> Remind me why we can't just insist on the presence of virtual-reg?

Because "virtual-reg" is evil and should preferably never
be used?  On the other hand, address translation for directly
memory mapped devices via "ranges" properties is a darn
solid, quite flexible, and proven mechanism.

I didn't look at the actual code but it should be really
small; I hope it doesn't copy the Linux code with its
millions of workarounds for broken device trees -- we
should insist on correct trees, or even just fix them
if they *are* broken ;-)


Segher
