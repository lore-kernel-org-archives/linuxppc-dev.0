Return-Path: <junita@gdatech.com>
Received: from darwaza.gdatech.com (darwaza.gdatech.com [66.237.41.98])
	by ozlabs.org (Postfix) with ESMTP id 7C0DC67B59
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 06:56:51 +1000 (EST)
Message-Id: <200608312057.k7VKvHP32470@sierra.gdatech.com>
From: "Junita Joseph" <junita@gdatech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Need help with TLB settings in Linux -System ACE 
Date: Thu, 31 Aug 2006 13:56:43 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0003_01C6CD05.4ABCDE20"
Cc: a.sudheer@gdatech.co.in
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0003_01C6CD05.4ABCDE20
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,
 
I am currently working on a PPC440SPe based custom board to bring up the
System ACE interface from Linux.
 
I am using linux-2.6.16 with the patch applied as per Ameet's suggestion
from the following link
 
https://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17
.1-sysace-1.1.patch
 
 
 
We are able to access the controller registers from u-boot, but kernel
throws a "Data Machine Check exception" while accessing the registers.
 
1.    I have set up System ACE base address as 0xE000_0000 (which is the
same as in u-boot).
2.    As far as I understand, kernel should pick-up TLB settings from
u-boot.
3.    But , while debugging through BDI this is what I observe:
 
TLB entry Listings from u-boot:
 
IDX TID      EPN  SIZE VTS          RPN   USER WIMGE USRSVC
 0 : 00 ff000000  16MB V0 -> 4_ff000000 U:0000 WI-G- XWRXWR
 1 : 00 00000000 256MB V0 -> 0_00000000 U:0000 -I-G- XWRXWR
 2 : 00 10000000 256MB V0 -> 0_10000000 U:0000 -I-G- XWRXWR
 3 : 00 20000000 256MB V0 -> 0_20000000 U:0000 -I-G- XWRXWR
 4 : 00 30000000 256MB V0 -> 0_30000000 U:0000 -I-G- XWRXWR
 5 : 00 90000000 256KB V0 -> 4_00000000 U:0000 -I--- XWRXWR
 6 : 00 e0000000   1KB V0 -> 4_e0000000 U:0000 -I-G- XWRXWR
 
 
Note : 6th entry is for system ACE.
 
TLB entry Listings  from Kernel:
 
IDX TID      EPN  SIZE VTS          RPN   USER WIMGE USRSVC
 0 : 00 00000000   1KB -0 -> 4_ff000000 U:0000 WI-G- XWRXWR
 1 : 00 fdfff000   4KB V0 -> 4_f0000000 U:0000 -IMG- ----WR
 2 : 00 fdffe000   4KB V0 -> 4_f0000000 U:0000 -IMG- ----WR
 3 : 00 fdffd000   4KB V0 -> 4_f0000000 U:0000 -IMG- ----WR
 4 : 00 e1000000   4KB V0 -> 0_e0000000 U:0000 -IMG- ----WR
 5 : 00 00000000   1KB -0 -> 4_00000000 U:0000 -I--- XWRXWR
 6 : 00 00000000   1KB -0 -> 4_e0000000 U:0000 -I-G- XWRXWR
 
Note: 4th entry is system ACE.
 
The RPN and access permissions are totally different for System ACE from
u-boot and kernel. I u-boot it is - 4_e0000000 , and in kernel it is
0_e0000000
 
I think this is the issue, causing exception during writes to registers from
kernel.
 
Could someone throw some light on this area? This is very critical for us
now.
 
Or am I missing something?
 
Any help would be appreciated.
 
Thanks in advance
Junita

------=_NextPart_000_0003_01C6CD05.4ABCDE20
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 11">
<meta name=3DOriginator content=3D"Microsoft Word 11">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C6CCFA.35AFECD0">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:UseWord2002TableStyleRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=3D"false" LatentStyleCount=3D"156">
 </w:LatentStyles>
