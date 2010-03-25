Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 8B18EB7C7E
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 21:10:26 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
Date: Thu, 25 Mar 2010 11:05:09 +0100
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<1269505301.8599.238.camel@pasglop>
In-Reply-To: <1269505301.8599.238.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201003251105.10033.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Csdncannon <csdncannon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 25 March 2010, Benjamin Herrenschmidt wrote:
> On Thu, 2010-03-25 at 10:41 +0800, Csdncannon wrote:
> >          In my program, the value of the 64-bit time base register is
> > read out, and you will find the later value is even smaller than the
> > earlier value from the log “log_timebase”. While the kernel depends on
> > the accuracy of the timebase for the compensation of the lost PIT
> > interrupt, the negative value between two continual timebase reading
> > will bring to the jump of the jiffies. And this timebase problem will
> > bring to the instability of the gettimeofday system call.
> > 
> >          Do you have any idea about this problem, thanks for your any
> > advice. Attached is the code and log.
> 
> This is a concern, it should definitely not happen. What machine is
> that ? is the code compiled 32-bit or 64-bit ? What kernel version ?
> 
> Arnd, any chance that could relate to the bug you've been chasing on
> Cell ?

We're still busy with the problem analysis on Cell, waiting for a time
slot to run the next test kernel. So far it seems like the timebase
is actually synchronized at a significant accuracy on QS22 to never
cause this problem with correct code, however it is possible to
observe incorrect timebase values on Cell whenever the mftb instruction
is not serialized with memory accesses, e.g. by using an isync in front
of the mftb. On Power6 and other CPUs, that problem will not happen.

	Arnd
