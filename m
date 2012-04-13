Return-Path: <tqnguyen@apm.com>
Received: from exprod5og114.obsmtp.com (exprod5og114.obsmtp.com [64.18.0.28])
 by ozlabs.org (Postfix) with SMTP id 3B806B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2012 13:29:34 +1000 (EST)
Received: by dadz8 with SMTP id z8so4340204dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 20:29:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F8417DB.3040502@mvista.com>
References: <1333447938-16461-1-git-send-email-tqnguyen@apm.com>
 <4F82B61D.8010502@mvista.com>
 <8a0ea5bd221ddeb9eded16e180aa8fbb@mail.gmail.com>
 <4F8417DB.3040502@mvista.com>
Date: Fri, 13 Apr 2012 10:29:31 +0700
Message-ID: <CAKrQpSsckS+mdWQBJWLxGY2bjUZ8eFenPCfCWtqRupLcQzQ7UQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add support 2 SATA ports for Maui and change filename
 from sata_dwc_460ex.c to sata_dwc_4xx.c
From: "Thang Q. Nguyen" <tqnguyen@apm.com>
To: Sergei Shtylyov <sshtylyov@mvista.com>
Content-Type: multipart/alternative; boundary=047d7b10c899a1db2004bd8714f1
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b10c899a1db2004bd8714f1
Content-Type: text/plain; charset=ISO-8859-1

Hi,
Two SATA device nodes in bluestone.dts uses the same structure as SATA node
in the canyonlands.dts. All boards having SATA DWC currently use this
structure. So, changing it will need to change all corresponding device
tree. The current sata_dwc_460ex.c agrees with this structure.

I want to give more information for SATA controller on Maui:
 - There are 2 SATA controllers on Maui, each has its own register set. But
they use the same DMA registers for processing DMA transfer.
 - For DMA transfer, each SATA controller will use its own DMA channel in
the DMA registers.
 - DMA controller driver must be supported and enabled in order to issue
SATA DMA transfer.

I agree that declaring the same DMA register information in 2 device nodes
can cause confliction but I think the driver can handle it. In case this
approach is not accepted, I will add only 1 SATA port to the bluestone.dts
and another port will be considered later.

For the APM confidential information from my email, it is added
automatically by the APM system. I have submitted a ticket for asking IT
not adding it into my email and it is in-progress. I will continue to
submit patches after the ticket is processed.

Regards,
Thang Nguyen -

On Tue, Apr 10, 2012 at 6:22 PM, Sergei Shtylyov <sshtylyov@mvista.com>wrote:

