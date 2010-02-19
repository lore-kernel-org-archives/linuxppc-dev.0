Return-Path: <prvs=166687140d=Staale.Aakermann@kongsberg.com>
Received: from ukgl-edge-p01.kongsberg.com (ukgl-edge-p01.kongsberg.com
	[193.71.180.98]) by ozlabs.org (Postfix) with ESMTP id C772EB7CB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Feb 2010 23:38:10 +1100 (EST)
Received: from UKGW-EXHUB-VP01.kda.kongsberg.com ([10.50.100.12])
	by ukgl-edge-p01.kongsberg.com (8.14.1/8.14.1) with ESMTP id
	o1JCWf74030188
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2010 13:32:41 +0100
From: <Staale.Aakermann@kongsberg.com>
To: <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 19 Feb 2010 13:32:15 +0100
Subject: ppc4xx emac support of phy-less devices patch + dts example
Message-ID: <DC3E0C93CCAB2F4DACB66FFECC909F5822F7F1EB13@ukgw-exmb-p06.kda.kongsberg.com>
Content-Type: multipart/alternative;
	boundary="_000_DC3E0C93CCAB2F4DACB66FFECC909F5822F7F1EB13ukgwexmbp06kd_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_DC3E0C93CCAB2F4DACB66FFECC909F5822F7F1EB13ukgwexmbp06kd_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm currently working on a custom embedded card with ppc405ex installed.
On this card, EMAC1 is "phy-less", and connected directly to a MAC on a mic=
rel switch (ks8995ma).
I've tried the default phy-less mode currently supported by the core driver=
 for ibm_newmac, but found
this insufficient. I've made a patch for the core driver so it supports som=
e more scenarios.

Since the simultanious operation of both EMACS on PPC405EX requires utiliza=
tion of the RGMII bridge, I did not
manage setting the speed to less than 1Gbps using the current phy-less mode=
. I've moved the phy-less setup to
the dts. I've also added a clock-internal which was required for my case, a=
s the SDR0_MFR E1CS register was set
by default in phy-less mode.

--- drivers/net/ibm_newemac/core.c 2010-02-19 11:13:00.000000000 +0100
+++ drivers/net/ibm_newemac/core.c 2010-02-19 12:53:56.000000000 +0100
@@ -2393,14 +2393,54 @@
            /* PHY-less configuration.
             * XXX I probably should move these settings to the dev tree
             */
+
+    if (emac_read_uint_prop(np, "phy-duplex", &dev->phy.duplex, 0))
+        dev->phy.duplex =3D 1;
+
+    if (emac_read_uint_prop(np, "phy-speed", &dev->phy.speed, 0))
+        dev->phy.speed =3D 100;
+
+    if (emac_read_uint_prop(np, "phy-autoneg", &dev->phy.autoneg, 0))
+        dev->phy.autoneg =3D 0;
+
            dev->phy.address =3D -1;
            dev->phy.features =3D SUPPORTED_MII;
-           if (emac_phy_supports_gige(dev->phy_mode))
-                 dev->phy.features |=3D SUPPORTED_1000baseT_Full;
-           else
-                 dev->phy.features |=3D SUPPORTED_100baseT_Full;
+
+        if (dev->phy.autoneg =3D=3D 1 )
+            dev->phy.features |=3D SUPPORTED_Autoneg;
+
+        switch (dev->phy.duplex)
+        {
+            case 0:
+
+                if (dev->phy.speed =3D=3D 10 )
+                    dev->phy.features |=3D SUPPORTED_10baseT_Half;
+
+                if (dev->phy.speed =3D=3D 100 )
+                    dev->phy.features |=3D SUPPORTED_100baseT_Half;
+
+                if (dev->phy.speed =3D=3D 100 )
+                    dev->phy.features |=3D SUPPORTED_100baseT_Half;
+
+            default:
+
+                if (dev->phy.speed =3D=3D 10 )
+                    dev->phy.features |=3D SUPPORTED_10baseT_Full;
+
+                if (dev->phy.speed =3D=3D 100 )
+                    dev->phy.features |=3D SUPPORTED_100baseT_Full;
+
+                if (dev->phy.speed =3D=3D 100 )
+                    dev->phy.features |=3D SUPPORTED_100baseT_Full;
+        }
+
            dev->phy.pause =3D 1;

+        #if defined (CONFIG_PPC_DCR_NATIVE) && defined (CONFIG_405EX)
+        if (of_get_property(np, "phy-clock-internal", NULL))
+            dcri_clrset(SDR0, SDR0_MFR, ( dev->rgmii_port ? SDR0_MFR_ECS >=
> 1 : SDR0_MFR_ECS ),0 );
+        #endif
+
            return 0;
      }


DTS example:

