Return-Path: <sarans1987@gmail.com>
Received: from mail-vc0-x22e.google.com (mail-vc0-x22e.google.com
 [IPv6:2607:f8b0:400c:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C1B02C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Aug 2013 03:37:23 +1000 (EST)
Received: by mail-vc0-f174.google.com with SMTP id gd11so1499806vcb.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 10:37:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <521A8782.60807@ovro.caltech.edu>
References: <CAEqOc-Rrsc2JoM4eeLzgyhGXqpJoe2Jfmf6uV4LjrTr7e8hhAw@mail.gmail.com>
 <5216860A.6060409@ovro.caltech.edu>
 <20130822222951.GA13201@ovro.caltech.edu>
 <CAEqOc-SdBZgiB1HZOQAJhgq_epdGsqMXaiSO0Axcd9ZBq6kLDw@mail.gmail.com>
 <521A8782.60807@ovro.caltech.edu>
Date: Fri, 30 Aug 2013 23:07:19 +0530
Message-ID: <CAEqOc-T5-PuVnDi-MdzGekbLHWR4wfnCb3etfRbu4DAmNGuzVg@mail.gmail.com>
Subject: Re: Ethernet over PCIe driver for Inter-Processor Communication
From: Saravanan S <sarans1987@gmail.com>
To: David Hawkins <dwh@ovro.caltech.edu>,
 Michael George <michaelgeorge2010@gmail.com>, naishab@gmail.com
Content-Type: multipart/alternative; boundary=047d7bd6c2c4a9731d04e52dac17
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

--047d7bd6c2c4a9731d04e52dac17
Content-Type: text/plain; charset=ISO-8859-1

Hi All ,


On Mon, Aug 26, 2013 at 4:08 AM, David Hawkins <dwh@ovro.caltech.edu> wrote:

> Hi S.Saravanan,
>
>
>  Root complex's would normally interrupt a device via a PCIe write
>>> to a register in a BAR on the end-point (or in extended configuration
>>> space registers depending on the hardware implementation).
>>>
>>
>> MPC8640 End point implements only the Type 0 header (Page 1116) . The
>> header implements five BARs (Page 1165).
>>
>
> One of those BARs typically provides access to the PowerPC memory
> mapped registers (or at least a 1MB window onto those registers).
> This is how your root complex can write to some form of messaging
> register.
>
>  PCIe drivers need some way to interrupt the processor, so there must
>>> be an option somewhere ... for example, what are the message register
>>> interrupts intended for? See p479
>>>
>>> http://cache.freescale.com/files/32bit/doc/ref_manual/MPC8641DRM.pdf
>>>
>>> (Ira and myself have not used the MPC8640 so are not familiar with
>>> its user manual).
>>>
>>
>> Message registers are for interrupting the processor. A write to
>> them sends an interrupt to the processor.  Actually message registers
>>
>> are used by the RC to enable interrupts to the processor when an EP
>> sends an MSI transaction to RC. In RC driver i register separately for
>>
>> the msi interrupts from all three EPs.
>>
>
> This is pretty much what you are looking for then right?



I successfully  mapped the Programmable Interrupt Controller registers in
the EP to the PCI space . Thus now I can write the shared message interrupt
registers in the EP from the RC over PCI . But  I am facing the following
problems now  .

1) In my driver at EP, to register for this interrupt I need to know the
hardware irq number but I can't find any interrupt number assigned  by the
PIC for the messages interrupt sources(Page 451 , MPC8641DRM manual).
2) Otherwise i need to get the virtual irq number assigned by kernel
corresponding to the message interrupt . I am unable to find a method to
get this also.

