Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out02.wipro.com (wipro-blr-out02.wipro.com
	[203.91.198.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 046CAB6F9F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Oct 2011 22:24:43 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <scottwood@freescale.com>
Subject: BUG: scheduling while atomic:
Date: Wed, 5 Oct 2011 11:24:25 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE014A35@HYD-MKD-MBX4.wipro.com>
Content-Type: multipart/alternative;
	boundary="_000_40631E9A2581F14BA60888C87A76A1FE014A35HYDMKDMBX4wiproco_"
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

--_000_40631E9A2581F14BA60888C87A76A1FE014A35HYDMKDMBX4wiproco_
Content-Type: text/plain; charset="us-ascii"
content-transfer-encoding: quoted-printable

Hi Scoot,

 When my  ISR gets exeuted I get a below BUG. Could let me what I am doing w=
rong in the ISR?


 BUG: scheduling while atomic: IRQ-20/0x0fff0000/108
Call Trace:
[C3AEFEC0] [C0007CCC]  (unreliable)
[C3AEFEF0] [C0017F10]
[C3AEFF00] [C0268818]
[C3AEFF50] [C0017F44]
[C3AEFF60] [C0018044]
[C3AEFF70] [C0046A90]
[C3AEFF90] [C0046D90]
[C3AEFFC0] [C0032AFC]
[C3AEFFF0] [C000F5AC]


Below is the code :
My ISR

irqreturn_t cpld_irq_handler(int irq, void * dev_id, struct pt_regs *regs)

{

wake_up(&cpld_intr_wait);

atomic_inc(&cpld_intr_data); /* incrementing this will indicate the poll() t=
hat the interrupt is occured */

return 0;

}

DRIVER_INIT
static int __init gpio_init(void)
{
        int ret =3D 0;
        int virq;


    atomic_set(&cpld_intr_data, 0);                     /* initialize the In=
terrupt indicator */
    init_waitqueue_head(&cpld_intr_wait);               /* Initialize the wa=
it queue */

    virq =3D irq_create_mapping(NULL, CPLD1_INTERRUPT);


   if ((ret =3D request_irq(virq,cpld_irq_handler, 0, GPIO_CHAR_PATH, NULL))=
!=3D0)
   {
      printk(KERN_ERR "gpio_init: Could not grab IRQ line for CPLD ret =3D %=
d\n",ret);
          goto err1;
   }


        if((s_nGPIOMajor =3D register_chrdev(MPC8247_DEVICE_MAJOR_NUM, GPIO_=
CHAR_PATH, &gpio_fops))<0)
        {
                GPIO_DBG2("GPIO_DRIVER  : unable to get major %d\n", s_nGPIO=
Major);
                return s_nGPIOMajor;

        }else{
                GPIO_DBG2("GPIO_DRIVER  : major =3D %x\n", s_nGPIOMajor );
        }

        return 0;

}

Thanks in Advance

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

--_000_40631E9A2581F14BA60888C87A76A1FE014A35HYDMKDMBX4wiproco_
Content-Type: text/html; charset="us-ascii"
content-transfer-encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<title></title>
<meta content=3D"MSHTML 6.00.2900.3698" name=3D"GENERATOR">
</head>
<body>
<div dir=3D"ltr" align=3D"left"><font size=3D"2">Hi Scoot,<br>
<br>
<span class=3D"123312911-05102011"><font face=3D"Arial" color=3D"#0000ff">&n=
bsp;<font face=3D"Times New Roman" color=3D"#000000">When my
</font>&nbsp;<font face=3D"Times New Roman" color=3D"#000000">ISR gets exeut=
ed I get&nbsp;a below BUG. Could let me what I am doing wrong in the ISR?</f=
ont></font></span></font></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"123312911-05102011"></span><f=
ont color=3D"#ff0000"><font size=3D"2"><span class=3D"123312911-05102011"><f=
ont face=3D"Arial" color=3D"#0000ff">&nbsp;</font></span></font></font></div=
>
<div dir=3D"ltr" align=3D"left"><font color=3D"#ff0000"><font size=3D"2"><sp=
an class=3D"123312911-05102011"></span></font></font>&nbsp;</div>
<div dir=3D"ltr" align=3D"left"><font color=3D"#ff0000"><font size=3D"2"><sp=
an class=3D"123312911-05102011">&nbsp;</span>BUG: scheduling while atomic: I=
RQ-20/0x0fff0000/108<br>
Call Trace:<br>
[C3AEFEC0] [C0007CCC]&nbsp; (unreliable)<br>
[C3AEFEF0] [C0017F10] <br>
[C3AEFF00] [C0268818] <br>
[C3AEFF50] [C0017F44] <br>
[C3AEFF60] [C0018044] <br>
[C3AEFF70] [C0046A90] <br>
[C3AEFF90] [C0046D90] <br>
[C3AEFFC0] [C0032AFC] <br>
[C3AEFFF0] [C000F5AC]</font></font></div>
<p><font color=3D"#ff0000"><br>
</font><br>
<font size=3D"2">Below is the code :<br>
<font face=3D"Arial" color=3D"#0000ff"><strong>My ISR</strong></font></font>=
</p>
<div><font face=3D"Arial" color=3D"#0000ff"><span lang=3D"EN">
<p><font size=3D"2">irqreturn_t cpld_irq_handler(int irq, void * dev_id, str=
uct pt_regs *regs)</font></p>
<p><font size=3D"2">{</font></p>
<p><font size=3D"2">wake_up(&amp;cpld_intr_wait);</font></p>
<p><font color=3D"#ff0000" size=3D"2">atomic_inc(&amp;cpld_intr_data); /* in=
crementing this will indicate the poll() that the interrupt is occured */</f=
ont></p>
<p><font size=3D"2"></font></p>
<p><font size=3D"2">return 0;</font></p>
<p><font size=3D"2">}</font></p>
</span></font></div>
<div><font face=3D"Arial" color=3D"#0000ff" size=3D"2"><strong>DRIVER_INIT</=
strong></font></div>
<div><font size=3D"2">static int __init gpio_init(void)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int virq;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp; </font><font size=3D"2"><font color=3D"#0000ff">atomic_se=
t(&amp;cpld_intr_data, 0);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* in=
itialize the Interrupt indicator */<br>
</font>&nbsp;&nbsp;&nbsp; init_waitqueue_head(&amp;cpld_intr_wait);&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* Initialize the wait queue */<br>
</font></div>
<p><font size=3D"2">&nbsp;&nbsp;&nbsp; virq =3D irq_create_mapping(NULL, CPL=
D1_INTERRUPT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;<br>
&nbsp;&nbsp; if ((ret =3D request_irq(virq,cpld_irq_handler, 0, GPIO_CHAR_PA=
TH, NULL))!=3D0)<br>
&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ERR &quot;gpio_init: Could not gr=
ab IRQ line for CPLD ret =3D %d\n&quot;,ret);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; goto err1;<br>
&nbsp;&nbsp; }<br>
&nbsp;&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if((s_nGPIOMajor =3D register_chr=
dev(MPC8247_DEVICE_MAJOR_NUM, GPIO_CHAR_PATH, &amp;gpio_fops))&lt;0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; GPIO_DBG2(&quot;GPIO_DRIVER&nbsp; : unable to get major %d\n&quot;=
, s_nGPIOMajor);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; return s_nGPIOMajor;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }else{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; GPIO_DBG2(&quot;GPIO_DRIVER&nbsp; : major =3D %x\n&quot;, s_nGPIOM=
ajor );<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;<br>
}</font> </p>
<p><span class=3D"123312911-05102011"><font size=3D"2">Thanks in Advance</fo=
nt></span></p>
<p><font size=3D"2">Regards,<br>
Smitha</font></p>
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

--_000_40631E9A2581F14BA60888C87A76A1FE014A35HYDMKDMBX4wiproco_--
