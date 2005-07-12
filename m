Return-Path: <segher@kernel.crashing.org>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 984C467B79
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2005 18:01:32 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.12.10/8.12.10) with ESMTP id j6C81NmE177214
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2005 08:01:23 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j6C81Nvo164024
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2005 10:01:23 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	j6C81MRT004241
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2005 10:01:22 +0200
In-Reply-To: <20050712020126.GE3945@localhost.localdomain>
References: <1120859097.8609.15.camel@cashmere.sps.mot.com>
	<20050711045532.GC32545@localhost.localdomain>
	<1121116950.15394.14.camel@cashmere.sps.mot.com>
	<20050712020126.GE3945@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <597c90908e1aae7e7917be736d8901a3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 12 Jul 2005 10:02:16 +0200
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

>>>  and forcing the user to
>>> split up these 64-bit quantities into cells is kind of silly.
>>
>> Hey, I didn't set that up! :-)  There wasn't an existing
>> clean way to state 64 bit values, and an arbitrary list of
>> them.  So I uh, leveraged the existing cell_t support!
>
> Cells make sense for the actual OF-like data, becayse they're an OF
> concept.  For memreserve, which is purely Linux specific, they don't/

No.  This is _not_ what is called a cell.  "Cell" is a Forth concept.
A cell can be any size.  Open Firmware puts the extra restriction on it
to be _at least_ 32 bits.

The thing you are referring to is what is called in OF

	"32-bit integer property encoding format".

It is defined to always be 32-bit, and not the cell size of the 
firmware,
so that you can use a 64-bit firmware with a 32-bit OS, and vice versa
(of course there could be different reasons why this isn't practical, 
but
that's not the point).

In OF words, this format is normally abbreviated as "int".

Btw -- beware of the fact that such an "int" does _not_ have any
alignment restrictions -- so you better read it byte by byte...


Segher
