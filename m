Return-Path: <Marc.Howard@KLA-Tencor.com>
Received: from ca1mail04.kla-tencor.com (mailout04.kla-tencor.com
	[192.146.1.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 736BA67B9A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 11:38:41 +1000 (EST)
Received: from CA1EXBH01.adcorp.kla-tencor.com
	(ca1exbh01.adcorp.kla-tencor.com [10.60.33.3])
	by ca1mail04.kla-tencor.com (8.12.10/8.12.11) with ESMTP id
	k7P1cah0019021
	for <linuxppc-embedded@ozlabs.org>; Thu, 24 Aug 2006 18:38:37 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Help with booting with very large initrd
Date: Thu, 24 Aug 2006 18:38:35 -0700
Message-ID: <91B22F93A880FA48879475E134D6F0BE02F33401@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm developing a PPC440GX based board that uses U-Boot to boot a
multi-file boot image composed of the kernel and a very large (> 96MB
uncompressed) initrd file.  The board has 512MB of RAM of which the
upper 16MB is reserved for dedicated hardware.  The 16MB block is
reserved via "mem=3D496M" and U-Boot is told to stay out of that area by
setting "initrd_high=3D1f000000".

Before anyone asks there are several reasons for doing things this way.
NFS is not an option in the target environment.

I can tftp the combined boot image to my board.  I checked the crc with
the crc32 command and it agrees exactly with the result obtained on the
host machine using the boot file.  Therefore there is not a "TFTP >32MB"
problem here.

If I boot I get the following:

=3D> boot
Waiting for PHY auto negotiation to complete... done
ENET Speed is 1000 Mbps - FULL duplex connection
Using ppc_4xx_eth2 device
TFTP from server 192.168.168.108; our IP address is 192.168.168.111
Filename 'pMulti-ramdisk'.
Load address: 0x400000
Loading: *
done
Bytes transferred =3D 38825407 (2506dbf hex)
Automatic boot of image at addr 0x00400000 ...
## Booting image at 00400000 ...
   Image Name:   Linux-2.6.10_mvl401-440gx_eval-I
   Created:      2006-08-25   1:01:29 UTC
   Image Type:   PowerPC Linux Multi-File Image (gzip compressed)
   Data Size:    38825343 Bytes =3D 37 MB
   Load Address: 00000000
   Entry Point:  00000000
   Contents:
   Image 0:  1137986 Bytes =3D  1.1 MB
   Image 1: 37687343 Bytes =3D 35.9 MB
   Verifying Checksum ... OK
   Uncompressing Multi-File Image ... OK
   Loading Ramdisk to 1cc0e000, end 1efff02f ... OK
Linux version 2.6.10_mvl401-440gx_eval (cram@toaster.kla-tencor.com)
(gcc version 3.4.3 (MontaVista 3.4.3-25.0.107.0601076 2006-07-21)) #46
Thu Aug 24 17:28:09 PDT 2006
IBM Ocotea port (MontaVista Software, Inc. <source@mvista.com>)
Built 1 zonelists
Kernel command line: ramdisk_size=3D262144 root=3D/dev/ram rw
console=3DttyS0,115200
ip=3D192.168.168.111:192.168.168.108::255.255.255.0:scpu2:eth0: off
mem=3D496M
PID hash table entries: 2048 (order: 11, 32768 bytes)

......stuff deleted......

RAMDISK driver initialized: 8 RAM disks of 262144K size 1024 blocksize
loop: loaded (max 8 devices)

......more stuff deleted......

eth0: link is down
eth0: link is up, 1000 FDX, pause enabled
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.168.111, mask=3D255.255.255.0,
gw=3D255.255.255.255,     host=3Dscpu2, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.168.108, rootserver=3D192.168.168.108, =
rootpath=3D
RAMDISK: Compressed image found at block 0
crc error (orig 0x9a278d64, CRC_VALUE 0xa7bcd2e3 -- ignoring!
length error (orig =3D 0x0c000000, bytes_out =3D 0x0c000015 -- ignored
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 120k init
Warning: unable to open an initial console.
Kernel panic - not syncing: No init found.  Try passing init=3D option =
to
kernel.
 <0>Rebooting in 180 seconds..

(I modified lib/inflate.c so that the crc and length checks would
provide more info).

Since the overall file CRC is good and U-Boot checksums are also okay
this looks like some sort of size limitation with the inflate routine.
BTW, The kerenel was made assuming a 256MB ramdisk; likewise the command
line specs one as well.  The initrd image would fit easily in that
space.

Have any of you worked on this problem before and come up with a
solution?

Thanks,

Marc Howard
