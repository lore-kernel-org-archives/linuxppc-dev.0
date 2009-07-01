Return-Path: <john.p.price@l-3com.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A9304B711B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 23:38:31 +1000 (EST)
Received: from smtp2out.l-3com.com (smtp2out.l-3com.com [166.20.51.112])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ironport2.l-3com.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 555AFDDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 23:38:29 +1000 (EST)
From: john.p.price@l-3com.com
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9FA4F.7EABE1DF"
Subject: RE: ppc405ex + gigabit ethernet
Date: Wed, 1 Jul 2009 09:26:07 -0400
Message-ID: <B9639434CFA424438117913649CDB7870D9475AF@MA_EXCHANGE.corp.sds.l-3com.com>
In-Reply-To: <e35801cc0907010424l66a7c4dem6f3f363c3b194ff4@mail.gmail.com>
References: <e35801cc0906300658q45d5ea00ub939ba73185efd72@mail.gmail.com><COL107-W41E84129BE81739BC96295B22E0@phx.gbl>
	<e35801cc0907010424l66a7c4dem6f3f363c3b194ff4@mail.gmail.com>
To: "Lada Podivin" <lada.podivin@gmail.com>, "LiuMing" <eemingliu@hotmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9FA4F.7EABE1DF
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

I have developed a board with the AMCC PPC405eX running at 600MHz and =
experimented with two transmission methods;

=20

1.    Raw socket w/jumbo frames =A8C approx. 600Mbits/sec

2.    TCP using writev w/jumbo frames =A8C approx. 525Mbits/sec

=20

From: linuxppc-dev-bounces+john.p.price=3Dl-3com.com@lists.ozlabs.org =
[mailto:linuxppc-dev-bounces+john.p.price=3Dl-3com.com@lists.ozlabs.org] =
On Behalf Of Lada Podivin
Sent: Wednesday, July 01, 2009 7:25 AM
To: LiuMing
Cc: linuxppc-dev@ozlabs.org
Subject: Re: ppc405ex + gigabit ethernet

=20

Thank you for your reply!
Yes, I agree the CPU is the bottleneck. But I have performed more tests =
with the netperf tool and results seem strange to me. If I send 800 B of =
data, the resulting speed is aproximately 100 Kb/s. On the other hand, =
If I try to send 32KB chunk of data with jumbo frames turned on, =
resulting speed is about 600 Kb/s (300-400 without jumbo frames). My =
ppc405ex runs at 600 MHz.

So it seems that it is definetely better idea to call sendto() less =
frequently with bigger amounts of data, than to call it more often with =
smaler amounts. Is it because smaller data means more frequent user =
space/kernel space switching? Or is it network related issue? =20

Thanks!

Best,
Lada

2009/7/1 LiuMing <eemingliu@hotmail.com>

Hi,
According to our experience on PPC405 + Gigabit Enet, your result is =
already very reasonable. For UDP transmission, it can be around 400 Kb/s =
because of the CPU bottleneck (in our case 300 MHz ppc405). If you want =
to further improve it, a faster CPU is needed to process the TCP/IP =
stack, or you may buy commercial TCP/IP stack rather than using the free =
Linux one.=20
=20
BR
Ming
=20

________________________________

Date: Tue, 30 Jun 2009 15:58:53 +0200
Subject: ppc405ex + gigabit ethernet
From: lada.podivin@gmail.com
To: linuxppc-dev@ozlabs.org



Hi,

I benchmarked performance of my network, which contains ppc405EX =
(Kilauea board, kernel 2.6.30 from Denx) connected with a linux desktop =
via gigabit ethernet. I used the netperf tool:=20

netperf -t UDP_STREAM -H 192.168.1.1 -- -m 32768

So I was sending UDP packets to the desktop. The resulting speed was =
about 370 Kb/s. I tried to send the packets to several different =
computers - with the same result. So the ppc board is the bottleneck in =
this case.

Is there any possibility to improve the gigabit capabilities of the =
ppc405EX? Is there anyone who achieved a better performance with ppc4xx =
boards?

Thanks!

Best,
Lada Podivin



________________________________

=C1=A2=BF=CC=CF=C2=D4=D8 MSN =B1=A3=BB=A4=B6=DC=A3=AC=B1=A3=D5=CF MSN =
=B0=B2=C8=AB=CE=C8=B6=A8=A3=A1 =CF=D6=D4=DA=BE=CD=CF=C2=D4=D8=A3=A1 =
<http://im.live.cn/safe/>=20

=20


------_=_NextPart_001_01C9FA4F.7EABE1DF
Content-Type: text/html;
	charset="GB2312"
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
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Arial","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1363630253;
	mso-list-type:hybrid;
	mso-list-template-ids:-1719635908 -127467540 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:.75in;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
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
style=3D'font-size:11.0pt;font-family:"Arial","sans-serif";
color:#1F497D'>I have developed a board with the AMCC PPC405eX running =
at 600MHz
and experimented with two transmission methods;<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Arial","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoListParagraph =
style=3D'margin-left:.75in;text-indent:-.25in;
mso-list:l0 level1 lfo1'><![if !supportLists]><span =
style=3D'font-size:11.0pt;
font-family:"Arial","sans-serif";color:#1F497D'><span =
style=3D'mso-list:Ignore'>1.<span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]><span
style=3D'font-size:11.0pt;font-family:"Arial","sans-serif";color:#1F497D'=
>Raw
socket w/jumbo frames =A8C approx. 600Mbits/sec<o:p></o:p></span></p>