> Hello.
>
>
> On 10-04-2012 7:46, Thang Nguyen wrote:
>
>  Hi Sergei,
>> Thanks for your review.
>>
>
>  On Maui, there are 2 separate SATA controllers but they share the same
>> AHBDMA controller. Each SATA controller is assigned a fixed DMA channel on
>> the AHBDMA (channel 0 is assigned to SATA controller 0 and channel 1 is
>> assigned to SATA controller 1).
>> For the 460EX, there is only 1 SATA controller and it uses channel 0 for
>> transferring data.
>>
>
>  In my opinion, in the case of Maui, we can use the same DMA information in
>> 2 device nodes as they use the same DMA controller. And in another CPU, if
>> they use different DMA controller, the corresponding information will also
>> be different.
>>
>
>   No, either the DMA controller should be a separate device node, or both
> ports and DMA controller should be packed into the single device node. The
> way you're doing it is incorrect because it creates memory resource
> conflict between devices when they are instantiated as platfrom devices.
>
>
>  Regards,
>> Thang Nguyen -
>> -----Original Message-----
>> From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
>> Sent: Monday, April 09, 2012 5:13 PM
>> To: Thang Q. Nguyen
>> Cc: Benjamin Herrenschmidt; Paul Mackerras; Jeff Garzik; Grant Likely; Rob
>> Herring; linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org;
>> linux-ide@vger.kernel.org; devicetree-discuss@lists.**ozlabs.org<devicetree-discuss@lists.ozlabs.org>
>> Subject: Re: [PATCH 1/1] Add support 2 SATA ports for Maui and change
>> filename from sata_dwc_460ex.c to sata_dwc_4xx.c
>>
>
>  Hello.
>>
>
>  On 03-04-2012 14:12, Thang Q. Nguyen wrote:
>>
>
>  Signed-off-by: Thang Q. Nguyen<tqnguyen@apm.com>
>>>
>> [...]
>>
>
>  diff --git a/arch/powerpc/boot/dts/**bluestone.dts
>>>
>> b/arch/powerpc/boot/dts/**bluestone.dts
>>
>>> index cfa23bf..803fda6 100644
>>> --- a/arch/powerpc/boot/dts/**bluestone.dts
>>> +++ b/arch/powerpc/boot/dts/**bluestone.dts
>>> @@ -155,6 +155,27 @@
>>>                                        /*RXDE*/  0x5 0x4>;
>>>                };
>>>
>>> +               /* SATA DWC devices */
>>> +               SATA0: sata@bffd1000 {
>>> +                       compatible = "amcc,sata-apm821xx";
>>> +                       reg =<4 0xbffd1000 0x800   /* SATA0 */
>>> +                              4 0xbffd0800 0x400>; /* AHBDMA */
>>> +                       dma-channel=<0>;
>>> +                       interrupt-parent =<&UIC0>;
>>> +                       interrupts =<26 4    /* SATA0 */
>>> +                                     25 4>;  /* AHBDMA */
>>> +               };
>>> +
>>> +               SATA1: sata@bffd1800 {
>>> +                       compatible = "amcc,sata-apm821xx";
>>> +                       reg =<4 0xbffd1800 0x800   /* SATA1 */
>>> +                              4 0xbffd0800 0x400>; /* AHBDMA */
>>> +                       dma-channel=<1>;
>>> +                       interrupt-parent =<&UIC0>;
>>> +                       interrupts =<27 4    /* SATA1 */
>>> +                                     25 4>;  /* AHBDMA */
>>> +               };
>>> +
>>>
>>
>      So, this is dual SATA controller, not dual port SATA controller?
>> BTW, it's wrong to have the same AHBDMA resource in two device nodes I
>> think.
>>
>
>  MBR, Sergei
>>
>
>   Can you get rid of the following? It looks stupid when you post to the
> maliing list.
>
>  CONFIDENTIALITY NOTICE: This e-mail message, including any attachments,
>> is for the sole use of the intended recipient(s) and contains information
>> that is confidential and proprietary to AppliedMicro Corporation or its
>> subsidiaries.
>> It is to be used solely for the purpose of furthering the parties'
>> business relationship.
>> All unauthorized review, use, disclosure or distribution is prohibited.
>> If you are not the intended recipient, please contact the sender by reply
>> e-mail
>> and destroy all copies of the original message.
>>
>
> WBR, Sergei
>



-- 

   *Thang Q. Nguyen    **|** Staff SW Eng.*

C: +849.7684.7607 | O: +848.3770.0640

F: +848.3770.0641  | tqnguyen@apm.com

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information 
that is confidential and proprietary to AppliedMicro Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.

--047d7b10c899a1db2004bd8714f1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div>Two SATA device nodes in bluestone.dts uses the same structure as S=
ATA node in the canyonlands.dts. All boards having SATA DWC currently use t=
his structure. So, changing it will need to change all corresponding device=
 tree. The current sata_dwc_460ex.c agrees with this structure.</div>
<div><br></div><div>I want to give more information for SATA controller on =
Maui:</div><div>=A0- There are 2 SATA controllers on Maui, each has its own=
 register set. But they use the same DMA registers for processing DMA trans=