EMAC1: ethernet@ef600a00 {
      linux,network-index =3D <0x1>;
      device_type =3D "network";
      compatible =3D "ibm,emac-405ex", "ibm,emac4sync";
      interrupt-parent =3D <&EMAC1>;
      interrupts =3D <0x0 0x1>;
      #interrupt-cells =3D <1>;
      #address-cells =3D <0>;
      #size-cells =3D <0>;
      interrupt-map =3D </*Status*/ 0x0 &UIC0 0x19 0x4
                   /*Wake*/  0x1  &UIC1 0x1f 0x4>;
      reg =3D <0xef600a00 0x000000c4>;
      local-mac-address =3D [0000000000];
      mal-device =3D <&MAL0>;
      mal-tx-channel =3D <1>;
      mal-rx-channel =3D <1>;
      cell-index =3D <1>;
      max-frame-size =3D <9000>;
      rx-fifo-size =3D <4096>;
      tx-fifo-size =3D <2048>;
      phy-mode =3D "rgmii";
      phy-map =3D <0xffffffff>;      // Be sure that the emac use phy-less =
configuration
      phy-address =3D <0xffffffff>;  // Be sure that the emac use phy-less =
configuration
      phy-speed =3D <100>;
      phy-duplex =3D <1>;
      phy-autoneg =3D <0>;
      phy-clock-internal;
      rgmii-device =3D <&RGMII0>;
      rgmii-channel =3D <1>;
      has-inverted-stacr-oc;
      has-new-stacr-staopc;
};



Best regards
Staale Aakermann, Systems Engineer
Kongsberg Defence Systems / Defence Communication
Olav Brunborgsv 6, P.O.Box 87, 1375 Billingstad, Norway
Phone: +47 66 84 24 00, Direct Phone: +47 66 74 48 51,
Fax: +47 66 84 82 30, Mobile: +47 928 29 879
Mail: staale.aakermann@kongsberg.com<mailto:staale.aakermann@kongsberg.com>
Url: www.kongsberg.com<http://www.kongsberg.com/>


--_000_DC3E0C93CCAB2F4DACB66FFECC909F5822F7F1EB13ukgwexmbp06kd_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
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

<body lang=3DNO-BOK link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hi,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I'm currently working on a custom embedded card with
ppc405ex installed. <o:p></o:p></p>

<p class=3DMsoNormal>On this card, EMAC1 is &quot;phy-less&quot;, and conne=
cted
directly to a MAC on a micrel switch (ks8995ma).<o:p></o:p></p>

<p class=3DMsoNormal>I've tried the default phy-less mode currently support=
ed by
the core driver for ibm_newmac, but found<o:p></o:p></p>

<p class=3DMsoNormal>this insufficient. I've made a patch for the core driv=
er so
it supports some more scenarios. <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Since the simultanious operation of both EMACS on PPC4=
05EX
requires utilization of the RGMII bridge, I did not <o:p></o:p></p>

<p class=3DMsoNormal>manage setting the speed to less than 1Gbps using the =
current
phy-less mode. I've moved the phy-less setup to <o:p></o:p></p>

<p class=3DMsoNormal>the dts. I've also added a clock-internal which was re=
quired
for my case, as the SDR0_MFR E1CS register was set<o:p></o:p></p>

