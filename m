Return-Path: <Lixin.Yao@HSTX.com>
Received: from mail.hstx.com (mail.hstx.com [64.95.133.106])
	by ozlabs.org (Postfix) with ESMTP id D638DB7B9A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Oct 2009 03:24:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA519F.CA11895E"
Subject: Device Tree Corrupted after unflatten_device_tree()
Date: Tue, 20 Oct 2009 09:10:06 -0700
Message-ID: <03D77CA4AC7F4D48A6AB5DA3F1001B3FB5BB88@exchtxus2.HSTX.global.vpn>
From: "Lixin Yao" <Lixin.Yao@HSTX.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA519F.CA11895E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I use a board with MPC866T and 2.6.28 Linux Kernel.  Occasionally, the
unflattened device is corrupted after "unflatten_device_tree()" which
causes crash of kernel when device tree is traversed later on.

I looked at the fixes in lib/lmb.c, arch/powerpc/mm, arch/powerpc/kernel
etc since 2.6.28 to 2.6.32-r4 (the most recent version) and could not
fix my problem.

I have had a hard time trying to determine the cause.=20

arch/powerpc/kernel/setup_32.c
void __init setup_arch(char **cmdline_p)
{
	*cmdline_p =3D cmd_line;

	/* so udelay does something sensible, assume <=3D 1000 bogomips */
	loops_per_jiffy =3D 500000000 / HZ;

	unflatten_device_tree();
	/* UNFLATTENED DEVICE TREE IS CORRUPTED SOMETIMES HERE */
	check_for_initrd();

   	......
}

Any ideas?

Thanks.

Lixin Yao
Harris Startex Networks Inc.
RTP, NC, USA

------_=_NextPart_001_01CA519F.CA11895E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>Device Tree Corrupted after unflatten_device_tree()</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">I use a =
board</FONT> <FONT FACE=3D"Calibri">with MPC866T and 2.6.28 Linux =
Kernel.</FONT>&nbsp;<FONT FACE=3D"Calibri"></FONT> <FONT =
FACE=3D"Calibri">Occa</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">s</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">ionally</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">, the unflattened</FONT></SPAN><SPAN LANG=3D"en-us"> =
<FONT FACE=3D"Calibri">device is corrupted after</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT FACE=3D"Calibri">&#8220;</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT =
FACE=3D"Calibri">unflatten_device_tree</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Calibri">()</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Calibri">&#8221;</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Calibri"> which causes crash of kernel when =
device tree is traversed</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri"> later on.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">I</FONT> <FONT =
FACE=3D"Calibri">looked at the fixes in</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT FACE=3D"Calibri">lib/lmb.c,</FONT><FONT =
FACE=3D"Calibri"> arch/powerpc/mm, arch/powerpc/kernel etc since 2.6.28 =
to 2.6.32</FONT><FONT FACE=3D"Calibri">-r4 (the most recent version) =
and</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT FACE=3D"Calibri">could not =
fix my problem</FONT></SPAN><SPAN LANG=3D"en-us">.</SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">I have had a =
hard time trying to determine the cause.</FONT></SPAN><SPAN =
LANG=3D"en-us"> </SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">arch/powerpc/kernel/</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Calibri">setup_32.c</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">void __init =
setup_arch(char **cmdline_p)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">{</FONT></SPAN></P>

<P DIR=3DLTR><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
FACE=3D"Calibri">*cmdline_p =3D cmd_line;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
FACE=3D"Calibri">/* so udelay does something sensible, assume &lt;=3D =
1000 bogomips */</FONT></SPAN></P>

<P DIR=3DLTR><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
FACE=3D"Calibri">loops_per_jiffy =3D 500000000 / HZ;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
FACE=3D"Calibri">unflatten_device_tree();</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
FACE=3D"Calibri">/*</FONT> <FONT FACE=3D"Calibri">UNFLATTENED</FONT> =
<FONT FACE=3D"Calibri">DEVICE TREE IS C</FONT><FONT =
FACE=3D"Calibri">ORRUPTED SOMETIMES HERE */</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
FACE=3D"Calibri">check_for_initrd();</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Calibri">&#8230;</FONT><FONT =
FACE=3D"Calibri">&#8230;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us">}</SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">Any =
ideas?</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Calibri">Thanks.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">Lixin =
Yao</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">Harris Startex =
Networks Inc.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Calibri">RTP</FONT><FONT =
FACE=3D"Calibri">, NC, USA</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01CA519F.CA11895E--
