Return-Path: <tmike@recipes4linux.com>
Received: from smtpauth01.mail.atl.earthlink.net
	(smtpauth01.mail.atl.earthlink.net [209.86.89.61])
	by ozlabs.org (Postfix) with ESMTP id ACBA12BF11
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Dec 2004 02:02:19 +1100 (EST)
From: "T Michael Turney" <tmike@recipes4linux.com>
To: "Jinwu Wei(???)" <wjw@mail.ndsc.com.cn>,
	<linuxppc-dev@ozlabs.org>
Date: Thu, 30 Dec 2004 06:44:36 -0800
Message-ID: <GEEKLLHMFHLAJOBEEELHGEJMCNAA.tmike@recipes4linux.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0008_01C4EE3B.06FE8080"
In-Reply-To: <002c01c4ee47$254516b0$c7c8a8c0@LocalHost>
Subject: RE: help me for: Oops: kernel access of bad area, sig: 11 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0008_01C4EE3B.06FE8080
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

If you are using MVL2.1 why do you have to port ppp_generic.c?
I have used the PPP support already built-in to this kernel without
problem, even ported wvdial/wvstreams to it.
Cheers,
T.mike
  -----Original Message-----
  From: linuxppc-dev-bounces@ozlabs.org =
[mailto:linuxppc-dev-bounces@ozlabs.org]On Behalf Of Jinwu Wei(???)
  Sent: Thursday, December 30, 2004 12:11 AM
  To: linuxppc-dev@ozlabs.org
  Subject: help me for: Oops: kernel access of bad area, sig: 11=20
  Importance: High



  Dear,

      Here is my problems,

       Our environmet is:
      OS: hardhat Linux 2.1
      platform: ppc lopec 7410
      uname -r : 2.4.17_mvl21-lopec
    =20
     When we port the ppp_generic.c(Which is a kernel module), and the =
program can be executed on host(redhat 7.2). Howerver, when we complied =
it and runned on ppc lopec7410 (target) by the cross-developemnt =
enviornment, which can result in the machine down, and when wei return =
in the beginning of ppp_xmit_process(), the machine is not down but the =
following massages is printed in the /var/log/massages:

  Dec 29 13:52:31 10 kernel: IN ppp_generic.c(ppp_write()):called =
function ppp_write () 0  times!=20
  Dec 29 13:52:31 10 kernel: In ppp_geberic.c(ppp_file_write()): the =
send device kind (pf->kind,1=3DINTERFACE,2=3DCHANNEL)is 1=20
  Dec 29 13:52:31 10 kernel: In ppp_geberic.c(ppp_file_write()):After =
copy_from_user, the data from pppd to kernel space is :=20
  Dec 29 13:52:31 10 kernel: =20
  Dec 29 13:52:31 10 kernel: c0 21 01 01 00 0a 02 06 00 00 00 00 =20
  Dec 29 13:52:31 10 kernel: IN ppp_GENERIC.c :ppp_xmit_process(),into =
this function =20
  Dec 29 13:52:31 10 kernel: IN ppp_GENERIC.c =
:ppp_xmit_process(),ppp->xmit_pending is 0 =20
  Dec 29 13:52:32 10 kernel: Oops: kernel access of bad area, sig: 11=20
  Dec 29 13:52:32 10 kernel: NIP: C0012F4C XER: 00000000 LR: C0012F34 =
SP: DF61FE40 REGS: df61fd90 TRAP: 0300    Tainted: P =20
  Dec 29 13:52:32 10 kernel: MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 =
IR/DR: 11=20
  Dec 29 13:52:32 10 kernel: DAR: 00000004, DSISR: 42000000=20
  Dec 29 13:52:32 10 kernel: TASK =3D df61e000[102] 'pppd' Last syscall: =
142 =20
  Dec 29 13:52:32 10 kernel: last math df61e000 last altivec df61e000=20
  Dec 29 13:52:32 10 kernel: GPR00: 00001032 DF61FE40 DF61E000 00000001 =
00009032 000000A5 DFDBEDE4 0001F618 =20
  Dec 29 13:52:32 10 kernel: GPR08: 0000003C 00000000 DF619008 DF619014 =
