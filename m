Return-Path: <iluri@fagorautomation.es>
Received: from sollube.sarenet.es (mx1.sarenet.es [194.30.0.37])
	by ozlabs.org (Postfix) with ESMTP id 4A7BF67B19
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 20:15:36 +1000 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by sollube.sarenet.es (Postfix) with ESMTP id 675EF374E2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 12:15:30 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: CRAMFS: Error -3 while decompressing! 
Date: Tue, 23 May 2006 12:15:25 +0200
Message-ID: <918EB199DDDFFA42BEA2EB3A1C6021F3D49640@correo.fagorautomation.net>
From: "IGOR LURI" <iluri@fagorautomation.es>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>What's /dev/rw ???
Is a mistake, the correct argument is root=3D/dev/ram.

We would want to use a Compact Flash card with VFAT file system to boot =
our system, so we need to store a linux kernel image and an initrd image =
on it.

						/boot/initrd.img
						/boot/vmlinux.img
						/custom/ (custom applications)


The contents of this initrd is basically busybox,libraris and device =
files:

						/bin/busybox (and simbolik links to busybox)					=09
						/etc/*
						/lib/lib*.so=20
						/dev/*
						/proc
						/mnt/(here goes mounted Compact Flash card )

U-Boot can load linux kernel image and initrd from Compact Flash to RAM. =
Then, when linux boots, we can mount the Compact flash card and execute =
our custom applications.

We haven't choose already the initrd file system type, but CRAMFS is an =
option. However, as I mentioned in the previos message, a CRAMFS initrd =
doesn=B4t boot in our board.


Thanks in advance.


-----Mensaje original-----
De: wd@denx.de [mailto:wd@denx.de]
Enviado el: lunes, 22 de mayo de 2006 22:59
Para: IGOR LURI
CC: linuxppc-embedded@ozlabs.org
Asunto: Re: CRAMFS: Error -3 while decompressing!=20


In message <44718702.1070809@fagorautomation.es> you wrote:
>=20
> We have a mpc5200liteB evaluation board with u-boot 1.1.4 and linux=20
> 2.4.25 from Denx.  We have grabed a cramfs  root fs on a mtd partition =

> and we are able to boot linux without problems:
...
> However, we are not able to boot linux with the same rootfs image =
(with=20
> the u-boot header) loaded from RAM.
>=20
>         setenv bootargs root=3D/dev/rw rw console=3DttyS0 =
console=3DttyS0
>         init=3D/sbin/init ip=3Don

What's /dev/rw ???

> and CRAMFS image is built with correct endianess:

Ummm.. Why would you want to use a cramfs file system in a ramdisk
image? This iseems to be a truely pessimal combination of features to
me. Please see
http://www.denx.de/wiki/view/DULG/RootFileSystemDesignAndBuilding for
some hints...

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Life sucks, but it's better than the alternative."
- Peter da Silva
