Return-Path: <gianfranco.casanova@alice.it>
Received: from smtp-out112.alice.it (smtp-out112.alice.it [85.37.17.112])
	by ozlabs.org (Postfix) with ESMTP id DEE7EDDEE1
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 22:50:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C91D79.F444F3E0"
Subject: PSC-SPI and MMC-SPI driver on lite5200b EVB. Device registration
	problems.
Date: Tue, 23 Sep 2008 14:43:18 +0200
Message-ID: <47602D18F269934AB73B7E550804A1E002137944@FBCMST09V03.fbc.local>
From: <gianfranco.casanova@alice.it>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C91D79.F444F3E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi guys

I'm using a lite5200b EVB (u-boot 1.2, kernel 2.6.26.3), using the =
psc-spi driver and the mmc-spi driver.

I've modified the lite5200b.dts file, I'd have SPI on PSC6 and mmc_spi =
connected to SPI on PSC6

first I've commented=20

//		spi@f00 {
//			compatible =3D "fsl,mpc5200b-spi","fsl,mpc5200-spi";
//			reg =3D <0xf00 0x20>;
//			interrupts =3D <2 13 0 2 14 0>;
//			interrupt-parent =3D <&mpc5200_pic>;
//		};

and then uncommented

		// PSC6 in spi mode example
		spi@2c00 {		// PSC6
			compatible =3D "fsl,mpc5200b-psc-spi","fsl,mpc5200-psc-spi";
			cell-index =3D <5>;
			reg =3D <0x2c00 0x100>;
			interrupts =3D <2 4 0>;
			interrupt-parent =3D <&mpc5200_pic>;
			mmc_spi@0 {
				linux,modalias =3D "mmc_spi";
			};
		};

I've also added a node to spi@2c00 (I'm not sure about last change).

My question are:
a) Is this the right way to insert a node in device tree (in this =
example for mmc-spi) or there are an other way to pass the information =
to mmc-spi that SPI is on PSC6?

b) Why in /proc/devices I do not see any spi device (mpc5200b-psc-spi) =
or something like that?
Adding some printk I have:
Fun =3D mpc52xx_psc_spi_init Ret =3D 0
Is my of_register_platform_driver was ok.

c) BTW a Block device mmc in /proc/devices is added (not mmc-spi as I'm =
waiting), if I try to create a node and then write on device nothing =
happens.

Any suggestion?

Thanks J

------_=_NextPart_001_01C91D79.F444F3E0
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
<TITLE>PSC-SPI and MMC-SPI driver on lite5200b EVB. Device registration =
problems.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi guys<BR>
<BR>
I'm using a lite5200b EVB (u-boot 1.2, kernel 2.6.26.3), using the =
psc-spi driver and the mmc-spi driver.<BR>
<BR>
I've modified the lite5200b.dts file, I'd have SPI on PSC6 and mmc_spi =
connected to SPI on PSC6<BR>
<BR>
first I've commented<BR>
<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi@f00 {<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;fsl,mpc5200b-spi&quot;,&quot;fsl,mpc5200-spi&quot;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0xf00 =
0x20&gt;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt;2 13 0 2 =
14 0&gt;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;mpc5200_pic&gt;;<BR>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
<BR>
and then uncommented<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PSC6 in spi mode =
example<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi@2c00 =
{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // PSC6<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;fsl,mpc5200b-psc-spi&quot;,&quot;fsl,mpc5200-psc-spi&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cell-index =3D &lt;5&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0x2c00 =
0x100&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt;2 4 =
0&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;mpc5200_pic&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmc_spi@0 {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linux,modalias =3D =
&quot;mmc_spi&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
<BR>
I've also added a node to spi@2c00 (I'm not sure about last change).<BR>
<BR>
My question are:<BR>
a) Is this the right way to insert a node in device tree (in this =
example for mmc-spi) or there are an other way to pass the information =
to mmc-spi that SPI is on PSC6?<BR>
<BR>
b) Why in /proc/devices I do not see any spi device (mpc5200b-psc-spi) =
or something like that?<BR>
Adding some printk I have:<BR>
Fun =3D mpc52xx_psc_spi_init Ret =3D 0<BR>
Is my of_register_platform_driver was ok.<BR>
<BR>
c) BTW a Block device mmc in /proc/devices is added (not mmc-spi as I'm =
waiting), if I try to create a node and then write on device nothing =
happens.<BR>
<BR>
Any suggestion?<BR>
<BR>
Thanks J</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C91D79.F444F3E0--
