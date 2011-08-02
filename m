Return-Path: <vneethv@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2FF14B71C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Aug 2011 19:03:59 +1000 (EST)
Received: by fxh10 with SMTP id 10so5835799fxh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 02 Aug 2011 02:03:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E37AB04.9070409@windriver.com>
References: <OFABB45B91.59E6539A-ONCA2578CC.006F5FB7-CA2578CC.0070CFA6@csc.com>
	<CAFbQSaDaL0UaiY4r+u=a72mmsCHxs7O5Z82MESrXXcWj2tNvbQ@mail.gmail.com>
	<OF7A7D0C50.273D2A69-ONCA2578CD.001B5783-CA2578CD.001D9FFE@csc.com>
	<CAFbQSaAhXUrb1peJ2E3Kkp1gd16JSn9OjneO826q_aMz+yzAqg@mail.gmail.com>
	<CAFbQSaC6BkZj+a4=-9Q2Cyj7w=4y5QYM22kaK1O=Uz5KW9iiuQ@mail.gmail.com>
	<4E37AB04.9070409@windriver.com>
From: Vineeth <vneethv@gmail.com>
Date: Tue, 2 Aug 2011 14:33:35 +0530
Message-ID: <CAFbQSaDhEpSqX4GQHjSTsmpwv3a36RE7WrXbn7ni=NVcTtVyiw@mail.gmail.com>
Subject: Re: Fwd: MPC7410 Linux Kernel
To: "tiejun.chen" <tiejun.chen@windriver.com>
Content-Type: multipart/alternative; boundary=bcaec52c5c73ffba2a04a98206ca
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--bcaec52c5c73ffba2a04a98206ca
Content-Type: text/plain; charset=ISO-8859-1

Thanks for the reply.

We were referring kuroboxHG.dts which uses Sandpoint architecture; which is
almost same as ours.

1. one doubt in kuroboxHG is the ranges property in SOC node says EUMB is at
0xFC00_0000; and as per the datasheet of mpc107, the open pic address will
be EUMB_BASE + 0x40000; but in kurobox its given as 0x80040000;

2. We know that our UART is mapped at address 0xDB00_0100; which is
connected in a PCI-LOCAL bridge whose base is at 0xDB00_0000
How can i represent these things in dts ? Can the RANGES property of PCI
node can mention this ?







On Tue, Aug 2, 2011 at 1:15 PM, tiejun.chen <tiejun.chen@windriver.com>wrote:

> Vineeth wrote:
> > Hi,
> >
> > We are trying to port  linux 2.6.38 on MPC7410 based board (This is a
> > preparatory design by our customer)
> >
> > System architecture is as follows,
> >
> > MPC7410 <=> MPC107 <=> PCI_to_LOCAL(plx9052) <=> UART
>
> MPCXXX should be compatible with TSIXXX. So you can refer to mpc7448_hpc2.
>
> >
> > Previously we were using ppc architecture and we had some issues with
> > page_init() functions; which may be because of our configuration.As we
> didnt
> > get much support on ppc architecture we moved to powerpc.
> >
> > Now we moved to powerpc architecture. We have some doubts on writing the
> dts
> > file. Please find the dts file attached.
> >
> > when we checked the legacy_serial.c file, we found that
> > legacy_serial_parents not expecting a pci-local or a pci bridge as
> parent.
> > is our understanding correct ? should we introduce a new pci parent in
> that
> > structure ?
>
> So you can understand this after refer to the file,
> arch/powerpc/boot/dts/mpc7448hpc2.dts.
>
> Tiejun
>
> >
> >  We are confused about writing the ranges property of PCI node.we were
> > referring booting_without_of doc but didnt get much info. Is there any
> file
> > which gives better idea about the ranges property ?
> >
> > Thanks
> >  Vineeth
>
>

--bcaec52c5c73ffba2a04a98206ca
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the reply.<br><br>We were referring kuroboxHG.dts which uses San=
dpoint architecture; which is almost same as ours.<br><br>1. one doubt in k=
uroboxHG is the ranges property in SOC node says EUMB is at 0xFC00_0000; an=
d as per the datasheet of mpc107, the open pic address will be EUMB_BASE + =
0x40000; but in kurobox its given as 0x80040000; <br>

<br>2. We know that our UART is mapped at address 0xDB00_0100; which is con=
nected in a PCI-LOCAL bridge whose base is at 0xDB00_0000<br>How can i repr=
esent these things in dts ? Can the RANGES property of PCI node can mention=
 this ?<br>

<br><br><br><br><br>=A0<br><br><div class=3D"gmail_quote">On Tue, Aug 2, 20=
11 at 1:15 PM, tiejun.chen <span dir=3D"ltr">&lt;<a href=3D"mailto:tiejun.c=
hen@windriver.com">tiejun.chen@windriver.com</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex;">

<div class=3D"im">Vineeth wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; We are trying to port =A0linux 2.6.38 on MPC7410 based board (This is =
a<br>
&gt; preparatory design by our customer)<br>
&gt;<br>
&gt; System architecture is as follows,<br>
&gt;<br>
&gt; MPC7410 &lt;=3D&gt; MPC107 &lt;=3D&gt; PCI_to_LOCAL(plx9052) &lt;=3D&g=
t; UART<br>
<br>
</div>MPCXXX should be compatible with TSIXXX. So you can refer to mpc7448_=
hpc2.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; Previously we were using ppc architecture and we had some issues with<=
br>
&gt; page_init() functions; which may be because of our configuration.As we=
 didnt<br>
&gt; get much support on ppc architecture we moved to powerpc.<br>
&gt;<br>
&gt; Now we moved to powerpc architecture. We have some doubts on writing t=
he dts<br>
&gt; file. Please find the dts file attached.<br>
&gt;<br>
&gt; when we checked the legacy_serial.c file, we found that<br>
&gt; legacy_serial_parents not expecting a pci-local or a pci bridge as par=
ent.<br>
&gt; is our understanding correct ? should we introduce a new pci parent in=
 that<br>
&gt; structure ?<br>
<br>
</div>So you can understand this after refer to the file,<br>
arch/powerpc/boot/dts/mpc7448hpc2.dts.<br>
<font color=3D"#888888"><br>
Tiejun<br>
</font><div><div></div><div class=3D"h5"><br>
&gt;<br>
&gt; =A0We are confused about writing the ranges property of PCI node.we we=
re<br>
&gt; referring booting_without_of doc but didnt get much info. Is there any=
 file<br>
&gt; which gives better idea about the ranges property ?<br>
&gt;<br>
&gt; Thanks<br>
&gt; =A0Vineeth<br>
<br>
</div></div></blockquote></div><br>

--bcaec52c5c73ffba2a04a98206ca--
