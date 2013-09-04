Return-Path: <sarans1987@gmail.com>
Received: from mail-vc0-x229.google.com (mail-vc0-x229.google.com
 [IPv6:2607:f8b0:400c:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 24FF12C00D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 04:34:55 +1000 (EST)
Received: by mail-vc0-f169.google.com with SMTP id ib11so448522vcb.28
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Sep 2013 11:34:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5220DF42.2030208@ovro.caltech.edu>
References: <CAEqOc-Rrsc2JoM4eeLzgyhGXqpJoe2Jfmf6uV4LjrTr7e8hhAw@mail.gmail.com>
 <5216860A.6060409@ovro.caltech.edu>
 <20130822222951.GA13201@ovro.caltech.edu>
 <CAEqOc-SdBZgiB1HZOQAJhgq_epdGsqMXaiSO0Axcd9ZBq6kLDw@mail.gmail.com>
 <521A8782.60807@ovro.caltech.edu>
 <CAEqOc-T5-PuVnDi-MdzGekbLHWR4wfnCb3etfRbu4DAmNGuzVg@mail.gmail.com>
 <5220DF42.2030208@ovro.caltech.edu>
Date: Thu, 5 Sep 2013 00:04:51 +0530
Message-ID: <CAEqOc-SYzOFSaUPLY2HS32c0PVnzwBNSVy3EG=EHOv2of2AGaQ@mail.gmail.com>
Subject: Re: Ethernet over PCIe driver for Inter-Processor Communication
From: Saravanan S <sarans1987@gmail.com>
To: David Hawkins <dwh@ovro.caltech.edu>
Content-Type: multipart/alternative; boundary=20cf307f330e9b4b1904e5930f5e
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

--20cf307f330e9b4b1904e5930f5e
Content-Type: text/plain; charset=ISO-8859-1

Hi All,


On Fri, Aug 30, 2013 at 11:36 PM, David Hawkins <dwh@ovro.caltech.edu>wrote:

> Hi S.Saravanan,
>
>>
>> I successfully  mapped the Programmable Interrupt Controller registers
>> in the EP to the PCI space. Thus now I can write the shared message
>>
>> interrupt registers in the EP from the RC over PCI.
>>
>
> Excellent.
>
>
>  But I am facing the following problems now.
>>
>> 1) In my driver at EP, to register for this interrupt I need to know the
>> hardware irq number but I can't find any interrupt number assigned  by
>> the PIC for the messages interrupt sources(Page 451 , MPC8641DRM manual).
>> 2) Otherwise i need to get the virtual irq number assigned by kernel
>> corresponding to the message interrupt . I am unable to find a method to
>> get this also.
>>
>
> I recall having to ask a similar question when trying to map a
> GPIO interrupt into a Linux interrupt number. I forget the
> convention (I'm "the hardware guy"). It may be a device tree
> thing, or an offset, I'll let someone more knowledgeable comment.
>
>  In the RC side driver i get the virtual irq number after calling
>> pci_enable_msi() which is straightforward.
>> I studied the RC code which sets up shared message interrupts (Page 481,
>> MPC manual)  for PCI MSI interrupts . When  msi is enabled the
>> "arch_setup_msi_irqs()" is called leading to the fsl_setup_msi_irqs()
>> (http://lxr.free-electrons.**com/source/arch/powerpc/**
>> sysdev/fsl_msi.c?v=3.7#L151<http://lxr.free-electrons.com/source/arch/powerpc/sysdev/fsl_msi.c?v=3.7#L151>
>> )
>> . In this function the virtual irq no is obtained as below:
>>
>> /virq = irq_create_mapping(msi_data->**irqhost, hwirq);/
>>
>>
>> In the above function the hardware irq number is same as the value
>> written into the  Shared Message Signaled Interrupt Index Register (Page
>> 482) which is strange. Further these functions are called in the RC
>> during pci_probe at boot time or when pci_enable_msi() is called . Thus
>> there is a always a PCI slave device context to it. However I  require
>> to do it in the EP which has no pci probing nor any  pci device
>> reference whatsoever as it a slave. Is this approach right  ?
>>
>
> I'm not sure.
>
> You'll have two drivers;
>  * The root-complex.
>    This is a standard PCIe driver, so you'll just follow convention
>    there
>  * The end-point driver.
>    This driver needs to use the PCIe bus, but its not responsible
>    for the PCIe bus in the way a root-complex is. The driver needs
>    to know what the root-complex is interrupting it for, eg.,
>    "transmitter empty" (I've read your last message) or "receiver
>    ready" (there is a message from me, waiting for you).
>    So you need at least two unique interrupts or messages from the
>    root-complex to the end-point.
>

I am happy to inform you that I finally found a way to register for the
interrupts from RC to EP. Now I have made a simple root and end point
network driver for two MPC8640 nodes  that are now up and running and I
could successfully ping across them. The basic flow is as follows.

 *Root Complex Driver*:
   1. It discovers the EP processor node and gets its base addresses.(BAR 1
and BAR 2)
   2. It sets a single inbound window mapping a portion of its RAM to PCI
space.(This is to allow inbound memory writes from EP).
   3.It enables the MSI interrupt for the EP and registers an interrupt
handler for the same.(To receive interrupts from EP. Note this is
conventional PCI method)
   4.  On receiving a transmit request from kernel it initiates a DMA
memory copy of the packet(in the socket buffer) to the EP memory through
BAR 1. After DMA finishes it sends an interrupt to EP by writing to its msi
register mapped in BAR2.
   5 . On reception of a packet(from EP) the msi interrupt  handler  is
called and it copies the packet in RAM to a socket buffer and passes it to
the kernel.
*
*
*End Point Driver:

*
1. It sets up the internal msi interrupt structure and registers an
interrupt handler.(To receive interrupts from RC. Note this is not done by
default in kernel as it is a slave and thus is added in the driver.)
2. It sets two inbound windows
    i) BAR1 maps to RAM area.(To allow inbound memory write from RC)
    ii) BAR2 is mapped to PIC register area.(To allow inbound message
interrupt register write from RC)
3. It sets up one outbound window to map its local address to PCI address
of RC .(To allow outbound memory write to RC RAM space).
4. On receiving a transmit request from kernel it initiates a DMA memory
copy of the packet(in the socket buffer) to the RC memory through the
outbound window. After DMA finishes it sends an interrupt to RC through the
conventional PCI MSI transaction.
5. On reception of a packet(from RC) the msi interrupt  handler  is called
and it copies the packet in RAM to a socket buffer and passes it to the
kernel.

