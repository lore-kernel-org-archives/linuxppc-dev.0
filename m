Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13CD9DDED9
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 08:07:11 +1000 (EST)
Message-ID: <46673009.6000109@freescale.com>
Date: Wed, 06 Jun 2007 17:07:05 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: MPC8349ea Random Device Generator driver
References: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
	<46672DB4.80504@freescale.com> <20070606220913.GA27820@lixom.net>
In-Reply-To: <20070606220913.GA27820@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, sl@powerlinux.fr,
	Philippe Lachenal <philippe.lachenal@hotmail.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:

> There's nothing wrong with the way he coded that up. Lots of drivers
> are written that way (all of mine are). It's at least as clear as any
> structure, and it doesn't cause temptation to do...

That vast majority of Freescale SOC device register maps are handled via a structure. 
He's doing everything via 32-bit operations, even though the registers are 64 bits, and 
therefore he has twice as much macros as he needs.

>>> +
>>> +
>>> +	/* check for things like FIFO underflow */
>>> +	
>>> +	u32 v;
>>> +
>>> +	v = in_be32(rng_regs + TALITOS_RNGISR_HI);
>> 	u64 v;
>> 	v = rng->rngisr;
>>
>> or something like that.  Try to use the built-in support for 64-bit data types when possible.
> 
> ...this. NO! Don't reference ioremapped memory from regular code like
> that. The way he's doing it is the preferred way.

Can you explain that better?  What is "regular code"?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
