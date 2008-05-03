Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44B2BDDE03
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 10:15:20 +1000 (EST)
In-Reply-To: <20080502.150448.32652665.davem@davemloft.net>
References: <BFB7B7A0-6EA9-467D-B23E-B0D46EF6BA54@kernel.crashing.org>
	<20080502.144220.53637856.davem@davemloft.net>
	<481B8B89.2030703@freescale.com>
	<20080502.150448.32652665.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8da0129209e812a5fca84cb13a3f6468@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions and
	-Os
Date: Sat, 3 May 2008 02:15:07 +0200
To: David Miller <davem@davemloft.net>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> What in libgcc references libc, and why isn't this a problem for
>> Linux/ARM, Linux/SH, U-boot, and the many other libc-less programs 
>> that
>> use libgcc?
>
> The problem only occurs once you reference a function that references
> libc stuff, and those guys are just lucky so far.

The only calls to the C library that GCC ever generates by itself
(for freestanding mode, at least) are calls to memcmp, memcpy, memmove,
memset (and abort, in some circumstances).  This is true whether or
not you link to libgcc.

> It's also one less variable to debug if you put the implementation
> in the kernel, or do you like debugging compiler induced problems?
> I don't :-)

On the other hand, if we opt to re-implement, we have to make sure
the in-kernel version of the GCC support routines is correct.  We
have to trust the compiler everywhere else already, why not here as
well?


Segher

p.s.  I just finished some testing linking a powerpc kernel with
libgcc.  All went fine, as expected.  I also did a stupid test that
actually needed a libgcc routine (__udivdi3); that went fine as well.
And yeah, I know about the modules issue, but that isn't really very
different from the analogue issue with in-kernel library routines.
