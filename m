Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BADB9B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Sep 2010 00:24:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB5A61.E4F14109"
Subject: RE: external interrupt mapping with FPGA on loacl bus
Date: Wed, 22 Sep 2010 16:24:36 +0200
Message-ID: <52CF90264091A14888078A031D780F4306C8C0E4@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <AANLkTikkM0HJHdTd5j9bRaW9uN8OsJcN9O99GAHtPQ18@mail.gmail.com>
References: <AANLkTikkM0HJHdTd5j9bRaW9uN8OsJcN9O99GAHtPQ18@mail.gmail.com>
From: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
To: "deebul nair" <deebuls@gmail.com>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB5A61.E4F14109
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Firstly you should make sure which interrupt level is used to trigger
the external interrupt. High level, low level, rising edge or falling
edge?=20
------
 0 =3D low to high edge sensitive type enabled
 1 =3D active low level sensitive type enabled
 2 =3D active high level sensitive type enabled
 3 =3D high to low edge sensitive type enable =20
=20
Then set the appropriate sense and level for your external interrupt.
And you have to ensure the FPGA issue the real interrupt. Maybe you can
use the hardware tool to probe if there is a interrupt signal on
external interrupt pin.
=20
Additionally I think your 'reg' property is wrong unless you have
abnormal way to parse that :)
=20
Cheers
Tiejun
=20


________________________________

	From:
linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.ozlabs.org=
]
On Behalf Of deebul nair
	Sent: Wednesday, September 22, 2010 4:15 PM
	To: linuxppc-dev@lists.ozlabs.org
	Subject: external interrupt mapping with FPGA on loacl bus
=09
=09
	=20
	Hi
	=20
	i have a FPGA called mcmc which is connected to the powerpc
mpc8572 on the local bus. It provides 2 interrupts which are connected
to the
	external interupts IRQ1 and IRQ3 of the mpc8572.
	the fpga is memory mapped on the local bus at address 0xc0000000

	I am able to register the interrupt and obtain virq , but no
interrupts.
	is the modifications made in the dts file enought/right for
