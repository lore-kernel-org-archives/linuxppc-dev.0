Return-Path: <otavio.sugeno@siemens.com>
Received: from chekov.siemens.com.br (chekov.siemens.com.br [200.186.153.37])
	by ozlabs.org (Postfix) with ESMTP id 85BDA689BD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 21:19:06 +1100 (EST)
Received: from sao0021x.siemens.com.br (exchange-cluster [200.186.153.35])
	by chekov.siemens.com.br (Postfix) with ESMTP id 74B9E169B2A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 07:56:15 -0200 (BRST)
Received: from sao1100a.ww101.siemens.net ([129.214.31.218])
	by sao0021x.siemens.com.br (8.12.10/8.9.3) with ESMTP id k0AA1eCE064619
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 08:01:41 -0200 (BRST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C615CC.181B3773"
Date: Tue, 10 Jan 2006 07:56:13 -0200
Message-ID: <BE0C32DB15562D419477AFD8378515E8266EED@SAO1014V.ww101.siemens.net>
From: "Sugeno, Otavio Isamu" <otavio.sugeno@siemens.com>
To: "Jonathan Qiang" <jonathan@haliplex.com.au>
Cc: linuxppc-embedded@ozlabs.org
Subject: RES: [Problem] linux 2.6.14 kernel hang up after the uImage
	uncompressedsuccessfully
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

------_=_NextPart_001_01C615CC.181B3773
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi.
I suggest you check the bd_info structure, if they are the same at =
u-boot and linux kernel.=20
See also the link below, it is always a good source to solve problems:
=20
http://www.denx.de/wiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel
=20
If it is the bd_info is ok, so probably your problem is with some =
configuration in you board or something that it is not working properly.
Try to compile a linux kernel only with basic features that you need, =
for example, serial and ethernet and check what happens.
=20
=20
Otavio I. Sugeno
Information & Communication
Com EN PSY DA
Phone: +55 41 341-5883
Fax: +55 41 341-5594
email: otavio.sugeno@siemens.com
Siemens Brasil 2005 * 100 ANOS
=20
=20

________________________________

De: linuxppc-embedded-bounces@ozlabs.org =
[mailto:linuxppc-embedded-bounces@ozlabs.org] Em nome de Jonathan Qiang
Enviada em: ter=E7a-feira, 10 de janeiro de 2006 01:06
Para: linuxppc-embedded@ozlabs.org
Assunto: [Problem] linux 2.6.14 kernel hang up after the uImage =
uncompressedsuccessfully


Hi,
=20
I am doing booting linux kernel 2.6.14.5 from kernel.org on a kind of =
embedded ppc board, where the chip mpc8272 has been settled.
But  after u-boot(1.1.4) finished booting itself and uncompressed the =
uImage(2.6.14.5 based). the kernel can not boot
Successfully. It stop somewhere. the script is below:=20
=20
=20
U-Boot 1.1.4 (Jan  3 2006 - 15:00:41)
=20
MPC8272 Reset Status: Check Stop, External Soft, External Hard
=20
MPC8272 Clock Configuration
 - Bus-to-Core Mult 5x, VCO Div 2, 60x Bus Freq  20-60 , Core Freq =
100-300
 - dfbrg 1, corecnf 0x1b, busdf 7, cpmdf 1, plldf 0, pllmf 7
 - vco_out  528000000, scc_clk  132000000, brg_clk   33000000
 - cpu_clk  330000000, cpm_clk  264000000, bus_clk   66000000
 - pci_clk   22000000
=20
CPU:   MPC8272 (HiP7 Rev 14, Mask 1.0 1K50M) at 330 MHz
I2C:   ready
DRAM:  SDRAM configuration:
        Refresh rate =3D 47, CAS latency =3D 3, Using Page Based =
Interleave
        Total size: 32 MB
FLASH Dectected: FLASH MFP, new id is 0x0089, Device ID is 0x8922
32 MB
In:    serial
Out:   serial
Err:   serial
Ethos version: ac21 (DEVID:ac2, DEVVER:1, MFGVER: 1)
CFG_CMXFCR_VALUE=3D0x00370000, CFG_CMXFCR_MASK=3D0x007F0000
Net:   FCC2 ETHERNET
Hit any key to stop autoboot:  0
Using FCC2 ETHERNET device
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.14.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    750080 Bytes =3D 732.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK=20
=20
Then I have tried to use BDI2000 to debug the kernel, It seems that the =
kernel can passed on console_init function. But still no message came =
out even printk(KERN_NOTICE);  and printk(linux_banner);=20
=20

------_=_NextPart_001_01C615CC.181B3773
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word" xmlns:st1 =3D=20
"urn:schemas-microsoft-com:office:smarttags"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3DWord.Document name=3DProgId>
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR>
<META content=3D"Microsoft Word 10" name=3DOriginator><LINK=20
href=3D"cid:filelist.xml@01C615EF.067C8A30" =
rel=3DFile-List><o:SmartTagType=20
name=3D"time"=20
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"></o:SmartTagT=
ype><o:SmartTagType=20
name=3D"date"=20
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"></o:SmartTagT=
ype><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:UseFELayout/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if !mso]>
<STYLE>st1\:* {
	BEHAVIOR: url(#default#ieooui)
}
</STYLE>
<![endif]-->
<STYLE>@font-face {
	font-family: SimSun;
}
@font-face {
	font-family: @SimSun;
}
@page Section1 {size: 612.0pt 792.0pt; margin: 72.0pt 90.0pt 72.0pt =
90.0pt; mso-header-margin: 35.4pt; mso-footer-margin: 35.4pt; =
mso-paper-source: 0; }
P.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: SimSun
}
LI.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: SimSun
}
DIV.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"; =
mso-style-parent: ""; mso-pagination: widow-orphan; =
mso-fareast-font-family: SimSun
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline; text-underline: single
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline; text-underline: single
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline; text-underline: single
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline; text-underline: single
}
SPAN.EmailStyle17 {
	COLOR: windowtext; FONT-FAMILY: Arial; mso-style-type: =
personal-compose; mso-style-noshow: yes; mso-ansi-font-size: 10.0pt; =
mso-bidi-font-size: 10.0pt; mso-ascii-font-family: Arial; =
mso-hansi-font-family: Arial; mso-bidi-font-family: Arial
}
SPAN.SpellE {
	mso-style-name: ""; mso-spl-e: yes
}
DIV.Section1 {
	page: Section1
}
</STYLE>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]--></HEAD>
<BODY lang=3DEN-US style=3D"tab-interval: 36.0pt" vLink=3Dpurple =
link=3Dblue>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D846075009-10012006>Hi.</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D846075009-10012006>I suggest you check the bd_info structure, if =
they are=20
the same at u-boot and linux kernel. </SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D846075009-10012006>See also the link below, it is always a good =
source to=20
solve problems:</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D846075009-10012006></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D846075009-10012006><A=20
href=3D"http://www.denx.de/wiki/bin/view/DULG/LinuxHangsAfterUncompressin=
gKernel">http://www.denx.de/wiki/bin/view/DULG/LinuxHangsAfterUncompressi=
ngKernel</A></SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D846075009-10012006></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D846075009-10012006>If it is the bd_info is ok, so probably your =
problem is=20
with some configuration in you board or something that it is not working =

