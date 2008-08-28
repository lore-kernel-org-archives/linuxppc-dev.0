Return-Path: <ralf.muller@nsn.com>
Received: from demumfd002.nsn-inter.net (demumfd002.nsn-inter.net
	[217.115.75.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DF080DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 16:55:58 +1000 (EST)
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
	by demumfd002.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id
	m7S6bana013820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Thu, 28 Aug 2008 08:37:36 +0200
Received: from demuexc023.nsn-intra.net (webmail.nsn-intra.net [10.150.128.36])
	by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP
	id m7S6baSH001546
	for <linuxppc-embedded@ozlabs.org>; Thu, 28 Aug 2008 08:37:36 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C908D8.8E5C58A3"
Subject: Virtual IRQs on 82xx
Date: Thu, 28 Aug 2008 09:37:34 +0300
Message-ID: <F9730D1BBC18E749AE72728B74D189E968356A@FIESEXC006.nsn-intra.net>
From: "Muller, Ralf (NSN - FI/Espoo)" <ralf.muller@nsn.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C908D8.8E5C58A3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm using a 8247 custom board and kernl 2.6.21.7 on the arch/powerpc
branch. Here the irq are virtualized  in the irq map functions now I'm
facing several problems.
* I have to manually call irq_create_of_mapping for each CPM interrupt
* The irq_map structure, which associates virtual to HW IRQs is not
initialized auto matically
* The reverse map isn't initialized

And the major problem is:
Now the kernel mixes virtual- and HW-IRQs, e.g. request_irq works with
HW_IRQs but the interrupt handler with virtual interrupts, which can't
work.
For some reason even on a powerpc the first 16 interrupts are reserved
for legacy (PC) IRQs, so the easiest mapping HW-IRQ0 -> VIRQ16 a.s.o
Is there an solution available for this problem, at least for it looks
like the problem still persists in 2.6.26?

Regards,
Ralf


------_=_NextPart_001_01C908D8.8E5C58A3
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.2">
<TITLE>Virtual IRQs on 82xx</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"fi"><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT></SPAN>
</P>

<P><SPAN LANG=3D"fi"><FONT SIZE=3D2 FACE=3D"Arial">I'm using a 8247 =
custom board and kernl 2.6.21.7 on the arch/powerpc branch. Here the irq =
are virtualized&nbsp; in the irq map functions now I'm facing several =
problems.</FONT></SPAN></P>

<P><SPAN LANG=3D"fi"><FONT SIZE=3D2 FACE=3D"Arial">* I have to manually =
call irq_create_of_mapping for each CPM interrupt</FONT></SPAN>

<BR><SPAN LANG=3D"fi"><FONT SIZE=3D2 FACE=3D"Arial">* The irq_map =
structure, which associates virtual to HW IRQs is not initialized auto =
matically</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">* The reverse map =
isn't initialized</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">And the major =
problem is:</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Now the kernel =
mixes virtual- and HW-IRQs, e.g. request_irq works with HW_IRQs but the =
interrupt handler with virtual interrupts, which can't =
work.</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">For some reason =
even on a powerpc the first 16 interrupts are reserved for legacy (PC) =
IRQs, so the easiest mapping HW-IRQ0 -&gt; VIRQ16 =
a.s.o</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Is there an =
solution available for this problem, at least for it looks like the =
problem still persists in 2.6.26?</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">Regards,</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">Ralf</FONT></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C908D8.8E5C58A3--