getting an external interrupt??
	=20
	=20
	The modified dts file for enrm8572
	=20
	localbus@e0005000 {
	=20

		#address-cells =3D <2>;
		=20
		#size-cells =3D <1>;
		=20
		compatible =3D "fsl,mpc8572-elbc", "fsl,elbc",
"simple-bus";
		=20
		reg =3D <0xe0005000 0x1000>;
		=20
		interrupts =3D <19 2>;
		=20
		interrupt-parent =3D <&mpic>;
		=20
		ranges =3D <0x0 0x0 0xfc000000 0x04000000
		=20
		0x1 0x0 0xc0000000 0x00080000
		=20
		0x2 0x0 0x90100000 0x00008000
		=20
		0x3 0x0 0x90000000 0x00040000
		=20
		0x4 0x0 0x91000000 0x00008000>;
		=20
		nand@3,0 {
		=20
		#address-cells =3D <1>;
		=20
		#size-cells =3D <1>;
		=20
		compatible =3D "fsl,mpc8572-fcm-nand",
		=20
		"fsl,elbc-fcm-nand";
		=20
		reg =3D <0x3 0x0 0x40000>;
		=20
		u-boot@0 {
		=20
		reg =3D <0x0 0x02000000>;
		=20
		read-only;
		=20
		};
		=20
		jffs2@2000000 {
		=20
		reg =3D <0x02000000 0x10000000>;
		=20
		};
		=20
		ramdisk@12000000 {
		=20
		reg =3D <0x12000000 0x08000000>;
		=20
		read-only;
		=20
		};
		=20
		kernel@1a000000 {
		=20
		reg =3D <0x1a000000 0x04000000>;
		=20
		};
		=20
		dtb@1e000000 {
		=20
		reg =3D <0x1e000000 0x01000000>;
		=20
		read-only;
		=20
		};
		=20
		empty@1f000000 {
		=20
		reg =3D <0x1f000000 0x21000000>;
		=20
		};
		=20
		};
		=20
		=20
		=20
		mcmc@1,0 {
		=20
		compatible =3D "fsl,fpga-pixis";
		=20
		reg =3D <1 0 32>;
		=20
		interrupts =3D <1 1 3 1>;
		=20
		interrupt-parent =3D <&mpic>;
		=20
		};

	=20
	};
	=20
	code for registering the interrupt :
	=20
	np =3D of_find_compatible_node(NULL, NULL, "fsl,fpga-pixis");
	=20
	mcmc_irq =3D irq;
	=20
	virq =3D irq_of_parse_and_map(np, mcmc_irq);
	=20
	if(virq =3D=3D NO_IRQ){
	=20
	printk(KERN_ERR "mcmc: failed to map interrupt");
	=20
	}
	=20
	printk(KERN_INFO "mcmc: interrupt mapped to virq %d\n", virq);
	=20
	ret =3D request_irq(virq, mcmc_interrupt, IRQF_DISABLED,"mcmc",
NULL);
	=20
	if(ret){
	=20
	printk(KERN_INFO "mcmc : cant get assigned irq %i\n errno :
<%d>\n",mcmc_irq,ret);
	=20
	}
	=20
	else{
	=20
	printk(KERN_ALERT "Interrupt requested OK\n");
	=20
	}
	=20
	d :
	=20
	when i register the driver the following output is obtaine
	=20
	for irq=3D1
	=20
	irq_of_parse_and_map
	=20
	irq : irq_create_mapping(0xc0fffb40,0x1)
	=20
	irq : using host @ c0fffb40
	=20
	irq : obtained virq 18
	=20
	irq : virq=3D12 <6>mcmc : interrupt mapped to irq 18
	=20
	Interrupt requested OK!
	=20
	for irq=3D0
	=20
	irq_of_parse_and_map
	=20
	irq : irq_create_mapping(0xc0fffb40,0x3)
	=20
	irq : using host @ c0fffb40
	=20
	irq : obtained virq 20
	=20
	irq : virq=3D14 <6>mcmc : interrupt mapped to irq 20
	=20
	Interrupt requested OK!
	=20
	=20
	=20
	=20
	=20
	--
	Cheeers
	=20
	Deebul !!!!!!
	=20
	=20


------_=_NextPart_001_01CB5A61.E4F14109
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.6003" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D952431214-22092010><FONT =
face=3DArial=20
size=3D2>Firstly&nbsp;you should make sure which interrupt level is used =
to=20
trigger the external interrupt. High level, low level, rising =
edge&nbsp;or=20
falling edge?&nbsp;</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D952431214-22092010><FONT =
face=3DArial=20
size=3D2>------</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D952431214-22092010><FONT =
face=3DArial=20
size=3D2>&nbsp;0 =3D low to high edge sensitive type enabled<BR>&nbsp;1 =
=3D active low=20
level sensitive type enabled<BR>&nbsp;2 =3D active high level sensitive =
type=20
enabled<BR>&nbsp;3 =3D high to low edge sensitive type =
enable</FONT></SPAN><SPAN=20
class=3D952431214-22092010><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D952431214-22092010><FONT =
face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D952431214-22092010><FONT =
face=3DArial=20
size=3D2>Then set the appropriate sense and level for your external =
interrupt. And=20
you&nbsp;have to&nbsp;ensure the FPGA issue the real interrupt. Maybe =
you can=20
use the hardware tool to probe if there is a interrupt signal on =
external=20
interrupt pin.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D952431214-22092010><FONT =
face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D952431214-22092010><FONT =
face=3DArial=20
size=3D2>Additionally I think your 'reg' property is wrong unless you =
have=20
abnormal&nbsp;way to parse that :)</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D952431214-22092010><FONT =
face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D952431214-22092010><FONT =
face=3DArial=20
size=3D2>Cheers</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D952431214-22092010><FONT =
face=3DArial=20
size=3D2>Tiejun</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D952431214-22092010><FONT =
face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV><BR>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B>=20
  linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.ozlabs.org=20
  =