properly.</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D846075009-10012006>Try to compile a linux kernel only with basic =
features=20
that you need, for example, serial and ethernet and check what=20
happens.</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D846075009-10012006></SPAN></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<P class=3DMsoAutoSig align=3Dleft><SPAN lang=3DPT-BR=20
style=3D"FONT-SIZE: 10pt; mso-ansi-language: PT-BR">Otavio I.=20
Sugeno<BR></SPAN><SPAN lang=3DPT-BR=20
style=3D"FONT-SIZE: 10pt; mso-ansi-language: PT-BR">Information &amp;=20
Communication<BR></SPAN><SPAN lang=3DPT-BR=20
style=3D"FONT-SIZE: 10pt; mso-ansi-language: PT-BR">Com EN PSY =
DA<BR></SPAN><SPAN=20
lang=3DPT-BR style=3D"FONT-SIZE: 10pt; mso-ansi-language: PT-BR">Phone: =
+55 41=20
341-5883<BR></SPAN><SPAN lang=3DPT-BR=20
style=3D"FONT-SIZE: 10pt; mso-ansi-language: PT-BR">Fax: +55 41=20
341-5594<BR></SPAN><SPAN lang=3DPT-BR=20
style=3D"FONT-SIZE: 10pt; mso-ansi-language: PT-BR">email: <A=20
href=3D"mailto:otavio.sugeno@siemens.com">otavio.sugeno@siemens.com</A><B=
R></SPAN><SPAN=20
lang=3DPT-BR style=3D"FONT-SIZE: 10pt; mso-ansi-language: PT-BR"><FONT=20
face=3DTim><SPAN lang=3DPT-BR style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Siemens=20
Brasil 2005 </SPAN><B><SPAN lang=3DPT-BR=20
style=3D"FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Arial">=95 100 =

