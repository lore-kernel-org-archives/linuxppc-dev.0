Return-Path: <mcnernbm@notes.udayton.edu>
Received: from ms-smtp-02-eri0.ohiordc.rr.com
	(ms-smtp-02-smtplb.ohiordc.rr.com [65.24.5.136])
	by ozlabs.org (Postfix) with ESMTP id 523DC68921
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 17:16:39 +1100 (EST)
Received: from lilmac (cpe-71-67-143-210.woh.res.rr.com [71.67.143.210])
	by ms-smtp-02-eri0.ohiordc.rr.com (8.12.10/8.12.7) with ESMTP id
	k056GWXX024532
	for <linuxppc-embedded@ozlabs.org>; Thu, 5 Jan 2006 01:16:36 -0500 (EST)
From: "Brett McNerney" <mcnernbm@notes.udayton.edu>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 5 Jan 2006 01:16:29 -0500
Message-ID: <000c01c611bf$92d5f900$0202a8c0@lilmac>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000D_01C61195.A9FFF100"
Subject: mmap
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

------=_NextPart_000_000D_01C61195.A9FFF100
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I have been trying to work with mmap to read and write to a custom hardware
module on a Xilinx virtex 4 board with linux running on the ppc.  But I have
gotten many different errors.  But the main one I am seeing is segmentation
error.  Below is the code I am using.  The device has a 256 address size
specified in the Xilinx tools and the base address I set in the Xilinx tools
was 0x81000000.  Am I doing something wrong in the code?  Any help would be
greatly appreciated as we have decided to try this method instead of using a
driver built into the kernel as this allows us some more flexibility.  Also
the hardware module I am using for testing contains 3 hardware registers
which adds two of the registers and returns the result in the third one.

 

I am open for other options on how I can do this other then mmap.  And am
still not against a driver built into the kernel if someone has a an example
I could see and can explain how to add it in so it builds into the kernel
since I have had no success on that either and have tried a couple different
tutorials I found online with no success.

Thanks for any help anyone can provide.

Brett

 

#include <stdio.h>

#include <sys/types.h>

#include <sys/stat.h>

#include <fcntl.h>

#include <sys/mman.h>

 

int main(void) {

      int fd;

      int *p;

      fd = open("/dev/mem, O_RDWR);

      p = (int *)mmap(0, 256, PROT_READ|PROT_WRITE,

                              MAP_PRIVATE, fd, 0x81000000);

      if (p == MAP_FAILED) {

            printf("Err: cannot access adder!/n");

            return -1;

      }

      printf("input two numbers: ");

      scanf("%d", &p);

      scanf("%d", &p+1);

      printf("%d + %d = %d\n", *p, *(p+1), *(p+2));

      munmap(p,256);

      close(fd);

      return 0;

}

 


------=_NextPart_000_000D_01C61195.A9FFF100
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have been trying to work with mmap to read and =
write to a custom
hardware module on a Xilinx virtex 4 board with linux running on the =
ppc.&nbsp; But
I have gotten many different errors.&nbsp; But the main one I am seeing =
is segmentation
error.&nbsp; Below is the code I am using.&nbsp; The device has a 256 =
address size
specified in the Xilinx tools and the base address I set in the Xilinx =
tools
was 0x81000000.&nbsp; Am I doing something wrong in the code?&nbsp; Any =
help would be
greatly appreciated as we have decided to try this method instead of =
using a
driver built into the kernel as this allows us some more =
flexibility.&nbsp; Also the
hardware module I am using for testing contains 3 hardware registers =
which adds
two of the registers and returns the result in the third =
one.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am open for other options on how I can do this =
other then
mmap.&nbsp; And am still not against a driver built into the kernel if =
someone has a
an example I could see and can explain how to add it in so it builds =
into the
kernel since I have had no success on that either and have tried a =
couple
different tutorials I found online with no =
success.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks for any help anyone can =
provide.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Brett<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblue
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:blue'>#include</span></font><font size=3D2 face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'> =
&lt;stdio.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblue
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:blue'>#include</span></font><font size=3D2 face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'> =
&lt;sys/types.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblue
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:blue'>#include</span></font><font size=3D2 face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'> =
&lt;sys/stat.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblue
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:blue'>#include</span></font><font size=3D2 face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'> =
&lt;fcntl.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblue
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:blue'>#include</span></font><font size=3D2 face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'> =
&lt;sys/mman.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
color=3Dblue
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:blue'>int</span></font><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'> main(<font =
color=3Dblue><span
style=3D'color:blue'>void</span></font>) {<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color=3Dblue><span
style=3D'color:blue'>int</span></font> fd;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color=3Dblue><span
style=3D'color:blue'>int</span></font> *p;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fd =3D
open(&quot;/dev/mem, O_RDWR);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p =3D (<font color=3Dblue><span
style=3D'color:blue'>int</span></font> *)mmap(0, 256, =
PROT_READ|PROT_WRITE,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAP_PRIVATE,
fd, 0x81000000);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color=3Dblue><span
style=3D'color:blue'>if</span></font> (p =3D=3D MAP_FAILED) =
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf(&quot;Err:
cannot access adder!/n&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<font
color=3Dblue><span style=3D'color:blue'>return</span></font> =
-1;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;input two
numbers: &quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scanf(&quot;%d&quot;,
&amp;p);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scanf(&quot;%d&quot;,
&amp;p+1);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;%d + %d =3D
%d\n&quot;, *p, *(p+1), *(p+2));<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
munmap(p,256);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
close(fd);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color=3Dblue><span
style=3D'color:blue'>return</span></font> =
0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_000D_01C61195.A9FFF100--
