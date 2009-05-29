Return-Path: <isaac.nancy@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id E4AFFDDE21
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 11:48:49 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so2661280ywt.39
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 18:48:48 -0700 (PDT)
MIME-Version: 1.0
Sender: isaac.nancy@gmail.com
In-Reply-To: <20090528200215.GA9793@b07421-ec1.am.freescale.net>
References: <1bcc666d0905281205p63ee8119td5578a749bce8377@mail.gmail.com>
	<20090528200215.GA9793@b07421-ec1.am.freescale.net>
Date: Thu, 28 May 2009 18:48:48 -0700
Message-ID: <1bcc666d0905281848m5d237742h12b4bac272f28ca9@mail.gmail.com>
Subject: Re: 8544 external interrupt configuration problems
From: Nancy Isaac <nancy.isaac@pobox.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=000e0cd47d72110c26046b03473a
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd47d72110c26046b03473a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thank you for your response.  My responses below.

On Thu, May 28, 2009 at 1:02 PM, Scott Wood <scottwood@freescale.com> wrote:

> On Thu, May 28, 2009 at 12:05:52PM -0700, Nancy Isaac wrote:
> > My device tree has the following entry for my fpga:
> >
> > CpuCpld\@f0000000{
> >                         compatible = "MPC8544DS";
> >                         device_type = "CpuCpld";
> >                         reg = <f0000000 00000040>;
> >                         interrupts = <41 2 42 2 43 2>;
> >                         interrupt-parent = <&mpic>;
> > };
>
> Where did you get those interrupt numbers from?  External interrupt
> numbers start at zero on MPIC.


<NI> I  tried several  things and this is the last set I tried. These
numbers start at the end of the internal interrupts.

I also tried specifying 1, 2 and 3 because it looks like there is just an
array of these interrupts and the interrupts are just added to this array as
they are registered with the hwirq and the virq is the index into the array
where the hwirq was added.  I get slightly different results but still not
accurate.

For example, in the device tree, I had setup interrupts = <1 2 2 2 3 2>; for
irq1, 2 and 3 which are all level sensitive interrupts. These map to virq
0x12, 0x13 and 0x14 .  I verify that there is no interrupt present by
looking at the registers in the FPGA and also by connecting a scope to the
signal.  Immediately after I finish registering the irqs listed above, I get
an interrupt  and my print statement in the do_IRQ function returns irq
number 0x12.  This happens even if I've disabled the interrupt at the FPGA.
Then I forced an interrupt to occur at the FPGA on irq2 and the do_irq
function still reports that the irq occured for 0x12.

>
> Is the level/sense information correct?


[NI] Yes, these interrupts are supposed to be active low, level sensitive
interrupts.


> > My driver does the mapping to the virq:
> >
> >  np = of_find_node_by_type(NULL, "CpuCpld");
> >     if (!np) {
> >         ret = -ENODEV;
> >     }
> >     cpldCpuDrv->MateIntIrq = irq_of_parse_and_map(np, 0);
> >     cpldCpuDrv->FtaIrq =  irq_of_parse_and_map(np, 1);
> >     cpldCpuDrv->ExtractIrq =  irq_of_parse_and_map(np, 2);
> >     cpldCpuDrv->XauiIrq =  irq_of_parse_and_map(np, 0);
> >
> >     of_node_put(np);
>
> Looks good (other than that you should be using compatible (with a more
> specific name) rather than device_type).
>
> > Does anyone know what the virq should be for these external interrupts?
>
> They're dynamically assigned.
>
> > I've tried specifying the actual irq numbers 1,2 and 3 and that doesn't
> work
> > either.
>
> Specifying them where?  In the device tree or as virq numbers?  Never
> hard-code virq numbers.


[NI] I specify this in the device tree.

>
>
> > Is there some PCI configuration that's getting in the way?  I've tried
> > disabling the FSL_PCIE and I get the same behavior.
>
> Barring an unusual bug, PCI should have nothing to do with the interrupt
> routing of things that aren't on the PCI bus.


[NI]. For 8544, the external interrupts can be shared with PCI Express. I
thought that if I am somehow enabling PCI Express, maybe it would explain
this behavior.


>
>
> -Scott
>

Thanks
Nancy