84244862 1004BE28 10040000 10040000 =20
  Dec 29 13:52:32 10 kernel: GPR16: 10040000 10040000 10040000 10040000 =
00009032 DF61FEF8 DF61FE98 0000012C =20
  Dec 29 13:52:32 10 kernel: GPR24: 00000006 00000000 00000145 DF61FED8 =
C02B0984 DF61900C DF7A35E0 DF619000 =20
  Dec 29 13:52:32 10 kernel: Call backtrace: =20
  Dec 29 13:52:32 10 kernel: C0035128 C00516E0 E100379C C0051A28 =
C0051D30 C0009FD0 C000409C =20
  Dec 29 13:52:32 10 kernel: 1001CBA8 10005EC0 100059B8 0FE69628 =
00000000 =20


  How to debug it and correcte it , Plese help me!

  Thanks a lot!
  -------------------------------------------

   Best Regards
  =20
   Dr. Jinwu Wei
  =20
  -----------------------------------------------------------------
  =20
  National Digital Switching System=20
  Engineering & Technology R&D Center (NDSC),
  Jianxue street 7#, Box:1001, No.783,
  Zhengzhou,   450002.
  Henan province, P.R. China.
  =20
  Tel: +86-371-3532873

  Fax: +86-371-3941700
  Email: wjw@mail.ndsc.com.cn

            or bstap2000@yahoo.com.cn

  =20

------=_NextPart_000_0008_01C4EE3B.06FE8080
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=EF=BB=BF<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns:v =3D "urn:schemas-microsoft-com:vml" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word"><HEAD><BASE=20
href=3D"file://C:\Program Files\Common Files\Microsoft =
Shared\Stationery\">
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8">
<META content=3DWord.Document name=3DProgId>
<META content=3D"MSHTML 6.00.2800.1458" name=3DGENERATOR>
<META content=3D"Microsoft Word 9" name=3DOriginator><LINK=20
href=3D"./=E9=AD=8F=E8=BF=9B=E6=AD=A6=E7=9A=84=E4=BF=A1=E7=BA=B8.files/fi=
lelist.xml" rel=3DFile-List><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Common</o:Author>
  <o:LastAuthor>Common</o:LastAuthor>
  <o:Revision>3</o:Revision>
  <o:TotalTime>6</o:TotalTime>
  <o:Created>2004-08-31T09:18:00Z</o:Created>
  <o:LastSaved>2004-08-31T09:26:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>73</o:Words>
  <o:Characters>419</o:Characters>
  <o:Company>HKZJZ</o:Company>
  <o:Lines>3</o:Lines>
  <o:Paragraphs>1</o:Paragraphs>
  <o:CharactersWithSpaces>514</o:CharactersWithSpaces>
  <o:Version>9.2812</o:Version>
 </o:DocumentProperties>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:DrawingGridVerticalSpacing>7.8 =
&#30917;</w:DrawingGridVerticalSpacing>
  <w:Compatibility>
   <w:UseFELayout/>
  </w:Compatibility>
 </w:WordDocument>
</xml><![endif]-->
<STYLE>@font-face {
	font-family: SimSun;
}
@font-face {
	font-family: SimSun;
}
@page  {mso-page-border-surround-header: no; =
mso-page-border-surround-footer: no; }
@page Section1 {size: 595.3pt 841.9pt; margin: 72.0pt 90.0pt 72.0pt =
90.0pt; mso-header-margin: 42.55pt; mso-footer-margin: 49.6pt; =
mso-paper-source: 0; }
BODY {
	BACKGROUND-POSITION: 0% 0%; COLOR: #000000; BACKGROUND-REPEAT: =
no-repeat
}
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
DIV.Section1 {
	page: Section1
}
</STYLE>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1027"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1"/>
 </o:shapelayout></xml><![endif]--></HEAD>
