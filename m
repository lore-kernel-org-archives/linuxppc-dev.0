Return-Path: <Haiying.Wang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 67B5A67B59
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Aug 2006 01:05:43 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7UGOfOA022032 for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 10:24:41 -0600 (MDT)
Received: from az33exm23.fsl.freescale.net (az33exm23.am.freescale.net
	[10.64.32.8])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7UF5eSS020725
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 10:05:41 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6CC45.C1743ED2"
Subject: RE: Some problem about code reading 
Date: Wed, 30 Aug 2006 08:05:39 -0700
Message-ID: <DDEDA444F5BF0E41AC8649FB40392C2901926250@az33exm23.fsl.freescale.net>
In-Reply-To: <002f01c6cc3a$a0788420$a309a8c0@SZD823>
From: "Wang Haiying-r54964" <Haiying.Wang@freescale.com>
To: "enorm" <enorm@126.com>, <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6CC45.C1743ED2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,=20
=20
please read the following from MPC85xx UM about the sequence on how to
write CCSRBAR:
=20
*************************************
When the e500 core is writing to CCSRBAR, it should use the following
sequence:

- Read the current value of CCSRBAR using a load word instruction
followed by an

    isync. This forces all accesses to configuration space to complete.

- Write the new value to CCSRBAR.

- Perform a load of an address that does not access configuration space
or the on-chip

SRAM, but has an address mapping already in effect (for example, boot
ROM).

Follow this load with an isync.

- Read the contents of CCSRBAR from its new location, followed by
another isync

instruction.

****************************************

The codes  between line 287-294 complete the third step above.

=20
Haiying=20



________________________________

	From:
linuxppc-embedded-bounces+haiying.wang=3Dfreescale.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+haiying.wang=3Dfreescale.com@ozlabs.org=
]
On Behalf Of enorm
	Sent: Wednesday, August 30, 2006 9:46 AM
	To: linuxppc-embedded@ozlabs.org
	Subject: Some problem about code reading=20
=09
=09
	Hi,
	  I met some problems when reading sourcecode of u-boot 1.1.4
(for mpc85xx)
	=20
	file /cpu/mpc85xx/start.s line 276
	=20
	=20
	276.    #if (CFG_CCSRBAR_DEFAULT !=3D CFG_CCSRBAR)
	277.    /* Special sequence needed to update CCSRBAR itself */
	278.    lis r4, CFG_CCSRBAR_DEFAULT@h
	279.    ori r4, r4, CFG_CCSRBAR_DEFAULT@l
	280.
	281.    lis r5, CFG_CCSRBAR@h
	282.    ori r5, r5, CFG_CCSRBAR@l
	283.    srwi r6,r5,12
	284.    stw r6, 0(r4)
	285.    isync
	286.
	287.     lis r5, 0xffff
	288.     ori r5,r5,0xf000
	289.     lwz r5, 0(r5)
	290.     isync
	291.
	292.    lis r3, CFG_CCSRBAR@h
	293.    lwz r5, CFG_CCSRBAR@l(r3)
	294.     isync
	295.    #endif
	=20
	=20
	I think it means if we don't use default CCSRBAR, we put the
CCSRBAR addr actually used to the proper place in default CCSRBAR, so
that it can jump to the addr we want to automatically.(line 276-286).
	=20
	But, I don't know what line 287-294 does. Can some one tell me
pls?=20
	Thanks for your help.=20
	=20


------_=_NextPart_001_01C6CC45.C1743ED2
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D602505014-30082006>Hi, </SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D602505014-30082006></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D602505014-30082006>please read the following from MPC85xx UM =
about the=20
sequence on how to write CCSRBAR:</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D602505014-30082006></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D602505014-30082006>*************************************</SPAN></=
FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT><SPAN class=3D602505014-30082006>
<P align=3Dleft><FONT face=3DArial color=3D#0000ff size=3D2>When the =
e500 core is=20
writing to CCSRBAR, it should use the following sequence:</FONT></P>
<P align=3Dleft><FONT face=3DArial color=3D#0000ff size=3D2>&#8211; Read =
the current value of=20
CCSRBAR using a load word instruction followed by an</FONT></P><B>
<P align=3Dleft><FONT color=3D#0000ff><FONT face=3DArial><FONT =
size=3D2><SPAN=20
class=3D602505014-30082006>&nbsp;&nbsp;&nbsp;=20
</SPAN>isync</FONT></FONT></FONT></B><FONT face=3DArial color=3D#0000ff =
size=3D2>.=20
This forces all accesses to configuration space to complete.</FONT></P>
<P align=3Dleft><FONT face=3DArial color=3D#0000ff size=3D2>&#8211; =
Write the new value to=20
CCSRBAR.</FONT></P>
<P align=3Dleft><FONT face=3DArial color=3D#0000ff size=3D2>&#8211; =
Perform a load of an=20
address that does not access configuration space or the =
on-chip</FONT></P>
<P align=3Dleft><FONT face=3DArial color=3D#0000ff size=3D2>SRAM, but =
has an address=20
mapping already in effect (for example, boot ROM).</FONT></P>
<P align=3Dleft><FONT face=3DArial><FONT size=3D2><FONT =
color=3D#0000ff>Follow this load=20
with an </FONT><B><FONT color=3D#0000ff>isync</FONT></B><FONT=20
color=3D#0000ff>.</FONT></FONT></FONT></P>
<P align=3Dleft><FONT face=3DArial><FONT size=3D2><FONT =
color=3D#0000ff>&#8211; Read the=20
contents of CCSRBAR from its new location, followed by another =
</FONT><B><FONT=20
color=3D#0000ff>isync</FONT></P></B></FONT></FONT>
<P align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2>instruction.</FONT></P>
<P align=3Dleft><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D602505014-30082006>****************************************</SPAN=
></FONT></P>
<P align=3Dleft></SPAN></FONT><SPAN =
class=3D602505014-30082006></SPAN><FONT=20
face=3DArial><FONT size=3D2><FONT color=3D#0000ff>The&nbsp;code<SPAN=20
class=3D602505014-30082006>s</SPAN>&nbsp;</FONT>&nbsp;<SPAN=20
class=3D602505014-30082006><FONT color=3D#0000ff>between line 287-294 =
complete the=20
third step above.</FONT></SPAN></FONT></FONT></P></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D602505014-30082006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D602505014-30082006>Haiying </SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT><FONT =
face=3DArial color=3D#0000ff=20
size=3D2></FONT><BR></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B>=20
  linuxppc-embedded-bounces+haiying.wang=3Dfreescale.com@ozlabs.org=20
  =
