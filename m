Date: Tue, 31 Jul 2001 08:05:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: James F Dougherty <jfd@GigabitNetworks.COM>
Cc: mgreer@mvista.com, linuxppc-embedded@lists.linuxppc.org,
	ppcboot-users@lists.sourceforge.net
Subject: Re: ISA SIO Problems
Message-ID: <20010731080552.B15710@opus.bloom.county>
References: <200107310352.UAA02739@krakatoa.gigabitnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200107310352.UAA02739@krakatoa.gigabitnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 30, 2001 at 08:52:09PM -0700, James F Dougherty wrote:

> When I fixed this, I immediately got console garbage (DLL value wrong for baud),
> so I hard-coded the com1 uart baud to 9600 as a temporary hack.

Er, check out the 'serial_struct' I think it is, in include/linux/serial.h,
you might try setting the 'custom_divisor' field, maybe..

> On the baud mismatch, I found out that my system uses a 14.3Mhz UART crystal,
> so the baud rates should change. Is there a clean way to change a #define, or
> should I define my own baud2code/code2baud translation routines. What is the
> cleanest way todo this?

In include/asm-ppc/mousse_serial.h: #define BASE_BAUD (14300000 / 16) maybe?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