So basically a bidirectional communication channel  has been established
but the driver is not ready for performance checks yet. I am working on it
now. I will report any improvements obtained in this regard.


> Its always a good idea to discuss different options, and to stub out
>>> drivers or create minimal (but functional) drivers. That way you'll
>>> be able to see how similar your new driver is to other drivers, and
>>> you'll quickly discover if there is a hardware feature in the
>>> existing driver that you cannot emulate (eg., some SRIO feature
>>> used by the rionet driver).
>>>
>>
>> Right now I am trying a very primitive driver just to check the
>> feasibility of bi-directional communication between the RC and the EP.
>> Once this is established  I will be in a better position to get inputs
>> on making it a more effective one.
>>
>
> You're on the right track. When I looked at using the messaging
> registers on the PLX PCI device, I started by simply creating
> what was effectively a serial port (one char at a time).
> Section 4 explains the interlocking required between two processors
>
> http://www.ovro.caltech.edu/~**dwh/correlator/pdf/cobra_**driver.pdf<http://www.ovro.caltech.edu/~dwh/correlator/pdf/cobra_driver.pdf>
>
> Thank You for this document . Was very helpful in understanding the basics
of a Host Target Communication and implementation of a virtual driver for
the same.


> The mailbox/interrupt registers are effectively being used to
> implement a mutex between the two processors.
>
> I think at one point Ira took similar code to this and hooked
> it into the actual serial layer, so that you had a tty over
> PCI. You could always start with a simplification like that too.
>
> Cheers,
> Dave
>
>

Regards,
S.Saravanan