<BODY lang=3DZH-CN style=3D"tab-interval: 21.0pt" vLink=3Dpurple =
link=3Dblue=20
bgColor=3D#ffffff>
<DIV><SPAN class=3D588474214-30122004><FONT face=3DArial size=3D2>If you =
are using=20
MVL2.1 why do you have to port ppp_generic.c?</FONT></SPAN></DIV>
<DIV><SPAN class=3D588474214-30122004><FONT face=3DArial size=3D2>I have =
used the PPP=20
support already built-in to this kernel without</FONT></SPAN></DIV>
<DIV><SPAN class=3D588474214-30122004><FONT face=3DArial =
size=3D2>problem, even ported=20
wvdial/wvstreams to it.</FONT></SPAN></DIV>
<DIV><SPAN class=3D588474214-30122004><FONT face=3DArial=20
size=3D2>Cheers,</FONT></SPAN></DIV>
<DIV><SPAN class=3D588474214-30122004><FONT face=3DArial=20
size=3D2>T.mike</FONT></SPAN></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #000000 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Original Message-----<BR><B>From:</B>=20
  linuxppc-dev-bounces@ozlabs.org =
[mailto:linuxppc-dev-bounces@ozlabs.org]<B>On=20
  Behalf Of </B>Jinwu Wei(???)<BR><B>Sent:</B> Thursday, December 30, =
2004 12:11=20
  AM<BR><B>To:</B> linuxppc-dev@ozlabs.org<BR><B>Subject:</B> help me =
for: Oops:=20
  kernel access of bad area, sig: 11 <BR><B>Importance:</B>=20
  High<BR><BR></FONT></DIV>
  <DIV><FONT face=3D=E5=AE=8B=E4=BD=93 size=3D2></FONT>&nbsp;</DIV>
  <DIV style=3D"FONT: 9pt =E5=AE=8B=E4=BD=93">
  <DIV>Dear,</DIV></DIV>
  <DIV>&nbsp;</DIV>
  <DIV>&nbsp;&nbsp;&nbsp; Here is my problems,</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Our environmet is:</DIV>
  <DIV>&nbsp;&nbsp;&nbsp; OS: hardhat Linux 2.1</DIV>
  <DIV>&nbsp;&nbsp;&nbsp; platform: ppc lopec 7410</DIV>
  <DIV>&nbsp;&nbsp;&nbsp;&nbsp;uname -r : <FONT=20
  face=3DArial>2.4.17_mvl21-lopec</FONT></DIV>
  <DIV>&nbsp;&nbsp; </DIV>
  <DIV>&nbsp;&nbsp; When we port the ppp_generic.c(Which is a kernel =
module),=20
  and the program can be executed on host(redhat 7.2). Howerver, when we =

  complied it and runned on ppc lopec7410 (target) by the =
cross-developemnt=20
  enviornment, which can result in the machine down, and when wei return =
in the=20
  beginning of ppp_xmit_process(), the machine is not down but the =
following=20
  massages is printed in the /var/log/massages:</DIV>
  <DIV><EM></EM>&nbsp;</DIV>
  <DIV><EM>Dec 29 13:52:31 10 kernel: IN =
ppp_generic.c(ppp_write()):called=20
  function ppp_write () 0&nbsp; times! <BR>Dec 29 13:52:31 10 kernel: In =

  ppp_geberic.c(ppp_file_write()): the send device kind=20
  (pf-&gt;kind,1=3DINTERFACE,2=3DCHANNEL)is 1 <BR>Dec 29 13:52:31 10 =
kernel: In=20
  ppp_geberic.c(ppp_file_write()):After copy_from_user, the data from =
pppd to=20
  kernel space is : <BR>Dec 29 13:52:31 10 kernel:&nbsp; <BR>Dec 29 =
13:52:31 10=20
  kernel: c0 21 01 01 00 0a 02 06 00 00 00 00&nbsp; <BR>Dec 29 13:52:31 =
10=20
  kernel: IN ppp_GENERIC.c :ppp_xmit_process(),into this function&nbsp; =
<BR>Dec=20
  29 13:52:31 10 kernel: IN ppp_GENERIC.c=20
  :ppp_xmit_process(),ppp-&gt;xmit_pending is 0&nbsp; <BR>Dec 29 =
