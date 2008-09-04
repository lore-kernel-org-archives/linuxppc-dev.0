Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id 0C546474E2
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 23:23:23 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so3583895rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2008 06:23:21 -0700 (PDT)
Message-ID: <319b0ac50809040623q1c32049ake8a5ea21fd5972cd@mail.gmail.com>
Date: Thu, 4 Sep 2008 15:23:21 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: irq
In-Reply-To: <319b0ac50809040127l2c506007vd6400a5edf912b71@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_47548_27550536.1220534601446"
References: <319b0ac50809030715h1a03a606jacddd400019f4483@mail.gmail.com>
	<48BEA106.9090307@selcomgroup.com>
	<319b0ac50809030803p6d659468wd7d2425224653374@mail.gmail.com>
	<6a6049b80809030905u561043ecr1438d20aebf5598d@mail.gmail.com>
	<48BEBD17.1030705@gmail.com>
	<20080903170815.GA10979@loki.buserror.net>
	<48BEFB5D.3040903@gmail.com> <1220497366.4879.27.camel@pasglop>
	<319b0ac50809040127l2c506007vd6400a5edf912b71@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>,
	M B <super.firetwister@googlemail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_47548_27550536.1220534601446
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I try to write a device tree about irq :

IT_controller: irq_controller@20006000 {
               clock-frequency =3D <0>;
               interrupt-controller;
            #address-cells =3D <0>;
               reg =3D <0x20006000 0x100>;
               compatible =3D "it";
               device_type =3D "it";
               big-endian;
           };

           uart@200b1000{
               device_type=3D"uart";
               compatible=3D"uart";
               interrupts =3D <0x18 0>;
               interrupt-parent=3D<&IT_controller>;
           };


uart_irq=3Dof_find_node_by_type(NULL, "uart");
    if(uart_irq=3D=3DNULL)
         printk("%s: No uart node found !\n", __func__);

    virt=3Dirq_of_parse_and_map(uart_irq, 0);
    printk("Virtual irq : %d \n",virt);


When I boot linux, virt=3D0;

What is wrong ?


