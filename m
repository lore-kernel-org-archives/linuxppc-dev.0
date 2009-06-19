Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 63671B7278
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 05:02:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9F10E.FF88F631"
Subject: RE: kilauea/405ex external interrupts
Date: Fri, 19 Jun 2009 11:51:45 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C0797A7EA@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <e35801cc0906190100i1a0429eahade975319b5246df@mail.gmail.com>
References: <e35801cc0906190100i1a0429eahade975319b5246df@mail.gmail.com>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "Lada Podivin" <lada.podivin@gmail.com>,
	<linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9F10E.FF88F631
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

You will have to program GPIO's to select appropriate external IRQ as
they are shared .

=20

From: linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org] On =
Behalf
Of Lada Podivin
Sent: Friday, June 19, 2009 1:01 AM
To: linuxppc-dev@lists.ozlabs.org
Subject: kilauea/405ex external interrupts

=20

Hi,
I'm writing a linux driver that uses an external interrupt (ppc 405ex).
I'm using GPIO pin 30 (external IRQ 1) connected to UIC1. I'm aware of
the virtual interrupt stuff, so I added a new node to my device tree in
order to get proper virtual IRQ number. This node describes an external
event and its connection to UIC via the mentioned ext. int. Here is a
sample of the divce-tree:
..

UIC1: interrupt-controller1 {
        compatible =3D "ibm,uic-405ex","ibm,uic";
        interrupt-controller;
        cell-index =3D <1>;
        dcr-reg =3D <0x0d0 0x009>;
        #address-cells =3D <0>;
        #size-cells =3D <0>;
        #interrupt-cells =3D <2>;
        interrupts =3D <0x1e 0x4 0x1f 0x4>; /* cascade */
        interrupt-parent =3D <&UIC0>;
};

EXTEVENT: external_event {
        device_type =3D "external";
        #address-cells =3D <0>;
        #size-cells =3D <0>;
        #interrupt-cells =3D <2>;
        interrupts =3D <0x1e 0x1>;
        interrupt-parent =3D <&UIC1>;
};
...

Then I use function "irq_of_parse_and_map()" which returns the virtual
IRQ number 22. So, "request_irq()" seems to be satisfied with this
number. I can see this interrupt in the /proc/interrupts. But! When I
connect a signal source to the pin 30, nothing happens - the interrupt
service routine isn't called.=20

Am I suppose to configure anything else? (e. g. pin multiplexing,
further device-tree tuning...) Thank you!

Best regards,
Ladi


------_=_NextPart_001_01C9F10E.FF88F631
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
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
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
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
color:#1F497D'>You will have to program GPIO&#8217;s to select =
appropriate external
IRQ as they are shared .<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0in 0in 0in'>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>
linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+tmarri=3Damcc.com@lists.ozlabs.org] <b>On =
Behalf Of </b>Lada
Podivin<br>
<b>Sent:</b> Friday, June 19, 2009 1:01 AM<br>
<b>To:</b> linuxppc-dev@lists.ozlabs.org<br>
<b>Subject:</b> kilauea/405ex external interrupts<o:p></o:p></span></p>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Hi,<br>
I'm writing a linux driver that uses an external interrupt (ppc 405ex). =
I'm
using GPIO pin 30 (external IRQ 1) connected to UIC1. I'm aware of the =
virtual
interrupt stuff, so I added a new node to my device tree in order to get =
proper
virtual IRQ number. This node describes an external event and its =
connection to
UIC via the mentioned ext. int. Here is a sample of the divce-tree:<br>
..<br>
<br>
UIC1: interrupt-controller1 {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D
&quot;ibm,uic-405ex&quot;,&quot;ibm,uic&quot;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-controller;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cell-index =3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dcr-reg =3D &lt;0x0d0 =
0x009&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells =3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells =3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #interrupt-cells =3D =
&lt;2&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts =3D &lt;0x1e 0x4 0x1f =
0x4&gt;;
/* cascade */<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;UIC0&gt;;<br>
};<br>
<br>
EXTEVENT: external_event {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type =3D =
&quot;external&quot;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells =3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells =3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #interrupt-cells =3D =
&lt;2&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts =3D &lt;0x1e =
0x1&gt;;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;UIC1&gt;;<br>
};<br>
...<br>
<br>
Then I use function &quot;irq_of_parse_and_map()&quot; which returns the
virtual IRQ number 22. So, &quot;request_irq()&quot; seems to be =
satisfied with
this number. I can see this interrupt in the /proc/interrupts. But! When =
I
connect a signal source to the pin 30, nothing happens - the interrupt =
service
routine isn't called. <br>
<br>
Am I suppose to configure anything else? (e. g. pin multiplexing, =
further
device-tree tuning...) Thank you!<br>
<br>
Best regards,<br>
Ladi<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C9F10E.FF88F631--
