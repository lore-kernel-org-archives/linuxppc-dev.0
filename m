Return-Path: <segher@kernel.crashing.org>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6AE26680F7
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2005 02:02:21 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id j81G2FO0069292
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Sep 2005 16:02:15 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP
	id j81G2FUO106332
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Sep 2005 18:02:15 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	j81G2EUD017260
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Sep 2005 18:02:15 +0200
In-Reply-To: <A93DEE5BF142D6419D27C298B6F463D812CCF5@mail.oerlikon.ca>
References: <A93DEE5BF142D6419D27C298B6F463D812CCF5@mail.oerlikon.ca>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <dcb98a2d90571beeb4497d78ed9af7ba@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Thu, 1 Sep 2005 18:00:51 +0200
To: "Nghiem, Tien" <TNghiem@oerlikon.ca>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, Marcin Dawidowicz <marcin.dawidowicz@kontron.pl>,
	Garcia =?ISO-8859-1?Q?J=E9r=E9mie?= <GARCIAJ@3il.fr>
Subject: Re: RE : Error while accessing physical address
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> unsigned short is 2 bytes, so you should use:
>
> regHdwAddress = (unsigned short *) ioremap((unsigned 
> short)address,0x2);

Nah.  The size doesn't matter that much (it will be mapped
with a page granularity anyway).  You just want to use

regHdwAddress = (unsigned short *)ioremap(address, 2);

Casting the address to unsigned short made the address 0x0400
instead of the address you wanted, so you destroy the ISI
vector when writing to it (and you might cause a cache paradox
as well, as the ioremap maps it uncacheable, and it might
already be in the cache at that time).


Segher