fer.</div>
<div>=A0- For DMA transfer, each SATA controller will use its own DMA chann=
el in the DMA registers.</div><div>=A0- DMA controller driver must be suppo=
rted and enabled in order to issue SATA DMA transfer.</div><div><br></div><=
div>
I agree that declaring the same DMA register information in 2 device nodes =
can cause confliction but I think the driver can handle it. In case this ap=
proach is not accepted, I will add only 1 SATA port to the bluestone.dts an=
d another port will be considered later.</div>
<div><br></div><div>For the APM confidential information from my email, it =
is added automatically by the APM system. I have submitted a ticket for ask=
ing IT not adding it into my email and it is in-progress. I will continue t=
o submit patches after the ticket is processed.</div>
<div><br></div><div>Regards,</div><div>Thang Nguyen -<br><br><div class=3D"=
gmail_quote">On Tue, Apr 10, 2012 at 6:22 PM, Sergei Shtylyov <span dir=3D"=
ltr">&lt;<a href=3D"mailto:sshtylyov@mvista.com">sshtylyov@mvista.com</a>&g=
t;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hello.<div class=3D"im"><br>
<br>
On 10-04-2012 7:46, Thang Nguyen wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Sergei,<br>
Thanks for your review.<br>
</blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Maui, there are 2 separate SATA controllers but they share the same<br>
AHBDMA controller. Each SATA controller is assigned a fixed DMA channel on<=
br>
the AHBDMA (channel 0 is assigned to SATA controller 0 and channel 1 is<br>
assigned to SATA controller 1).<br>
For the 460EX, there is only 1 SATA controller and it uses channel 0 for<br=
>
transferring data.<br>
</blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
In my opinion, in the case of Maui, we can use the same DMA information in<=
br>
2 device nodes as they use the same DMA controller. And in another CPU, if<=
br>
they use different DMA controller, the corresponding information will also<=
br>
be different.<br>
</blockquote>
<br></div>
 =A0 No, either the DMA controller should be a separate device node, or bot=