In the RC side driver i get the virtual irq number after calling
pci_enable_msi() which is straightforward.
I studied the RC code which sets up shared message interrupts (Page 481,
MPC manual)  for PCI MSI interrupts . When  msi is enabled the
"arch_setup_msi_irqs()" is called leading to the fsl_setup_msi_irqs() (
http://lxr.free-electrons.com/source/arch/powerpc/sysdev/fsl_msi.c?v=3.7#L151)
. In this function the virtual irq no is obtained as below:

*virq = irq_create_mapping(msi_data->irqhost, hwirq);*

* *
In the above function the hardware irq number is same as the value
written into the  Shared Message Signaled Interrupt Index Register (Page
482) which is strange. Further these functions are called in the RC during
pci_probe at boot time or when pci_enable_msi() is called . Thus there is a
always a PCI slave device context to it. However I  require to do it in the
EP which has no pci probing nor any  pci device reference whatsoever as it
a slave. Is this approach right  ?

The end-points interrrupt the root-complex using PCIe MSI interrupts,
> whereas the root-complex interrupts an end-point by writing directly
> to its MSI interrupt.
>
>
>  To access them in the EP from the RC  i will have to set an inbound
>> window mapping the PIC register space in the EP to the PCI mem space
>> assigned to it . An inbound window maps a PCI address on the bus
>> received by the PCIe controller to a platform address. I will try that
>> and let u know .
>>
>
> Right, as I comment above, one of the BARs typically exposes the PowerPC
> internal registers.
>
>
>  Feel free to discuss your ideas for your PCIe driver (eg., why start
>>> with rionet rather than Ira's driver), either on-list, or email Ira
>>> and myself directly
>>>
>>
>> To be frank with you there was no particular reason in starting with
>> rionet. Maybe because our board also had SRIO interface and we are using
>> rionet driver successfully. I had looked at Ira's driver later. I will
>> study that also and try   to come back with a skeleton for my driver.
>>
>
> Its always a good idea to discuss different options, and to stub out
> drivers or create minimal (but functional) drivers. That way you'll
> be able to see how similar your new driver is to other drivers, and
> you'll quickly discover if there is a hardware feature in the
> existing driver that you cannot emulate (eg., some SRIO feature
> used by the rionet driver).
>

Right now I am trying a very primitive driver just to check the feasibility
of bi-directional communication between the RC and the EP. Once this is
established  I will be in a better position to get inputs on making it a
more effective one.


>  One further note. You might want to look at rproc/rpmsg and their virtio
>>> driver support. That seems to be where the Linux world is moving for
>>> inter-processor communications. See for example the ARM CPUs interfacing
>>> with DSPs.
>>>
>>
>> I will study that as i am not familiar with virtio .
>>
>
> Follow Ira's advice. Talk to the guys working on virtio, tell them what
> you are trying to do. They'll likely have good advice for you.
>
> Good luck!
>
> Cheers,
> Dave
>
>
>
Warm Regards,

S.Saravanan

--047d7bd6c2c4a9731d04e52dac17
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All ,<br><div class=3D"gmail_extra">=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 <br><br><div class=3D"gmail_quote">On Mon, Aug 26, 2013 at 4:0=
8 AM, David Hawkins <span dir=3D"ltr">&lt;<a href=3D"mailto:dwh@ovro.caltec=
h.edu" target=3D"_blank">dwh@ovro.caltech.edu</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hi S.Saravanan,<div><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">


Root complex&#39;s would normally interrupt a device via a PCIe write<br>
to a register in a BAR on the end-point (or in extended configuration<br>
space registers depending on the hardware implementation).<br>
</blockquote>
<br>
MPC8640 End point implements only the Type 0 header (Page 1116) . The<br>
header implements five BARs (Page 1165).<br>
</blockquote>
<br></div>
One of those BARs typically provides access to the PowerPC memory<br>
mapped registers (or at least a 1MB window onto those registers).<br>
This is how your root complex can write to some form of messaging<br>
register.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">


PCIe drivers need some way to interrupt the processor, so there must<br>
be an option somewhere ... for example, what are the message register<br>
interrupts intended for? See p479<br>
<br>
<a href=3D"http://cache.freescale.com/files/32bit/doc/ref_manual/MPC8641DRM=
.pdf" target=3D"_blank">http://cache.freescale.com/files/32bit/doc/ref_manu=
al/MPC8641DRM.pdf</a><br>
<br>
(Ira and myself have not used the MPC8640 so are not familiar with<br>
its user manual).<br>
</blockquote>
<br></div>
Message registers are for interrupting the processor. A write to<br>
them sends an interrupt to the processor. =A0Actually message registers<div=
><br>
are used by the RC to enable interrupts to the processor when an EP<br></di=
v>
sends an MSI transaction to RC. In RC driver i register separately for<div>=
<br>
the msi interrupts from all three EPs.<br>
</div></blockquote>
<br>
This is pretty much what you are looking for then right?=A0</blockquote><di=
v><br><br><div>I successfully=A0 mapped the Programmable Interrupt Controll=
er registers in the EP to the PCI space
 . Thus now I can write the shared message interrupt registers in the EP fr=
om=20
the RC over PCI . But=A0 I am facing the following problems now=A0 .<br><br=
></div><div>1)  In my driver at EP, to register=20
for this interrupt I need to know the hardware irq number but I can&#39;t f=
ind any interrupt number assigned=A0 by the PIC for the messages interrupt =
sources(Page 451 , MPC8641DRM manual).<br></div><div>2) Otherwise i need to=
 get the virtual irq number assigned by kernel corresponding to
 the message interrupt . I am unable to find a method to get this also. <br=
