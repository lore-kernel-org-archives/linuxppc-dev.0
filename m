Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 488CB2C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 08:38:26 +1000 (EST)
Message-ID: <521A8782.60807@ovro.caltech.edu>
Date: Sun, 25 Aug 2013 15:38:58 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Saravanan S <sarans1987@gmail.com>
Subject: Re: Ethernet over PCIe driver for Inter-Processor Communication
References: <CAEqOc-Rrsc2JoM4eeLzgyhGXqpJoe2Jfmf6uV4LjrTr7e8hhAw@mail.gmail.com>
 <5216860A.6060409@ovro.caltech.edu> <20130822222951.GA13201@ovro.caltech.edu>
 <CAEqOc-SdBZgiB1HZOQAJhgq_epdGsqMXaiSO0Axcd9ZBq6kLDw@mail.gmail.com>
In-Reply-To: <CAEqOc-SdBZgiB1HZOQAJhgq_epdGsqMXaiSO0Axcd9ZBq6kLDw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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

>> Root complex's would normally interrupt a device via a PCIe write
>> to a register in a BAR on the end-point (or in extended configuration
>> space registers depending on the hardware implementation).
>
> MPC8640 End point implements only the Type 0 header (Page 1116) . The
> header implements five BARs (Page 1165).

One of those BARs typically provides access to the PowerPC memory
mapped registers (or at least a 1MB window onto those registers).
This is how your root complex can write to some form of messaging
register.

>> PCIe drivers need some way to interrupt the processor, so there must
>> be an option somewhere ... for example, what are the message register
>> interrupts intended for? See p479
>>
>> http://cache.freescale.com/files/32bit/doc/ref_manual/MPC8641DRM.pdf
>>
>> (Ira and myself have not used the MPC8640 so are not familiar with
>> its user manual).
>
> Message registers are for interrupting the processor. A write to
> them sends an interrupt to the processor.  Actually message registers
> are used by the RC to enable interrupts to the processor when an EP
> sends an MSI transaction to RC. In RC driver i register separately for
> the msi interrupts from all three EPs.

This is pretty much what you are looking for then right?

The end-points interrrupt the root-complex using PCIe MSI interrupts,
whereas the root-complex interrupts an end-point by writing directly
to its MSI interrupt.

> To access them in the EP from the RC  i will have to set an inbound
> window mapping the PIC register space in the EP to the PCI mem space
> assigned to it . An inbound window maps a PCI address on the bus
> received by the PCIe controller to a platform address. I will try that
> and let u know .

Right, as I comment above, one of the BARs typically exposes the PowerPC
internal registers.

>> Feel free to discuss your ideas for your PCIe driver (eg., why start
>> with rionet rather than Ira's driver), either on-list, or email Ira
>> and myself directly
>
> To be frank with you there was no particular reason in starting with
> rionet. Maybe because our board also had SRIO interface and we are using
> rionet driver successfully. I had looked at Ira's driver later. I will
> study that also and try   to come back with a skeleton for my driver.

Its always a good idea to discuss different options, and to stub out
drivers or create minimal (but functional) drivers. That way you'll
be able to see how similar your new driver is to other drivers, and
you'll quickly discover if there is a hardware feature in the
existing driver that you cannot emulate (eg., some SRIO feature
used by the rionet driver).

>> One further note. You might want to look at rproc/rpmsg and their virtio
>> driver support. That seems to be where the Linux world is moving for
>> inter-processor communications. See for example the ARM CPUs interfacing
>> with DSPs.
>
> I will study that as i am not familiar with virtio .

Follow Ira's advice. Talk to the guys working on virtio, tell them what
you are trying to do. They'll likely have good advice for you.

Good luck!

Cheers,
Dave