2008/9/4, S=E9bastien Chr=E9tien <sebastien.chretien.enseirb@gmail.com>:
>
> I read the booting_without_of.txt document and the Interrupt Mapping
> docucument from http://playground.sun.com/1275. But I don't understand al=
l
> parameters. Can somebody help me to create my device tree about interrupt
> part ?
>
> I have an interrupt controller at the adresse 0x20006000. The irq_id rang=
e
> is 1 to 63.
> I would like to try UART interrupt, which have ids : 0x18 (tranmission fi=
fo
> empty,
> 0x19 (reception fifo full), 0x1a (reception error), 0x1b (break emission)=
.
> What other informations are needed ?
>
>
> Nothing is cascaded.
>
> Thanks
>
>
>
>
> 2008/9/4, Benjamin Herrenschmidt <benh@kernel.crashing.org>:
>>
>> On Wed, 2008-09-03 at 23:02 +0200, S=E9bastien Chr=E9tien wrote:
>>
>> > irq_of_parse_and_map is equivalent to ioremap in the MMU case ?
>>
>>
>> On the powerpc architecture, we use virtualized IRQ numbers in order to
>> deal with the wide range of interrupt controllers around and multiple
>> of them cascaded.
>>
>> The base function to "map" a physical interrupt to a virtual interrupt
>> is irq_create_mapping(). It takes an irq_host argument which represent
>> the IRQ "domain" (typically irq controller) off which the interrupt you
>> are trying to map hangs.
>>
>> If you pass NULL, it will use the "default" controller, which doesn't
>> always exist, it depends on the platform. Usually, platforms set that
>> to the toplevel PIC.
>>
>> However, normally, that function shouldn't be used directly. Instead,
>> you should create a representation of your device in the device-tree
>> along with the appropriate interrupt mapping, and then use the
>> irq_of_parse_and_map() function to obtain a mapped virtual irq based
>> on the device-tree information. This will take care of finding the
>> right irq_host but will also properly setup the polarity of the
>> interrupt etc...
>>
>> Now, as to how you should represent the interrupt in the device-tree,
>> this should be explained in Documentation/booting-without-of.txt
>>
>> Cheers,
>> Ben.
>>
>>
>

------=_Part_47548_27550536.1220534601446
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I try to write a device tree about irq : <br>
<br>
IT_controller: irq_controller@20006000 {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
clock-frequency =3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
interrupt-controller;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells =3D=
 &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
reg =3D &lt;0x20006000 0x100&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
compatible =3D &quot;it&quot;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
device_type =3D &quot;it&quot;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
big-endian;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uart@200b1000{<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
device_type=3D&quot;uart&quot;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
compatible=3D&quot;uart&quot;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
interrupts =3D &lt;0x18 0&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
interrupt-parent=3D&lt;&amp;IT_controller&gt;;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
<br>
<br>
uart_irq=3Dof_find_node_by_type(NULL, &quot;uart&quot;);<br>
&nbsp;&nbsp;&nbsp; if(uart_irq=3D=3DNULL)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;printk(&quot;%s: No uart node f=
ound !\n&quot;, __func__);<br>
<br>
&nbsp;&nbsp;&nbsp; virt=3Dirq_of_parse_and_map(uart_irq, 0);<br>
&nbsp;&nbsp;&nbsp; printk(&quot;Virtual irq : %d \n&quot;,virt);<br>
<br>
<br>
When I boot linux, virt=3D0;<br>
<br>
What is wrong ?<br>
<br><br><div><span class=3D"gmail_quote">2008/9/4, S=E9bastien Chr=E9tien &=
lt;<a href=3D"mailto:sebastien.chretien.enseirb@gmail.com">sebastien.chreti=
en.enseirb@gmail.com</a>&gt;:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
I read the booting_without_of.txt document and the Interrupt Mapping
docucument from <a href=3D"http://playground.sun.com/1275" target=3D"_blank=
" onclick=3D"return top.js.OpenExtLink(window,event,this)">http://playgroun=
d.sun.com/1275</a>. But I don&#39;t understand
all parameters. Can somebody help me to create my device tree about
interrupt part ?<br>
<br>
I have an interrupt controller at the adresse 0x20006000. The irq_id range =
is 1 to 63.<br>
I would like to try UART interrupt, which have ids : 0x18 (tranmission fifo=
 empty,<br>
0x19 (reception fifo full), 0x1a (reception error), 0x1b (break emission).<=
br>
What other informations are needed ?<br>
<br>
<br>
Nothing is cascaded.<br>
<br>
Thanks<br>
<br>
<br>
<br><br><div><span class=3D"gmail_quote">2008/9/4, Benjamin Herrenschmidt &=
lt;<a href=3D"mailto:benh@kernel.crashing.org" target=3D"_blank" onclick=3D=
"return top.js.OpenExtLink(window,event,this)">benh@kernel.crashing.org</a>=
&gt;:</span><div>
<span class=3D"e" id=3D"q_11c2c797973e45b9_1"><blockquote class=3D"gmail_qu=
ote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0p=
t 0.8ex; padding-left: 1ex;">
On Wed, 2008-09-03 at 23:02 +0200, S=E9bastien Chr=E9tien wrote:<br> <br> &=
gt; irq_of_parse_and_map is equivalent to ioremap in the MMU case ?<br> <br=
> <br>On the powerpc architecture, we use virtualized IRQ numbers in order =
to<br>

 deal with the wide range of interrupt controllers around and multiple<br> =
of them cascaded.<br> <br> The base function to &quot;map&quot; a physical =
interrupt to a virtual interrupt<br> is irq_create_mapping(). It takes an i=
rq_host argument which represent<br>

 the IRQ &quot;domain&quot; (typically irq controller) off which the interr=
upt you<br> are trying to map hangs.<br> <br> If you pass NULL, it will use=
 the &quot;default&quot; controller, which doesn&#39;t<br> always exist, it=
 depends on the platform. Usually, platforms set that<br>

 to the toplevel PIC.<br> <br> However, normally, that function shouldn&#39=
;t be used directly. Instead,<br> you should create a representation of you=
r device in the device-tree<br> along with the appropriate interrupt mappin=
g, and then use the<br>

 irq_of_parse_and_map() function to obtain a mapped virtual irq based<br> o=
n the device-tree information. This will take care of finding the<br> right=
 irq_host but will also properly setup the polarity of the<br> interrupt et=
c...<br>

 <br> Now, as to how you should represent the interrupt in the device-tree,=
<br> this should be explained in Documentation/booting-without-of.txt<br> <=
br> Cheers,<br> Ben.<br> <br> </blockquote></span></div></div><br>
</blockquote></div><br>

------=_Part_47548_27550536.1220534601446--
