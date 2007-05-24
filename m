Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C248DDEAB
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 08:08:34 +1000 (EST)
In-Reply-To: <200705242316.29713.arnd@arndb.de>
References: <4655C7A6.2050606@mvista.com> <200705242221.17790.arnd@arndb.de>
	<1180038295.3360.29.camel@zod.rchland.ibm.com>
	<200705242316.29713.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bd721e3985ba0b54ea1a00c2f4acd993@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 440 ebony patch seems to have broken 85xx build on powerpc.git
Date: Fri, 25 May 2007 00:08:28 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 1. Pass -Wa,-many to gcc
> This will really allow any possible instruction to be assembled, 
> including
> the old POWER architecture, but also includes all the other strange
> stuff like -maltivec, -mspe, -me500, ...

And it doesn't prevent the compiler from compiling insns
that can never work on the platform; for example, the
compiler in the original bug report will happily put isel
insns all over the place.

> 2. protect the use of special instructions with .machine directives.
> You can write all the inline assemblies like
>
> 	.machine push
> 	.machine 440
> 	<440 specific instruction>
> 	.machine pop
>
> This should work in any reasonably recent version of binutils, meaning
> that we don't need to pass stuff like -Wa,-m440 any more.

[You don't need the assembler flag at all, just the compiler
flag -mcpu=440].

This of course works, but is ultra-silly to do in a file
that will never run on anything other than 440 systems.


Segher