[mailto:linuxppc-embedded-bounces+haiying.wang=3Dfreescale.com@ozlabs.org=
] <B>On=20
  Behalf Of </B>enorm<BR><B>Sent:</B> Wednesday, August 30, 2006 9:46=20
  AM<BR><B>To:</B> linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> Some =
problem=20
  about code reading <BR></FONT><BR></DIV>
  <DIV></DIV>
  <DIV><FONT size=3D2>Hi,</FONT></DIV>
  <DIV><FONT size=3D2>&nbsp; I met some problems when reading sourcecode =
of u-boot=20
  1.1.4 (for mpc85xx)</FONT></DIV>
  <DIV><FONT size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT size=3D2>file /cpu/mpc85xx/start.s line 276</FONT></DIV>
  <DIV><FONT size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT size=3D2>276.&nbsp;&nbsp;&nbsp; #if (CFG_CCSRBAR_DEFAULT =
!=3D=20
  CFG_CCSRBAR)<BR>277.&nbsp;&nbsp;&nbsp; /* Special sequence needed to =
update=20
  CCSRBAR itself */<BR>278.&nbsp;&nbsp;&nbsp; lis&nbsp;r4, <A=20
  =
href=3D"mailto:CFG_CCSRBAR_DEFAULT@h">CFG_CCSRBAR_DEFAULT@h</A><BR>279.&n=
bsp;&nbsp;&nbsp;=20
  ori&nbsp;r4, r4, <A=20
  =
href=3D"mailto:CFG_CCSRBAR_DEFAULT@l">CFG_CCSRBAR_DEFAULT@l</A></FONT></D=
IV>
  <DIV><FONT size=3D2>280.</FONT></DIV>
  <DIV><FONT size=3D2>281.&nbsp;&nbsp;&nbsp; lis&nbsp;r5, <A=20
  =
href=3D"mailto:CFG_CCSRBAR@h">CFG_CCSRBAR@h</A><BR>282.&nbsp;&nbsp;&nbsp;=
=20
  ori&nbsp;r5, r5, <A=20
  =
href=3D"mailto:CFG_CCSRBAR@l">CFG_CCSRBAR@l</A><BR>283.&nbsp;&nbsp;&nbsp;=
=20
  srwi&nbsp;r6,r5,12<BR>284.&nbsp;&nbsp;&nbsp; stw&nbsp;r6,=20
  0(r4)<BR>285.&nbsp;&nbsp;&nbsp; isync</FONT></DIV>
  <DIV><FONT size=3D2>286.</FONT></DIV>
  <DIV><FONT size=3D2>287.&nbsp;&nbsp;&nbsp; &nbsp;lis&nbsp;r5,=20
  0xffff<BR>288.&nbsp;&nbsp;&nbsp;=20
  &nbsp;ori&nbsp;r5,r5,0xf000<BR>289.&nbsp;&nbsp;&nbsp;&nbsp; =
lwz&nbsp;r5,=20
  0(r5)<BR>290.&nbsp;&nbsp;&nbsp; &nbsp;isync</FONT></DIV>
  <DIV><FONT size=3D2>291.</FONT></DIV>
  <DIV><FONT size=3D2>292.&nbsp;&nbsp;&nbsp; lis&nbsp;r3, <A=20
  =
href=3D"mailto:CFG_CCSRBAR@h">CFG_CCSRBAR@h</A><BR>293.&nbsp;&nbsp;&nbsp;=
=20
  lwz&nbsp;r5, <A=20
  =
href=3D"mailto:CFG_CCSRBAR@l(r3">CFG_CCSRBAR@l(r3</A>)<BR>294.&nbsp;&nbsp=
;&nbsp;=20
  &nbsp;isync<BR>295.&nbsp;&nbsp;&nbsp; #endif</FONT></DIV>
  <DIV><FONT size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT size=3D2>I think it means if we don't use default CCSRBAR, =
we put the=20
  CCSRBAR addr actually used to the proper place in default CCSRBAR, so =
that it=20
  can jump to the addr we want to automatically.(line =
276-286).</FONT></DIV>
  <DIV><FONT size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT size=3D2>But, I don't know what line 287-294 does.&nbsp;Can =
some one=20
  tell me pls?&nbsp;</FONT></DIV>
  <DIV><FONT size=3D2>Thanks for your help.</FONT>&nbsp;</DIV>
  <DIV><FONT size=3D2></FONT>&nbsp;</DIV></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C6CC45.C1743ED2--
