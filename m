Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.239])
	by ozlabs.org (Postfix) with ESMTP id 03C1BDE308
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 18:23:12 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so792400rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 01:23:11 -0700 (PDT)
Message-ID: <319b0ac50808210123m81e8364od983d5dbbb601104@mail.gmail.com>
Date: Thu, 21 Aug 2008 10:23:11 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: michael@ellerman.id.au
Subject: Re: [machdep_calls] IRQ
In-Reply-To: <1219305767.8008.14.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_21113_5989041.1219306991399"
References: <319b0ac50808210013p677ebb91vf3b30748138c6d4c@mail.gmail.com>
	<1219305767.8008.14.camel@localhost>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_21113_5989041.1219306991399
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Exactly, I mean ppc_md.init_IRQ().
Ok. What have I to setup in this function ? I set the mask and other
registers. Is it right ?  How do I chose the mask ?
At the end of this funtion, IRQ are disable. Is that right ? So who does
enable IRQs ?

Sorry for all this questions, I am learning the low layer of Linux.

2008/8/21, Michael Ellerman <michael@ellerman.id.au>:
>
> On Thu, 2008-08-21 at 09:13 +0200, S=E9bastien Chr=E9tien wrote:
> > Hello,
> >
> > What are the constraints in order to implement a irq_init function ?
>
>
> You mean ppc_md.init_IRQ() ?
>
> If so, it's a hook you can use to setup your interrupt controller. It's
> called from init_IRQ() (arch/powerpc/kernel/irq.c), which is called from
> start_kernel() (init/main.c).
>
> Not long after it is called irqs are enabled. I think it is the last
> callback into arch code before irqs are enabled.
>
> When it is called the device tree is unflattened, so you can use the of_
> API. Bootmem is setup so you can use alloc_bootmem(), but you can't
> kmalloc yet. ioremap should work.
>
>
>
> > What is the aim or get_irq ? Does it retun an information about the
> > mask, the states, or... ?
>
>
> The aim of ppc_md.get_irq() ? It's called from do_IRQ()
> (arch/powerpc/kernel/irq.c) which is called from assembler in the
> appropriate head_x.S
>
> It just returns the number (virtual number) of the irq that just fired.
> If for some reason you took a spurious interrupt it should return
> NO_IRQ.
>
> I'm not sure what you mean about masks or states, someone else might
> though.
>
> cheers
>
> --
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
>
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
>
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person
>
>

------=_Part_21113_5989041.1219306991399
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Exactly, I mean ppc_md.init_IRQ().<br>
Ok. What have I to setup in this function ? I set the mask and other regist=
ers. Is it right ?&nbsp; How do I chose the mask ?<br>
At the end of this funtion, IRQ are disable. Is that right ? So who does en=
able IRQs ?<br>
<br>
Sorry for all this questions, I am learning the low layer of Linux.<br><br>=
<div><span class=3D"gmail_quote">2008/8/21, Michael Ellerman &lt;<a href=3D=
"mailto:michael@ellerman.id.au">michael@ellerman.id.au</a>&gt;:</span><bloc=
kquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, =
204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Thu, 2008-08-21 at 09:13 +0200, S=E9bastien Chr=E9tien wrote:<br> &gt; H=
ello,<br> &gt;<br> &gt; What are the constraints in order to implement a ir=
q_init function ?<br> <br> <br>You mean ppc_md.init_IRQ() ?<br> <br> If so,=
 it&#39;s a hook you can use to setup your interrupt controller. It&#39;s<b=
r>
 called from init_IRQ() (arch/powerpc/kernel/irq.c), which is called from<b=
r> start_kernel() (init/main.c).<br> <br> Not long after it is called irqs =
are enabled. I think it is the last<br> callback into arch code before irqs=
 are enabled.<br>
 <br> When it is called the device tree is unflattened, so you can use the =
of_<br> API. Bootmem is setup so you can use alloc_bootmem(), but you can&#=
39;t<br> kmalloc yet. ioremap should work.<br> <br><br> <br> &gt; What is t=
he aim or get_irq ? Does it retun an information about the<br>
 &gt; mask, the states, or... ?<br> <br> <br>The aim of ppc_md.get_irq() ? =
It&#39;s called from do_IRQ()<br> (arch/powerpc/kernel/irq.c) which is call=
ed from assembler in the<br> appropriate head_x.S<br> <br> It just returns =
the number (virtual number) of the irq that just fired.<br>
 If for some reason you took a spurious interrupt it should return<br> NO_I=
RQ.<br> <br> I&#39;m not sure what you mean about masks or states, someone =
else might<br> though.<br> <br> cheers<br> <br> --<br> Michael Ellerman<br>
 OzLabs, IBM Australia Development Lab<br> <br> wwweb: <a href=3D"http://mi=
chael.ellerman.id.au">http://michael.ellerman.id.au</a><br> phone: +61 2 62=
12 1183 (tie line 70 21183)<br> <br> We do not inherit the earth from our a=
ncestors,<br>
 we borrow it from our children. - S.M.A.R.T Person<br> <br></blockquote></=
div><br>

------=_Part_21113_5989041.1219306991399--
