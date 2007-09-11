Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0ADA8DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 04:16:25 +1000 (EST)
Message-ID: <46E6DBC9.5090203@ovro.caltech.edu>
Date: Tue, 11 Sep 2007 11:17:45 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: PCI target implementation on AMCC PPC CPUs
References: <556445368AFA1C438794ABDA8901891C06460054@USA0300MS03.na.xerox.net>	<406A31B117F2734987636D6CCC93EE3C022417D2@ehost011-3.exch011.intermedia.net>	<46E06259.5010305@ovro.caltech.edu>	<200709111113.46508.matthias.fuchs@esd-electronics.com>
	<46E6D131.2030904@ovro.caltech.edu>
In-Reply-To: <46E6D131.2030904@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Matthias,
> 
>> we build a couple of PCI target designs using AMCC PowerPCs.
>> You are right that some things could be better. But ..

Since you build a couple of target designs, I assume you
(or someone working with you) must have written some host
to target communication device drivers.

The reason I refer to the AMCC interrupt solution as
'cheesy' is that there is only one way to generate
an interrupt; this is distinct from the fact that
there is one interrupt signal (in each direction).

The PCI-to-local bus bridges from PLX, and the messaging
units found in other processors still only have one
interrupt signal between the target and the host
(an INTA# PCI line), and a host-to-target interrupt
by way of some interrupt controller line internal to the
SoC. However, these devices have multiple bits to
assert the interrupt signals.

The nicest feature I've used for developing a host-to-target
communications mechanism is the mailbox registers.
A mailbox register can be written by the host using
write-1 to set, and then cleared by the target using
write-1 to clear. Its important that a write-1 interface
is used, if read-modify-write was used, then interrupts
could be missed.

I wrote up the method I used to create an interprocessor
handshake (used much like a mutex)

http://www.ovro.caltech.edu/~dwh/correlator/pdf/cobra_driver.pdf

The host processor and the target processor use this
protocol for protecting access to a common resource; the
read and write data buffers. The buffers are transferred
using DMA.

Page 8-10 of the document shows a simplified version analogous
to the serial ports of a UART.

A key part of the protocol described is that, analogous to
a serial port, two interrupt sources are required;
  * transmitter empty
  * receiver ready

The host CPU writes to a transmitter ready bit to generate
a receiver ready interrupt at the target, and once the
target has moved the transmitter data out of the transmit
buffer, it writes to the transmitter empty bit to generate
a transmitter empty interrupt to the host. And the
analogous operation happens for the target to host
transmissions. Hence there are two mailbox bits that
the devices write to to generate an interrupt to the other
processor, and two mailbox bits that generate interrupts,
so are cleared by each processor.

The two interprocessor data paths are independent and
asynchronous with respect to each other, and no polling
is required; upon receiving a mailbox interrupt the
ISR can schedule a receive task, or a transmit task,
or both, depending on the state of the mailbox bits.

How then with only one interrupt source do you implement
a robust interprocessor handshake with the AMCC
single-interrupt, without resorting to polling anywhere
in a driver?

Obviously the above driver was just my take on how to
create such an interface. After I wrote it, I had a look
around and found Micheal Barr had created something similar
(not in the context of a linux driver though).

BTW; I'm not trying to start a flame-war of AMCC verus
Freescale. This just happened to be a downside to this
processor for my specific application. I found plenty
of downsides with Coldfire's, and PowerQuiccIIs and IIIs
too.

Cheers,
Dave
