Return-Path: <ncaruso@irobot.com>
Received: from irobot.com (smtp1.irobot.com [66.238.211.203])
	by ozlabs.org (Postfix) with ESMTP id 178D067A65
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 08:42:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C51470.639849BB"
Date: Wed, 16 Feb 2005 16:39:15 -0500
Message-ID: <712A2DEC228C7448978CBD7A7AD5B090592CFB@fever.wardrobe.irobot.com>
From: "Caruso, Nick" <ncaruso@irobot.com>
To: "Eric N. Johnson (ACD)" <ejohnson@acdstar.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: How to set a custom baud rate using 2.6 linux distro on MPC5200
	based board?
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

------_=_NextPart_001_01C51470.639849BB
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org on behalf of Eric N. Johnson =
(ACD)
Sent: Tue 2/15/2005 6:55 PM
To: linuxppc-embedded@ozlabs.org
Subject: Re: How to set a custom baud rate using 2.6 linux distro on =
MPC5200 based board?
=20

>I'm trying to set a custom baud rate (500KBaud, in case anyone cares) =
on=20
>one of the PSCs on a MPC5200 board.
[snip]
>   serial_info.flags =3D ASYNC_SPD_CUST | ASYNC_LOW_LATENCY;
>    serial_info.custom_divisor =3D 48;  // clock on FTDI chip / 48 =
=3D=3D 500KB
>
>    if ( ioctl(tty_fd, TIOCSSERIAL, &serial_info ) < 0) {
>      perror("config_serial_port: ioctl TIOCSSERIAL");
>      return(-1);
>    }
>
>This compiled fine under the ppc cross-dev tools we have but it fails =
with=20
>an "invalid argument" error when run on the ppc board.

It looks like this code was written for an FTDI serial port.  The FTDI =
is a=20
USB to Serial converter that handles baud rate generation very =
differently=20
from a standard UART.
_______________________________________________

Yes, it was originally written for a USB-to-serial adapter.  However it =
is my belief that the clock divisor thing works with any serial device, =
including so-called 16550 devices.=20

I think there may be a problem where TIOCSSERIAL doesn't work for the =
MPC5200 PSC uart code.  It seems that if I get the ports' attributes =
with TIOCGSERIAL and immediately set the same values on the same port I =
get an error return from the ioctl call.  I'm talking with our BSP =
vendor about this.

    best regards,=20

      Nick Caruso

------_=_NextPart_001_01C51470.639849BB
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
<TITLE>RE: How to set a custom baud rate using 2.6 linux distro on =
MPC5200 based board?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>-----Original Message-----<BR>
From: linuxppc-embedded-bounces@ozlabs.org on behalf of Eric N. Johnson =
(ACD)<BR>
Sent: Tue 2/15/2005 6:55 PM<BR>
To: linuxppc-embedded@ozlabs.org<BR>
Subject: Re: How to set a custom baud rate using 2.6 linux distro on =
MPC5200 based board?<BR>
<BR>
<BR>
&gt;I'm trying to set a custom baud rate (500KBaud, in case anyone =
cares) on<BR>
&gt;one of the PSCs on a MPC5200 board.<BR>
[snip]<BR>
&gt;&nbsp;&nbsp; serial_info.flags =3D ASYNC_SPD_CUST | =
ASYNC_LOW_LATENCY;<BR>
&gt;&nbsp;&nbsp;&nbsp; serial_info.custom_divisor =3D 48;&nbsp; // clock =
on FTDI chip / 48 =3D=3D 500KB<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp; if ( ioctl(tty_fd, TIOCSSERIAL, &amp;serial_info =
) &lt; 0) {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; perror(&quot;config_serial_port: =
ioctl TIOCSSERIAL&quot;);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return(-1);<BR>
&gt;&nbsp;&nbsp;&nbsp; }<BR>
&gt;<BR>
&gt;This compiled fine under the ppc cross-dev tools we have but it =
fails with<BR>
&gt;an &quot;invalid argument&quot; error when run on the ppc board.<BR>
<BR>
It looks like this code was written for an FTDI serial port.&nbsp; The =
FTDI is a<BR>
USB to Serial converter that handles baud rate generation very =
differently<BR>
from a standard UART.<BR>
_______________________________________________<BR>
<BR>
Yes, it was originally written for a USB-to-serial adapter.&nbsp; =
However it is my belief that the clock divisor thing works with any =
serial device, including so-called 16550 devices.<BR>
<BR>
I think there may be a problem where TIOCSSERIAL doesn't work for the =
MPC5200 PSC uart code.&nbsp; It seems that if I get the ports' =
attributes with TIOCGSERIAL and immediately set the same values on the =
same port I get an error return from the ioctl call.&nbsp; I'm talking =
with our BSP vendor about this.<BR>
<BR>
&nbsp;&nbsp;&nbsp; best regards,<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Nick Caruso<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C51470.639849BB--
