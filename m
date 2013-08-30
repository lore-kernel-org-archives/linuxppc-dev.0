Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 92D1C2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Aug 2013 04:07:07 +1000 (EST)
Message-ID: <5220DF42.2030208@ovro.caltech.edu>
Date: Fri, 30 Aug 2013 11:06:58 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Saravanan S <sarans1987@gmail.com>
Subject: Re: Ethernet over PCIe driver for Inter-Processor Communication
References: <CAEqOc-Rrsc2JoM4eeLzgyhGXqpJoe2Jfmf6uV4LjrTr7e8hhAw@mail.gmail.com>
 <5216860A.6060409@ovro.caltech.edu> <20130822222951.GA13201@ovro.caltech.edu>
 <CAEqOc-SdBZgiB1HZOQAJhgq_epdGsqMXaiSO0Axcd9ZBq6kLDw@mail.gmail.com>
 <521A8782.60807@ovro.caltech.edu>
 <CAEqOc-T5-PuVnDi-MdzGekbLHWR4wfnCb3etfRbu4DAmNGuzVg@mail.gmail.com>
In-Reply-To: <CAEqOc-T5-PuVnDi-MdzGekbLHWR4wfnCb3etfRbu4DAmNGuzVg@mail.gmail.com>
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
>
> I successfully  mapped the Programmable Interrupt Controller registers
> in the EP to the PCI space. Thus now I can write the shared message
> interrupt registers in the EP from the RC over PCI.

Excellent.

> But I am facing the following problems now.
>
> 1) In my driver at EP, to register for this interrupt I need to know the
> hardware irq number but I can't find any interrupt number assigned  by
> the PIC for the messages interrupt sources(Page 451 , MPC8641DRM manual).
> 2) Otherwise i need to get the virtual irq number assigned by kernel
> corresponding to the message interrupt . I am unable to find a method to
> get this also.

I recall having to ask a similar question when trying to map a
GPIO interrupt into a Linux interrupt number. I forget the
convention (I'm "the hardware guy"). It may be a device tree
thing, or an offset, I'll let someone more knowledgeable comment.

> In the RC side driver i get the virtual irq number after calling
> pci_enable_msi() which is straightforward.
> I studied the RC code which sets up shared message interrupts (Page 481,
> MPC manual)  for PCI MSI interrupts . When  msi is enabled the
> "arch_setup_msi_irqs()" is called leading to the fsl_setup_msi_irqs()
> (http://lxr.free-electrons.com/source/arch/powerpc/sysdev/fsl_msi.c?v=3.7#L151)
> . In this function the virtual irq no is obtained as below:
>
> /virq = irq_create_mapping(msi_data->irqhost, hwirq);/
>
> In the above function the hardware irq number is same as the value
> written into the  Shared Message Signaled Interrupt Index Register (Page
> 482) which is strange. Further these functions are called in the RC
> during pci_probe at boot time or when pci_enable_msi() is called . Thus
> there is a always a PCI slave device context to it. However I  require
> to do it in the EP which has no pci probing nor any  pci device
> reference whatsoever as it a slave. Is this approach right  ?

I'm not sure.

You'll have two drivers;
  * The root-complex.
    This is a standard PCIe driver, so you'll just follow convention
    there
  * The end-point driver.
    This driver needs to use the PCIe bus, but its not responsible
    for the PCIe bus in the way a root-complex is. The driver needs
    to know what the root-complex is interrupting it for, eg.,
    "transmitter empty" (I've read your last message) or "receiver
    ready" (there is a message from me, waiting for you).
    So you need at least two unique interrupts or messages from the
    root-complex to the end-point.

>> Its always a good idea to discuss different options, and to stub out
>> drivers or create minimal (but functional) drivers. That way you'll
>> be able to see how similar your new driver is to other drivers, and
>> you'll quickly discover if there is a hardware feature in the
>> existing driver that you cannot emulate (eg., some SRIO feature
>> used by the rionet driver).
>
> Right now I am trying a very primitive driver just to check the
> feasibility of bi-directional communication between the RC and the EP.
> Once this is established  I will be in a better position to get inputs
> on making it a more effective one.

You're on the right track. When I looked at using the messaging
registers on the PLX PCI device, I started by simply creating
what was effectively a serial port (one char at a time).
Section 4 explains the interlocking required between two processors

http://www.ovro.caltech.edu/~dwh/correlator/pdf/cobra_driver.pdf

The mailbox/interrupt registers are effectively being used to
implement a mutex between the two processors.

I think at one point Ira took similar code to this and hooked
it into the actual serial layer, so that you had a tty over
PCI. You could always start with a simplification like that too.

Cheers,
Dave
