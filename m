Return-Path: <earl.olsen@dilithiumnetworks.com>
Received: from DHOST001-17.DEX001.intermedia.net (dhost001-17.intermedia.net
	[64.78.61.64]) by ozlabs.org (Postfix) with ESMTP id E39F1683FF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Oct 2005 07:21:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5C9F2.AF6FBE63"
Date: Wed, 5 Oct 2005 14:21:01 -0700
Message-ID: <B8561865DB141248943E2376D0E8521501420346@DHOST001-17.DEX001.intermedia.net>
From: "Earl Olsen" <earl.olsen@dilithiumnetworks.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: problems with dma_alloc_coherent and consistent_alloc 
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

------_=_NextPart_001_01C5C9F2.AF6FBE63
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


(Sorry, I had trouble outlook and messed up the subject line)

We are using a PPC 750 with 512m of RAM. =20

1) When we try to allocate memory using consistent_alloc we get a=20
failure with get_pteptr - there is no pte. =20

2) When we try using dma_alloc_coherent the system locks up when
we try to access that memory.

I'm guessing these problems stem from the memory being allocated
is from the 384 bytes of RAM that gets handed over to BATs 2 AND 3,
not the remaining memory handled by the page table.

In the first case, pages are allocated, but since if came from the
BAT region, will not have a page table mapping.

In the second case, if dma_alloc_init gets memory from the BAT
region, then we have the BAT and page management mechanisms
both trying to control the memory.

Does this sound like a good theory?  Has anybody encountered
this problem before?

Thanks

--
Earl Olsen
Senior Software Engineer
Dilithium Networks, Inc.
TEL:+1 707-792-3925
earl.olsen@dilithiumnetworks.com
www.dilithiumnetworks.com

Communications for a Borderless World

This electronic message from Dilithium Networks contains information
which may be privileged or confidential. It is intended to be for the
use of the recipient(s) named above. If you are not the intended
recipient please return the message to the sender by replying to it and
then delete the message from your computer. Dilithium Networks shall not
be held liable to any person resulting from the use of any information
contained in this e-mail and shall not be liable to any person who acts
or omits to do anything in reliance upon it. Dilithium Networks does not
accept responsibility for changes made to this message after it was
sent.


------_=_NextPart_001_01C5C9F2.AF6FBE63
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE>problems with dma_alloc_coherent and consistent_alloc </TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">(Sorry, I had trouble outlook and =
messed up the subject line)</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">We are using a PPC 750 with 512m =
of RAM.&nbsp; </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">1) When we try to allocate memory =
using consistent_alloc we get a </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">failure with get_pteptr - there =
is no pte.&nbsp; </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">2) When we try using =
dma_alloc_coherent the system locks up when</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">we try to access that =
memory.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">I'm guessing these problems stem =
from the memory being allocated</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">is from the 384 bytes of RAM =
that gets handed over to BATs 2 AND 3,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">not the remaining memory handled =
by the page table.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">In the first case, pages are =
allocated, but since if came from the</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">BAT region, will not have a page =
table mapping.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">In the second case, if =
dma_alloc_init gets memory from the BAT</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">region, then we have the BAT and =
page management mechanisms</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">both trying to control the =
memory.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Does this sound like a good =
theory?&nbsp; Has anybody encountered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">this problem before?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Thanks</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">--</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Earl Olsen</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Senior Software Engineer</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Dilithium Networks</FONT><FONT =
SIZE=3D2 FACE=3D"Arial">, Inc.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">T</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">EL</FONT><FONT SIZE=3D2 FACE=3D"Arial">:+1 =
707-792-3925</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">e</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">arl.</FONT><FONT SIZE=3D2 FACE=3D"Arial">o</FONT><FONT =
SIZE=3D2 FACE=3D"Arial">lsen@dilithiumnetworks.com</FONT>

<BR><A HREF=3D"file://www.dilithiumnetworks.com"><U><FONT =
COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">www.dilithiumnetworks.com</FONT></U></A>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Communications for a Borderless =
World</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">This electronic message from Dilithium =
Networks contains information which may be privileged or confidential. =
It is intended to be for the use of the recipient(s) named above. If you =
are not the intended recipient please return the message to the sender =
by replying to it and then delete the message from your computer. =
Dilithium Networks shall not be held liable to any person resulting from =
the use of any information contained in this e-mail and shall not be =
liable to any person who acts or omits to do anything in reliance upon =
it. Dilithium Networks does not accept responsibility for changes made =
to this message after it was sent.</FONT></P>

</BODY>
</HTML>
------_=_NextPart_001_01C5C9F2.AF6FBE63--
