Return-Path: <DusharaJ@optiscan.com>
Received: from mail.optiscan.com (mail.optiscan.com [203.26.112.1])
	by ozlabs.org (Postfix) with ESMTP id 69CC8DDE31
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 17:58:07 +1100 (EST)
From: Dushara Jayasinghe <DusharaJ@optiscan.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Thu, 19 Feb 2009 17:58:04 +1100
Subject: RE: Newby trying to get Ethernet going on MPC83xx series device.
Message-ID: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054B@mailsvr>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40549@mailsvr>
	<3A45394FD742FA419B760BB8D398F9ED246F06@zch01exm26.fsl.freescale.net>
	<FD3D453EC8A8D5479E7E063D31E2FA44268653@zin33exm24.fsl.freescale.net>
In-Reply-To: <FD3D453EC8A8D5479E7E063D31E2FA44268653@zin33exm24.fsl.freescale.net>
Content-Type: multipart/alternative;
	boundary="_000_DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054Bmailsvr_"
MIME-Version: 1.0
Cc: 'Aggrwal Poonam-B10812' <Poonam.Aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_000_DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054Bmailsvr_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

That did it.

I based my board specific file on mpc834x_itx.c which had

static struct of_device_id __initdata mpc834x_itx_ids[] =3D {
                { .compatible =3D "fsl,pq2pro-localbus", },
                { .compatible =3D "simple-bus", },
                {},
};

Don't know if this is broken?

From: Aggrwal Poonam-B10812 [mailto:Poonam.Aggrwal@freescale.com]
Sent: Thursday, 19 February 2009 5:49 PM
To: Li Yang-R58472; Dushara Jayasinghe; linuxppc-dev@ozlabs.org
Subject: RE: Newby trying to get Ethernet going on MPC83xx series device.


Can you look into your board specific file
Like board/freescale/mpc8249_mds/mpc8349_mds.c

And check if the buses are getting probed.

For example

static struct of_device_id mpc834x_ids[] =3D {
        { .type =3D "soc", },
        { .compatible =3D "soc", },
        { .compatible =3D "simple-bus", },
        {},
};

static int __init mpc834x_declare_of_platform_devices(void)
{
        of_platform_bus_probe(NULL, mpc834x_ids, NULL);
        return 0;
}
machine_device_initcall(mpc834x_mds, mpc834x_declare_of_platform_devices);

Regards
Poonam


