Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AC58367A45
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 11:00:42 +1100 (EST)
Received: from [192.100.16.36] (kiwi.ovro.caltech.edu [192.100.16.36])
	by ovro.ovro.caltech.edu (8.13.1/8.13.1) with ESMTP id k1A00cgi020080
	for <linuxppc-embedded@ozlabs.org>; Thu, 9 Feb 2006 16:00:38 -0800
Message-ID: <43EBD715.4020303@ovro.caltech.edu>
Date: Thu, 09 Feb 2006 15:58:13 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Yosemite/440EP 'issues' as a PCI target
References: <20060209003459.0ED30352564@atlas.denx.de>
In-Reply-To: <20060209003459.0ED30352564@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

I'm evaluating the 440EP for use as the control processor
on a PCI peripheral. Today I have been looking at what I
can use for processor-to-processor communications over
the PCI bus. The boards will be used in existing
equipment that does not have ethernet in the backplane.

It appears that the 440EP has very limited options for
interrupt-based communications over the PCI bus.

Lets assume the following basic host-to-host protocol
(interrupt-based handshake).

1) PCI system slot machine 'host' has all the IRQs routed
    to it. This will be an x86-based machine.
    The host interrupts the device when it wants to
    send it data, or when it wants to send an acknowledge.

2) PCI device slot; a 440EP based board.
    The device interrupts the host when it wants
    to send it data, or when it wants to send an
    acknowledge.

If the 440EP board wants to interrupt the host, it can
generate an interrupt by writing to the PCI Interrupt
Control/Status Register, PCIC0_ICS, with only 1 bit
available for interrupt generation (i.e., there is
no concept of a mailbox or doorbell register, just a bit)
(see p388 of the v1.18 manual).

Now what if the host wants to interrupt the 440EP.
Errr, there is no register defined for this purpose.
The UIC chapter, p220-222 v1.18 manual indicates
all the interrupt bits. Sure there are a couple of
PCI source interrupts, one for writes to the PCI
configuration-space command register (so can't really
use that), and another for power-management events.

Have I missed something?

I'll have an FPGA/CPLD on the external bus, so I guess
I can implement a mailbox/doorbell register in that
and then have that register trigger an external interrupt
on the 440EP. The 440EP PCI target BARs will then need
to be setup to decode to the EBC decode range.
Sounds like a hack ... (even more of a hack is to
loop back a GPIO onto an EXTINT and setup the target
decode to cover the GPIO registers, and the x86 can
toggle a GPIO directly).

Of course if I have a few unused peripherals I might
be able to cause them to generate an interrupt. But
that gets tricky since in a lot of cases, as device
interrupts are often controlled via DCRs.

I realize that some of the other devices have I2O messaging
units (440GX and 440SP), so are more suited to PCI comms
applications. However, I require the hardware FPU on
the 440EP. From the selector guide, its only the 440EP
and 440EPx that contain the FPU.

Any comments on this?
Dave