[mailto:linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.ozlabs.org=
] <B>On=20
  Behalf Of </B>deebul nair<BR><B>Sent:</B> Wednesday, September 22, =
2010 4:15=20
  PM<BR><B>To:</B> linuxppc-dev@lists.ozlabs.org<BR><B>Subject:</B> =
external=20
  interrupt mapping with FPGA on loacl bus<BR></FONT><BR></DIV>
  <DIV></DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Hi</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>i have a FPGA called mcmc which is connected to the powerpc =
mpc8572 on=20
  the local bus. It provides 2 interrupts which are connected to =
the</DIV>
  <DIV>external interupts IRQ1 and IRQ3 of the mpc8572.</DIV>
  <DIV>the fpga is memory mapped on the local bus at address <FONT=20
  face=3D"Courier New">0xc0000000 </FONT></DIV>
  <DIV>I am able to register the interrupt and obtain virq , but no=20
  interrupts.</DIV>
  <DIV>is the modifications made in the dts file enought/right for =
getting an=20
  external interrupt??</DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
  <DIV>&nbsp;</DIV>
  <DIV><STRONG>The modified dts file for enrm8572</STRONG></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">localbus@e0005000 =
{</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <BLOCKQUOTE dir=3Dltr style=3D"MARGIN-RIGHT: 0px">
    <DIV><FONT face=3D"courier new,monospace">#address-cells =3D=20
    &lt;2&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">#size-cells =3D=20
&lt;1&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">compatible =3D =
"fsl,mpc8572-elbc",=20
    "fsl,elbc", "simple-bus";</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">reg =3D &lt;0xe0005000=20
    0x1000&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">interrupts =3D &lt;19=20
    2&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">interrupt-parent =3D=20
    &lt;&amp;mpic&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">ranges =3D &lt;0x0 0x0 =
0xfc000000=20
    0x04000000</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">0x1 0x0 0xc0000000=20
    0x00080000</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">0x2 0x0 0x90100000=20
    0x00008000</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">0x3 0x0 0x90000000=20
    0x00040000</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">0x4 0x0 0x91000000=20
    0x00008000&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">nand@3,0 {</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">#address-cells =3D=20
    &lt;1&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">#size-cells =3D=20
&lt;1&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">compatible =3D=20
    "fsl,mpc8572-fcm-nand",</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier =
new,monospace">"fsl,elbc-fcm-nand";</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">reg =3D &lt;0x3 0x0=20
    0x40000&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">u-boot@0 {</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">reg =3D &lt;0x0=20
    0x02000000&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">read-only;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">};</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">jffs2@2000000 =
{</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">reg =3D &lt;0x02000000=20
    0x10000000&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">};</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">ramdisk@12000000 =
{</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">reg =3D &lt;0x12000000=20
    0x08000000&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">read-only;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">};</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">kernel@1a000000 =
{</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">reg =3D &lt;0x1a000000=20
    0x04000000&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">};</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">dtb@1e000000 =
{</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">reg =3D &lt;0x1e000000=20
    0x01000000&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">read-only;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">};</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">empty@1f000000 =
{</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">reg =3D &lt;0x1f000000=20
    0x21000000&gt;;</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">};</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace">};</FONT></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><STRONG><FONT style=3D"BACKGROUND-COLOR: #ffff33"=20
    face=3D"courier new,monospace">mcmc@1,0 {</FONT></STRONG></DIV>
    <DIV><STRONG><FONT style=3D"BACKGROUND-COLOR: #ffff33"=20
    face=3D"courier new,monospace"></FONT></STRONG>&nbsp;</DIV>
    <DIV><STRONG><FONT style=3D"BACKGROUND-COLOR: #ffff33"=20
    face=3D"courier new,monospace">compatible =3D=20
    "fsl,fpga-pixis";</FONT></STRONG></DIV>
    <DIV><STRONG><FONT style=3D"BACKGROUND-COLOR: #ffff33"=20
    face=3D"courier new,monospace"></FONT></STRONG>&nbsp;</DIV>
    <DIV><STRONG><FONT style=3D"BACKGROUND-COLOR: #ffff33"=20
    face=3D"courier new,monospace">reg =3D &lt;1 0 =
32&gt;;</FONT></STRONG></DIV>
    <DIV><STRONG><FONT style=3D"BACKGROUND-COLOR: #ffff33"=20
    face=3D"courier new,monospace"></FONT></STRONG>&nbsp;</DIV>
    <DIV><STRONG><FONT style=3D"BACKGROUND-COLOR: #ffff33"=20
    face=3D"courier new,monospace">interrupts =3D &lt;1 1 3=20
    1&gt;;</FONT></STRONG></DIV>
    <DIV><STRONG><FONT style=3D"BACKGROUND-COLOR: #ffff33"=20
    face=3D"courier new,monospace"></FONT></STRONG>&nbsp;</DIV>
    <DIV><STRONG><FONT style=3D"BACKGROUND-COLOR: #ffff33"=20
    face=3D"courier new,monospace">interrupt-parent =3D=20
    &lt;&amp;mpic&gt;;</FONT></STRONG></DIV>
    <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"courier =
new,monospace">};</FONT></DIV></BLOCKQUOTE>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">};</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><STRONG>code for registering the interrupt :</STRONG></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">np =3D =
of_find_compatible_node(NULL,=20
  NULL, "fsl,fpga-pixis");</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">mcmc_irq =3D =
irq;</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">virq =3D =
irq_of_parse_and_map(np,=20
  mcmc_irq);</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">if(virq =3D=3D =
NO_IRQ){</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">printk(KERN_ERR "mcmc: =
failed to map=20
  interrupt");</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">}</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">printk(KERN_INFO "mcmc: =
interrupt=20
  mapped to virq %d\n", virq);</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">ret =3D request_irq(virq,=20
  mcmc_interrupt, IRQF_DISABLED,"mcmc", NULL);</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">if(ret){</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">printk(KERN_INFO "mcmc : =
cant get=20
  assigned irq %i\n errno : &lt;%d&gt;\n",mcmc_irq,ret);</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">}</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">else{</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">printk(KERN_ALERT "Interrupt =
requested=20
  OK\n");</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">}</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV>d :</DIV>
  <DIV>&nbsp;</DIV>
  <DIV><STRONG>when i register the driver the following output is=20
  obtaine</STRONG></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><STRONG>for irq=3D1</STRONG></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=3D"courier =
new,monospace">irq_of_parse_and_map</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">irq :=20
  irq_create_mapping(0xc0fffb40,0x1)</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">irq : using host @=20
  c0fffb40</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">irq : obtained virq =
18</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">irq : virq=3D12 =
&lt;6&gt;mcmc :=20
  interrupt mapped to irq 18</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">Interrupt requested =
OK!</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><STRONG>for irq=3D0</STRONG></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=3D"courier =
new,monospace">irq_of_parse_and_map</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">irq :=20
  irq_create_mapping(0xc0fffb40,0x3)</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">irq : using host @=20
  c0fffb40</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">irq : obtained virq =
20</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">irq : virq=3D14 =
&lt;6&gt;mcmc :=20
  interrupt mapped to irq 20</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"courier new,monospace">Interrupt requested =
OK!</FONT></DIV>
  <DIV><FONT face=3D"courier new,monospace"></FONT>&nbsp;</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>--</DIV>
  <DIV>Cheeers</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Deebul !!!!!!</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>&nbsp;</DIV></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01CB5A61.E4F14109--
