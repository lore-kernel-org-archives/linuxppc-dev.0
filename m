Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 762FBB6F1A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 01:06:15 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5MF6BOt006165
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 08:06:11 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o5MF6G4f029262
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 10:06:17 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB121C.72C4C0F5"
Subject: Re: UCC UART
Date: Tue, 22 Jun 2010 08:06:10 -0700
Message-ID: <5610599F537DD74A8D1F5CC946A7507303478FD4@az33exm25.fsl.freescale.net>
In-Reply-To: <4C20CECB.9050609@mlbassoc.com>
References: <4C20CECB.9050609@mlbassoc.com>
From: "Tabi Timur-B04825" <B04825@freescale.com>
To: "Gary Thomas" <gary@mlbassoc.com>
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB121C.72C4C0F5
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Gary Thomas wrote:
> I'm still trying to get UCC UART to work on my MPC8358 with
> the 2.6.33.3 kernel.
>
> When I try to send data to the port, there is no output, not
> even any interrupts on the device. What I see is that the UART
> driver seems to initialize fine and pushes characters into
> the output buffers & descriptors. However, there are no
> interrupts hence it just sits there...
>
> My device tree entry for this device now looks like this:
> /* ttyQE0 (UCC3) */
> serial_qe0: serial@4000 {
> device_type =3D "serial";
> compatible =3D "ucc_uart";
> cell-index =3D <3>;
> reg =3D <0x2200 0x200>;
> interrupts =3D <34>;
> interrupt-parent =3D <&qeic>;
> port-number =3D <0>;
> rx-clock-name =3D "brg1";
> tx-clock-name =3D "brg1";
> };

You might try assigning different BRGs to TX and RX.

>
> * Are there any known issues with this driver?

Heh. :-)

I'd say that there are plenty of unknown issues with this =
driver/hardware.=20
For some reason, QE UART is just unreliable.  I've had several people =
try to=20
use the QE for UART, and almost everyone has problems with it.

> * Is there any way to get a handle on why no data is moving?

The QE is a black box.  If you're programming it correctly but it =
doesn't do=20
what it's supposed to, there's almost no way to debug it.

> * Is there some way to tell if the QE even sees the descriptors?

Not to my knowledge.

> * The driver and documentation mention a "soft UART" mode for
> chips with broken UART hardware. How do I know if my board
> has functioning UART hardware?

I believe only the 8323 and the 8360 have broken UARTs.  Those are the =
only=20
ones that have the microcode update that enable soft-UART, anyway.

>
> Note: I have UCC1+UCC2 working great with ethernet.
>
> Thanks for any pointers or ideas

You should contact Freescale support and ask them for help.  Even though =
I=20
wrote the Linux driver, I have no "inside" connection to the QE team =
here at=20
Freescale.

------_=_NextPart_001_01CB121C.72C4C0F5
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>Re: UCC UART</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Gary Thomas wrote:<BR>
&gt; I'm still trying to get UCC UART to work on my MPC8358 with<BR>
&gt; the 2.6.33.3 kernel.<BR>
&gt;<BR>
&gt; When I try to send data to the port, there is no output, not<BR>
&gt; even any interrupts on the device. What I see is that the UART<BR>
&gt; driver seems to initialize fine and pushes characters into<BR>
&gt; the output buffers &amp; descriptors. However, there are no<BR>
&gt; interrupts hence it just sits there...<BR>
&gt;<BR>
&gt; My device tree entry for this device now looks like this:<BR>
&gt; /* ttyQE0 (UCC3) */<BR>
&gt; serial_qe0: serial@4000 {<BR>
&gt; device_type =3D &quot;serial&quot;;<BR>
&gt; compatible =3D &quot;ucc_uart&quot;;<BR>
&gt; cell-index =3D &lt;3&gt;;<BR>
&gt; reg =3D &lt;0x2200 0x200&gt;;<BR>
&gt; interrupts =3D &lt;34&gt;;<BR>
&gt; interrupt-parent =3D &lt;&amp;qeic&gt;;<BR>
&gt; port-number =3D &lt;0&gt;;<BR>
&gt; rx-clock-name =3D &quot;brg1&quot;;<BR>
&gt; tx-clock-name =3D &quot;brg1&quot;;<BR>
&gt; };<BR>
<BR>
You might try assigning different BRGs to TX and RX.<BR>
<BR>
&gt;<BR>
&gt; * Are there any known issues with this driver?<BR>
<BR>
Heh. :-)<BR>
<BR>
I'd say that there are plenty of unknown issues with this =
driver/hardware.<BR>
For some reason, QE UART is just unreliable.&nbsp; I've had several =
people try to<BR>
use the QE for UART, and almost everyone has problems with it.<BR>
<BR>
&gt; * Is there any way to get a handle on why no data is moving?<BR>
<BR>
The QE is a black box.&nbsp; If you're programming it correctly but it =
doesn't do<BR>
what it's supposed to, there's almost no way to debug it.<BR>
<BR>
&gt; * Is there some way to tell if the QE even sees the =
descriptors?<BR>
<BR>
Not to my knowledge.<BR>
<BR>
&gt; * The driver and documentation mention a &quot;soft UART&quot; mode =
for<BR>
&gt; chips with broken UART hardware. How do I know if my board<BR>
&gt; has functioning UART hardware?<BR>
<BR>
I believe only the 8323 and the 8360 have broken UARTs.&nbsp; Those are =
the only<BR>
ones that have the microcode update that enable soft-UART, anyway.<BR>
<BR>
&gt;<BR>
&gt; Note: I have UCC1+UCC2 working great with ethernet.<BR>
&gt;<BR>
&gt; Thanks for any pointers or ideas<BR>
<BR>
You should contact Freescale support and ask them for help.&nbsp; Even =
though I<BR>
wrote the Linux driver, I have no &quot;inside&quot; connection to the =
QE team here at<BR>
Freescale.<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CB121C.72C4C0F5--
