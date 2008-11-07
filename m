Return-Path: <s104259@yahoo.it>
Received: from web23104.mail.ird.yahoo.com (web23104.mail.ird.yahoo.com
	[217.146.189.44]) by ozlabs.org (Postfix) with SMTP id 134CEDDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Nov 2008 23:16:59 +1100 (EST)
Date: Fri, 7 Nov 2008 12:10:17 +0000 (GMT)
From: Angelo <s104259@yahoo.it>
Subject: Serial console on board based on Lite5200b
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <31090.73221.qm@web23104.mail.ird.yahoo.com>
Reply-To: s104259@yahoo.it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, I have a board based on the Lite5200b, except that the serial console i=
s on PSC4 instead of PSC1.=20

Using the a custom U-boot (1.2.0) and kernel 2.6.21 (compiled for powerpc),=
 I managed to get U-boot to output on the console on PSC4, but the kernel
does not.

I had just modified lite5200b.dts in some points:

1- My memory is 128Mb
2- I don't need eth,mdio,ata so I had commented
3- Enable PSC4
4- Added the chosen node:

chosen {
      linux,stdout-path =3D "/soc5200@f0000000/serial@2600";
      bootargs =3D "console=3DttyPSC4,115200";=20
};

Debugging my board i notified that u-boot read & modify the device tree blo=
b adding the chosen node:
chosen{                                                                   =
=20
  name =3D "chosen";                                                       =
=20
  bootargs =3D "console=3DttyPSC3";
  linux,platform =3D <600>;
  linux,initrd-start =3D <7e2e000>;
  linux,initrd-end =3D <7f0fbf2>;
  linux,stdout-path =3D "/soc5200@f0000000/serial@2600";
};=20

I follow step by step the kernel start procedure.. and I notify that in set=
up_arch funtion is called find_legacy_serial_ports, but when is done if(leg=
acy_serial_console >=3D 0)=20
legacy_serial_console is equal to -1.

However, it is not sufficient.  What am I missing?

Thank you!
=0A=0A=0A      Unisciti alla community di Io fotografo e video, il nuovo co=
rso di fotografia di Gazzetta dello sport:=0Ahttp://www.flickr.com/groups/i=
ofotografoevideo
