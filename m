Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id F066DDDE1B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 07:45:22 +1100 (EST)
Message-ID: <49D280E0.9020701@mlbassoc.com>
Date: Tue, 31 Mar 2009 14:45:20 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: "Matthew L. Creech" <mlcreech@gmail.com>
Subject: Re: MPC83xx console : no output after handover
References: <5ee96a840903311330y36ed97bet92319da8d118086@mail.gmail.com>
In-Reply-To: <5ee96a840903311330y36ed97bet92319da8d118086@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matthew L. Creech wrote:
> (Sorry if this is a dupe, but I think my first attempt was filtered out)

Nope, it made it.

> Hi,
> 
> I'm trying to get Linux booting on a custom board based on the MPC8313
> ERDB, but there's no output after the console is transferred.  I get
> the following:
> 
> Using MPC831x RDB machine description
> Linux version 2.6.29 (mlcreech@lap) (gcc version 4.3.2 (Sourcery G++ Lite 4.3-50
> ) ) #2 PREEMPT Tue Mar 31 14:54:27 EDT 2009
> console [udbg0] enabled
> 
> ... (normal boot output) ...
> 
> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A
> console handover: boot [udbg0] -> real [ttyS0]
> serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 17) is a 16550A
> 
> If I boot with "console=udbg0,115200", then it gets much further along
> before printing "turn off boot console udbg0".  So presumably the
> kernel is booting beyond this point, but my console isn't printing any
> output.  I traced from that last line back up the call stack to the
> end of drivers/serial/8250.c:serial8250_init(), and everything seems
> okay (it returns 0, and pritnk() still works fine at that point).  I'm
> not sure where to go from there to figure out where the problem lies.
> Could someone point me in the right direction, or suggest what might
> cause a console problem like this?

What does your command line (boot args) when it fails?  It should
probably have something like "console=ttyS0,115200" in it.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