ANOS<BR></SPAN></B></FONT></SPAN><FONT face=3D"Times New Roman"><SPAN =
lang=3DPT-BR=20
style=3D"FONT-SIZE: 10pt; mso-ansi-language: =
PT-BR"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<DIV>&nbsp;</DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Dpt-br dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>De:</B> =
linuxppc-embedded-bounces@ozlabs.org=20
[mailto:linuxppc-embedded-bounces@ozlabs.org] <B>Em nome de </B>Jonathan =

Qiang<BR><B>Enviada em:</B> ter=E7a-feira, 10 de janeiro de 2006=20
01:06<BR><B>Para:</B> linuxppc-embedded@ozlabs.org<BR><B>Assunto:</B> =
[Problem]=20
linux 2.6.14 kernel hang up after the uImage=20
uncompressedsuccessfully<BR></FONT><BR></DIV>
<DIV></DIV>
<DIV class=3DSection1>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Hi,<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">I am doing booting <SPAN=20
class=3DSpellE>linux</SPAN> kernel 2.6.14.5 from kernel.org on a kind of =

</SPAN></FONT><B><FONT color=3Dblack><SPAN=20
style=3D"FONT-WEIGHT: bold; COLOR: black">embedded <SPAN =
class=3DSpellE>ppc</SPAN>=20
board, where the chip mpc8272 has been =
settled.<o:p></o:p></SPAN></FONT></B></P>
<P class=3DMsoNormal><B><FONT face=3D"Times New Roman" color=3Dblack =
size=3D3><SPAN=20
style=3D"FONT-WEIGHT: bold; FONT-SIZE: 12pt; COLOR: black">But <SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>after u-boot(1.1.4) finished =
booting=20
itself and uncompressed the <SPAN class=3DSpellE>uImage</SPAN>(2.6.14.5 =
based).=20
the kernel can not boot<o:p></o:p></SPAN></FONT></B></P>
<P class=3DMsoNormal><B><FONT face=3D"Times New Roman" color=3Dblack =
size=3D3><SPAN=20
style=3D"FONT-WEIGHT: bold; FONT-SIZE: 12pt; COLOR: black">Successfully. =
It stop=20
somewhere. the script is below: <o:p></o:p></SPAN></FONT></B></P>
<P class=3DMsoNormal><B><FONT face=3D"Times New Roman" color=3Dblack =
size=3D3><SPAN=20
style=3D"FONT-WEIGHT: bold; FONT-SIZE: 12pt; COLOR: =
black"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3DMsoNormal><B><FONT face=3D"Times New Roman" color=3Dblack =
size=3D3><SPAN=20
style=3D"FONT-WEIGHT: bold; FONT-SIZE: 12pt; COLOR: =
black"><o:p>&nbsp;</o:p></SPAN></FONT></B></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">U-Boot 1.1.4=20
(</SPAN></FONT><st1:date Year=3D"2006" Day=3D"3" Month=3D"1"><FONT =
face=3DArial=20
size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Jan<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>3 =
2006</SPAN></FONT></st1:date><FONT=20
face=3DArial size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"> -=20
</SPAN></FONT><st1:time Minute=3D"0" Hour=3D"15"><FONT face=3DArial =
size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">15:00:41</SPAN></FONT></st1:time><FONT=20
face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">)<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">MPC8272 Reset Status: =
Check Stop,=20
External Soft, External Hard<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">MPC8272 Clock=20
Configuration<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>- Bus-to-Core <SPAN=20
class=3DSpellE>Mult</SPAN> 5x, VCO Div 2, 60x Bus Freq<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>20-60 , Core Freq=20
100-300<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>- <SPAN =
class=3DSpellE>dfbrg</SPAN> 1,=20
<SPAN class=3DSpellE>corecnf</SPAN> 0x1b, <SPAN =
class=3DSpellE>busdf</SPAN> 7, <SPAN=20
class=3DSpellE>cpmdf</SPAN> 1, <SPAN class=3DSpellE>plldf</SPAN> 0, =
<SPAN=20
class=3DSpellE>pllmf</SPAN> 7<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>- <SPAN =
class=3DSpellE>vco_out</SPAN><SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>528000000, <SPAN=20
class=3DSpellE>scc_clk</SPAN><SPAN style=3D"mso-spacerun: yes">&nbsp;=20
</SPAN>132000000, <SPAN class=3DSpellE>brg_clk</SPAN><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;=20
</SPAN>33000000<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>- <SPAN =
class=3DSpellE>cpu_clk</SPAN><SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>330000000, <SPAN=20
class=3DSpellE>cpm_clk</SPAN><SPAN style=3D"mso-spacerun: yes">&nbsp;=20
</SPAN>264000000, <SPAN class=3DSpellE>bus_clk</SPAN><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;=20
</SPAN>66000000<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>- <SPAN =
class=3DSpellE>pci_clk</SPAN><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;=20
</SPAN>22000000<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">CPU:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>MPC8272 (HiP7 Rev 14, =
Mask 1.0=20
1K50M) at 330 MHz<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">I2C:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; =
</SPAN>ready<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">DRAM:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>SDRAM=20
configuration:<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Refresh rate =3D 47, CAS latency =3D 3, Using Page Based=20
Interleave<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Total size: 32 MB<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">FLASH <SPAN=20
class=3DSpellE>Dectected</SPAN>: FLASH MFP, new id is 0x0089, Device ID =
is=20
0x8922<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">32 =
MB<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">In:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;=20
</SPAN>serial<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Out:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;=20
</SPAN>serial<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Err:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;=20
</SPAN>serial<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Ethos version: ac21 =
(DEVID:ac2,=20
DEVVER:1, MFGVER: 1)<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">CFG_CMXFCR_VALUE=3D0x00370000,=20
CFG_CMXFCR_MASK=3D0x007F0000<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Net:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>FCC2=20
ETHERNET<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Hit any key to stop <SPAN=20
class=3DSpellE>autoboot</SPAN>:<SPAN style=3D"mso-spacerun: yes">&nbsp;=20
</SPAN>0<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Using FCC2 ETHERNET=20
device<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">## Booting image at =
00200000=20
...<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Image Name:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;=20
</SPAN>Linux-2.6.14.5<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Image Type:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>PowerPC Linux Kernel =
Image (<SPAN=20
class=3DSpellE>gzip</SPAN> compressed)<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Data Size:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </SPAN>750080 Bytes =3D =
732.5 <SPAN=20
class=3DSpellE>kB</SPAN><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Load Address:=20
00000000<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Entry Point:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>00000000<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Verifying Checksum ...=20
OK<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Uncompressing Kernel =
Image ... OK=20
<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Then I have tried to use =
BDI2000 to=20
debug the kernel, It seems that the kernel can passed on <SPAN=20
class=3DSpellE>console_init</SPAN> function. But still no message came =
out even=20
<SPAN class=3DSpellE>printk</SPAN>(KERN_NOTICE);<SPAN=20
style=3D"mso-tab-count: 1">&nbsp; </SPAN>and <SPAN=20
class=3DSpellE>printk</SPAN>(<SPAN class=3DSpellE>linux_banner</SPAN>);=20
<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P></DIV></BODY></HTML>

------_=_NextPart_001_01C615CC.181B3773--
