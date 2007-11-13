Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 199FEDDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 08:43:50 +1100 (EST)
Subject: Re: Kernel locks up after calling kernel_execve()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20071113212320.85840@gmx.net>
References: <20071108214723.135260@gmx.net>
	<1194564017.6561.21.camel@pasglop> <20071109074155.266120@gmx.net>
	<1194594629.6561.34.camel@pasglop>  <20071110171130.254580@gmx.net>
	<1194753340.21340.24.camel@pasglop>  <20071113212320.85840@gmx.net>
Content-Type: text/plain
Date: Wed, 14 Nov 2007 08:43:38 +1100
Message-Id: <1194990218.28865.1.camel@pasglop>
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


On Tue, 2007-11-13 at 22:23 +0100, Gerhard Pircher wrote:
> > There are ways, sure, which probably involve adding prink's all over
> the
> > place to figure it out... could be some DMA issue for example, could
> be
> > pretty much anything. Have you tried booting an initrd with no disk
> > access ?
> I tried to boot with a ramdisk, but that didn't help much. I still
> locks up
> while loading an init program or after entering some commands in
> sh shell. Looks like the problem is hidden deep in the kernel.

Well, at least the above tells is it's not DMA related.

I don't know of any deeply hidden problem, so you are probably hitting
something else ... if you have disabled idle, then it may be useful to
try instrumenting locks or irq enable/disable.

Also, did you try booting with all kernel debug options enabled ?

Finally, since the problem seem to have started around a specific kernel
version, can you try to bisect the patch that causes it ?

Ben.
