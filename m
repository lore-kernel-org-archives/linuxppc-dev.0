Return-Path: <sarans1987@gmail.com>
Received: from mail-vc0-x236.google.com (mail-vc0-x236.google.com
 [IPv6:2607:f8b0:400c:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2711D2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 01:20:58 +1000 (EST)
Received: by mail-vc0-f182.google.com with SMTP id hf12so1539294vcb.27
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Aug 2013 08:20:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130822222951.GA13201@ovro.caltech.edu>
References: <CAEqOc-Rrsc2JoM4eeLzgyhGXqpJoe2Jfmf6uV4LjrTr7e8hhAw@mail.gmail.com>
 <5216860A.6060409@ovro.caltech.edu>
 <20130822222951.GA13201@ovro.caltech.edu>
Date: Sun, 25 Aug 2013 20:50:54 +0530
Message-ID: <CAEqOc-SdBZgiB1HZOQAJhgq_epdGsqMXaiSO0Axcd9ZBq6kLDw@mail.gmail.com>
Subject: Re: Ethernet over PCIe driver for Inter-Processor Communication
From: Saravanan S <sarans1987@gmail.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>, scottwood@freescale.com
Content-Type: multipart/alternative; boundary=089e0111dcd290f00104e4c72fc5
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Hawkins <dwh@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e0111dcd290f00104e4c72fc5
Content-Type: text/plain; charset=ISO-8859-1

Hi All,
         First of all thank you  all for taking your time out to reply



On Fri, Aug 23, 2013 at 3:59 AM, Ira W. Snyder <iws@ovro.caltech.edu> wrote:

> On Thu, Aug 22, 2013 at 02:43:38PM -0700, David Hawkins wrote:
> > Hi S.Saravanan,
> >
> > > I have a custom board  with four MPC8640 nodes connected over
> > > a transparent PCI express switch . In this configuration one node is
> > > configured as host(Root Complex) and others as agents(End Point). Thus
> > > the legacy PCI software works fine . However the mainline kernel lacks
> > > any standard support for Inter-processor communication over PCI. I am
> > > in the process of developing an Ethernet over  PCI driver for the same
> > > on the lines of rionet . However I am facing the following problems.
> > >
> > > a)   I can generate MSI interrupts from End Point to Root Complex over
> > > PCI . But the vice-versa is not possible . However i need a method to
> > > interrupt the End Point from the Root Complex to complete my driver.
> >
> > Root complex's would normally interrupt a device via a PCIe write
> > to a register in a BAR on the end-point (or in extended configuration
> > space registers depending on the hardware implementation).
>
> MPC8640 End point implements only the Type 0 header (Page 1116) . The
header implements five BARs (Page 1165).


> > > Only previous references I can find are this post
> > >
> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg25765.html
> > > However this uses doorbells and I think may not be possible in MPC8640.
> >
> > PCIe drivers need some way to interrupt the processor, so there must
> > be an option somewhere ... for example, what are the message register
> > interrupts intended for? See p479
> >
> > http://cache.freescale.com/files/32bit/doc/ref_manual/MPC8641DRM.pdf
> >
> > (Ira and myself have not used the MPC8640 so are not familiar with
> > its user manual).
>

   Message registers  are for interrupting the processor . A write to them
sends an interrupt to the processor .  Actually message registers are used
by the RC to enable interrupts to the processor when an EP sends an MSI
transaction to RC.In RC driver  i register separately for the msi
interrupts from all three EPs.

 To access them in the EP from the RC  i will have to set an inbound window
mapping the PIC register space in the EP  to the PCI mem space  assigned to
it . An inbound window maps a PCI address on the bus received by the PCIe
controller to a platform address. I will try that and let u know .

> >
> > > Any pointers on this issue and guidance on this driver development
> would
> > > be helpful .
> >
> > We use the Ethernet-over-PCI driver that Ira developed. Our next boards
> > will use an MPC8308, but we don't currently have any in a PCIe device
> > form-factor (just the MPC8038RDB), so he has not ported it to PCIe.
> >
> > Feel free to discuss your ideas for your PCIe driver (eg., why start
> > with rionet rather than Ira's driver), either on-list, or email Ira
> > and myself directly
>

To be frank with you there was no particular reason in starting with
rionet. Maybe because our board also had SRIO interface and we are using
rionet driver successfully. I had looked at Ira's driver later. I will
study that also and try   to come back with a skeleton for my driver.


>
> One further note. You might want to look at rproc/rpmsg and their virtio
> driver support. That seems to be where the Linux world is moving for
> inter-processor communications. See for example the ARM CPUs interfacing
> with DSPs.
>
> Ira
>

I will study that as i am not familiar with virtio .

Regards,

S.Saravanan

--089e0111dcd290f00104e4c72fc5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi All,<br></div>=A0=A0=A0=A0=A0=A0=A0=A0 First =
of all thank you=A0 all for taking your time out to reply<br></div><br><div=
><div><div><div class=3D"gmail_extra"> <br></div><div class=3D"gmail_extra"=
><br><div class=3D"gmail_quote">
On Fri, Aug 23, 2013 at 3:59 AM, Ira W. Snyder <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:iws@ovro.caltech.edu" target=3D"_blank">iws@ovro.caltech.edu</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D""><div class=3D"h5">On Thu, Aug 22, 2013 at 02:43:38PM -0700,=
 David Hawkins wrote:<br>
&gt; Hi S.Saravanan,<br>
&gt;<br>
&gt; &gt; I have a custom board =A0with four MPC8640 nodes connected over<b=
r>
&gt; &gt; a transparent PCI express switch . In this configuration one node=
 is<br>
&gt; &gt; configured as host(Root Complex) and others as agents(End Point).=
 Thus<br>
&gt; &gt; the legacy PCI software works fine . However the mainline kernel =
lacks<br>
&gt; &gt; any standard support for Inter-processor communication over PCI. =
I am<br>
&gt; &gt; in the process of developing an Ethernet over =A0PCI driver for t=
he same<br>
&gt; &gt; on the lines of rionet . However I am facing the following proble=
ms.<br>
&gt; &gt;<br>
&gt; &gt; a) =A0 I can generate MSI interrupts from End Point to Root Compl=
ex over<br>
&gt; &gt; PCI . But the vice-versa is not possible . However i need a metho=
d to<br>
&gt; &gt; interrupt the End Point from the Root Complex to complete my driv=
er.<br>
&gt;<br>
&gt; Root complex&#39;s would normally interrupt a device via a PCIe write<=
br>
&gt; to a register in a BAR on the end-point (or in extended configuration<=
br>
&gt; space registers depending on the hardware implementation).<br>
<br></div></div></blockquote><div>MPC8640 End point implements only the Typ=
e 0 header (Page 1116) . The header implements five BARs (Page 1165).=A0 <b=
r></div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D""><div class=3D"h5">
&gt; &gt; Only previous references I can find are this post<br>
&gt; &gt; <a href=3D"http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.=
org/msg25765.html" target=3D"_blank">http://www.mail-archive.com/linuxppc-d=
ev@lists.ozlabs.org/msg25765.html</a><br>
&gt; &gt; However this uses doorbells and I think may not be possible in MP=
C8640.<br>
&gt;<br>
&gt; PCIe drivers need some way to interrupt the processor, so there must<b=
r>
&gt; be an option somewhere ... for example, what are the message register<=
br>
&gt; interrupts intended for? See p479<br>
&gt;<br>
&gt; <a href=3D"http://cache.freescale.com/files/32bit/doc/ref_manual/MPC86=
41DRM.pdf" target=3D"_blank">http://cache.freescale.com/files/32bit/doc/ref=
_manual/MPC8641DRM.pdf</a><br>
&gt;<br>
&gt; (Ira and myself have not used the MPC8640 so are not familiar with<br>
&gt; its user manual).<br></div></div></blockquote><div><br></div><div>=A0=
=A0 Message registers=A0 are for interrupting the processor . A write to th=
em sends an interrupt to the processor .=A0 Actually message registers are =
used by the RC to enable interrupts to the processor when an EP sends an MS=
I transaction to RC.In RC driver=A0 i register separately for the msi inter=
rupts from all three EPs.<br>
<br>=A0To access them in the EP from the RC=A0 i will have to set an inboun=
d window mapping the PIC=20
register space in the EP=A0 to the PCI mem space=A0 assigned to it . An inb=
ound window maps a PCI address on the bus received by the PCIe controller t=
o a platform address. I will try that and let u know . <br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<div class=3D""><div class=3D"h5">
&gt;<br>
&gt; &gt; Any pointers on this issue and guidance on this driver developmen=
t would<br>
&gt; &gt; be helpful .<br>
&gt;<br>
&gt; We use the Ethernet-over-PCI driver that Ira developed. Our next board=
s<br>
&gt; will use an MPC8308, but we don&#39;t currently have any in a PCIe dev=
ice<br>
&gt; form-factor (just the MPC8038RDB), so he has not ported it to PCIe.<br=
>
&gt;<br>
&gt; Feel free to discuss your ideas for your PCIe driver (eg., why start<b=
r>
&gt; with rionet rather than Ira&#39;s driver), either on-list, or email Ir=
a<br>
&gt; and myself directly<br></div></div></blockquote><div><br></div><div>To=
 be frank with you there was no particular reason in starting with rionet. =
Maybe because our board also had SRIO interface and we are using rionet dri=
ver successfully. I had looked at Ira&#39;s driver later. I will study that=
 also and try =A0 to come back with a skeleton for my driver.=A0 <br>
</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
class=3D""><div class=3D"h5">
<br>
</div></div>One further note. You might want to look at rproc/rpmsg and the=
ir virtio<br>
driver support. That seems to be where the Linux world is moving for<br>
inter-processor communications. See for example the ARM CPUs interfacing<br=
>
with DSPs.<br>
<span class=3D""><font color=3D"#888888"><br>
Ira<br>
</font></span></blockquote></div><br></div><div class=3D"gmail_extra">I wil=
l study that as i am not familiar with virtio .<br></div><div class=3D"gmai=
l_extra"><br></div><div class=3D"gmail_extra">Regards,<br><br></div><div cl=
ass=3D"gmail_extra">
S.Saravanan<br></div><div class=3D"gmail_extra"><br><br><br></div></div></d=
iv></div></div>

--089e0111dcd290f00104e4c72fc5--
