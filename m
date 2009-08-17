Return-Path: <tmarri@amcc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A3CAFB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 04:17:57 +1000 (EST)
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 674CFDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 04:17:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA1F65.9325F636"
Subject: FW: need help getting SPI controller working on 405EX
	[PPM2009081200000033]
Date: Mon, 17 Aug 2009 11:07:24 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C07E4EF93@SDCEXCHANGE01.ad.amcc.com>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA1F65.9325F636
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20

1) It looks like the correct entry in kilauea.dts file should be:=20
208             IIC1: i2c@ef600500 {=20
209                 compatible =3D "ibm,iic-405ex", "ibm,iic";=20
210                 reg =3D <ef600500 14>;=20
211                 interrupt-parent =3D <&UIC0>;=20
212                 interrupts =3D <7 4>;=20
213                 #address-cells =3D <1>;=20
214                 #size-cells =3D <0>;=20
215             };=20
216=20
217             SPI0: spi@ef600600 {=20
218                 /* compatible =3D "ibm,iic-405ex", "ibm,iic"; */=20
219                 compatible =3D "amcc,scp-405ex";=20
220                 reg =3D <ef600600 6>;=20
221                 interrupts =3D <8 4>;=20
222                 interrupt-parent =3D <&UIC0>;=20
223             };=20
224=20
225             RGMII0: emac-rgmii@ef600b00 {=20
226                 compatible =3D "ibm,rgmii-405ex", "ibm,rgmii";=20
227                 reg =3D <ef600b00 104>;=20
228                 has-mdio;=20
229             };=20
230=20
231             EMAC0: ethernet@ef600900 {=20

2) Right now the e.g. scp-dev.c is in drivers/scp directory in one of
the internal release I have found, NOT in the e.g. 2.6.29.

Additional comments:=20
- Ideally the file should be moved to drivers/spi, like all other spi
drivers.=20
- Even in the internal release, the files do NOT compile properly,
because of missing file, need CONFIG_PINE, etc=20
[support@localhost linux]$ make uImage=20
scripts/kconfig/conf -s arch/powerpc/Kconfig=20
  CHK     include/linux/version.h=20
  CHK     include/linux/utsrelease.h=20
  CALL    scripts/checksyscalls.sh=20
  CHK     include/linux/compile.h=20
  CALL    arch/powerpc/kernel/systbl_chk.sh=20
  CC      drivers/scp/scp-dev.o=20
drivers/scp/scp-dev.c:84:24: error: asm/ibm4xx.h: No such file or
directory=20
drivers/scp/scp-dev.c:705: error: 'scpdev_init' undeclared here (not in
a function)=20
make[2]: *** [drivers/scp/scp-dev.o] Error 1=20
make[1]: *** [drivers/scp] Error 2=20
make: *** [drivers] Error 2=20
[support@localhost linux]=20

Q: Marri, what do we need to provide to Nathan French ?=20
Q: Fan, per Jinag-An's request, what is the procedure for cleaning this
up before releasing to Linux community ?=20

Regards, Samuel=20

-----Original Message-----=20
From: support_reply@amcc.com [mailto:support_reply@amcc.com]=20
Sent: Fri 8/7/2009 9:24 AM=20
To: Samuel Wang=20
Subject: FW: need help getting SPI controller working on 405EX
[PPM2009081200000033311192]=20
 =20
Sender          : tmarri@amcc.com=20
Tracking Number : PPM2009081200000033311192=20
Pool            : PPC_MID=20
Sent to         : "AMCC Product Support" <supportimc@amcc.com>=20
Date            : 8/7/09 9:24 AM=20
---=20

Forwarded by: Alan Millard=20

(no comments entered)=20
---=20

=20

-----Original Message-----=20
From: linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org=20
[mailto:linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org] On =
Behalf

Of Nathan French=20
Sent: Thursday, August 06, 2009 9:08 AM=20
To: linuxppc-dev@lists.ozlabs.org=20
Subject: need help getting SPI controller working on 405EX=20

Hi, I am trying to add support for the 405EX's SPI controller on a=20
Kilauea board.  I've added the below to the device tree (under=20
plb/opb/):=20

[nfrench@nfrench-laptop linux-2.6-denx]$ diff -C2=20
arch/powerpc/boot/dts/kilauea.dts spi.dts=20
*** arch/powerpc/boot/dts/kilauea.dts   2009-05-05 15:56:16.000000000=20
-0700=20
--- spi.dts     2009-08-06 08:42:19.000000000 -0700=20
***************=20
*** 207,210 ****=20
--- 207,221 ----=20
                                #size-cells =3D <0>;=20
                        };=20
