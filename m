Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 500A6DDFBA
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 08:37:39 +1000 (EST)
Message-ID: <481B97DD.5070103@freescale.com>
Date: Fri, 02 May 2008 17:38:21 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions and
	-Os
References: <481B8B89.2030703@freescale.com>	<20080502.150448.32652665.davem@davemloft.net>	<481B92A7.3070302@freescale.com>
	<20080502.153059.91956773.davem@davemloft.net>
In-Reply-To: <20080502.153059.91956773.davem@davemloft.net>
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
> From: Scott Wood <scottwood@freescale.com>
> Date: Fri, 02 May 2008 17:16:07 -0500
> 
>> If GCC generates a call to a libgcc function that calls a libc function, 
>> I'd consider that a pretty serious bug, given that said libc function is 
>> likely to consist of GCC-generated code, which could call the same 
>> libgcc function, which calls the libc function, etc.
> 
> Not really, there are several interfaces in libgcc that need some
> runtime help from the C library or the dynamic linker.
> 
> For example, EH frame support.

...which is in libgcc_eh, not libgcc, and is in support of features not 
found in the language that libc is implemented in, avoiding any 
possibility of a cyclic dependency.  And the sort of libc functions it 
uses are basic, standard things like memcpy and malloc.  Much easier and 
more stable to implement than the internal libgcc interface.

> You really don't know what you're talking about.

Yawn.

>> I'd say problems are more likely if you use nonstandard implementations 
>> of GCC internals...
> 
> The kernel is a special environment.  Therefore even if you start
> linking with libgcc, it is inevitable that you will need some
> changed local version for some of those routines in the kernel.

Such as?

-Scott
