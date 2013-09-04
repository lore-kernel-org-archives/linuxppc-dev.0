Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 577442C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 05:28:31 +1000 (EST)
Message-ID: <522789DD.8000007@ovro.caltech.edu>
Date: Wed, 04 Sep 2013 12:28:29 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Saravanan S <sarans1987@gmail.com>
Subject: Re: Ethernet over PCIe driver for Inter-Processor Communication
References: <CAEqOc-Rrsc2JoM4eeLzgyhGXqpJoe2Jfmf6uV4LjrTr7e8hhAw@mail.gmail.com>
 <5216860A.6060409@ovro.caltech.edu> <20130822222951.GA13201@ovro.caltech.edu>
 <CAEqOc-SdBZgiB1HZOQAJhgq_epdGsqMXaiSO0Axcd9ZBq6kLDw@mail.gmail.com>
 <521A8782.60807@ovro.caltech.edu>
 <CAEqOc-T5-PuVnDi-MdzGekbLHWR4wfnCb3etfRbu4DAmNGuzVg@mail.gmail.com>
 <5220DF42.2030208@ovro.caltech.edu>
 <CAEqOc-SYzOFSaUPLY2HS32c0PVnzwBNSVy3EG=EHOv2of2AGaQ@mail.gmail.com>
In-Reply-To: <CAEqOc-SYzOFSaUPLY2HS32c0PVnzwBNSVy3EG=EHOv2of2AGaQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: naishab@gmail.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Michael George <michaelgeorge2010@gmail.com>,
 "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi S.Saravanan,

>> You'll have two drivers;
>>  * The root-complex.
>>    This is a standard PCIe driver, so you'll just follow convention
>>    there
>>  * The end-point driver.
>>    This driver needs to use the PCIe bus, but its not responsible
>>    for the PCIe bus in the way a root-complex is. The driver needs
>>    to know what the root-complex is interrupting it for, eg.,
>>    "transmitter empty" (I've read your last message) or "receiver
>>    ready" (there is a message from me, waiting for you).
>>    So you need at least two unique interrupts or messages from the
>>    root-complex to the end-point.
>
> I am happy to inform you that I finally found a way to register for the
> interrupts from RC to EP. Now I have made a simple root and end point
> network driver for two MPC8640 nodes  that are now up and running and I
> could successfully ping across them.

That is awesome! :)

> The basic flow is as follows.
>
> _Root Complex Driver_:
>     1. It discovers the EP processor node and gets its base
> addresses.(BAR 1 and BAR 2)
>     2. It sets a single inbound window mapping a portion of its RAM to
> PCI space.(This is to allow inbound memory writes from EP).
>     3.It enables the MSI interrupt for the EP and registers an interrupt
> handler for the same.(To receive interrupts from EP. Note this is
> conventional PCI method)
>     4.  On receiving a transmit request from kernel it initiates a DMA
> memory copy of the packet(in the socket buffer) to the EP memory through
> BAR 1. After DMA finishes it sends an interrupt to EP by writing to its
> msi register mapped in BAR2.
>     5 . On reception of a packet(from EP) the msi interrupt  handler  is
> called and it copies the packet in RAM to a socket buffer and passes it
> to the kernel.
> _
> _
> _End Point Driver:
>
> _
> 1. It sets up the internal msi interrupt structure and registers an
> interrupt handler.(To receive interrupts from RC. Note this is not done
> by default in kernel as it is a slave and thus is added in the driver.)
> 2. It sets two inbound windows
>      i) BAR1 maps to RAM area.(To allow inbound memory write from RC)
>      ii) BAR2 is mapped to PIC register area.(To allow inbound message
> interrupt register write from RC)
> 3. It sets up one outbound window to map its local address to PCI
> address of RC .(To allow outbound memory write to RC RAM space).
> 4. On receiving a transmit request from kernel it initiates a DMA memory
> copy of the packet(in the socket buffer) to the RC memory through the
> outbound window. After DMA finishes it sends an interrupt to RC through
> the conventional PCI MSI transaction.
> 5. On reception of a packet(from RC) the msi interrupt  handler  is
> called and it copies the packet in RAM to a socket buffer and passes it
> to the kernel.
>
> So basically a bidirectional communication channel  has been established
> but the driver is not ready for performance checks yet. I am working on
> it now. I will report any improvements obtained in this regard.

Now that you have processor-to-processor communications working,
it would be useful to figure out an architecture for the driver
that will make it acceptable to the community at large.

For example, can you make this driver work from U-Boot too?
Eg., can your driver support a root-complex running Linux and
end-points running U-Boot that fetch their kernel via the
PCIe network, and then boot Linux, and switch over to using
the Linux version of the PCIe network driver.

This is what Ira has done with the PCInet driver, and it allows
us to have an x86 PCI host CPU that then boots multiple
MPC8349EA PowerPC peripheral CPUs.

Ira had discussions with various kernel developers, and I believe
the general feedback was "Can this be made to work with virtio?".
Ira can comment more on that.

>> You're on the right track. When I looked at using the messaging
>> registers on the PLX PCI device, I started by simply creating
>> what was effectively a serial port (one char at a time).
>> Section 4 explains the interlocking required between two processors
>>
>> <http://www.ovro.caltech.edu/~dwh/correlator/pdf/cobra_driver.pdf>
>
> Thank You for this document . Was very helpful in understanding the
> basics of a Host Target Communication and implementation of a virtual
> driver for the same.

I'm glad to hear it helped.

Cheers,
Dave
