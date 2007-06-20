Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A2D6DDED9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 02:07:56 +1000 (EST)
In-Reply-To: <46795026.8040502@ru.mvista.com>
References: <1182298509.5674.356.camel@rhino>
	<567a30ea184b6efc37e4c5df60fea1ac@kernel.crashing.org>
	<46795026.8040502@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <000737fbc16c8d25bb3ebcdc9bbd9eab@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix I8042 IRQs on MPC8641 HPCN
Date: Wed, 20 Jun 2007 18:07:36 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> 	 * IRQ 9:  Level
>>> 	 * IRQ 10: Level
>>> 	 * IRQ 11: Level
>>> -	 * IRQ 12: Level
>>> +	 * IRQ 12: Edge
>>> 	 * IRQ 14: Edge
>>> 	 * IRQ 15: Edge
>>> 	 */
>>> -	outb(0xfa, 0x4d0);
>>> -	outb(0x1e, 0x4d1);
>>> +	outb(0xf8, 0x4d0);
>>> +	outb(0x0e, 0x4d1);
>> The comment doesn't mention IRQ13.  You're changing IRQ9
>> to edge as well; is this an accident?
>
>    Whare -- I'm only seeing bit 1 changing which corresponds to IRQ1 
> and is reserved (0) anyway.

Uh yeah, bit 1, it's hard to count these single-byte quantities :-)

>>  If not, you need to change the comment too.


Segher
