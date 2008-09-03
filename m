Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id 197FDDE0A6
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 01:03:47 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so3072813rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Sep 2008 08:03:46 -0700 (PDT)
Message-ID: <319b0ac50809030803p6d659468wd7d2425224653374@mail.gmail.com>
Date: Wed, 3 Sep 2008 17:03:46 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: irq
In-Reply-To: <48BEA106.9090307@selcomgroup.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_29996_1129382.1220454226270"
References: <319b0ac50809030715h1a03a606jacddd400019f4483@mail.gmail.com>
	<48BEA106.9090307@selcomgroup.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_29996_1129382.1220454226270
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The failure referes to setup_irq :
desc->chip =3D=3D &no_irq_chip is true

What is irq_desc and how can I initialize it ?


setup_irq(unsigned int irq, struct irqaction *new)
{
    struct irq_desc *desc =3D irq_desc + irq;
    struct irqaction *old, **p;
    const char *old_name =3D NULL;
    unsigned long flags;
    int shared =3D 0;

    if (irq >=3D NR_IRQS)
        return -EINVAL;

    printk("desc\n");
    if (desc->chip =3D=3D &no_irq_chip)
        return -ENOSYS;
    printk("desc2\n");

2008/9/3, Daniele Bosi <d.bosi@selcomgroup.com>:
>
> Try to set some flag into the third parameter of the request_irq()
> function like:
>
> SA_SHIRQ                Interrupt is shared
>
> SA_INTERRUPT            Disable local interrupts while processing
>
> SA_SAMPLE_RANDOM        The interrupt can be used for entropy
>
> otherwise try to use the function install_irq_handler()
>
>
> bye Daniele
>
>
>
> S=E9bastien Chr=E9tien ha scritto:
>
> > Hello,
> >
> > I am trying to register a function writh IRQ :
> >
> > static irqreturn_t uart_test (int irq , void *dev_id)
> > {
> >     printk("/!\\ Interruption : tx_empty\n");
> >        return IRQ_HANDLED;
> > }
> >
> >     req=3Drequest_irq(0x18,uart_test,NULL,"uart_test",NULL);
> >     printk("Initialisation IRQ UART : %d \n", req);
> >
> > When I boot linux ppc, the req value is -38.
> > What is wrong ?
>
> > -----------------------------------------------------------------------=
-
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
> --
>
>
> ------------------------------------------------------------------------
>
>
>   Daniele Bosi
>
> *DIGITEK S.p.A.*
>
> Via L. Romagnoli 24,
> 41033 Concordia sulla Secchia
> Modena (MO), Italy
>
> *Tel*: +39-(0)53556942 Fax. +39-(0)53554550
>
> *Web:    * http://www.digitek.it
>
> *Mail to:* d.bosi@selcomgroup.com <mailto:d.bosi@selcomgroup.com>
>
>

------=_Part_29996_1129382.1220454226270
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The failure referes to setup_irq :<br>
desc-&gt;chip =3D=3D &amp;no_irq_chip is true<br>
<br>
What is irq_desc and how can I initialize it ?<br>
<br>
<br>
setup_irq(unsigned int irq, struct irqaction *new)<br>
{<br>
&nbsp;&nbsp;&nbsp; struct irq_desc *desc =3D irq_desc + irq;<br>
&nbsp;&nbsp;&nbsp; struct irqaction *old, **p;<br>
&nbsp;&nbsp;&nbsp; const char *old_name =3D NULL;<br>
&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&nbsp;&nbsp;&nbsp; int shared =3D 0;<br>
<br>
&nbsp;&nbsp;&nbsp; if (irq &gt;=3D NR_IRQS)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -EINVAL;<br>
<br>
&nbsp;&nbsp;&nbsp; printk(&quot;desc\n&quot;);<br>
&nbsp;&nbsp;&nbsp; if (desc-&gt;chip =3D=3D &amp;no_irq_chip)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -ENOSYS;<br>
&nbsp;&nbsp;&nbsp; printk(&quot;desc2\n&quot;);<br><br><div><span class=3D"=
gmail_quote">2008/9/3, Daniele Bosi &lt;<a href=3D"mailto:d.bosi@selcomgrou=
p.com">d.bosi@selcomgroup.com</a>&gt;:</span><blockquote class=3D"gmail_quo=
te" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt=
 0.8ex; padding-left: 1ex;">
Try to set some flag into the third parameter of the request_irq()<br> func=
tion like:<br> <br> SA_SHIRQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Interrupt is shared<br> <b=
r> SA_INTERRUPT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;Disable local interrupts while processing<br> <br>
 SA_SAMPLE_RANDOM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The interr=
upt can be used for entropy<br> <br> otherwise try to use the function inst=
all_irq_handler()<br> <br> <br> bye Daniele<br> <br> <br> <br> S=E9bastien =
Chr=E9tien ha scritto:<br> <br>&gt; Hello,<br>
 &gt;<br> &gt; I am trying to register a function writh IRQ :<br> &gt;<br> =
&gt; static irqreturn_t uart_test (int irq , void *dev_id)<br> &gt; {<br> &=
gt;&nbsp;&nbsp;&nbsp;&nbsp; printk(&quot;/!\\ Interruption : tx_empty\n&quo=
t;);<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return IRQ_HAN=
DLED;<br>
 &gt; }<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; req=3Drequest_irq(0x18,ua=
rt_test,NULL,&quot;uart_test&quot;,NULL);<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; =
printk(&quot;Initialisation IRQ UART : %d \n&quot;, req);<br> &gt;<br> &gt;=
 When I boot linux ppc, the req value is -38.<br>
 &gt; What is wrong ?<br> <br>&gt; ----------------------------------------=
--------------------------------<br> &gt;<br> &gt; ________________________=
_______________________<br> &gt; Linuxppc-dev mailing list<br> &gt; <a href=
=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>
 &gt; <a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://=
ozlabs.org/mailman/listinfo/linuxppc-dev</a><br> <br> --<br> <br> <br> ----=
--------------------------------------------------------------------<br> <b=
r>
 <br>&nbsp;&nbsp;Daniele Bosi<br> <br> *DIGITEK S.p.A.*<br> <br> Via L. Rom=
agnoli 24,<br> 41033 Concordia sulla Secchia<br> Modena (MO), Italy<br> <br=
> *Tel*: +39-(0)53556942 Fax. +39-(0)53554550<br> <br> *Web:&nbsp;&nbsp;&nb=
sp;&nbsp;* <a href=3D"http://www.digitek.it">http://www.digitek.it</a><br>
 <br> *Mail to:* <a href=3D"mailto:d.bosi@selcomgroup.com">d.bosi@selcomgro=
up.com</a> &lt;mailto:<a href=3D"mailto:d.bosi@selcomgroup.com">d.bosi@selc=
omgroup.com</a>&gt;<br> <br> </blockquote></div><br>

------=_Part_29996_1129382.1220454226270--