h ports and DMA controller should be packed into the single device node. Th=
e way you&#39;re doing it is incorrect because it creates memory resource c=
onflict between devices when they are instantiated as platfrom devices.<div=
>
<div class=3D"h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Regards,<br>
Thang Nguyen -<br>
-----Original Message-----<br>
From: Sergei Shtylyov [mailto:<a href=3D"mailto:sshtylyov@mvista.com" targe=
t=3D"_blank">sshtylyov@mvista.com</a>]<br>
Sent: Monday, April 09, 2012 5:13 PM<br>
To: Thang Q. Nguyen<br>
Cc: Benjamin Herrenschmidt; Paul Mackerras; Jeff Garzik; Grant Likely; Rob<=
br>
Herring; <a href=3D"mailto:linuxppc-dev@lists.ozlabs.org" target=3D"_blank"=
>linuxppc-dev@lists.ozlabs.org</a>; <a href=3D"mailto:linux-kernel@vger.ker=
nel.org" target=3D"_blank">linux-kernel@vger.kernel.org</a>;<br>
<a href=3D"mailto:linux-ide@vger.kernel.org" target=3D"_blank">linux-ide@vg=
er.kernel.org</a>; <a href=3D"mailto:devicetree-discuss@lists.ozlabs.org" t=
arget=3D"_blank">devicetree-discuss@lists.<u></u>ozlabs.org</a><br>
Subject: Re: [PATCH 1/1] Add support 2 SATA ports for Maui and change<br>
filename from sata_dwc_460ex.c to sata_dwc_4xx.c<br>
</blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello.<br>
</blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 03-04-2012 14:12, Thang Q. Nguyen wrote:<br>
</blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Signed-off-by: Thang Q. Nguyen&lt;<a href=3D"mailto:tqnguyen@apm.com" targe=
t=3D"_blank">tqnguyen@apm.com</a>&gt;<br>
</blockquote>
[...]<br>
</blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/arch/powerpc/boot/dts/<u></u>bluestone.dts<br>
</blockquote>
b/arch/powerpc/boot/dts/<u></u>bluestone.dts<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
index cfa23bf..803fda6 100644<br>
--- a/arch/powerpc/boot/dts/<u></u>bluestone.dts<br>
+++ b/arch/powerpc/boot/dts/<u></u>bluestone.dts<br>
@@ -155,6 +155,27 @@<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0/*RXDE*/ =A00x5 0x4&gt;;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};<br>
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* SATA DWC devices */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 SATA0: sata@bffd1000 {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;amcc,sat=
a-apm821xx&quot;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D&lt;4 0xbffd1000 0x800=
 =A0 /* SATA0 */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04 0xbffd0800 0=
x400&gt;; /* AHBDMA */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma-channel=3D&lt;0&gt;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D&lt;&amp;=
UIC0&gt;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D&lt;26 4 =A0 =
=A0/* SATA0 */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2=
5 4&gt;; =A0/* AHBDMA */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 SATA1: sata@bffd1800 {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;amcc,sat=
a-apm821xx&quot;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D&lt;4 0xbffd1800 0x800=
 =A0 /* SATA1 */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04 0xbffd0800 0=
x400&gt;; /* AHBDMA */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma-channel=3D&lt;1&gt;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D&lt;&amp;=
UIC0&gt;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D&lt;27 4 =A0 =
=A0/* SATA1 */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2=
5 4&gt;; =A0/* AHBDMA */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
+<br>
</blockquote></blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
 =A0 =A0 So, this is dual SATA controller, not dual port SATA controller?<b=
r>
BTW, it&#39;s wrong to have the same AHBDMA resource in two device nodes I<=
br>
think.<br>
</blockquote>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
MBR, Sergei<br>
</blockquote>
<br></div></div>
 =A0 Can you get rid of the following? It looks stupid when you post to the=
 maliing list.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments,<br>
is for the sole use of the intended recipient(s) and contains information<b=
r>
that is confidential and proprietary to AppliedMicro Corporation or its sub=
sidiaries.<br>
It is to be used solely for the purpose of furthering the parties&#39; busi=
ness relationship.<br>
All unauthorized review, use, disclosure or distribution is prohibited.<br>
If you are not the intended recipient, please contact the sender by reply e=
-mail<br>
and destroy all copies of the original message.<br>
</blockquote>
<br>
WBR, Sergei<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>
 =20
 =20
 =20
 =20
  <font face=3D"arial, helvetica, sans-serif"><span style=3D"border-collaps=
e:collapse;font-size:medium"><br><table border=3D"0" cellspacing=3D"0" cell=
padding=3D"0" width=3D"448" style=3D"background:white;border-collapse:colla=
pse">
 <tbody><tr style=3D"height:60.95pt">
  <td width=3D"162" valign=3D"top" style=3D"width:121.5pt;padding:0in 0in 0=
in 0in;height:60.95pt">
  <p style=3D"margin-bottom:0in;margin-bottom:.0001pt;line-height:normal"><=
span><img src=3D"https://sites.google.com/a/apm.com/logosig/_/rsrc/12780129=
78742/home/apm_sig_left_063010.jpg"></span></p>
  </td>
  <td width=3D"286" style=3D"width:214.45pt;padding:0in 0in 0in 0in;height:=
60.95pt">
  <p style=3D"margin-bottom:0in;margin-bottom:.0001pt;line-height:12.2pt"><=
b><span style=3D"font-size:9.0pt;color:#7f7f7f">Thang Q. Nguyen =A0=A0<span=
>=A0</span></span></b><b><span style=3D"font-size:9.0pt;color:#8cc63f">|</s=
pan></b><b><span style=3D"font-size:9.0pt;color:#7f7f7f"> Staff SW Eng.</sp=
an></b></p>

  <p style=3D"margin-bottom:0in;margin-bottom:.0001pt;line-height:12.2pt"><=
span style=3D"font-size:9.0pt;color:#7f7f7f">C: +849.7684.7607
  </span><span style=3D"font-size:9.0pt;color:#8cc63f">|</span><span style=
=3D"font-size:9.0pt;color:#7f7f7f"> O:
  +848.3770.0640</span></p>
  <p style=3D"margin-bottom:0in;margin-bottom:.0001pt;line-height:12.2pt"><=
span style=3D"font-size:9.0pt;color:#7f7f7f">F: +848.3770.0641 =A0</span><s=
pan style=3D"font-size:9.0pt;color:#8cc63f">|</span><span style=3D"font-siz=
e:9.0pt;color:#7f7f7f"> <a href=3D"mailto:tqnguyen@apm.com" target=3D"_blan=
k">tqnguyen@apm.com</a></span><span style=3D"font-size:10.0pt;color:#7f7f7f=
"></span></p>

  </td>
 </tr></tbody></table><table border=3D"0" cellspacing=3D"0" cellpadding=3D"=
0" width=3D"477" style=3D"background:white;border-collapse:collapse"><tbody=
></tbody></table></span></font><br>
</div>

<pre>CONFIDENTIALITY NOTICE: This e-mail message, including any attachmen=
ts, =

is for the sole use of the intended recipient(s) and contains information=
=A0
that is confidential and proprietary to AppliedMicro Corporation or its s=
ubsidiaries. =

It is to be used solely for the purpose of furthering the parties' busine=
ss relationship. =

All unauthorized review, use, disclosure or distribution is prohibited. =

If you are not the intended recipient, please contact the sender by reply=
 e-mail =

and destroy all copies of the original message.
=0D
--047d7b10c899a1db2004bd8714f1--
