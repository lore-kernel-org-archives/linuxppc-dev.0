Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 999ECDDF0D
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 03:41:32 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0KGfQsC017737
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 09:41:26 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n0KGfPOF023149
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 10:41:25 -0600 (CST)
Date: Tue, 20 Jan 2009 10:41:24 -0600
From: Scott Wood <scottwood@freescale.com>
To: Daniel Ng <daniel.ng1234@gmail.com>
Subject: Re: Device Tree setup for 8272-based board
Message-ID: <20090120164124.GC8978@ld0162-tx32.am.freescale.net>
References: <547eba1b0901151722p4a6afce4nc769fcb8cff82ea6@mail.gmail.com>
	<547eba1b0901151940x588ead2bk52342ea1cecc6db0@mail.gmail.com>
	<20090116181405.GB722@ld0162-tx32.am.freescale.net>
	<547eba1b0901181758q27d09f1fx7d07d7385f028312@mail.gmail.com>
	<547eba1b0901192323i2a505dcg841d42092dc5dd5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <547eba1b0901192323i2a505dcg841d42092dc5dd5d@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 20, 2009 at 06:23:08PM +1100, Daniel Ng wrote:
> PID hash table entries: 128 (order: 7, 512 bytes)
> time_init: decrementer frequency = 16.500000 MHz
> time_init: processor frequency   = 330.000000 MHz
> clocksource: timebase mult[f26c9b2] shift[22] registered
> clockevent: decrementer mult[439] shift[16] cpu[0]
> Console: colour dummy ü
> 
> -at this point the board just reboots.

Looks like something goes wrong when the real serial driver kicks in.

> I thought it might have been to do with:
> 
> 'No hpxred-bcsr in device tree'
> 
> If I add in a 'BCSR' node to my Device Tree I get the following:

Don't add random nodes unless they correspond to hardware that's actually
there.

> Which leads me to think BCSR is irrelevant for my board. What is BCSR?

Board control and status registers.

> Another possibility might be that I have set the following in the kernel-
> 
> CONFIG_HZ=250
> 
> -this is in contrast to the above reported 330Mhz.

Those are two different things.  CONFIG_HZ is the frequency of timer
interrupts that Linux requests.

> In the "2.6.14+old u-boot" setup, I had also configured u-boot such
> that the memory was set to 64MB, but I told the kernel it was either
> 32MB or 64MB depending on what was physically available. This was so I
> could use the same u-boot for boards with either 32MB or 64MB. Is it
> still possible to do this for the new u-boot and kernel 2.6.27?

Yes, but it would be much better if u-boot could figure this out
dynamically.

-Scott