--000e0cd47d72110c26046b03473a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thank you for your response.=A0 My responses below.<br><br><div class=3D"gm=
ail_quote">On Thu, May 28, 2009 at 1:02 PM, Scott Wood <span dir=3D"ltr">&l=
t;<a href=3D"mailto:scottwood@freescale.com">scottwood@freescale.com</a>&gt=
;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>On Thu, May 28, 2009 at 12:05:52PM -0700, Nancy Isaac wrote:<br>
&gt; My device tree has the following entry for my fpga:<br>
&gt;<br>
&gt; CpuCpld\@f0000000{<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;M=
PC8544DS&quot;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D &quot;=
CpuCpld&quot;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lt;f0000000 0=
0000040&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D &lt;41 =
2 42 2 43 2&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D &=
lt;&amp;mpic&gt;;<br>
&gt; };<br>
<br>
</div>Where did you get those interrupt numbers from? =A0External interrupt=
<br>
numbers start at zero on MPIC.</blockquote><div><br>&lt;NI&gt; I=A0 tried s=
everal=A0 things and this is the last set I tried. These numbers start at t=
he end of the internal interrupts.=A0 <br><br>I also tried specifying 1, 2 =
and 3 because it looks like there is just an array of these interrupts and =
the interrupts are just added to this array as they are registered with the=
 hwirq and the virq is the index into the array where the hwirq was added.=
=A0 I get slightly different results but still not accurate.=A0 <br>
<br>For example, in the device tree, I had setup  interrupts =3D &lt;1 2 2 =
2 3 2&gt;; for irq1, 2 and 3 which are all level sensitive interrupts. Thes=
e map to virq 0x12, 0x13 and 0x14 .=A0 I verify that there is no interrupt =
present by looking at the registers in the FPGA and also by connecting a sc=
ope to the signal.=A0 Immediately after I finish registering the irqs liste=
d above, I get an interrupt=A0 and my print statement in the do_IRQ functio=
n returns irq number 0x12.=A0 This happens even if I&#39;ve disabled the in=
terrupt at the FPGA.=A0 Then I forced an interrupt to occur at the FPGA on =
irq2 and the do_irq function still reports that the irq occured for 0x12.<b=
r>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
Is the level/sense information correct?</blockquote><div><br>[NI] Yes, thes=
e interrupts are supposed to be active low, level sensitive interrupts.<br>=
</div><div><br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=
=3D"im"><br>
&gt; My driver does the mapping to the virq:<br>
&gt;<br>
&gt; =A0np =3D of_find_node_by_type(NULL, &quot;CpuCpld&quot;);<br>
&gt; =A0 =A0 if (!np) {<br>
&gt; =A0 =A0 =A0 =A0 ret =3D -ENODEV;<br>
&gt; =A0 =A0 }<br>
&gt; =A0 =A0 cpldCpuDrv-&gt;MateIntIrq =3D irq_of_parse_and_map(np, 0);<br>
&gt; =A0 =A0 cpldCpuDrv-&gt;FtaIrq =3D =A0irq_of_parse_and_map(np, 1);<br>
&gt; =A0 =A0 cpldCpuDrv-&gt;ExtractIrq =3D =A0irq_of_parse_and_map(np, 2);<=
br>
&gt; =A0 =A0 cpldCpuDrv-&gt;XauiIrq =3D =A0irq_of_parse_and_map(np, 0);<br>
&gt;<br>
&gt; =A0 =A0 of_node_put(np);<br>
<br>
</div>Looks good (other than that you should be using compatible (with a mo=
re<br>
specific name) rather than device_type).<br>
<div class=3D"im"><br>
&gt; Does anyone know what the virq should be for these external interrupts=
?<br>
<br>
</div>They&#39;re dynamically assigned.<br>
<div class=3D"im"><br>
&gt; I&#39;ve tried specifying the actual irq numbers 1,2 and 3 and that do=
esn&#39;t work<br>
&gt; either.<br>
<br>
</div>Specifying them where? =A0In the device tree or as virq numbers? =A0N=
ever<br>
hard-code virq numbers.</blockquote><div><br>[NI] I specify this in the dev=
ice tree.=A0 <br></div><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
<br>
<div class=3D"im"><br>
&gt; Is there some PCI configuration that&#39;s getting in the way? =A0I&#3=
9;ve tried<br>
&gt; disabling the FSL_PCIE and I get the same behavior.<br>
<br>
</div>Barring an unusual bug, PCI should have nothing to do with the interr=
upt<br>
routing of things that aren&#39;t on the PCI bus.</blockquote><div>=A0</div=
><div>[NI]. For 8544, the external interrupts can be shared with PCI Expres=
s. I thought that if I am somehow enabling PCI Express, maybe it would expl=
ain this behavior.<br>
</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left:=
 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex=
;"><br>
<font color=3D"#888888"><br>
-Scott<br>
</font></blockquote></div><br>Thanks<br>Nancy<br>

--000e0cd47d72110c26046b03473a--
