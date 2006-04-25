Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 565BD67A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 00:18:28 +1000 (EST)
In-Reply-To: <64A27FD84D948C48ABF3250BF78446FD01B7DF5D@OTTSVW100.gdcan.com>
References: <64A27FD84D948C48ABF3250BF78446FD01B7DF5D@OTTSVW100.gdcan.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <A2CF40E7-1518-407E-A492-2AF35AD162BD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Rebuilding FS MDS 8349 BSP & JFFS2 integration
Date: Tue, 25 Apr 2006 09:18:21 -0500
To: "Krawczuk, Victor" <Victor.Krawczuk@gdcanada.com>
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


On Apr 24, 2006, at 4:30 PM, Krawczuk, Victor wrote:

> Hi,
>
> I am a newbie to Linux but not to embedded PPC. I was hoping =20
> someone could point me to the direction here. I apologize in =20
> advance if this is kindergarten stuff.
>
> I downloaded the MDS-8349 Linux BSP from FreeScale. I was able to =20
> burn the default prebuilt images "uboot" and "jffs2.img" to my =20
> MDS-8349 (PB) board and have uboot tftp the prebuilt "uImage" to my =20=

> PB. I used "tftpboot 200000 uImage" to download and "bootm" to =20
> boot.  As per included instructions, I had "setenv bootargs root=3D/=20=

> dev/mtdblock1 rootfstype=3Djffs2 rw console=3DttyS0,115200" in uboot, =20=

> followed by a "saveenv". The prebuilt Linux (uImage) came up, no =20
> problem.
>
> As I need to include USB Host support to the PPC kernel, I used the =20=

> ltib tool to reconfigure and rebuild Linux, as well as a matching =20
> jffs2 (I would think). Ltib produced vmlinux.gz.uboot and =20
> rootfs.jffs2 for me.  For some reason, rootfs.jffs2 was =20
> significantly smaller than the prebuilt "jffs2.img" (2483184 bytes =20
> vs. 4325376 bytes). I'm not sure why. I then did the following:
Questions regarding the Freescale BSP are best directed at Freescale =20
as they have a custom kernel they are providing with their BSPs.
> bootargs is still set to "root=3D/dev/mtdblock1 rootfstype=3Djffs2 rw =20=

> console=3DttyS0,115200"  in uboot:
>
> Using the same (prebuilt) uboot as before:
>
> - tftpboot 400000 rootfs.jffs2 (rebuilt jffs2)
> - erase fe020000 fe5fffff
> - cp.b 400000 fe020000 25e3f0
>
> - tftpboot 200000 vmlinux.gz.uboot (rebuilt Linux containing USB =20
> Host stuff)
> - bootm
>
> Linux could not boot!  I got the following root FS error:
>
> [stuff deleted=85]
> io scheduler deadline registered
> io scheduler cfq registered
> RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
> loop: loaded (max 8 devices)
> eth0: Gianfar Ethernet Controller Version 1.1, 00:04:9f:00:2d:b7
> eth0: Running with NAPI disabled
> eth0: 64/64 RX/TX BD ring size
> eth1: Gianfar Ethernet Controller Version 1.1, 00:04:9f:00:2d:b8
> eth1: Running with NAPI disabled
> eth1: 64/64 RX/TX BD ring size
> i2c /dev entries driver
> NET: Registered protocol family 2
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP established hash table entries: 16384 (order: 5, 131072 bytes)
> TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Root-NFS: No NFS server available, giving up.
> VFS: Unable to mount root fs via NFS, trying floppy.
> VFS: Cannot open root device "mtdblock1" or unknown-block(2,0)
> Please append a correct "root=3D" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-=20=

> block(2,0)
>  <0>Rebooting in 180 seconds..
>
> Would anybody happen to know what is going wrong?  How am I =20
> supposed to know the correct "root=3D" boot option for a rebuilt =20
> jffs2 using LTIB, if that is my problem?
Where there any messages related to MTD or flash in the boot log?  If =20=

not that would seem to be the first place to look.

- kumar=