+            =20
+             SPI0: spi@ef600600 {=20
+                 cell-index =3D <0>;=20
+                 compatible =3D "ibm,spi-405ex", "ibm,spi";=20
+                 reg =3D <ef600600 6>;=20
+                 interrupts =3D <8 4>;=20
+                 interrupt-parent =3D <&UIC0>;=20
+                 mode =3D "cpu";=20
+             };=20
 =20
                        RGMII0: emac-rgmii@ef600b00 {=20

I've also compiled my kernel with the following enabled:=20

        CONFIG_SPI=3Dy=20
        CONFIG_SPI_MASTER=3Dy=20
        CONFIG_SPI_SPIDEV=3Dy=20

I see this make it into the device tree after boot:=20

        [root@10.2.3.28 /]$ find /proc/device-tree/ | grep spi=20
        /proc/device-tree/plb/opb/spi@ef600600=20
        /proc/device-tree/plb/opb/spi@ef600600/name=20
        /proc/device-tree/plb/opb/spi@ef600600/mode=20
        /proc/device-tree/plb/opb/spi@ef600600/interrupt-parent=20
        /proc/device-tree/plb/opb/spi@ef600600/interrupts=20
        /proc/device-tree/plb/opb/spi@ef600600/reg=20
        /proc/device-tree/plb/opb/spi@ef600600/compatible=20
        /proc/device-tree/plb/opb/spi@ef600600/cell-index=20

But I don't see any /dev/spidev* devices created or any mention of SPI=20
at boot time.  I'm starting to suspect that I don't have the kernel=20
configured right, otherwise I would see at least the SPI driver=20
complaining about something, right?=20

Thanks,=20

Nathan French=20

_______________________________________________=20
Linuxppc-dev mailing list=20
Linuxppc-dev@lists.ozlabs.org=20
https://lists.ozlabs.org/listinfo/linuxppc-dev=20

=20


------_=_NextPart_001_01CA1F65.9325F636
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:a=3D"urn:schemas-microsoft-com:office:access" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" =
xmlns:rs=3D"urn:schemas-microsoft-com:rowset" xmlns:z=3D"#RowsetSchema" =
xmlns:b=3D"urn:schemas-microsoft-com:office:publisher" =
xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadsheet" =
xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" =
xmlns:odc=3D"urn:schemas-microsoft-com:office:odc" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" =
xmlns:rtc=3D"http://microsoft.com/officenet/conferencing" =
xmlns:D=3D"DAV:" xmlns:Repl=3D"http://schemas.microsoft.com/repl/" =
xmlns:mt=3D"http://schemas.microsoft.com/sharepoint/soap/meetings/" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ppda=3D"http://www.passport.com/NameSpace.xsd" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sub=3D"http://schemas.microsoft.com/sharepoint/soap/2002/1/alerts/"=
 xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#" =
xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/soap" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:udcp2p=3D"http://schemas.microsoft.com/data/udc/parttopart" =
xmlns:wf=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/" =
xmlns:dsss=3D"http://schemas.microsoft.com/office/2006/digsig-setup" =
xmlns:dssi=3D"http://schemas.microsoft.com/office/2006/digsig" =
xmlns:mdssi=3D"http://schemas.openxmlformats.org/package/2006/digital-sig=
nature" =
xmlns:mver=3D"http://schemas.openxmlformats.org/markup-compatibility/2006=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns:mrels=3D"http://schemas.openxmlformats.org/package/2006/relationshi=
ps" xmlns:spwp=3D"http://microsoft.com/sharepoint/webpartpages" =
xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/2006/types"=
 =
xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/2006/messag=
es" =
xmlns:pptsl=3D"http://schemas.microsoft.com/sharepoint/soap/SlideLibrary/=
" =
xmlns:spsl=3D"http://microsoft.com/webservices/SharePointPortalServer/Pub=
lishedLinksService" xmlns:Z=3D"urn:schemas-microsoft-com:" =
xmlns:st=3D"&#1;" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<title>RE: need help getting SPI controller working on 405EX
[PPM2009081200000033311192]</title>
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
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
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p><span style=3D'font-size:10.0pt'>1) It looks like the correct entry =
in
kilauea.dts file should be:</span> <br>
<span =
style=3D'font-size:10.0pt'>208&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
IIC1: i2c@ef600500 {</span> <br>
<span =
style=3D'font-size:10.0pt'>209&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
compatible =3D &quot;ibm,iic-405ex&quot;, &quot;ibm,iic&quot;;</span> =
<br>
<span =
style=3D'font-size:10.0pt'>210&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
reg =3D &lt;ef600500 14&gt;;</span> <br>
<span =
style=3D'font-size:10.0pt'>211&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
interrupt-parent =3D &lt;&amp;UIC0&gt;;</span> <br>
<span =
style=3D'font-size:10.0pt'>212&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
interrupts =3D &lt;7 4&gt;;</span> <br>
<span =
style=3D'font-size:10.0pt'>213&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
#address-cells =3D &lt;1&gt;;</span> <br>
<span =
style=3D'font-size:10.0pt'>214&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
#size-cells =3D &lt;0&gt;;</span> <br>
<span =
style=3D'font-size:10.0pt'>215&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
};</span> <br>
<span style=3D'font-size:10.0pt'>216 </span><br>
<span =
style=3D'font-size:10.0pt'>217&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SPI0: spi@ef600600 {</span> <br>
<span =
style=3D'font-size:10.0pt'>218&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/* compatible =3D &quot;ibm,iic-405ex&quot;, &quot;ibm,iic&quot;; =
*/</span> <br>
<span =
style=3D'font-size:10.0pt'>219&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
compatible =3D &quot;amcc,scp-405ex&quot;;</span> <br>
<span =
style=3D'font-size:10.0pt'>220&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
reg =3D &lt;ef600600 6&gt;;</span> <br>
<span =
style=3D'font-size:10.0pt'>221&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
interrupts =3D &lt;8 4&gt;;</span> <br>
<span =
style=3D'font-size:10.0pt'>222&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
interrupt-parent =3D &lt;&amp;UIC0&gt;;</span> <br>
<span =
style=3D'font-size:10.0pt'>223&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
};</span> <br>
<span style=3D'font-size:10.0pt'>224 </span><br>
<span =
style=3D'font-size:10.0pt'>225&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
RGMII0: emac-rgmii@ef600b00 {</span> <br>
<span =
style=3D'font-size:10.0pt'>226&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
compatible =3D &quot;ibm,rgmii-405ex&quot;, =
&quot;ibm,rgmii&quot;;</span> <br>
<span =
style=3D'font-size:10.0pt'>227&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
reg =3D &lt;ef600b00 104&gt;;</span> <br>
<span =
style=3D'font-size:10.0pt'>228&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
has-mdio;</span> <br>
<span =
style=3D'font-size:10.0pt'>229&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
};</span> <br>
<span style=3D'font-size:10.0pt'>230 </span><br>
<span =
style=3D'font-size:10.0pt'>231&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
EMAC0: ethernet@ef600900 {</span> <o:p></o:p></p>

<p><span style=3D'font-size:10.0pt'>2) Right now the e.g. scp-dev.c is =
in
drivers/scp directory in one of the internal release I have found, NOT =
in the
e.g. 2.6.29.</span><o:p></o:p></p>