--20cf307f330e9b4b1904e5930f5e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div>Hi All,<br><div class=3D"gmail_extra"><br><=
br><div class=3D"gmail_quote">On Fri, Aug 30, 2013 at 11:36 PM, David Hawki=
ns <span dir=3D"ltr">&lt;<a href=3D"mailto:dwh@ovro.caltech.edu" target=3D"=
_blank">dwh@ovro.caltech.edu</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hi S.Saravanan,<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D"im">
<br>
I successfully =A0mapped the Programmable Interrupt Controller registers<br=
></div>
in the EP to the PCI space. Thus now I can write the shared message<div cla=
ss=3D"im"><br>
interrupt registers in the EP from the RC over PCI.<br>
</div></blockquote>
<br>
Excellent.<div class=3D"im"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
But I am facing the following problems now.<br>
<br>
1) In my driver at EP, to register for this interrupt I need to know the<br=
>
hardware irq number but I can&#39;t find any interrupt number assigned =A0b=
y<br>
the PIC for the messages interrupt sources(Page 451 , MPC8641DRM manual).<b=
r>
2) Otherwise i need to get the virtual irq number assigned by kernel<br>
corresponding to the message interrupt . I am unable to find a method to<br=
>
get this also.<br>
</blockquote>
<br></div>
I recall having to ask a similar question when trying to map a<br>
GPIO interrupt into a Linux interrupt number. I forget the<br>
convention (I&#39;m &quot;the hardware guy&quot;). It may be a device tree<=
br>
thing, or an offset, I&#39;ll let someone more knowledgeable comment.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D"im">
In the RC side driver i get the virtual irq number after calling<br>
pci_enable_msi() which is straightforward.<br>
I studied the RC code which sets up shared message interrupts (Page 481,<br=
>
MPC manual) =A0for PCI MSI interrupts . When =A0msi is enabled the<br>
&quot;arch_setup_msi_irqs()&quot; is called leading to the fsl_setup_msi_ir=
qs()<br>
(<a href=3D"http://lxr.free-electrons.com/source/arch/powerpc/sysdev/fsl_ms=
i.c?v=3D3.7#L151" target=3D"_blank">http://lxr.free-electrons.<u></u>com/so=
urce/arch/powerpc/<u></u>sysdev/fsl_msi.c?v=3D3.7#L151</a>)<br>
. In this function the virtual irq no is obtained as below:<br>
<br></div>
/virq =3D irq_create_mapping(msi_data-&gt;<u></u>irqhost, hwirq);/<div clas=
s=3D"im"><br>
<br>
In the above function the hardware irq number is same as the value<br>
written into the =A0Shared Message Signaled Interrupt Index Register (Page<=
br>
482) which is strange. Further these functions are called in the RC<br>
during pci_probe at boot time or when pci_enable_msi() is called . Thus<br>
there is a always a PCI slave device context to it. However I =A0require<br=
>
to do it in the EP which has no pci probing nor any =A0pci device<br>
reference whatsoever as it a slave. Is this approach right =A0?<br>
</div></blockquote>
<br>
I&#39;m not sure.<br>
<br>
You&#39;ll have two drivers;<br>
=A0* The root-complex.<br>
=A0 =A0This is a standard PCIe driver, so you&#39;ll just follow convention=
<br>
=A0 =A0there<br>
=A0* The end-point driver.<br>
=A0 =A0This driver needs to use the PCIe bus, but its not responsible<br>
=A0 =A0for the PCIe bus in the way a root-complex is. The driver needs<br>
=A0 =A0to know what the root-complex is interrupting it for, eg.,<br>
=A0 =A0&quot;transmitter empty&quot; (I&#39;ve read your last message) or &=
quot;receiver<br>
=A0 =A0ready&quot; (there is a message from me, waiting for you).<br>
=A0 =A0So you need at least two unique interrupts or messages from the<br>
=A0 =A0root-complex to the end-point.<br>
</blockquote><div><br></div><div>I am happy to inform you that I finally fo=
und a way to register for the interrupts from RC to EP. Now I have made a s=
imple root and end point network driver for two MPC8640 nodes=A0 that are n=
ow up and running and I could successfully ping across them. The basic flow=
 is as follows.<br>
<br></div><div>=A0<u>Root Complex Driver</u>:<br></div><div>=A0=A0 1. It di=
scovers the EP processor node and gets its base addresses.(BAR 1 and BAR 2)=
<br></div><div>=A0=A0 2. It sets a single inbound window mapping a portion =
of its RAM to PCI space.(This is to allow inbound memory writes from EP).<b=
r>
</div><div>=A0=A0 3.It enables the MSI interrupt for the EP and registers a=
n interrupt handler for the same.(To receive interrupts from EP. Note this =
is conventional PCI method)<br></div><div>=A0=A0 4.=A0 On receiving a trans=
mit request from kernel it initiates a DMA memory copy of the packet(in the=
 socket buffer) to the EP memory through BAR 1. After DMA finishes it sends=
 an interrupt to EP by writing to its msi register mapped in BAR2.<br>
</div><div>=A0=A0 5 . On reception of a packet(from EP) the msi interrupt=
=A0 handler=A0 is called and it copies the packet in RAM to a socket buffer=
 and passes it to the kernel.<br></div><div><u><br></u></div><div><u>End Po=
int Driver:<br>
<br></u></div><div>1. It sets up the internal msi interrupt structure and r=
egisters an interrupt handler.(To receive interrupts from RC. Note this is =
not done by default in kernel as it is a slave and thus is added in the dri=
ver.)<br>
</div><div>2. It sets two inbound windows <br></div><div>=A0=A0=A0 i) BAR1 =
maps to RAM area.(To allow inbound memory write from RC)<br></div><div>=A0=
=A0=A0 ii) BAR2 is mapped to PIC register area.(To allow inbound message in=
terrupt register write from RC)<br>
</div><div>3. It sets up one outbound window to map its local address to PC=
I address of RC .(To allow outbound memory write to RC RAM space).<br>4. On=
 receiving a transmit request from kernel it initiates a DMA memory=20
copy of the packet(in the socket buffer) to the RC memory through the outbo=
und window. After DMA finishes it sends an interrupt to RC through the conv=
entional PCI MSI transaction.<br>5. On reception of a packet(from RC) the m=
si interrupt=A0 handler=A0 is=20
called and it copies the packet in RAM to a socket buffer and passes it to=
=20
the kernel.<br><br></div><div>So basically a bidirectional communication ch=
annel=A0 has been established but the driver is not ready for performance c=
hecks yet. I am working on it now. I will report any improvements obtained =
in this regard.<br>
</div><div>=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div class=3D"im"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Its always a good idea to discuss different options, and to stub out<br>
drivers or create minimal (but functional) drivers. That way you&#39;ll<br>
be able to see how similar your new driver is to other drivers, and<br>
you&#39;ll quickly discover if there is a hardware feature in the<br>
existing driver that you cannot emulate (eg., some SRIO feature<br>
used by the rionet driver).<br>
</blockquote>
<br>
Right now I am trying a very primitive driver just to check the<br>
feasibility of bi-directional communication between the RC and the EP.<br>
Once this is established =A0I will be in a better position to get inputs<br=
>
on making it a more effective one.<br>
</blockquote>
<br></div>
You&#39;re on the right track. When I looked at using the messaging<br>
registers on the PLX PCI device, I started by simply creating<br>
what was effectively a serial port (one char at a time).<br>
Section 4 explains the interlocking required between two processors<br>
<br>
<a href=3D"http://www.ovro.caltech.edu/~dwh/correlator/pdf/cobra_driver.pdf=
" target=3D"_blank">http://www.ovro.caltech.edu/~<u></u>dwh/correlator/pdf/=
cobra_<u></u>driver.pdf</a><br>
<br></blockquote><div>Thank You for this document . Was very helpful in und=
erstanding the basics of a Host Target Communication and implementation of =
a virtual driver for the same.<br></div><div>=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">

The mailbox/interrupt registers are effectively being used to<br>
implement a mutex between the two processors.<br>
<br>
I think at one point Ira took similar code to this and hooked<br>
it into the actual serial layer, so that you had a tty over<br>
PCI. You could always start with a simplification like that too.<br>
<br>
Cheers,<br>
Dave<br>
<br></blockquote><div><br><br></div><div>Regards,<br></div><div>S.Saravanan=
 <br></div></div><br></div></div>

--20cf307f330e9b4b1904e5930f5e--
