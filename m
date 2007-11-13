Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36B66DDE0C
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 10:38:02 +1100 (EST)
Subject: Re: Kernel locks up after calling kernel_execve()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20071113220655.85840@gmx.net>
References: <20071108214723.135260@gmx.net>
	<1194564017.6561.21.camel@pasglop> <20071109074155.266120@gmx.net>
	<1194594629.6561.34.camel@pasglop>  <20071110171130.254580@gmx.net>
	<1194753340.21340.24.camel@pasglop>  <20071113212320.85840@gmx.net>
	<1194990218.28865.1.camel@pasglop>  <20071113220655.85840@gmx.net>
Content-Type: text/plain
Date: Wed, 14 Nov 2007 10:37:52 +1100
Message-Id: <1194997072.28865.5.camel@pasglop>
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


On Tue, 2007-11-13 at 23:06 +0100, Gerhard Pircher wrote:
> Well, I only disabled power saving with powersave=off. Are there any
> other
> ways to disable idle? What do you mean with instrumenting locks or
> irq enable/disable?

Add printk's to things :-) It's a UP kernel so there should be no
spinlocks anyway.

Best is to try to get a 100% reprocase and printk your way toward the
origin of the problem if you don't have a HW debugger. Unless you manage
to sneak in an irq to xmon but if you are totally locked up, you
probably can't.

Could also be something you do that your buggy northbridge doesn't like.
For example, maybe it dislikes M bit in the hash table and you end up
with it set due to other reasons (I know we had changes in this area).

> > Also, did you try booting with all kernel debug options enabled ?
> I compiled in almost all kernel debugging options and booted the
> kernel
> with driver_debug, initcall_debug and debug. I didn't notice any
> serious
> error messages so far. Not sure however, if I missed a debug option.
> 
> > Finally, since the problem seem to have started around a specific
> kernel
> > version, can you try to bisect the patch that causes it ?
> Hmm, I'm not sure how to do this (only worked on platform code so
> far).
> I guess you think about checking out a kernel version from the git
> repository, which doesn't contain the patch for kernel_execve().
> I still suspect the kernel_execve() function (which was introduced in
> 2.6.17) because the kernel locks up after starting the first user
> program.
> AFAIK kernel threads should be running much earlier.

They are but they cause a lot less MMU pressure, could be an
indication...

Ben.