<p><span style=3D'font-size:10.0pt'>Additional comments:</span> <br>
<span style=3D'font-size:10.0pt'>- Ideally the file should be moved to
drivers/spi, like all other spi drivers.</span> <br>
<span style=3D'font-size:10.0pt'>- Even in the internal release, the =
files do NOT
compile properly, because of missing file, need CONFIG_PINE, etc</span> =
<br>
<span style=3D'font-size:10.0pt'>[support@localhost linux]$ make =
uImage</span> <br>
<span style=3D'font-size:10.0pt'>scripts/kconfig/conf -s =
arch/powerpc/Kconfig</span>
<br>
<span style=3D'font-size:10.0pt'>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp;
include/linux/version.h</span> <br>
<span style=3D'font-size:10.0pt'>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp;
include/linux/utsrelease.h</span> <br>
<span style=3D'font-size:10.0pt'>&nbsp; CALL&nbsp;&nbsp;&nbsp;
scripts/checksyscalls.sh</span> <br>
<span style=3D'font-size:10.0pt'>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp;
include/linux/compile.h</span> <br>
<span style=3D'font-size:10.0pt'>&nbsp; CALL&nbsp;&nbsp;&nbsp;
arch/powerpc/kernel/systbl_chk.sh</span> <br>
<span style=3D'font-size:10.0pt'>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
drivers/scp/scp-dev.o</span> <br>
<span style=3D'font-size:10.0pt'>drivers/scp/scp-dev.c:84:24: error:
asm/ibm4xx.h: No such file or directory</span> <br>
<span style=3D'font-size:10.0pt'>drivers/scp/scp-dev.c:705: error: =
'scpdev_init'
undeclared here (not in a function)</span> <br>
<span style=3D'font-size:10.0pt'>make[2]: *** [drivers/scp/scp-dev.o] =
Error 1</span>
<br>
<span style=3D'font-size:10.0pt'>make[1]: *** [drivers/scp] Error =
2</span> <br>
<span style=3D'font-size:10.0pt'>make: *** [drivers] Error 2</span> <br>
<span style=3D'font-size:10.0pt'>[support@localhost linux]</span> =
<o:p></o:p></p>

