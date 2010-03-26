Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 97BB4B7CE7
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 12:55:39 +1100 (EST)
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Csdncannon <csdncannon@gmail.com>
In-Reply-To: <43c137a81003251811s52ac72eaud921d187e9747098@mail.gmail.com>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<1269505301.8599.238.camel@pasglop> <201003251105.10033.arnd@arndb.de>
	<43c137a81003250800n660195c5k42c8516068aeda8d@mail.gmail.com>
	<1269549524.8599.243.camel@pasglop>
	<43c137a81003251811s52ac72eaud921d187e9747098@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 26 Mar 2010 12:55:27 +1100
Message-ID: <1269568527.8599.259.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-03-26 at 09:11 +0800, Csdncannon wrote:
> After trying the new code with "isync" and unsigned long long
> convertion, this problem doesn't happen(I tested for several minutes).
> But the previous block of codes(lacking of isync) is borrowed from
> kernel. And if this is a bug of kernel?

There's an outstanding question about that. Some processors make mftb
context synchronizing but it appears that it may not be the case for all
of them.

Thus indeed, we -might- need some isync's in some places, it's not
totally clear to me though.

Can you send the code that fails (without the isync) ? The one you sent
did have them everywhere.

Cheers,
Ben.

> Thanks
> Gino
> 
> 2010/3/26 Benjamin Herrenschmidt <benh@kernel.crashing.org>
>         On Thu, 2010-03-25 at 23:00 +0800, Csdncannon wrote:
>         > I am really sorry that the previously attached code is
>         wrong, this one
>         > "timebase.c" is the right one, and the "log_timebase" file
>         is the
>         > right log.
>         >
>         > We are using FreeScale PowerPc 8378, kernel 2.6.28 and
>         compiled as
>         > 32-bit.
>         
>         
>         And despite all those sync/isync you can still observe the
>         timebase
>         going backward ? That sounds scary. However, at this stage all
>         I can
>         suggest is getting freescale folks to have a look, as this
>         should really
>         not happen. Maybe there's some setting with that specific SoC
>         that is
>         missing or similar...
>         
>         Cheers,
>         Ben.
>         
>         
>         >
>         > Thanks
>         > Gino
>         >
>         > 2010/3/25 Arnd Bergmann <arnd@arndb.de>
>         >         On Thursday 25 March 2010, Benjamin Herrenschmidt
>         wrote:
>         >         > On Thu, 2010-03-25 at 10:41 +0800, Csdncannon
>         wrote:
>         >         > >          In my program, the value of the 64-bit
>         time base
>         >         register is
>         >         > > read out, and you will find the later value is
>         even
>         >         smaller than the
>         >         > > earlier value from the log “log_timebase”. While
>         the
>         >         kernel depends on
>         >         > > the accuracy of the timebase for the
>         compensation of the
>         >         lost PIT
>         >         > > interrupt, the negative value between two
>         continual
>         >         timebase reading
>         >         > > will bring to the jump of the jiffies. And this
>         timebase
>         >         problem will
>         >         > > bring to the instability of the gettimeofday
>         system call.
>         >         > >
>         >         > >          Do you have any idea about this
>         problem, thanks
>         >         for your any
>         >         > > advice. Attached is the code and log.
>         >         >
>         >         > This is a concern, it should definitely not
>         happen. What
>         >         machine is
>         >         > that ? is the code compiled 32-bit or 64-bit ?
>         What kernel
>         >         version ?
>         >         >
>         >         > Arnd, any chance that could relate to the bug
>         you've been
>         >         chasing on
>         >         > Cell ?
>         >
>         >
>         >         We're still busy with the problem analysis on Cell,
>         waiting
>         >         for a time
>         >         slot to run the next test kernel. So far it seems
>         like the
>         >         timebase
>         >         is actually synchronized at a significant accuracy
>         on QS22 to
>         >         never
>         >         cause this problem with correct code, however it is
>         possible
>         >         to
>         >         observe incorrect timebase values on Cell whenever
>         the mftb
>         >         instruction
>         >         is not serialized with memory accesses, e.g. by
>         using an isync
>         >         in front
>         >         of the mftb. On Power6 and other CPUs, that problem
>         will not
>         >         happen.
>         >
>         >                Arnd
>         >
>         
>         
>         
> 
