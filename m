Return-Path: <kpoole@mrv.com>
Received: from mailserver.corp.int.mrv.com (mx2.lb.mrv.com [66.43.110.200])
	by ozlabs.org (Postfix) with ESMTP id BBE8567A0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 04:38:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C67397.C503617B"
Subject: IMAP_ADDR on PPC 8xx
Date: Tue, 9 May 2006 14:38:30 -0400
Message-ID: <4D8794260B62C940BBA7150CC5EB3BD43D23CA@bosmail.BOS.int.mrv.com>
From: "Kenneth Poole" <kpoole@mrv.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C67397.C503617B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

In our build, (currently based on 2.6.14.3) we define IMAP_ADDR as
follows:

#define	IMAP_ADDR	(((bd_t *)__res)->bi_immr_base)

With very few exceptions, nearly all driver code that dereferences
IMAP_ADDR can be used unchanged and the IMMR value is always the value
passed up from the bootloader. We build one image that runs on multiple
platforms and some platforms place the IMMR address space at different
addresses than others. It's not a constant.

Regardless, I see little reason to ioremap() the IMMR address. The MMU
is set up in such a way that IMMR based locations can be accessed
directly.

Ken Poole, MRV Communications, Inc.

> In a related vein, as I alluded to in my previous email, there has
been
> previous discussion on this list about the fact that it is frowned
upon
> for device drivers to directly dereference IMAP_ADDR.  Instead, I've
> seen a recommendation that each individual driver perform an
io_remap()
> operation on IMAP_ADDR and save the resulting kernel virtual address
in
> a driver-specific data structure.  Is this a universally-accepted
> viewpoint?  Is this something that the community agrees "should be
> fixed" and we're just waiting for someone (like me) to volunteer to
fix
> all the drivers?

> Or are there arguments in favor of keeping the direct IMAP_ADDR
> dereferences?  For example, if each driver performs its own separate
> io_remap(), doesn't that have potentially negative consequences on the
> VM system for some PPC implementations (e.g. increased contention for
> TLB entries)?

> Are these issues addressed by or otherwise impacted by other ongoing
PPC
> Linux work such as the "ppc" + "ppc64" --> "powerpc" effort / "flat
> device tree" stuff???


------_=_NextPart_001_01C67397.C503617B
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>IMAP_ADDR on PPC 8xx</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">In our build</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">,</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"> (currently based on 2.6.14.3)</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"> we define IMAP_ADDR =
as follows:</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">#define</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">IMAP_ADDR</FONT></SPAN><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Courier New">(((bd_t =
*)__res)-&gt;bi_immr_base)</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">With very few exceptions, nearly all driver code</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Courier New">that dereferences =
IMAP_ADDR</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">can be used unchanged and the IMMR value is =
always</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New"> the value passed up from the bootloader. We build one image that =
runs on multiple platforms and some platforms place the =
IMMR</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Courier =
New">address space</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">at different</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"> addresses than =
others. It</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Courier New">s not a constant.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">Regardless, I see little reason to ioremap() the IMMR address. The =
MMU is set up in such a way that IMMR based locations can be accessed =
directly.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">Ken Poole, MRV Communications, Inc.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">In a related vein, as I alluded to in my previous =
email, there has been</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">previous discussion on this list about the fact =
that it is frowned upon</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">for device drivers to directly dereference =
IMAP_ADDR.&nbsp; Instead, I've</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">seen a recommendation that each individual driver =
perform an io_remap()</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">operation on IMAP_ADDR and save the resulting =
kernel virtual address in</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">a driver-specific data structure.&nbsp; Is this a =
universally-accepted</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">viewpoint?&nbsp; Is this something that the =
community agrees &quot;should be</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">fixed&quot; and we're just waiting for someone =
(like me) to volunteer to fix</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">all the drivers?</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">Or are there arguments in favor of keeping the =
direct IMAP_ADDR</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">dereferences?&nbsp; For example, if each driver =
performs its own separate</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">io_remap(), doesn't that have potentially negative =
consequences on the</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">VM system for some PPC implementations (e.g. =
increased contention for</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">TLB entries)?</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">Are these issues addressed by or otherwise impacted =
by other ongoing PPC</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">Linux work such as the &quot;ppc&quot; + =
&quot;ppc64&quot; --&gt; &quot;powerpc&quot; effort / =
&quot;flat</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">device tree&quot; stuff???</FONT></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C67397.C503617B--
