Return-Path: <mqy@263.net.cn>
From: "KylongMu" <mqy@263.net.cn>
To: "Wolfgang Denk" <wd@denx.de>
Date: Sun, 13 Nov 2005 02:01:24 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000B_01C5E7F6.278ED3D0"
In-Reply-To: <20051112164751.CA6C6DBB@smtp.263.net>
Message-Id: <20051112180127.10C03CEA@smtp.263.net>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Problem solved: 11-11-05 2.6.14 on AMCC Yosemite board(boot error) 
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

------=_NextPart_000_000B_01C5E7F6.278ED3D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Denk:

      The problem is solved After I check the document at:

http://www.denx.de/wiki/view/DULG/RamdiskGreaterThan4MBCausesProblems

It wrote:

14.3.14. Ramdisk Greater than 4 MB Causes Problems

Question: 

I built a ramdisk image which is bigger than 4 MB. I run into problems when
I try to boot Linux with this image, while other (smaller) ramdisk images
work fine. 

Answer: 

The Linux kernel has a default maximum ramdisk size of 4096 kB. To boot with
a bigger ramdisk image, you must raise this value. There are two methods: 

*   Dynamical adjustment using boot arguments:
You can pass a boot argument ramdisk_size=<size-in-kB> to the Linux kernel
to overwrite the configured maximum. Note that this argument needs to be
before any root argument. A flexible way to to this is using U-Boot
environment variables. For instance, to boot with a ramdisk image of 6 MB
(6144 kB), you can define: 

=> setenv rd_size 6144

=> setenv bootargs ... ramdisk_size=\$(rd_size) ...

=> saveenv

       

If you later find out that you need an even bigger ramdisk image, or that a
smaller one is sufficient, all that needs changing is the value of the
"rd_size" environment variable.

With the first way I modify the boorargs, and all work OK

*    

*	Increasing the Linux kernel default value:
When configuring your Linux kernel, adjust the value of the
CONFIG_BLK_DEV_RAM_SIZE parameter so that it contains a number equal or
larger than your ramdisk (in kB). (In the 2.4 kernel series, you'll find
this setting under the "Block devices" menu choice while, in the 2.6 series,
it will be under "Device drivers" -> "Block devices".) 

With the second way I only modify the CONFIG_BLK_DEV_RAM_SIZE, but when it
boot, it's shows this problem still:

Kernel panic - not syncing: No init found.  Try passing init= option to
kernel.

 

Last file I wrote:

 

>What you show is NOT the current code.

     By update with the most recent code, I did new test, and get

Different error message, that I can't solve it, pls check the attachment. 

 

> U-Boot 1.1.3 (Sep  7 2005 - 09:03:02)

 

>Please update U-Boot as well. You need this commit included:

 

>commit f190c11b1f22ff766e046588e5a7bb55f28ae305

>tree 1c41a7beffe8a293174dcb7c28b394349204a047

>parent 4d03a21f2329bb13a9661a23742ac0b77a7a76d5

>author Stefan Roese <sr@denx.de> Sat, 05 Nov 2005 15:50:16 +0100

>committer Stefan Roese <sr@denx.de> Sat, 05 Nov 2005 15:50:16 +0100

 

>    Adjust bd->bi_flashstart on Yellowstone & Yosemite to correct size

>    Patch by Stefan Roese, 05 Nov 2005

 

>I recommend to use the top-of-tree from the CVS or GIT repositories.

 

> Linux version 2.6.14 (root@dxp) (gcc version 4.0.0) #1 Fri Nov 11

> 09:51:04 CST 2005

 

>This is not the current code base. You should  use  top-of-tree  from

>GIT repository (commit ff1df84b3c3154ffdb646941e1c70d17554e3042); the

>kernel will display something like this:

 

>Linux version 2.6.14-gff1df84b ...

     I update my source code by "cg-update" directly, after many message and
file download it shows "full merged",

I think it is work. But the version only is 2.6.14. 

 

Thanks a lot!

 

Kylong Mu


------=_NextPart_000_000B_01C5E7F6.278ED3D0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chsdate" downloadurl=3D""/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chmetcnv" downloadurl=3D""/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:9.0pt;
	font-family:SimSun;}
code
	{font-family:SimSun;}
