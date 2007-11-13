Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E01FBDDE2B
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 09:06:58 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 13 Nov 2007 23:06:55 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1194990218.28865.1.camel@pasglop>
Message-ID: <20071113220655.85840@gmx.net>
MIME-Version: 1.0
References: <20071108214723.135260@gmx.net>	 <1194564017.6561.21.camel@pasglop>
	<20071109074155.266120@gmx.net>	 <1194594629.6561.34.camel@pasglop>
	<20071110171130.254580@gmx.net>	 <1194753340.21340.24.camel@pasglop>
	<20071113212320.85840@gmx.net> <1194990218.28865.1.camel@pasglop>
Subject: Re: Kernel locks up after calling kernel_execve()
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Wed, 14 Nov 2007 08:43:38 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: Kernel locks up after calling kernel_execve()

> Well, at least the above tells is it's not DMA related.
> 
> I don't know of any deeply hidden problem, so you are probably hitting
> something else ... if you have disabled idle, then it may be useful to
> try instrumenting locks or irq enable/disable.
Well, I only disabled power saving with powersave=off. Are there any other
ways to disable idle? What do you mean with instrumenting locks or
irq enable/disable?

> Also, did you try booting with all kernel debug options enabled ?
I compiled in almost all kernel debugging options and booted the kernel
with driver_debug, initcall_debug and debug. I didn't notice any serious
error messages so far. Not sure however, if I missed a debug option.

> Finally, since the problem seem to have started around a specific kernel
> version, can you try to bisect the patch that causes it ?
Hmm, I'm not sure how to do this (only worked on platform code so far).
I guess you think about checking out a kernel version from the git
repository, which doesn't contain the patch for kernel_execve().
I still suspect the kernel_execve() function (which was introduced in
2.6.17) because the kernel locks up after starting the first user program.
AFAIK kernel threads should be running much earlier.

Thanks!

regards,

Gerhard
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
