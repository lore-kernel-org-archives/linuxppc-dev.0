Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 341A6DDED6
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 16:28:26 +1000 (EST)
In-Reply-To: <20070515061855.GD6998@localhost.localdomain>
References: <20070515020026.GG565@localhost.localdomain>
	<8492e53122b6e1ba269afd53b48a4968@kernel.crashing.org>
	<20070515054758.GC6998@localhost.localdomain>
	<200705150811.09927.sr@denx.de>
	<20070515061855.GD6998@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1950a79f97480ba96f1b00352ec449a5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Small fixes for the Ebony device tree
Date: Tue, 15 May 2007 08:28:09 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Anyone have any objection to the following:  each of these controllers
> should have compatible properties listing 3 string, first, a specific
> version for the CPU in question (e.g "ibm,sdram-440gp"), then a string
> based on the type as listed below, finally "ibm,sdram-4xx".

Is that last entry ever useful?  Do all those controllers
have something in common?

>> SDRAM:		all 40x (except for 405EZ)
> 	ibm,sdram-40x
>
>> DDR:		440GP, 440GX, 440EP, 440GR
> 	ibm,sdram-44x-ddr
>
>> DDR2:		440SP, 440SPe
> 	ibm,sdram-44x-ddr2
>
>> DDR2 (Denali):	440EPx, 440GRx
> 	ibm,sdram-44x-ddr2denali

Is this one a superset of the previous one?  If so,
put both names in.

> Seem reasonable?

It's better to say 440 than 44x, maybe all "441" parts
will be totally different.  I don't know what to do
with 40x; maybe say 405 as that seems to be the most
common chip.  OTOH, you don't have to deal with that
right now :-)


Segher
