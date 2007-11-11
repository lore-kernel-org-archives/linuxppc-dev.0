Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5DAD6DDEC4
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Nov 2007 14:55:52 +1100 (EST)
Subject: Re: Kernel locks up after calling kernel_execve()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20071110171130.254580@gmx.net>
References: <20071108214723.135260@gmx.net>
	<1194564017.6561.21.camel@pasglop> <20071109074155.266120@gmx.net>
	<1194594629.6561.34.camel@pasglop>  <20071110171130.254580@gmx.net>
Content-Type: text/plain
Date: Sun, 11 Nov 2007 14:55:40 +1100
Message-Id: <1194753340.21340.24.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2007-11-10 at 18:11 +0100, Gerhard Pircher wrote:
> -------- Original-Nachricht --------
> > Datum: Fri, 09 Nov 2007 18:50:29 +1100
> > Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > An: Gerhard Pircher <gerhard_pircher@gmx.net>
> > CC: linuxppc-dev@ozlabs.org
> > Betreff: Re: Kernel locks up after calling kernel_execve()
> 
> > 
> > > I tried to use /bin/sh as init program and was able to enter a command,
> > > but then the machine locked up, too.
> > > Could that be a problem with a CPU sleeping/idle code?
> > 
> > That's possibly an issue, try disabling power save if any for that CPU
> > type. If it worked and broke, you may have to bisect tho.
> I disabled the powersaving code by adding powersave=off to the kernel's
> command line, but it didn't help. It seems to lockup whenever it tries to
> access a filesystem.
> Is there a way to debug it without a hardware debugger or can you
> recommend a cheap hardware debugger?

There are ways, sure, which probably involve adding prink's all over the
place to figure it out... could be some DMA issue for example, could be
pretty much anything. Have you tried booting an initrd with no disk
access ?

Ben.