<p class=3DMsoListParagraph =
style=3D'margin-left:.75in;text-indent:-.25in;
mso-list:l0 level1 lfo1'><![if !supportLists]><span =
style=3D'font-size:11.0pt;
font-family:"Arial","sans-serif";color:#1F497D'><span =
style=3D'mso-list:Ignore'>2.<span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]><span
style=3D'font-size:11.0pt;font-family:"Arial","sans-serif";color:#1F497D'=
>TCP
using writev w/jumbo frames =A8C approx. =
525Mbits/sec<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Arial","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0in 0in 0in'>

<p class=3DMsoNormal style=3D'margin-left:.5in'><b><span =
style=3D'font-size:10.0pt;
font-family:"Tahoma","sans-serif"'>From:</span></b><span =
style=3D'font-size:10.0pt;
font-family:"Tahoma","sans-serif"'> =
linuxppc-dev-bounces+john.p.price=3Dl-3com.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+john.p.price=3Dl-3com.com@lists.ozlabs.org] =
<b>On
Behalf Of </b>Lada Podivin<br>
<b>Sent:</b> Wednesday, July 01, 2009 7:25 AM<br>
<b>To:</b> LiuMing<br>
<b>Cc:</b> linuxppc-dev@ozlabs.org<br>
<b>Subject:</b> Re: ppc405ex + gigabit ethernet<o:p></o:p></span></p>

</div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:0in;margin-right:0in;margin-bottom:
12.0pt;margin-left:.5in'>Thank you for your reply!<br>
Yes, I agree the CPU is the bottleneck. But I have performed more tests =
with
the netperf tool and results seem strange to me. If I send 800 B of =
data, the
resulting speed is aproximately 100 Kb/s. On the other hand, If I try to =
send
32KB chunk of data with jumbo frames turned on, resulting speed is about =
600
Kb/s (300-400 without jumbo frames). My ppc405ex runs at 600 MHz.<br>
<br>
So it seems that it is definetely better idea to call sendto() less =
frequently
with bigger amounts of data, than to call it more often with smaler =
amounts. Is
it because smaller data means more frequent user space/kernel space =
switching?
Or is it network related issue?&nbsp; <br>
<br>
Thanks!<br>
<br>
Best,<br>
Lada<o:p></o:p></p>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'>2009/7/1 LiuMing &lt;<a
href=3D"mailto:eemingliu@hotmail.com">eemingliu@hotmail.com</a>&gt;<o:p><=
/o:p></p>

<div>

<p class=3DMsoNormal style=3D'margin-left:.5in'>Hi,<br>
According to our experience on PPC405 + Gigabit Enet, your result is =
already
very reasonable. For UDP transmission, it can be around 400 Kb/s because =
of
the&nbsp;CPU bottleneck (in our case 300 MHz ppc405). If you want
to&nbsp;further improve it, a faster CPU is needed to process the TCP/IP =
stack,
or you may buy&nbsp;commercial TCP/IP stack&nbsp;rather than using the =
free
Linux one. <br>
&nbsp;<br>
BR<br>
Ming<br>
&nbsp;<o:p></o:p></p>

<div class=3DMsoNormal align=3Dcenter =
style=3D'margin-left:.5in;text-align:center'>

<hr size=3D2 width=3D"100%" align=3Dcenter>

</div>

<p class=3DMsoNormal style=3D'margin-left:.5in'>Date: Tue, 30 Jun 2009 =
15:58:53
+0200<br>
Subject: ppc405ex + gigabit ethernet<br>
From: <a href=3D"mailto:lada.podivin@gmail.com" =
target=3D"_blank">lada.podivin@gmail.com</a><br>
To: <a href=3D"mailto:linuxppc-dev@ozlabs.org" =
target=3D"_blank">linuxppc-dev@ozlabs.org</a><o:p></o:p></p>

<div>

<div>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:0in;margin-right:0in;margin-bottom:
12.0pt;margin-left:.5in'><br>
<br>
Hi,<br>
<br>
I benchmarked performance of my network, which contains ppc405EX =
(Kilauea
board, kernel 2.6.30 from Denx) connected with a linux desktop via =
gigabit
ethernet. I used the netperf tool: <br>
<br>
netperf -t UDP_STREAM -H 192.168.1.1 -- -m 32768<br>
<br>
So I was sending UDP packets to the desktop. The resulting speed was =
about 370
Kb/s. I tried to send the packets to several different computers - with =
the
same result. So the ppc board is the bottleneck in this case.<br>
<br>
Is there any possibility to improve the gigabit capabilities of the =
ppc405EX?
Is there anyone who achieved a better performance with ppc4xx =
boards?<br>
<br>
Thanks!<br>
<br>
Best,<br>
Lada Podivin<br>
<br>
<o:p></o:p></p>

</div>

</div>

<div>

<div class=3DMsoNormal align=3Dcenter =
style=3D'margin-left:.5in;text-align:center'>

<hr size=3D2 width=3D"100%" align=3Dcenter>

</div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><span =
lang=3DZH-CN>=C1=A2=BF=CC=CF=C2=D4=D8</span> MSN <span
lang=3DZH-CN>=B1=A3=BB=A4=B6=DC=A3=AC=B1=A3=D5=CF</span> MSN <span =
lang=3DZH-CN>=B0=B2=C8=AB=CE=C8=B6=A8=A3=A1 </span><a
href=3D"http://im.live.cn/safe/" target=3D"_blank"><span =
lang=3DZH-CN>=CF=D6=D4=DA=BE=CD=CF=C2=D4=D8=A3=A1</span></a><o:p></o:p></=
p>

</div>

</div>

</div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C9FA4F.7EABE1DF--
