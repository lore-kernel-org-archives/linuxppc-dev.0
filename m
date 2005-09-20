Return-Path: <earl.olsen@dilithiumnetworks.com>
Received: from DHOST001-17.DEX001.intermedia.net (dhost001-17.intermedia.net
	[64.78.61.64]) by ozlabs.org (Postfix) with ESMTP id 3F64768377
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 02:02:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5BDFC.BD809CF2"
Date: Tue, 20 Sep 2005 09:02:45 -0700
Message-ID: <B8561865DB141248943E2376D0E85215014202FE@DHOST001-17.DEX001.intermedia.net>
From: "Earl Olsen" <earl.olsen@dilithiumnetworks.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: GT64260_eth (Ethernet) Driver
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

------_=_NextPart_001_01C5BDFC.BD809CF2
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Does anybody know if this issue was solved?
I'm running into the exact same problem with 2.6.10.

Thanks


Dieu Morales wrote:

>Greetings, I am working with the latest 2.6.7 kernel
>source on a ppc radstone PPC7A board and was curious
>if anyone was in the process or planned on porting the
>gt64260_eth driver to support the 2.6.x kernel.
>
>Not being familiar with the gt64260 Ethernet device or
>code, I plan to take it line by line. I have attempted
>to use the driver from the ppc.bkbits.net 2.4
>development tree and currently have only changed the
>dev =3D init_etherdev(dev, sizeof (gt_eth_priv));
>to
>dev =3D alloc_etherdev(sizeof (gt_eth_priv_struct ));
>Shortly after, when attempting to allocate the Tx and
>Rx page buffers, I get an exception in the
>uncachedPages function.  I have traced the problem to
>the pmd_present=F2(*pmd) function in va_to_pte(addr)
>returning 0.  I dumped the values of pmd, init_mm, and
>pmd in the va_to_pte() and the values seemed O.K., so
>I commented out the pmd_present=F2(*pmd) check but was
>once again stopped by the pte_present(*pte) check.  I
>have seen the driver operate under 2.4.26 dev tree
>from ppc.bkbits.net where this problem does not occur.
>One difference I have noticed is that during
>initialization of the 2.6.7 kernel, I do not get the
>following output.
>Buffer-cache hash table entries:
>Page-cache hash table entries:
>The filemap.c, where the "Page-cache " printk resides
>in 2.4, looks heavily reworked, so I don't suspect
>this is an issue?
>
>
Dieu,

You should sync up with Brian Waite (look at CC: list) who has been
looking at writing a new enet driver for the 2.6 kernel using the latest
bridge support code.  You can get a look at the latest support code by
cloning bk://source.mvista.com/linux-2.5-marvell.  Note the the mpsc
driver that's there still isn't working correctly.

Mark


--
Earl Olsen
Senior Software Engineer
Dilithium Networks, Inc.
TEL:+1 707-792-3925
earl.olsen@dilithiumnetworks.com
www.dilithiumnetworks.com

Communications for a Borderless World

This electronic message from Dilithium Networks contains information =
which may be privileged or confidential. It is intended to be for the =
use of the recipient(s) named above. If you are not the intended =
recipient please return the message to the sender by replying to it and =
then delete the message from your computer. Dilithium Networks shall not =
be held liable to any person resulting from the use of any information =
contained in this e-mail and shall not be liable to any person who acts =
or omits to do anything in reliance upon it. Dilithium Networks does not =
accept responsibility for changes made to this message after it was =
sent.


------_=_NextPart_001_01C5BDFC.BD809CF2
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE>GT64260_eth (Ethernet) Driver</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Does anybody know if this issue =
was solved?</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">I'm running into the exact same =
problem with 2.6.10.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Thanks</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Dieu Morales wrote:<BR>
<BR>
&gt;<I>Greetings, I am working with the latest 2.6.7 kernel<BR>
</I>&gt;<I>source on a ppc radstone PPC7A board and was curious<BR>
</I>&gt;<I>if anyone was in the process or planned on porting the<BR>
</I>&gt;<I>gt64260_eth driver to support the 2.6.x kernel.<BR>
</I>&gt;<I><BR>
</I>&gt;<I>Not being familiar with the gt64260 Ethernet device or<BR>
</I>&gt;<I>code, I plan to take it line by line. I have attempted<BR>
</I>&gt;<I>to use the driver from the ppc.bkbits.net 2.4<BR>
</I>&gt;<I>development tree and currently have only changed the<BR>
</I>&gt;<I>dev =3D init_etherdev(dev, sizeof (gt_eth_priv));<BR>
</I>&gt;<I>to<BR>
</I>&gt;<I>dev =3D alloc_etherdev(sizeof (gt_eth_priv_struct ));<BR>
</I>&gt;<I>Shortly after, when attempting to allocate the Tx and<BR>
</I>&gt;<I>Rx page buffers, I get an exception in the<BR>
</I>&gt;<I>uncachedPages function.&nbsp; I have traced the problem =
to<BR>
</I>&gt;<I>the pmd_present=F2(*pmd) function in va_to_pte(addr)<BR>
</I>&gt;<I>returning 0.&nbsp; I dumped the values of pmd, init_mm, =
and<BR>
</I>&gt;<I>pmd in the va_to_pte() and the values seemed O.K., so<BR>
</I>&gt;<I>I commented out the pmd_present=F2(*pmd) check but was<BR>
</I>&gt;<I>once again stopped by the pte_present(*pte) check.&nbsp; =
I<BR>
</I>&gt;<I>have seen the driver operate under 2.4.26 dev tree<BR>
</I>&gt;<I>from ppc.bkbits.net where this problem does not occur.<BR>
</I>&gt;<I>One difference I have noticed is that during<BR>
</I>&gt;<I>initialization of the 2.6.7 kernel, I do not get the<BR>
</I>&gt;<I>following output.<BR>
</I>&gt;<I>Buffer-cache hash table entries:<BR>
</I>&gt;<I>Page-cache hash table entries:<BR>
</I>&gt;<I>The filemap.c, where the &quot;Page-cache &quot; printk =
resides<BR>
</I>&gt;<I>in 2.4, looks heavily reworked, so I don't suspect<BR>
</I>&gt;<I>this is an issue?<BR>
</I>&gt;<I><BR>
</I>&gt;<I><BR>
</I>Dieu,<BR>
<BR>
You should sync up with Brian Waite (look at CC: list) who has been<BR>
looking at writing a new enet driver for the 2.6 kernel using the =
latest<BR>
bridge support code.&nbsp; You can get a look at the latest support code =
by<BR>
cloning bk://source.mvista.com/linux-2.5-marvell.&nbsp; Note the the =
mpsc<BR>
driver that's there still isn't working correctly.<BR>
<BR>
Mark</FONT>
</P>
<BR>

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
------_=_NextPart_001_01C5BDFC.BD809CF2--
