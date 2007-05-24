Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2F5C9DDDF3
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 08:02:52 +1000 (EST)
In-Reply-To: <200705242221.17790.arnd@arndb.de>
References: <4655C7A6.2050606@mvista.com>
	<2ded9f19fbaf49a89ed6e32de87f5828@kernel.crashing.org>
	<1180035543.3360.25.camel@zod.rchland.ibm.com>
	<200705242221.17790.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <ab81cfaedb70d6911fcbac9c43f5cf69@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 440 ebony patch seems to have broken 85xx build on powerpc.git
Date: Fri, 25 May 2007 00:02:44 +0200
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

>>> Nothing is telling GCC what CPU to compile for, so it
>>> will just use the compiler's default, which very likely
>>> is not what you want. =A0For files that will only ever
>>> be used on 440, the correct flags are -mcpu=3D440 -Wa,-m440 .
>>
>> We could add that to the per-file flags already, right?
>
> I think it should really use -mcpu=3Dpowerpc on all files.
> The problem that Dave saw was the result of using a compiler
> that defaults to -mcpu=3D8540, which uses instruction that
> don't work on 440.

No, those options _do_ work on 440, but the -mbooke
assembler flag disallows isel (since it is an optional
insn).

> The common files really need to be built with -mcpu flags that
> make the code work on any system if you want to be able
> to use just a single boot wrapper binary for all.

On any system where they can run at all, yes.  It should
be fine to compile a 440-only file with 440-specific flags.


Segher
