Return-Path: <segher@kernel.crashing.org>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5DFA467C92
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jul 2005 23:28:42 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id j6EDSYYR202558
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jul 2005 13:28:34 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j6EDSYW9181538
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jul 2005 15:28:34 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	j6EDSX5U006457
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jul 2005 15:28:34 +0200
In-Reply-To: <20050714010246.GC15769@sneetch.ozlabs.ibm.com>
References: <1120859097.8609.15.camel@cashmere.sps.mot.com>
	<20050711045532.GC32545@localhost.localdomain>
	<1121116950.15394.14.camel@cashmere.sps.mot.com>
	<20050712020126.GE3945@localhost.localdomain>
	<597c90908e1aae7e7917be736d8901a3@kernel.crashing.org>
	<20050714010246.GC15769@sneetch.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <222f5734355eba22f7662b47f46355b2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Thu, 14 Jul 2005 15:29:30 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH: Add memreserve to DTC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> My mistake, I misunderstood the terminology.  But the basic point is
> that lots of things in the kernel already assume a cell is 32-bits, so
> it would be silly to try and change that here.  This is not true for
> the memreserve values.

Of course you should use 32-bit values; but please just don't call it
a cell, there's nothing more confusing than messing up terminology.

>> Btw -- beware of the fact that such an "int" does _not_ have any
>> alignment restrictions -- so you better read it byte by byte...
>
> Erm.. in what context.  dtc never reads ints from the blob format as
> ints - properties are just byte strings to it.  At present you can't
> mix cell input format with other sorts, which means the ints must, in
> fact, be aligned, since properties are.

When reading integers from properties that have been created by an OF
implementation.  Whether this is a problem for DTC or not, I don't know;
I just thought I'd mention the problem to you, people fall in that trap
again and again.


Segher
