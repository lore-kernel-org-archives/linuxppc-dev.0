Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85954DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 14:16:35 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IHu19-00020P-6U
	for linuxppc-embedded@ozlabs.org; Sun, 05 Aug 2007 21:16:31 -0700
Message-ID: <12010845.post@talk.nabble.com>
Date: Sun, 5 Aug 2007 21:16:31 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Uncompressing Kernel Image ... Error: inflate() returned -3
	GUNZIP ERROR - must RESET board to recover
In-Reply-To: <137d01c6e288$844fcdd0$8119fea9@deltatau.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <20060926064451.71706.qmail@web26012.mail.ukl.yahoo.com>
	<HOECLKEKOHLAMMGDLLBHGEKJHLAA.stelios@stelioscellar.com>
	<137d01c6e288$844fcdd0$8119fea9@deltatau.local>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


change ur bootm address it will work fine....

see the fallowing example..

Linux crashes when uncompressing the kernel
Question:
When I try to boot Linux, it crashes during uncompressing the kernel image:
=3D> bootm 100000
## Booting image at 00100000 ...
Image Name: Linux=E2=88=922.4.25
Image Type: PowerPC Linux Kernel Image (gzip compressed)
Data Size: 1003065 Bytes =3D 979.6 kB
Load Address: 00000000
Entry Point: 00000000
Verifying Checksum ... OK
Uncompressing Kernel Image ... Error: inflate() returned =E2=88=923
GUNZIP ERROR =E2=88=92 must RESET board to recover
Answer:
Your kernel image is quite big =E2=88=92 nearly 1 MB compressed; when it ge=
ts
uncompressed it will need 2.5
... 3 MB, starting at address 0x0000. But your compressed image was stored
at 1 MB (0x100000), so
the uncompressed code will overwrite the (remaining) compressed image. The
solution is thus simple:
just use a higher address to download the compressed image into RAM. For
example, try:
=3D> bootm 400000




Henry Bausley wrote:
>=20
> I am getting the error
>=20
> Uncompressing Kernel Image ... Error: inflate() returned -3
> GUNZIP ERROR - must RESET board to recover
> OK
>=20
> when u-boot tries to uncompress the kernel.  I am using a board based upo=
n
> a=20
> Yosemite AMCC 440EP.
> I do have some boards that work.  Does anyone know what could cause this=
=20
> problem.  Bad Flash , Bad DDR ?
>=20
>=20
>=20
>=20
>=20
>=20
> U-Boot 1.1.4 (Jun 30 2006 - 14:55:59)
>=20
> CPU:   AMCC PowerPC 440EP Rev. B at 533.333 MHz (PLB=3D133, OPB=3D66, EBC=
=3D66=20
> MHz)
>        I2C boot EEPROM enabled
>        Internal PCI arbiter disabled, PCI async ext clock used
>        32 kB I-Cache 32 kB D-Cache
> Board: Yosemite - AMCC PPC440EP Evaluation Board
> I2C:   ready
> DRAM:  256 MB
> FLASH: 64 MB
> PCI:   Bus Dev VenId DevId Class Int
> In:    serial
> Out:   serial
> Err:   serial
> Net:   ppc_4xx_eth0, ppc_4xx_eth1
> Hit any key to stop autoboot:  0
> ## Booting image at fc000000 ...
>    Image Name:   Linux-2.6.14-rtl
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1250069 Bytes =3D  1.2 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... Error: inflate() returned -3
> GUNZIP ERROR - must RESET board to recover
> OK
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

--=20
View this message in context: http://www.nabble.com/Asterisk-on-Embedded-Li=
nux-tf2336671.html#a12010845
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