<p class=3DMsoNormal>by default in phy-less mode.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>--- drivers/net/ibm_newemac/core.c 2010-02-19
11:13:00.000000000 +0100<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+++ drivers/net/ibm_newemac/core.c 2010-02-19
12:53:56.000000000 +0100<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>@@ -2393,14 +2393,54 @@<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /*
PHY-less configuration.<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &nbsp;*
XXX I probably should move these settings to the dev tree<o:p></o:p></span>=
</p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &nbsp;*/<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (emac_read_uint_prop(np,
&quot;phy-duplex&quot;, &amp;dev-&gt;phy.duplex, 0))<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
dev-&gt;phy.duplex =3D 1;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (emac_read_uint_prop(np,
&quot;phy-speed&quot;, &amp;dev-&gt;phy.speed, 0))<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;dev-=
&gt;phy.speed
=3D 100;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp; if (emac_read_uint_prop(np,
&quot;phy-autoneg&quot;, &amp;dev-&gt;phy.autoneg, 0))<o:p></o:p></span></p=
>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
dev-&gt;phy.autoneg =3D 0;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; dev-&gt;phy.address
=3D -1;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; dev-&gt;phy.features
=3D SUPPORTED_MII;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if
(emac_phy_supports_gige(dev-&gt;phy_mode))<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;phy.features
|=3D SUPPORTED_1000baseT_Full;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; else<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;phy.features
|=3D SUPPORTED_100baseT_Full;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
(dev-&gt;phy.autoneg =3D=3D 1 )<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
dev-&gt;phy.features |=3D SUPPORTED_Autoneg;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swit=
ch
(dev-&gt;phy.duplex)<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:=
p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
case 0:<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (dev-&gt;phy.speed =3D=3D 10 )<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
dev-&gt;phy.features |=3D SUPPORTED_10baseT_Half;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (dev-&gt;phy.speed =3D=3D 100 )<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
dev-&gt;phy.features |=3D SUPPORTED_100baseT_Half;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (dev-&gt;phy.speed =3D=3D 100 )<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
dev-&gt;phy.features |=3D SUPPORTED_100baseT_Half;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
default:<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (dev-&gt;phy.speed =3D=3D 10 )<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
dev-&gt;phy.features |=3D SUPPORTED_10baseT_Full;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (dev-&gt;phy.speed =3D=3D 100 )<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
dev-&gt;phy.features |=3D SUPPORTED_100baseT_Full;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (dev-&gt;phy.speed =3D=3D 100 )<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
dev-&gt;phy.features |=3D SUPPORTED_100baseT_Full;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; dev-&gt;phy.pause
=3D 1;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #if
defined (CONFIG_PPC_DCR_NATIVE) &amp;&amp; defined (CONFIG_405EX)<o:p></o:p=
></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
(of_get_property(np, &quot;phy-clock-internal&quot;, NULL))<o:p></o:p></spa=
n></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
dcri_clrset(SDR0, SDR0_MFR, ( dev-&gt;rgmii_port ? SDR0_MFR_ECS &gt;&gt; 1 =
:
SDR0_MFR_ECS ),0 );<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #end=
if<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>+<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; return
0;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></spa=
n></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>DTS example:<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>EMAC1: ethernet@ef600a00 {<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linux,network-ind=
ex =3D
&lt;0x1&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D
&quot;network&quot;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D
&quot;ibm,emac-405ex&quot;, &quot;ibm,emac4sync&quot;;<o:p></o:p></span></p=
>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =
=3D
&lt;&amp;EMAC1&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &l=
t;0x0
0x1&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells =
=3D
&lt;1&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =
=3D
&lt;0&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D
&lt;0&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-map =3D
&lt;/*Status*/ 0x0 &amp;UIC0 0x19 0x4<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;/*Wake*/&nbsp;
0x1&nbsp; &amp;UIC1 0x1f 0x4&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0xef6=
00a00
0x000000c4&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; local-mac-address=
 =3D
[0000000000]; <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mal-device =3D
&lt;&amp;MAL0&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mal-tx-channel =
=3D
&lt;1&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mal-rx-channel =
=3D
&lt;1&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cell-index =3D
&lt;1&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max-frame-size =
=3D
&lt;9000&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx-fifo-size =3D
&lt;4096&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tx-fifo-size =3D
&lt;2048&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phy-mode =3D
&quot;rgmii&quot;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phy-map =3D
&lt;0xffffffff&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Be sure that the emac =
use
phy-less configuration<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phy-address =3D
&lt;0xffffffff&gt;;&nbsp; // Be sure that the emac use phy-less configurati=
on<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phy-speed =3D
&lt;100&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phy-duplex =3D
&lt;1&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phy-autoneg =3D
&lt;0&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phy-clock-interna=
l;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span>=
</p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rgmii-device =3D
&lt;&amp;RGMII0&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rgmii-channel =3D
&lt;1&gt;;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has-inverted-stac=
r-oc;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has-new-stacr-sta=
opc;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'>};<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><b><span lang=3DEN-GB style=3D'font-size:10.0pt;font-f=
amily:
"Arial","sans-serif";color:navy'>Best regards </span></b><b><span lang=3DEN=
-GB
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:navy'><o:p=
></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-GB style=3D'font-size:10.0pt;font-f=
amily:
"Arial","sans-serif";color:navy'>Staale Aakermann</span></b><span lang=3DEN=
-GB>, </span><b><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";col=
or:navy'>Systems
Engineer</span></b><o:p></o:p></p>

<p class=3DMsoNormal><b><span lang=3DEN-GB style=3D'font-size:10.0pt;font-f=
amily:
"Arial","sans-serif";color:navy'>Kongsberg Defence&nbsp;Systems / Defence
Communication</span></b><span lang=3DEN-GB><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'mso-margin-top-alt:7.2pt;margin-right:0cm;mar=
gin-bottom:
3.0pt;margin-left:0cm;mso-margin-top-alt:.6gd;mso-para-margin-right:0cm;
mso-para-margin-bottom:3.0pt;mso-para-margin-left:0cm'><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:navy'>Olav
Brunborgsv 6, P.O.Box 87, 1375 Billingstad, Norway</span><span lang=3DEN-GB=
><o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:10.0pt;font-fami=
ly:"Arial","sans-serif";
color:navy'>Phone:&nbsp;+47 66 84 24 00, Direct Phone:&nbsp;+47 66 74&nbsp;=
48
51,</span><span lang=3DEN-GB><o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:10.0pt;font-fami=
ly:"Arial","sans-serif";
color:navy'>Fax: +47 66 84&nbsp;82 30, Mobile: +47&nbsp;928 29 879</span><s=
pan
lang=3DEN-GB><o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:10.0pt;font-fami=
ly:"Arial","sans-serif";
color:navy'>Mail:&nbsp;<a href=3D"mailto:staale.aakermann@kongsberg.com"><s=
pan
style=3D'color:blue'>staale.aakermann@kongsberg.com</span></a></span><span
lang=3DEN-GB><o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:10.0pt;font-fami=
ly:"Arial","sans-serif";
color:navy'>Url: <a href=3D"http://www.kongsberg.com/"><span style=3D'color=
:blue'>www.kongsberg.com</span></a></span><o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--_000_DC3E0C93CCAB2F4DACB66FFECC909F5822F7F1EB13ukgwexmbp06kd_--
