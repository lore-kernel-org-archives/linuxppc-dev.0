Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98C1CDDE38
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 09:51:49 +1000 (EST)
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20070602085359.GA10333@iram.es>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
	<20070602085359.GA10333@iram.es>
Content-Type: text/plain
Date: Sun, 03 Jun 2007 09:51:38 +1000
Message-Id: <1180828298.14025.24.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> By far the most important registers are the ones at 0x20 since
> you access them at every interrupt. The registers at 0x4d0
> are typically set by firmware and never touched later, there
> is not a single access to them in sysdev/i8259.c.
> 
> I have vague memories of a node named i8259@20 one a board 
> who had OF in 1997 (a Motorola MVME but they switched to 
> PPCBUG just after :-().

Here's the entry for a 8259 in an old pSeries device-tree:

(Note the use of the recommended naming practice where the name is
actually the device-class)

/proc/device-tree/pci@fef00000/isa@b/interrupt-controller@i20:
name             "interrupt-controller"
linux,phandle    00ceed58 (13561176)
interrupt-parent 00c73068 (13054056)
interrupt-controller

#interrupt-cells 00000002
interrupts       00000000 00000002
reserved-interrupts
                 00000002 00000003
reg              00000001 00000020 00000002 00000001
                 000000a0 00000002 00000001 000004d0
                 00000002
compatible       "chrp,iic"
built-in
model            "WINB,W83C553"
device_type      "interrupt-controller"
ibm,loc-code     "P2"
