Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7D4CDDE30
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 08:48:08 +1000 (EST)
In-Reply-To: <46A798D8.7020906@freescale.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<20070725165326.5331.19920.stgit@localhost.localdomain>
	<46A78322.3080607@ru.mvista.com> <46A78E3F.1030904@ru.mvista.com>
	<20070725180145.GA29689@ld0162-tx32.am.freescale.net>
	<46A7941F.2050300@ru.mvista.com> <46A798D8.7020906@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <14924a51c8a1664a21a85f450d503e82@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver for
	CF	interface
Date: Wed, 1 Aug 2007 00:47:57 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>    I never suggested that -- what I did suggest was make of_serial.c
>> recognize certain chip types and register them with 8250 driver.
>
> What would be the advantage of maintaining a list of chips whose only
> difference is register spacing, rather than just using reg-shift and
> being done with it?

reg-shift alone isn't enough to know how to access the device
registers.  In the case of UARTs, they typically are internal
to some SoC, so the device driver can just look up what SoC it
is and will then know what to do.  For IDE though, as far as I
understand it typically is board-specific, done by some glue
logic off of some GPIOs or on an FPGA; I think detection is best
handled by platform code in this case, an "mmio-ide" shim driver
would be helpful of course.


Segher