<p><span style=3D'font-size:10.0pt'>Q: Marri, what do we need to provide =
to
Nathan French ?</span> <br>
<span style=3D'font-size:10.0pt'>Q: Fan, per Jinag-An's request, what is =
the
procedure for cleaning this up before releasing to Linux community =
?</span> <o:p></o:p></p>

<p><span style=3D'font-size:10.0pt'>Regards, Samuel</span> =
<o:p></o:p></p>

<p><span style=3D'font-size:10.0pt'>-----Original Message-----</span> =
<br>
<span style=3D'font-size:10.0pt'>From: support_reply@amcc.com [<a
href=3D"mailto:support_reply@amcc.com">mailto:support_reply@amcc.com</a>]=
</span> <br>
<span style=3D'font-size:10.0pt'>Sent: Fri 8/7/2009 9:24 AM</span> <br>
<span style=3D'font-size:10.0pt'>To: Samuel Wang</span> <br>
<span style=3D'font-size:10.0pt'>Subject: FW: need help getting SPI =
controller
working on 405EX [PPM2009081200000033311192]</span> <br>
<span style=3D'font-size:10.0pt'>&nbsp;</span> <br>
<span =
style=3D'font-size:10.0pt'>Sender&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
: tmarri@amcc.com</span> <br>
<span style=3D'font-size:10.0pt'>Tracking Number : =
PPM2009081200000033311192</span>
<br>
<span =
style=3D'font-size:10.0pt'>Pool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
: PPC_MID</span> <br>
<span style=3D'font-size:10.0pt'>Sent
to&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &quot;AMCC Product
Support&quot; &lt;supportimc@amcc.com&gt;</span> <br>
<span =
style=3D'font-size:10.0pt'>Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
: 8/7/09 9:24 AM</span> <br>
<span style=3D'font-size:10.0pt'>---</span> <o:p></o:p></p>

<p><span style=3D'font-size:10.0pt'>Forwarded by: Alan Millard</span> =
<o:p></o:p></p>

<p><span style=3D'font-size:10.0pt'>(no comments entered)</span> <br>
<span style=3D'font-size:10.0pt'>---</span> <o:p></o:p></p>

<p class=3DMsoNormal =
style=3D'margin-bottom:12.0pt'><o:p>&nbsp;</o:p></p>

<p><span style=3D'font-size:10.0pt'>-----Original Message-----</span> =
<br>
<span style=3D'font-size:10.0pt'>From:
linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org</span> <br>
<span style=3D'font-size:10.0pt'>[<a
href=3D"mailto:linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org">m=
ailto:linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org</a>]
On Behalf</span> <br>
<span style=3D'font-size:10.0pt'>Of Nathan French</span> <br>
<span style=3D'font-size:10.0pt'>Sent: Thursday, August 06, 2009 9:08 =
AM</span> <br>
<span style=3D'font-size:10.0pt'>To: =
linuxppc-dev@lists.ozlabs.org</span> <br>
<span style=3D'font-size:10.0pt'>Subject: need help getting SPI =
controller
working on 405EX</span> <o:p></o:p></p>

<p><span style=3D'font-size:10.0pt'>Hi, I am trying to add support for =
the
405EX's SPI controller on a</span> <br>
<span style=3D'font-size:10.0pt'>Kilauea board.&nbsp; I've added the =
below to the
device tree (under</span> <br>
<span style=3D'font-size:10.0pt'>plb/opb/):</span> <o:p></o:p></p>