</xml><![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:"Times New Roman";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1281109487;
	mso-list-type:hybrid;
	mso-list-template-ids:-1259430296 67698703 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am currently working on a PPC440SPe based custom =
board to
bring up the System ACE interface from =
Linux.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am using linux-2.6.16 with the patch applied as per =
<span
class=3DSpellE>Ameet&#8217;s</span> suggestion from the following =
link<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<pre><i><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-style:italic'><a
href=3D"https://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linu=
xppc-2.6.17.1-sysace-1.1.patch">https://www.cs.york.ac.uk/rtslab/demos/am=
os/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.1.patch</a><o:p></o:p></sp=
an></font></i></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>We are =
able to access the controller registers from u-boot, but kernel throws a =
&#8220;Data Machine Check exception&#8221; while accessing the =
registers.<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1;tab-stops:
list .5in left 45.8pt 91.6pt 137.4pt 183.2pt 229.0pt 274.8pt 320.6pt =
366.4pt 412.2pt 458.0pt 503.8pt 549.6pt 595.4pt 641.2pt 687.0pt =
732.8pt'><![if !supportLists]><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;mso-fareast-font-family:
"Courier New"'><span style=3D'mso-list:Ignore'>1.<font size=3D1
face=3D"Times New Roman"><span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]>I have set up System ACE =
base address as 0xE000_0000 (which is the same as in =
u-boot).<o:p></o:p></pre><pre
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1;tab-stops:
list .5in left 45.8pt 91.6pt 137.4pt 183.2pt 229.0pt 274.8pt 320.6pt =
366.4pt 412.2pt 458.0pt 503.8pt 549.6pt 595.4pt 641.2pt 687.0pt =
732.8pt'><![if !supportLists]><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;mso-fareast-font-family:
"Courier New"'><span style=3D'mso-list:Ignore'>2.<font size=3D1
face=3D"Times New Roman"><span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]>As far as I understand, =
kernel should pick-up TLB settings from u-boot.<o:p></o:p></pre><pre
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1;tab-stops:
list .5in left 45.8pt 91.6pt 137.4pt 183.2pt 229.0pt 274.8pt 320.6pt =
366.4pt 412.2pt 458.0pt 503.8pt 549.6pt 595.4pt 641.2pt 687.0pt =
732.8pt'><![if !supportLists]><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;mso-fareast-font-family:
"Courier New"'><span style=3D'mso-list:Ignore'>3.<font size=3D1
face=3D"Times New Roman"><span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]>But , while debugging =
through BDI this is what I observe:<o:p></o:p></pre><pre
style=3D'margin-left:.5in'><b =
style=3D'mso-bidi-font-weight:normal'><font size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:bold;mso-bidi-font-weight:
normal'><o:p>&nbsp;</o:p></span></font></b></pre><pre =
style=3D'margin-left:.5in'><b
style=3D'mso-bidi-font-weight:normal'><font size=3D2 face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-weight:bold;mso-bidi-font-weight:normal'>T=
LB entry Listings from u-boot</span></font></b>:<o:p></o:p></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'>IDX TID<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DGramE>EPN<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>SIZE</span> VTS<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; </span>RPN<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>USER WIMGE USRSVC<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'> <span class=3DGramE>0 :</span> 00 =
ff000000<span style=3D'mso-spacerun:yes'>&nbsp; </span>16MB V0 -&gt; =
4_ff000000 U:0000 WI-G- XWRXWR<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'> <span class=3DGramE>1 :</span> 00 00000000 =
256MB V0 -&gt; 0_00000000 U:0000 -I-G- =
XWRXWR<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'> <span class=3DGramE>2 :</span> 00 10000000 =
256MB V0 -&gt; 0_10000000 U:0000 -I-G- =
XWRXWR<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'> <span class=3DGramE>3 :</span> 00 20000000 =
256MB V0 -&gt; 0_20000000 U:0000 -I-G- =
XWRXWR<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'> <span class=3DGramE>4 :</span> 00 30000000 =
256MB V0 -&gt; 0_30000000 U:0000 -I-G- =
XWRXWR<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'> <span class=3DGramE>5 :</span> 00 90000000 =
256KB V0 -&gt; 4_00000000 U:0000 -I--- =
XWRXWR<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'> <span class=3DGramE>6 :</span> 00 =
e0000000<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>1KB V0 =
-&gt; 4_e0000000 U:0000 -I-G- XWRXWR<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><span class=3DGramE><b =
style=3D'mso-bidi-font-weight:normal'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:bold;
mso-bidi-font-weight:normal'>Note</span></font></b> :</span> =
6<sup>th</sup> entry is for system ACE.<o:p></o:p></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><b =
style=3D'mso-bidi-font-weight:normal'><font size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:bold;mso-bidi-font-weight:
normal'>TLB entry <span class=3DGramE>Listings <span =
style=3D'mso-spacerun:yes'>&nbsp;</span>from</span> =
Kernel</span></font></b>:<o:p></o:p></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'>IDX TID<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
class=3DGramE>EPN<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>SIZE</span> VTS<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; </span>RPN<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; =
</span>USER WIMGE USRSVC<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'> <span class=3DGramE>0 :</span> 00 =
00000000<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>1KB -0 =
-&gt; 4_ff000000 U:0000 WI-G- XWRXWR<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'> <span class=3DGramE>1 :</span> 00 =
fdfff000<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>4KB V0 =
-&gt; 4_f0000000 U:0000 -IMG- ----WR<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'> <span class=3DGramE>2 :</span> 00 =
fdffe000<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>4KB V0 =
-&gt; 4_f0000000 U:0000 -IMG- ----WR<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'> <span class=3DGramE>3 :</span> 00 =
fdffd000<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>4KB V0 =
-&gt; 4_f0000000 U:0000 -IMG- ----WR<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'> <span class=3DGramE>4 :</span> 00 =
e1000000<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>4KB V0 =
-&gt; 0_e0000000 U:0000 -IMG- ----WR<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'> <span class=3DGramE>5 :</span> 00 =
00000000<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>1KB -0 =
-&gt; 4_00000000 U:0000 -I--- XWRXWR<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'> <span class=3DGramE>6 :</span> 00 =
00000000<span style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>1KB -0 =
-&gt; 4_e0000000 U:0000 -I-G- XWRXWR<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><b =
style=3D'mso-bidi-font-weight:normal'><font size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:bold;mso-bidi-font-weight:
normal'>Note</span></font></b>: 4<sup>th</sup> entry is system =
ACE.<o:p></o:p></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'>The RPN and access permissions are totally =
different for System ACE from u-boot and kernel. I u-boot it is &#8211; =
<b
style=3D'mso-bidi-font-weight:normal'><span =
style=3D'font-weight:bold;mso-bidi-font-weight:
normal'>4_<span class=3DGramE>e0000000<span =
style=3D'font-weight:normal'> ,</span></span></span></b> and in kernel =
it is <b
style=3D'mso-bidi-font-weight:normal'><span =
style=3D'font-weight:bold;mso-bidi-font-weight:
normal'>0_e0000000</span></b><o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'>I think this is the issue, causing exception =
during writes to registers from =
kernel.<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Could someone throw some light on this area? =
This is very critical for us now.<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Or am I missing =
something?<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Any help would be =
appreciated.<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Thanks in =
advance<o:p></o:p></span></font></pre><pre
style=3D'margin-left:.5in'><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Junita<o:p></o:p></span></font></pre></div>

</body>

</html>

------=_NextPart_000_0003_01C6CD05.4ABCDE20--
