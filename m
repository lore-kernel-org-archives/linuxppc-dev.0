Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8CE1DDDF34
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 11:33:45 +1000 (EST)
Date: Wed, 4 Apr 2007 02:36:37 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070404023637.65c56227@the-village.bc.nu>
In-Reply-To: <20070403.182125.77058566.davem@davemloft.net>
References: <17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<20070403.165518.55726194.davem@davemloft.net>
	<20070404021924.71e87580@the-village.bc.nu>
	<20070403.182125.77058566.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: dwmw2@infradead.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Using different majors for different instances of the exact same kind
> of device is really not smart.  It's a serial port, and if you try
> to dress it up to be something else you run into all kinds of problems.

Disagree. There are lots of good reasons you need to know which
port/which card/which slot/which multiplexor.

There is a world of a difference between a serious serial port
application and "wtf has my console gone"

> Not the least of which is the user has to scratch his head figuring
> out what kind of chip drives his serial console, he just wants the
> first serial port and he should have a way to say just that even
> on the kernel command line.

Define "first". First by I/O order, by PCI scan order (and which type),
does ACPI come before or after ISA etc...

At the moment we sort of magic this for the PC by having hardcoded probe
order hacks by address, on the sparc by having other driver magic, on the
PPC by hardcoding some rules etc then hack the result to be ttyS0.

I've no fundamental problem with S0->console port 1, S1 -> console port 2
etc, but the general notion that type and positional information doesn't
matter is complete and utter bollocks when you try and apply it to any
serious serial setup.

Alan