<p><span style=3D'font-size:10.0pt'>[nfrench@nfrench-laptop =
linux-2.6-denx]$ diff
-C2</span> <br>
<span style=3D'font-size:10.0pt'>arch/powerpc/boot/dts/kilauea.dts =
spi.dts</span>
<br>
<span style=3D'font-size:10.0pt'>***
arch/powerpc/boot/dts/kilauea.dts&nbsp;&nbsp; 2009-05-05 =
15:56:16.000000000</span>
<br>
<span style=3D'font-size:10.0pt'>-0700</span> <br>
<span style=3D'font-size:10.0pt'>--- spi.dts&nbsp;&nbsp;&nbsp;&nbsp; =
2009-08-06
08:42:19.000000000 -0700</span> <br>
<span style=3D'font-size:10.0pt'>***************</span> <br>
<span style=3D'font-size:10.0pt'>*** 207,210 ****</span> <br>
<span style=3D'font-size:10.0pt'>--- 207,221 ----</span> <br>
<span style=3D'font-size:10.0pt'>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =
&lt;0&gt;;</span> <br>
<span style=3D'font-size:10.0pt'>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };</span> <br>
<span =
style=3D'font-size:10.0pt'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><br>
<span =
style=3D'font-size:10.0pt'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
SPI0: spi@ef600600 {</span> <br>
<span =
style=3D'font-size:10.0pt'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
cell-index =3D &lt;0&gt;;</span> <br>
<span =
style=3D'font-size:10.0pt'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
compatible =3D &quot;ibm,spi-405ex&quot;, &quot;ibm,spi&quot;;</span> =
<br>
<span =
style=3D'font-size:10.0pt'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
reg =3D &lt;ef600600 6&gt;;</span> <br>
<span =
style=3D'font-size:10.0pt'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
interrupts =3D &lt;8 4&gt;;</span> <br>
<span =
style=3D'font-size:10.0pt'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
interrupt-parent =3D &lt;&amp;UIC0&gt;;</span> <br>
<span =
style=3D'font-size:10.0pt'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
mode =3D &quot;cpu&quot;;</span> <br>
<span =
style=3D'font-size:10.0pt'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
};</span> <br>
<span style=3D'font-size:10.0pt'>&nbsp; </span><br>
<span style=3D'font-size:10.0pt'>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RGMII0: emac-rgmii@ef600b00 =
{</span>
<o:p></o:p></p>

<p><span style=3D'font-size:10.0pt'>I've also compiled my kernel with =
the
following enabled:</span> <o:p></o:p></p>

<p><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
CONFIG_SPI=3Dy</span> <br>
<span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CONFIG_SPI_MASTER=3Dy</span>
<br>
<span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
CONFIG_SPI_SPIDEV=3Dy</span> <o:p></o:p></p>

<p><span style=3D'font-size:10.0pt'>I see this make it into the device =
tree after
boot:</span> <o:p></o:p></p>

<p><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[root@10.2.3.28 /]$ find /proc/device-tree/ | grep spi</span> <br>
<span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/proc/device-tree/plb/opb/spi@ef600600</span> <br>
<span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/proc/device-tree/plb/opb/spi@ef600600/name</span>
<br>
<span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/proc/device-tree/plb/opb/spi@ef600600/mode</span> <br>
<span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/proc/device-tree/plb/opb/spi@ef600600/interrupt-parent</span> <br>
<span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/proc/device-tree/plb/opb/spi@ef600600/interrupts</span> <br>
<span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/proc/device-tree/plb/opb/spi@ef600600/reg</span> <br>
<span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/proc/device-tree/plb/opb/spi@ef600600/compatible</span> <br>
<span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/proc/device-tree/plb/opb/spi@ef600600/cell-index</span> <o:p></o:p></p>

<p><span style=3D'font-size:10.0pt'>But I don't see any /dev/spidev* =
devices
created or any mention of SPI</span> <br>
<span style=3D'font-size:10.0pt'>at boot time.&nbsp; I'm starting to =
suspect that
I don't have the kernel</span> <br>
<span style=3D'font-size:10.0pt'>configured right, otherwise I would see =
at least
the SPI driver</span> <br>
<span style=3D'font-size:10.0pt'>complaining about something, =
right?</span> <o:p></o:p></p>

<p><span style=3D'font-size:10.0pt'>Thanks,</span> <o:p></o:p></p>

<p><span style=3D'font-size:10.0pt'>Nathan French</span> <o:p></o:p></p>

<p><span =
style=3D'font-size:10.0pt'>______________________________________________=
_</span>
<br>
<span style=3D'font-size:10.0pt'>Linuxppc-dev mailing list</span> <br>
<span style=3D'font-size:10.0pt'>Linuxppc-dev@lists.ozlabs.org</span> =
<br>
<span style=3D'font-size:10.0pt'><a
href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozl=
abs.org/listinfo/linuxppc-dev</a></span>
<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01CA1F65.9325F636--