pre
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 126.65pt 72.0pt 126.65pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:552353865;
	mso-list-template-ids:-79517406;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1
	{mso-list-id:1795253666;
	mso-list-template-ids:-1859327692;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Dear Denk:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dnavy =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:7.5pt;color:navy'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font><font
size=3D3 color=3Dnavy><span lang=3DEN-US =
style=3D'font-size:12.0pt;color:navy'>The
problem is solved After I check the document =
at:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D3 color=3Dnavy =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:12.0pt;color:navy'><a
href=3D"http://www.denx.de/wiki/view/DULG/RamdiskGreaterThan4MBCausesProb=
lems">http://www.denx.de/wiki/view/DULG/RamdiskGreaterThan4MBCausesProble=
ms</a><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D3 color=3Dnavy =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:12.0pt;color:navy'>It =
wrote:</span></font><font
size=3D2 color=3Dnavy><span lang=3DEN-US =
style=3D'font-size:10.5pt;color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><a name=3D"Section_14.3.14."></a><st1:chsdate
IsROCDate=3D"False" IsLunarDate=3D"False" Day=3D"30" Month=3D"12" =
Year=3D"1899" w:st=3D"on"><font
 size=3D1 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:9.0pt'>14.3.14</span></font></st1:chsdate><span
lang=3DEN-US>. Ramdisk Greater than 4 MB Causes Problems</span><span =
lang=3DEN-US><o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dleft style=3D'text-align:left'><font =
size=3D3 face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'>Question: =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'margin-left:36.0pt;text-align:left'><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt;
font-family:SimSun'>I built a ramdisk image which is bigger than 4 MB. I =
run
into problems when I try to boot Linux with this image, while other =
(smaller)
ramdisk images work fine. <o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft style=3D'text-align:left'><font =
size=3D3 face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'>Answer: =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'margin-left:36.0pt;text-align:left'><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt;
font-family:SimSun'>The Linux kernel has a default maximum ramdisk size =
of 4096
kB. To boot with a bigger ramdisk image, you must raise this value. =
There are
two methods: <o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:
auto;margin-left:72.0pt;text-align:left;text-indent:-18.0pt;mso-list:l0 =
level1 lfo1'><![if !supportLists]><font
size=3D2 face=3DSymbol><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Symbol'><span
style=3D'mso-list:Ignore'>&middot;<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt;
font-family:SimSun'>Dynamical adjustment using boot arguments:<br>
You can pass a boot argument </span></font><font size=3D3 =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:12.0pt;font-family:SimSun'>ramdisk_size=3D&lt;size-in-=
kB&gt;</span></font><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt;
font-family:SimSun'> to the Linux kernel to overwrite the configured =
maximum.
Note that this argument needs to be before any </span></font><font =
size=3D3
face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt;font-family:
SimSun'>root</span></font><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:SimSun'> argument. A flexible way =
to to
this is using U-Boot environment variables. For instance, to boot with a
ramdisk image of 6 MB (6144 kB), you can define: =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft style=3D'text-align:left'><font =
size=3D3 face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'>=3D&gt; =
setenv rd_size
6144<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft style=3D'text-align:left'><font =
size=3D3 face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'>=3D&gt; =
setenv bootargs
... ramdisk_size=3D\$(rd_size) ...<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft style=3D'text-align:left'><font =
size=3D3 face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:12.0pt;font-family:SimSun'>=3D&gt; =
saveenv<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft style=3D'text-align:left'><font =
size=3D3 face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:12.0pt;font-family:SimSun'>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D3 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>If you later find out that you need an even =
bigger
ramdisk image, or that a smaller one is sufficient, all that needs =
changing is
the value of the </span></font><font size=3D3><span lang=3DEN-US =
style=3D'font-size:
12.0pt'>&quot;rd_size&quot;</span></font><font size=3D3><span =
lang=3DEN-US
style=3D'font-size:12.0pt'> environment =
variable.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><b><font size=3D4 color=3Dblue =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:14.0pt;color:blue;font-weight:bold'>With =
the first
way I modify the boorargs, and all work =
OK<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:
auto;margin-left:72.0pt;text-align:left;text-indent:-18.0pt;mso-list:l1 =
level1 lfo2'><![if !supportLists]><font
size=3D2 face=3DSymbol><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Symbol'><span
style=3D'mso-list:Ignore'>&middot;<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt;
font-family:SimSun'><o:p>&nbsp;</o:p></span></font></p>

<ul type=3Ddisc>
 <ul type=3Dcircle>
  <li class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:
      auto;text-align:left;mso-list:l1 level2 lfo2'><font size=3D3 =
face=3D&#23435;&#20307;><span
      lang=3DEN-US =
style=3D'font-size:12.0pt;font-family:SimSun'>Increasing the
      Linux kernel default value:<br>
      When configuring your Linux kernel, adjust the value of the =
</span></font><font
      size=3D3 face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt;
      font-family:SimSun'>CONFIG_BLK_DEV_RAM_SIZE</span></font><font =
size=3D3
      face=3D&#23435;&#20307;><span lang=3DEN-US =
style=3D'font-size:12.0pt;
      font-family:SimSun'> parameter so that it contains a number equal =
or
      larger than your ramdisk (in kB). (In the 2.4 kernel series, =
you'll find
      this setting under the &quot;Block devices&quot; menu choice =
while, in
      the 2.6 series, it will be under &quot;Device drivers&quot; -&gt;
      &quot;Block devices&quot;.) <o:p></o:p></span></font></li>
 </ul>
</ul>

<p class=3DMsoPlainText><b><font size=3D4 color=3Dblue =
face=3DArial><span lang=3DEN-US
style=3D'font-size:14.0pt;font-family:Arial;color:blue;font-weight:bold'>=
With the
second way I only modify the </span></font></b><b><font size=3D4 =
color=3Dblue><span
lang=3DEN-US =
style=3D'font-size:14.0pt;color:blue;font-weight:bold'>CONFIG_BLK_DEV_RAM=
_SIZE,
but when it boot, it&#8217;s shows this problem =
still:</span></font></b><b><font
size=3D4 color=3Dblue face=3DArial><span lang=3DEN-US =
style=3D'font-size:14.0pt;
font-family:Arial;color:blue;font-weight:bold'><o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b><font size=3D4 color=3Dblue =
face=3DArial><span lang=3DEN-US
style=3D'font-size:14.0pt;font-family:Arial;color:blue;font-weight:bold'>=
Kernel
panic - not syncing: No init found.&nbsp; Try passing init=3D option to =
kernel.<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b><font size=3D4 color=3Dblue =
face=3DArial><span lang=3DEN-US
style=3D'font-size:14.0pt;font-family:Arial;color:blue;font-weight:bold'>=
<o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><font size=3D4 face=3DArial><span lang=3DEN-US
style=3D'font-size:14.0pt;font-family:Arial'>Last file I =
wrote:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><b><font size=3D4 color=3Dblue =
face=3DArial><span lang=3DEN-US
style=3D'font-size:14.0pt;font-family:Arial;color:blue;font-weight:bold'>=
<o:p>&nbsp;</o:p></span></font></b></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;What you show is NOT the current =
code.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:9.0pt;color:black'>&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font><font
size=3D1 color=3Dblack><span lang=3DEN-US =
style=3D'font-size:7.5pt;color:black'>By
update with the most recent code, I did new test, and =
get<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:9.0pt;color:black'>Different error =
message, that I
can</span></font><font color=3Dblack face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-family:"Courier =
New";color:black'>&#8217;</span></font><font
color=3Dblack><span lang=3DEN-US style=3D'color:black'>t solve it, pls =
check the
attachment. <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:7.5pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt; U-Boot <st1:chsdate IsROCDate=3D"False"
IsLunarDate=3D"False" Day=3D"30" Month=3D"12" Year=3D"1899" =
w:st=3D"on">1.1.3</st1:chsdate>
(Sep&nbsp; 7 2005 - 09:03:02)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:7.5pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;Please update U-Boot as well. You need =
this commit
included:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:7.5pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;commit f<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"190" UnitName=3D"C" =
w:st=3D"on">190c</st1:chmetcnv>11b<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"1"
UnitName=3D"F" w:st=3D"on">1f</st1:chmetcnv>22ff766e046588e<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"5" =
UnitName=3D"a"
w:st=3D"on">5a</st1:chmetcnv>7bb<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"55" UnitName=3D"F" =
w:st=3D"on">55f</st1:chmetcnv>28ae305<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;tree <st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"1" UnitName=3D"C" =
w:st=3D"on">1c</st1:chmetcnv><st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"41"
UnitName=3D"a" w:st=3D"on">41a</st1:chmetcnv>7beffe<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"8" =
UnitName=3D"a"
w:st=3D"on">8a</st1:chmetcnv>293174dcb<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"7" UnitName=3D"C" =
w:st=3D"on">7c</st1:chmetcnv>28b<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False"
SourceValue=3D"394349204" UnitName=3D"a" =
w:st=3D"on">394349204a</st1:chmetcnv>047<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;parent 4d<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"3" UnitName=3D"a" =
w:st=3D"on">03a</st1:chmetcnv><st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"21"
UnitName=3D"F" w:st=3D"on">21f</st1:chmetcnv>2329bb<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"13" UnitName=3D"a"
w:st=3D"on">13a</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"9661" =
UnitName=3D"a" w:st=3D"on">9661a</st1:chmetcnv><st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"23742"
UnitName=3D"ac" w:st=3D"on">23742ac</st1:chmetcnv>0b<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"77" UnitName=3D"a"
w:st=3D"on">77a</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"7" UnitName=3D"a" =
w:st=3D"on">7a</st1:chmetcnv>76d5<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;author Stefan Roese &lt;sr@denx.de&gt; =
Sat, 05 Nov
2005 15:50:16 +0100<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;committer Stefan Roese &lt;sr@denx.de&gt; =
Sat, 05
Nov 2005 15:50:16 +0100<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:7.5pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;&nbsp;&nbsp;&nbsp; Adjust =
bd-&gt;bi_flashstart on
Yellowstone &amp; Yosemite to correct size<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;&nbsp;&nbsp;&nbsp; Patch by Stefan Roese, =
05 Nov
2005<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:7.5pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;I recommend to use the top-of-tree from =
the CVS or
GIT repositories.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:7.5pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt; Linux version <st1:chsdate =
IsROCDate=3D"False"
IsLunarDate=3D"False" Day=3D"30" Month=3D"12" Year=3D"1899" =
w:st=3D"on">2.6.14</st1:chsdate>
(root@dxp) (gcc version 4.0.0) #1 Fri Nov =
11<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt; 09:51:04 CST =
2005<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:7.5pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;This is not the current code base. You =
should&nbsp;
use&nbsp; top-of-tree&nbsp; from<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;GIT repository (commit =
ff1df84b<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"3"
UnitName=3D"C" w:st=3D"on">3c</st1:chmetcnv>3154ffdb646941e<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"1" =
UnitName=3D"C"
w:st=3D"on">1c</st1:chmetcnv>70d17554e3042); =
the<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;kernel will display something like =
this:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:7.5pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&gt;Linux version <st1:chsdate =
IsROCDate=3D"False"
IsLunarDate=3D"False" Day=3D"30" Month=3D"12" Year=3D"1899" =
w:st=3D"on">2.6.14</st1:chsdate>-gff1df84b
...<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>&nbsp;&nbsp;&nbsp;&nbsp; I update my source =
code by </span></font><font
face=3D"Courier New"><span lang=3DEN-US style=3D'font-family:"Courier =
New"'>&#8220;</span></font><span
lang=3DEN-US>cg-update</span><font face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-family:"Courier New"'>&#8221;</span></font><span =
lang=3DEN-US>
directly, after many message and file download it shows </span><font
face=3D"Courier New"><span lang=3DEN-US style=3D'font-family:"Courier =
New"'>&#8220;</span></font><span
lang=3DEN-US>full merged</span><font face=3D"Courier New"><span =
lang=3DEN-US
style=3D'font-family:"Courier New"'>&#8221;</span></font><span =
lang=3DEN-US>,<o:p></o:p></span></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:9.0pt;color:black'>I think it is work. =
But the
version only is <st1:chsdate IsROCDate=3D"False" IsLunarDate=3D"False" =
Day=3D"30"
Month=3D"12" Year=3D"1899" w:st=3D"on">2.6.14</st1:chsdate>. =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:7.5pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Thanks a lot!<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US =
style=3D'font-size:7.5pt;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoPlainText><font size=3D1 color=3Dblack =
face=3D&#23435;&#20307;><span
lang=3DEN-US style=3D'font-size:9.0pt;color:black'>Kylong =
Mu<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_000B_01C5E7F6.278ED3D0--