> -----Original Message-----
> From:
> linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.com@ozla
> bs.org] On Behalf Of Li Yang-R58472
> Sent: Thursday, February 19, 2009 10:52 AM
> To: Dushara Jayasinghe; linuxppc-dev@ozlabs.org
> Subject: RE: Newby trying to get Ethernet going on MPC83xx
> series device.
>
> > -----Original Message-----
> > From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> > [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]
> > On Behalf Of Dushara Jayasinghe
> > Sent: Thursday, February 19, 2009 12:27 PM
> > To: 'linuxppc-dev@ozlabs.org'
> > Subject: Newby trying to get Ethernet going on MPC83xx
> series device.
> >
> > Hi I'm having difficulty getting an Ethernet device up on a
> dev board
> > with an MPX8349 controller.
> >
> > The contents of my .dts file are as follows (based on
> > mpc8349emitx.dts):
> >
> >         soc8349@e0000000 {
> >                 ...
> >
> >                 mdio@24520 {
> >                         #address-cells =3D <1>;
> >                         #size-cells =3D <0>;
> >                         compatible =3D "fsl,gianfar-mdio";
> >                         reg =3D <24520 20>;
> >
> >                         /* Vitesse 8201 */
> >                         phy1c: ethernet-phy@1c {
> >                                 interrupt-parent =3D <&ipic>;
> >                                 interrupts =3D <3 8>;
> >                                 reg =3D <0>;
> >                                 device_type =3D "ethernet-phy";
> >                         };
> >                         tbi0: tbi-phy@11 {
> >                                 reg =3D <11>;
> >                                 device_type =3D "tbi-phy";
> >                         };
> >                 };
> >
> >                 mdio@25520 {
> >                         #address-cells =3D <1>;
> >                         #size-cells =3D <0>;
> >                         compatible =3D "fsl,gianfar-tbi";
> >                         reg =3D <25520 20>;
> >
> >                         tbi1: tbi-phy@11 {
> >                                 reg =3D <11>;
> >                                 device_type =3D "tbi-phy";
> >                         };
> >                 };
> >
> >                 ethernet@24000 {
> >                         cell-index =3D <0>;
> >                         device_type =3D "network";
> >                         model =3D "TSEC";
> >                         compatible =3D "gianfar";
> >                         reg =3D <24000 1000>;
> >                         local-mac-address =3D [ 00 00 00 00 00 00 ];
> >                         interrupts =3D <20 8 21 8 22 8>;
> >                         interrupt-parent =3D <&ipic>;
> >                         tbi-handle =3D <&tbi0>;
> >                         phy-handle =3D <&phy1c>;
> >                         linux,network-index =3D <0>;
> >                 };
> >
> >                 ethernet@25000 {
> >                         cell-index =3D <1>;
> >                         device_type =3D "network";
> >                         model =3D "TSEC";
> >                         compatible =3D "gianfar";
> >                         reg =3D <25000 1000>;
> >                         local-mac-address =3D [ 00 00 00 00 00 00 ];
> >                         interrupts =3D <23 8 24 8 25 8>;
> >                         interrupt-parent =3D <&ipic>;
> >                         /* Vitesse 7385 isn't on the MDIO bus */
> >                         fixed-link =3D <1 1 1000 0 0>;
> >                         linux,network-index =3D <1>;
> >                         tbi-handle =3D <&tbi1>;
> >                         phy-connection-type =3D "gmii";
> >                 };
> >         };
> >
> > I get the following error during the boot sequence:
> >
> > IP-Config: Device `eth0' not found
> >
> > I also found that both gfar_init (in gianfar.c) and
> gfar_mdio_init (in
> > gianfar_mii.c) are called but the probe handlers of either of these
> > devices are not executed.
> >
> > What am I missing?
>
> Don't find any obvious problem.  I suggest you to debug
> gfar_of_init() in arch/powerpc/sysdev/fsl_soc.c to see if it
> works correctly.
>
> - Leo
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>

--_000_DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054Bmailsvr_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<title>RE: Newby trying to get Ethernet going on MPC83xx series device.</ti=
tle>
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-AU link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>That did it.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>I based my board specific file on mpc834x_itx.c which had<o:=
p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>static struct of_device_id __initdata mpc834x_itx_ids[] =3D =
{<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {
.compatible =3D &quot;fsl,pq2pro-localbus&quot;, },<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {
.compatible =3D &quot;simple-bus&quot;, },<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {},<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>};<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>Don&#8217;t know if this is broken?<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm'>

<p class=3DMsoNormal><b><span lang=3DEN-US style=3D'font-size:10.0pt;font-f=
amily:
"Tahoma","sans-serif"'>From:</span></b><span lang=3DEN-US style=3D'font-siz=
e:10.0pt;
font-family:"Tahoma","sans-serif"'> Aggrwal Poonam-B10812
[mailto:Poonam.Aggrwal@freescale.com] <br>
<b>Sent:</b> Thursday, 19 February 2009 5:49 PM<br>
<b>To:</b> Li Yang-R58472; Dushara Jayasinghe; linuxppc-dev@ozlabs.org<br>
<b>Subject:</b> RE: Newby trying to get Ethernet going on MPC83xx series
device.<o:p></o:p></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-s=
erif"'>Can
you look into your board specific file </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>Like
board/freescale/mpc8249_mds/mpc8349_mds.c</span><span lang=3DEN-US> </span>=
<o:p></o:p></p>

<p><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-s=
erif"'>And
check if the buses are getting probed.</span><span lang=3DEN-US> </span><o:=
p></o:p></p>

<p><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-s=
erif"'>For
example</span><span lang=3DEN-US> </span><o:p></o:p></p>

<p><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-s=
erif"'>static
struct of_device_id mpc834x_ids[] =3D {</span> <br>
<b><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-s=
erif";
color:red'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .type =3D
&quot;soc&quot;, },</span></b> <br>
<b><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-s=
erif";
color:red'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .compatible =3D
&quot;soc&quot;, },</span></b> <br>
<b><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-s=
erif";
color:red'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .compatible =3D
&quot;simple-bus&quot;, },</span></b> <br>
<b><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-s=
erif";
color:red'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {},</span></b> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>};</span><span
lang=3DEN-US> </span><o:p></o:p></p>

<p><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-s=
erif"'>static
int __init mpc834x_declare_of_platform_devices(void)</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>{</span>
<br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><b><span
lang=3DEN-US> </span></b><b><span lang=3DEN-US style=3D'font-size:10.0pt;fo=
nt-family:
"Arial","sans-serif";color:red'>of_platform_bus_probe(NULL, mpc834x_ids, NU=
LL);</span></b>
<br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
return 0;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>}</span>
<br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>machine_device_initcall(mpc834x_mds,
mpc834x_declare_of_platform_devices);</span><span lang=3DEN-US> </span><o:p=
></o:p></p>

<p><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-s=
erif"'>Regards</span>
<br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>Poonam</span>
<br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&nbsp;</span><span
lang=3DEN-US> </span><o:p></o:p></p>

<p><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-s=
erif"'>&gt;
-----Original Message-----</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
From: </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.com@ozlabs.org </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
[</span><a href=3D"mailto:linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.c=
om@ozla"><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>ma=
ilto:linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.com@ozla</span></a>
<br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
bs.org] On Behalf Of Li Yang-R58472</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
Sent: Thursday, February 19, 2009 10:52 AM</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
To: Dushara Jayasinghe; linuxppc-dev@ozlabs.org</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
Subject: RE: Newby trying to get Ethernet going on MPC83xx </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
series device.</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
</span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; -----Original Message-----</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org</span> <br=
>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; [</span><a
href=3D"mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org"><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>ma=
ilto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org</span></a><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>]<=
/span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; On Behalf Of Dushara Jayasinghe</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; Sent: Thursday, February 19, 2009 12:27 PM</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; To: 'linuxppc-dev@ozlabs.org'</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; Subject: Newby trying to get Ethernet going on MPC83xx </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
series device.</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; Hi I'm having difficulty getting an Ethernet device up on a </span><br=
>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
dev board </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; with an MPX8349 controller.</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp; </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; The contents of my .dts file are as follows (based on</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; mpc8349emitx.dts):</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp; </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc8349@e0000000 {</sp=
an> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
...</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp; </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
mdio@24520 {</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
#address-cells =3D &lt;1&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
#size-cells =3D &lt;0&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
compatible =3D &quot;fsl,gianfar-mdio&quot;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
reg =3D &lt;24520 20&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp; </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/* Vitesse 8201 */</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
phy1c: ethernet-phy@1c {</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
interrupt-parent =3D &lt;&amp;ipic&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
interrupts =3D &lt;3 8&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
reg =3D &lt;0&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
device_type =3D &quot;ethernet-phy&quot;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
};</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
tbi0: tbi-phy@11 {</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
reg =3D &lt;11&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
device_type =3D &quot;tbi-phy&quot;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
};</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
};</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp; </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
mdio@25520 {</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
#address-cells =3D &lt;1&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
#size-cells =3D &lt;0&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
compatible =3D &quot;fsl,gianfar-tbi&quot;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
reg =3D &lt;25520 20&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp; </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
tbi1: tbi-phy@11 {</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
reg =3D &lt;11&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
device_type =3D &quot;tbi-phy&quot;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
};</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
};</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp; </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
ethernet@24000 {</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
cell-index =3D &lt;0&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
device_type =3D &quot;network&quot;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
model =3D &quot;TSEC&quot;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
compatible =3D &quot;gianfar&quot;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
reg =3D &lt;24000 1000&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
local-mac-address =3D [ 00 00 00 00 00 00 ];</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
interrupts =3D &lt;20 8 21 8 22 8&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
interrupt-parent =3D &lt;&amp;ipic&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
tbi-handle =3D &lt;&amp;tbi0&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
phy-handle =3D &lt;&amp;phy1c&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
linux,network-index =3D &lt;0&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
};</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp; </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
ethernet@25000 {</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
cell-index =3D &lt;1&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
device_type =3D &quot;network&quot;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
model =3D &quot;TSEC&quot;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
compatible =3D &quot;gianfar&quot;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
reg =3D &lt;25000 1000&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
local-mac-address =3D [ 00 00 00 00 00 00 ];</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
interrupts =3D &lt;23 8 24 8 25 8&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
interrupt-parent =3D &lt;&amp;ipic&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/* Vitesse 7385 isn't on the MDIO bus */</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
fixed-link =3D &lt;1 1 1000 0 0&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
linux,network-index =3D &lt;1&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
tbi-handle =3D &lt;&amp;tbi1&gt;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
phy-connection-type =3D &quot;gmii&quot;;</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
};</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp; </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; I get the following error during the boot sequence:</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp; </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; IP-Config: Device `eth0' not found</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp; </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; I also found that both gfar_init (in gianfar.c) and </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
gfar_mdio_init (in </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; gianfar_mii.c) are called but the probe handlers of either of these </=
span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; devices are not executed.</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt;&nbsp; </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
&gt; What am I missing?</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
</span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
Don't find any obvious problem.&nbsp; I suggest you to debug </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
gfar_of_init() in arch/powerpc/sysdev/fsl_soc.c to see if it </span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
works correctly.</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
</span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
- Leo</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
_______________________________________________</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
Linuxppc-dev mailing list</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
Linuxppc-dev@ozlabs.org</span> <br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
</span><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev"><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>ht=
tps://ozlabs.org/mailman/listinfo/linuxppc-dev</span></a>
<br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
</span><br>
<span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Arial","sans-seri=
f"'>&gt;
</span><o:p></o:p></p>

</div>

</body>

</html>

--_000_DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054Bmailsvr_--
