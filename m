Return-Path: <gianfranco.casanova@alice.it>
Received: from smtp-out25.alice.it (smtp-out25.alice.it [85.33.2.25])
	by ozlabs.org (Postfix) with ESMTP id 1683EDDDDF
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 19:44:40 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C94BB4.61ED2BBD"
Subject: R: R: USB on lite5200 does not work.
Date: Fri, 21 Nov 2008 09:36:29 +0100
Message-ID: <47602D18F269934AB73B7E550804A1E002137973@FBCMST09V03.fbc.local>
References: <47602D18F269934AB73B7E550804A1E00213796C@FBCMST09V03.fbc.local><fa686aa40811200656g783947f5l609650b707c6c883@mail.gmail.com><47602D18F269934AB73B7E550804A1E00213796F@FBCMST09V03.fbc.local>
	<fa686aa40811200749xd9f8701ud6ee9b77b4c21001@mail.gmail.com>
From: <gianfranco.casanova@alice.it>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"linuxppc-dev" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C94BB4.61ED2BBD
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Grant&Wolfgang

thanks for yours posts. You are right about WR. For lite5200 only few =
patchs have been used. Most of the job is for support other boards or to =
introduce some patchs for its debug system.

The main HW difference between our board and lite5200 is:
console on PSC3 and

port_config. On lite5200 defined as

	/* Set port config */
	port_config =3D in_be32(&gpio->port_config);

	port_config &=3D ~0x00800000;	/* 48Mhz internal, pin is GPIO	*/

	port_config &=3D ~0x00007000;	/* USB port : Differential mode	*/
	port_config |=3D  0x00001000;	/*            USB 1 only	*/

	port_config &=3D ~0x03000000;	/* ATA CS is on csb_4/5		*/
	port_config |=3D  0x01000000;

on our HW defined as:
	/* Radionav configuration */
	port_config =3D  0x0C712E66;

I still do not understand our bug with USB.
Have you got some suggestions or some test to be performed in order to =
find out a solutions?

Thanks J

-----Messaggio originale-----
Da: Grant Likely [mailto:grant.likely@secretlab.ca]
Inviato: gio 20/11/2008 16.49
A: gianfranco.casanova@alice.it; linuxppc-dev
Oggetto: Re: R: USB on lite5200 does not work.
=20
On Thu, Nov 20, 2008 at 8:33 AM,  <gianfranco.casanova@alice.it> wrote:
> I Grant
> I would but I cannot move up to an other kernel, project constraints.
>
> Complement of INFO:
> using a lite5200EVB USB works. using our board (kernel modified for =
our
> board), USB does not work.
>
> Have you got some ideas? I can send you what file have been modified =
(a
> couple).

Check your settings in the port config register.

Also, please remember to CC: the mailing list when replying to =
questions.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.


------_=_NextPart_001_01C94BB4.61ED2BBD
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.27">
<TITLE>R: R: USB on lite5200 does not work.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi Grant&amp;Wolfgang<BR>
<BR>
thanks for yours posts. You are right about WR. For lite5200 only few =
patchs have been used. Most of the job is for support other boards or to =
introduce some patchs for its debug system.<BR>
<BR>
The main HW difference between our board and lite5200 is:<BR>
console on PSC3 and<BR>
<BR>
port_config. On lite5200 defined as<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set port config */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_config =3D =
in_be32(&amp;gpio-&gt;port_config);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_config &amp;=3D =
~0x00800000;&nbsp;&nbsp;&nbsp;&nbsp; /* 48Mhz internal, pin is =
GPIO&nbsp; */<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_config &amp;=3D =
~0x00007000;&nbsp;&nbsp;&nbsp;&nbsp; /* USB port : Differential mode =
*/<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_config |=3D&nbsp; =
0x00001000;&nbsp;&nbsp;&nbsp;&nbsp; =
/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; USB =
1 only&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_config &amp;=3D =
~0x03000000;&nbsp;&nbsp;&nbsp;&nbsp; /* ATA CS is on csb_4/5 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_config |=3D&nbsp; =
0x01000000;<BR>
<BR>
on our HW defined as:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Radionav configuration =
*/<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_config =3D&nbsp; =
0x0C712E66;<BR>
<BR>
I still do not understand our bug with USB.<BR>
Have you got some suggestions or some test to be performed in order to =
find out a solutions?<BR>
<BR>
Thanks J<BR>
<BR>
-----Messaggio originale-----<BR>
Da: Grant Likely [<A =
HREF=3D"mailto:grant.likely@secretlab.ca">mailto:grant.likely@secretlab.c=
a</A>]<BR>
Inviato: gio 20/11/2008 16.49<BR>
A: gianfranco.casanova@alice.it; linuxppc-dev<BR>
Oggetto: Re: R: USB on lite5200 does not work.<BR>
<BR>
On Thu, Nov 20, 2008 at 8:33 AM,&nbsp; =
&lt;gianfranco.casanova@alice.it&gt; wrote:<BR>
&gt; I Grant<BR>
&gt; I would but I cannot move up to an other kernel, project =
constraints.<BR>
&gt;<BR>
&gt; Complement of INFO:<BR>
&gt; using a lite5200EVB USB works. using our board (kernel modified for =
our<BR>
&gt; board), USB does not work.<BR>
&gt;<BR>
&gt; Have you got some ideas? I can send you what file have been =
modified (a<BR>
&gt; couple).<BR>
<BR>
Check your settings in the port config register.<BR>
<BR>
Also, please remember to CC: the mailing list when replying to =
questions.<BR>
<BR>
g.<BR>
<BR>
--<BR>
Grant Likely, B.Sc., P.Eng.<BR>
Secret Lab Technologies Ltd.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C94BB4.61ED2BBD--