13:52:32 10=20
  kernel: Oops: kernel access of bad area, sig: 11 <BR>Dec 29 13:52:32 =
10=20
  kernel: NIP: C0012F4C XER: 00000000 LR: C0012F34 SP: DF61FE40 REGS: =
df61fd90=20
  TRAP: 0300&nbsp;&nbsp;&nbsp; Tainted: P&nbsp; <BR>Dec 29 13:52:32 10 =
kernel:=20
  MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11 <BR>Dec 29 13:52:32 10 =
kernel:=20
  DAR: 00000004, DSISR: 42000000 <BR>Dec 29 13:52:32 10 kernel: TASK =3D =

  df61e000[102] 'pppd' Last syscall: 142&nbsp; <BR>Dec 29 13:52:32 10 =
kernel:=20
  last math df61e000 last altivec df61e000 <BR>Dec 29 13:52:32 10 =
kernel: GPR00:=20
  00001032 DF61FE40 DF61E000 00000001 00009032 000000A5 DFDBEDE4 =
0001F618&nbsp;=20
  <BR>Dec 29 13:52:32 10 kernel: GPR08: 0000003C 00000000 DF619008 =
DF619014=20
  84244862 1004BE28 10040000 10040000&nbsp; <BR>Dec 29 13:52:32 10 =
kernel:=20
  GPR16: 10040000 10040000 10040000 10040000 00009032 DF61FEF8 DF61FE98=20
  0000012C&nbsp; <BR>Dec 29 13:52:32 10 kernel: GPR24: 00000006 00000000 =

  00000145 DF61FED8 C02B0984 DF61900C DF7A35E0 DF619000&nbsp; <BR>Dec 29 =

  13:52:32 10 kernel: Call backtrace:&nbsp; <BR>Dec 29 13:52:32 10 =
kernel:=20
  C0035128 C00516E0 E100379C C0051A28 C0051D30 C0009FD0 C000409C&nbsp; =
<BR>Dec=20
  29 13:52:32 10 kernel: 1001CBA8 10005EC0 100059B8 0FE69628 =
00000000</EM>&nbsp;=20
  </DIV>
  <DIV>&nbsp;</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>How to debug it and correcte it , Plese help me!</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Thanks a lot!</DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal><SPAN=20
  lang=3DEN-US>-------------------------------------------</SPAN></P>
  <P class=3DMsoNormal><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&nbsp;Best=20
  Regards<BR>&nbsp;<BR></SPAN><SPAN lang=3DEN-US=20
  style=3D"mso-bidi-font-size: 10.0pt">&nbsp;Dr. Jinwu Wei</SPAN><SPAN =
lang=3DEN-US=20
  style=3D"FONT-SIZE: =
10pt"><BR>&nbsp;<BR>-----------------------------------------------------=
------------<BR>&nbsp;<BR>National=20
  Digital Switching System <BR>Engineering &amp; Technology R&amp;D =
Center=20
  (NDSC),<BR>Jianxue street 7#, Box:1001, =
No.783,<BR>Zhengzhou,&nbsp;&nbsp;=20
  450002.<BR>Henan province, P.R. China.<BR>&nbsp;<BR>Tel:=20
  +86-371-3532873<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN lang=3DEN-US style=3D"FONT-SIZE: 10pt">Fax: =

  +86-371-3941700<BR>Email: <A=20
  =
href=3D"mailto:wjw@mail.ndsc.com.cn">wjw@mail.ndsc.com.cn</A><o:p></o:p><=
/SPAN></P>
  <P class=3DMsoNormal><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt"><SPAN=20
  style=3D"mso-spacerun: =
yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  </SPAN>or <A=20
  =
href=3D"mailto:bstap2000@yahoo.com.cn">bstap2000@yahoo.com.cn</A><o:p></o=
:p></SPAN></P>
  <P class=3DMsoNormal><SPAN=20
  lang=3DEN-US><![if =
!supportEmptyParas]><![endif]>&nbsp;<o:p></o:p></SPAN></P></DIV></BLOCKQU=
OTE></BODY></HTML>

------=_NextPart_000_0008_01C4EE3B.06FE8080--
