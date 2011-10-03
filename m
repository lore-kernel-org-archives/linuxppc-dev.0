Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out01.wipro.com (wipro-blr-out01.wipro.com
	[203.91.198.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 28D3FB6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Oct 2011 01:27:36 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <scottwood@freescale.com>
Subject: RE: Request_irq fails for IRQ2 
Date: Mon, 3 Oct 2011 14:27:21 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE0145F8@HYD-MKD-MBX4.wipro.com>
Content-Type: multipart/alternative;
	boundary="_000_40631E9A2581F14BA60888C87A76A1FE0145F8HYDMKDMBX4wiproco_"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_40631E9A2581F14BA60888C87A76A1FE0145F8HYDMKDMBX4wiproco_
Content-Type: text/plain; charset="us-ascii"
content-transfer-encoding: quoted-printable


Hi Scott,

 I try to request an IRQ (IRQ2 and IRQ3 which are ineterrupt no 20 and 21 in=
 mpc8247)in my driver . The
Call fails in setup_irq in Manage.c at /kernel/irq.

Setup _irq returns -ENOSYS

if (desc->irq_data.chip =3D=3D &no_irq_chip)
                 return -ENOSYS;


I found that I need to pass the virtual interrupt number instead of hardware=
 interrupt number.
So I added below piece of code

Below is the call to request irq in my driver.

virq =3D irq_create_mapping(NULL, CPLD1_INTERRUPT);




   if ((ret =3D request_irq(virq,cpld_irq_handler, 0, GPIO_CHAR_PATH, NULL))=
!=3D0)
   {
      printk(KERN_ERR "gpio_init: Could not grab IRQ line for CPLD ret =3D %=
d\n",ret);
          goto err1;
   }


Now it fails in irq_create_mapping   with NO_IRQ error.

if (controller =3D=3D NULL)
                host =3D irq_default_host;
else
                host =3D irq_find_host(controller);
if (host =3D=3D NULL) {
                printk(KERN_WARNING "irq: no irq host found for %s !\n",
                       controller->full_name);
                return NO_IRQ;
        }


I just don't know what I should pass for host , also when I pass NULL for ho=
st . I see the default host is NULL..
Could you please help me. My project delivery is near , I need  help soon.


Regards,
Smitha



Please do not print this email unless it is absolutely necessary. =0A=
=0A=
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. =0A=
=0A=
WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. =0A=
=0A=
www.wipro.com

--_000_40631E9A2581F14BA60888C87A76A1FE0145F8HYDMKDMBX4wiproco_
Content-Type: text/html; charset="us-ascii"
content-transfer-encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial" size=3D"2"><span style=3D"font-size:10pt;">
<div>&nbsp;</div>
<div>Hi Scott,</div>
<div>&nbsp;</div>
<div> I try to request an IRQ (IRQ2 and IRQ3 which are ineterrupt no 20 and=
 21 in mpc8247)in my driver . The</div>
<div>Call fails in setup_irq in Manage.c at /kernel/irq. </div>
<div>&nbsp;</div>
<div>Setup _irq returns -ENOSYS</div>
<div>&nbsp;</div>
<div><font color=3D"red">if (desc-&gt;irq_data.chip =3D=3D &amp;no_irq_chip)=
</font></div>
<div><font color=3D"red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOSYS;</font></div>
<div><font color=3D"blue">&nbsp;</font></div>
<div><font color=3D"blue">&nbsp;</font></div>
<div><font color=3D"blue">I found that I need to pass the virtual interrupt=
 number instead of hardware interrupt number. </font></div>
<div><font color=3D"blue">So I added below piece of code </font></div>
<div><font color=3D"blue">&nbsp;</font></div>
<div>Below is the call to request irq in my driver. </div>
<div><font color=3D"blue">&nbsp;</font></div>
<div><font face=3D"Courier New" size=3D"2"><span style=3D"font-size:9pt;">vi=
rq =3D irq_create_mapping(NULL, CPLD1_INTERRUPT); </span></font></div>
<div><font face=3D"Courier New" size=3D"2"><span style=3D"font-size:9pt;">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font></div>
<div><font face=3D"Courier New" size=3D"2"><span style=3D"font-size:9pt;">&n=
bsp;</span></font></div>
<div><font face=3D"Courier New" size=3D"2"><span style=3D"font-size:9pt;">&n=
bsp;</span></font></div>
<div><font face=3D"Courier New" size=3D"2"><span style=3D"font-size:9pt;">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font></div>
<div><font face=3D"Courier New" size=3D"2"><span style=3D"font-size:9pt;">&n=
bsp;&nbsp; if ((ret =3D request_irq(virq,cpld_irq_handler, 0, GPIO_CHAR_PATH=
, NULL))!=3D0)</span></font></div>
<div><font face=3D"Courier New" size=3D"2"><span style=3D"font-size:9pt;">&n=
bsp;&nbsp; {</span></font></div>
<div><font face=3D"Courier New" size=3D"2"><span style=3D"font-size:9pt;">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ERR &quot;gpio_init: Could not grab=
 IRQ line for CPLD ret =3D %d\n&quot;,ret);</span></font></div>
<div><font face=3D"Courier New" size=3D"2"><span style=3D"font-size:9pt;">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; goto err1;</span></font></di=
v>
<div><font face=3D"Courier New" size=3D"2"><span style=3D"font-size:9pt;">&n=
bsp;&nbsp; }</span></font></div>
<div><font face=3D"Courier New" size=3D"2" color=3D"blue"><span style=3D"fon=
t-size:9pt;">&nbsp;</span></font></div>
<div><font color=3D"blue">&nbsp;</font></div>
<div><font color=3D"blue">Now it fails in <font face=3D"Courier New" size=3D=
"2" color=3D"black"><span style=3D"font-size:9pt;"><b>irq_create_mapping</b>=
</span></font><b>&nbsp;&nbsp; with NO_IRQ error.</b></font></div>
<div><font color=3D"blue">&nbsp;</font></div>
<div><font color=3D"blue"><b>if (controller =3D=3D NULL)</b></font></div>
<div><font color=3D"blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>host =3D irq_default_host;</b></=
font></div>
<div><font color=3D"blue"><b>else</b></font></div>
<div><font color=3D"blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>host =3D irq_find_host(controlle=
r);</b></font></div>
<div><font color=3D"blue">if (host =3D=3D NULL) {</font></div>
<div><font color=3D"blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_WARNING &quot;irq: no i=
rq host found for %s !\n&quot;,</font></div>
<div><font color=3D"blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; controller-&gt;full_name);</font></div>
<div><font color=3D"blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return <font color=3D"red">NO_IRQ</=
font>;</font></div>
<div><font color=3D"blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</font=
></div>
<div><font color=3D"blue">&nbsp;</font></div>
<div><font color=3D"blue">&nbsp;</font></div>
<div>I just don't know what I should pass for host , also when I pass NULL f=
or host . I see the default host is NULL..</div>
<div>Could you please help me. My project delivery is near , I need&nbsp; he=
lp soon.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Smitha</div>
<div><font color=3D"red">&nbsp;</font></div>
<div><font color=3D"red">&nbsp;</font></div>
</span></font>
<P><strong><span style=3D'font-size:10.0pt;font-family:=0A=
"Palatino Linotype","serif";color:green'> Please do not print this email unl=
ess it is absolutely necessary. </span></strong><span style=3D'font-family:"=
Arial","sans-serif"'><o:p></o:p></span></p>=0A=
=0A=
=0A=
<p> The information contained in this electronic message and any attachments=
 to this message are intended for the exclusive use of the addressee(s) and=
 may contain proprietary, confidential or privileged information. If you are=
 not the intended recipient, you should not disseminate, distribute or copy=
 this e-mail. Please notify the sender immediately and destroy all copies of=
 this message and any attachments. </p>=0A=
=0A=
<p>WARNING: Computer viruses can be transmitted via email. The recipient sho=
uld check this email and any attachments for the presence of viruses. The co=
mpany accepts no liability for any damage caused by any virus transmitted by=
 this email. </p>=0A=
<p>=0A=
www.wipro.com=0A=
</p>
</body>
</html>

--_000_40631E9A2581F14BA60888C87A76A1FE0145F8HYDMKDMBX4wiproco_--
