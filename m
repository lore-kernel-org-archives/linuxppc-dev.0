Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8898FDDFE9
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 08:15:24 +1000 (EST)
Message-ID: <481B92A7.3070302@freescale.com>
Date: Fri, 02 May 2008 17:16:07 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions and
	-Os
References: <BFB7B7A0-6EA9-467D-B23E-B0D46EF6BA54@kernel.crashing.org>	<20080502.144220.53637856.davem@davemloft.net>	<481B8B89.2030703@freescale.com>
	<20080502.150448.32652665.davem@davemloft.net>
In-Reply-To: <20080502.150448.32652665.davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:
> The problem only occurs once you reference a function that references
> libc stuff, and those guys are just lucky so far.

Yeah, lucky they don't need to reinvent the wheel every time the 
GCC/libgcc interface changes. :-)

If GCC generates a call to a libgcc function that calls a libc function, 
I'd consider that a pretty serious bug, given that said libc function is 
likely to consist of GCC-generated code, which could call the same 
libgcc function, which calls the libc function, etc.

> It's also one less variable to debug if you put the implementation
> in the kernel, or do you like debugging compiler induced problems?
> I don't :-)

I'd say problems are more likely if you use nonstandard implementations 
of GCC internals...

-Scott