><br>In the RC side driver i get the virtual irq number after calling pci_e=
nable_msi() which is straightforward.=A0 <br></div>I studied the RC code wh=
ich sets up shared message interrupts (Page 481, MPC manual)=A0 for PCI MSI=
 interrupts . When=A0 msi is enabled the=A0 &quot;arch_setup_msi_irqs()&quo=
t; is called leading to the fsl_setup_msi_irqs() (<a href=3D"http://lxr.fre=
e-electrons.com/source/arch/powerpc/sysdev/fsl_msi.c?v=3D3.7#L151" target=
=3D"_blank">http://lxr.free-electrons.com/source/arch/powerpc/sysdev/fsl_ms=
i.c?v=3D3.7#L151</a>) . In this function the virtual irq no is obtained as =
below:<br>

</div><div><br>

<p style=3D"margin-bottom:0.0001pt;line-height:normal"><i><span style=3D"fo=
nt-size:12pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;">vir=
q
=3D irq_create_mapping(msi_data-&gt;irqhost, hwirq);</span></i></p>

<p><i><span style=3D"line-height:115%;font-size:12pt;font-family:&quot;Time=
s New Roman&quot;,&quot;serif&quot;">=A0</span></i></p>In the above functio=
n the hardware irq number is same as the value=A0=A0 written into the=A0 Sh=
ared Message Signaled Interrupt Index Register (Page 482) which is strange.=
 Further these functions are called in the RC during pci_probe at boot time=
 or when pci_enable_msi() is called . Thus there is a always a PCI slave de=
vice context to it. However I=A0 require to do it in the EP which has no pc=
i probing nor any=A0 pci device reference whatsoever as it a slave. Is this=
 approach right=A0 ?<pre>
</pre></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
The end-points interrrupt the root-complex using PCIe MSI interrupts,<br>
whereas the root-complex interrupts an end-point by writing directly<br>
to its MSI interrupt.<div><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
To access them in the EP from the RC =A0i will have to set an inbound<br>
window mapping the PIC register space in the EP to the PCI mem space<br>
assigned to it . An inbound window maps a PCI address on the bus<br>
received by the PCIe controller to a platform address. I will try that<br>
and let u know .<br>
</blockquote>
<br></div>
Right, as I comment above, one of the BARs typically exposes the PowerPC<br=
>
internal registers.<div><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">


Feel free to discuss your ideas for your PCIe driver (eg., why start<br>
with rionet rather than Ira&#39;s driver), either on-list, or email Ira<br>
and myself directly<br>
</blockquote>
<br>
To be frank with you there was no particular reason in starting with<br>
rionet. Maybe because our board also had SRIO interface and we are using<br=
>
rionet driver successfully. I had looked at Ira&#39;s driver later. I will<=
br>
study that also and try =A0 to come back with a skeleton for my driver.<br>
</blockquote>
<br></div>
Its always a good idea to discuss different options, and to stub out<br>
drivers or create minimal (but functional) drivers. That way you&#39;ll<br>
be able to see how similar your new driver is to other drivers, and<br>
you&#39;ll quickly discover if there is a hardware feature in the<br>
existing driver that you cannot emulate (eg., some SRIO feature<br>
used by the rionet driver).<br></blockquote><div><br></div><div>Right now I=
 am trying a very primitive driver just to check the feasibility of bi-dire=
ctional communication between the RC and the EP. Once this is established=
=A0 I will be in a better position to get inputs on making it a more effect=
ive one. <br>

</div><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><br><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">

<div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
One further note. You might want to look at rproc/rpmsg and their virtio<br=
>
driver support. That seems to be where the Linux world is moving for<br>
inter-processor communications. See for example the ARM CPUs interfacing<br=
>
with DSPs.<br>
</blockquote>
<br></div><div>
I will study that as i am not familiar with virtio .<br>
</div></blockquote>
<br>
Follow Ira&#39;s advice. Talk to the guys working on virtio, tell them what=
<br>
you are trying to do. They&#39;ll likely have good advice for you.<br>
<br>
Good luck!<br>
<br>
Cheers,<br>
Dave<br>
<br>
<br>
</blockquote></div><br></div><div class=3D"gmail_extra">Warm Regards,<br><b=
r></div><div class=3D"gmail_extra">S.Saravanan<br></div><div class=3D"gmail=
_extra"><br></div></div>

--047d7bd6c2c4a9731d04e52dac17--
