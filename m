Return-Path: <lpetras@netspace.net.au>
Received: from mail.netspace.net.au (cumulus.netspace.net.au [203.10.110.72])
	by ozlabs.org (Postfix) with ESMTP id 623E267A6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Feb 2005 16:36:56 +1100 (EST)
From: "Linas Petras" <lpetras@netspace.net.au>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 9 Feb 2005 16:36:53 +1100
Message-ID: <000001c50e69$5df30610$6401a8c0@supernova>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Cc: 'Sylvain Munaut' <tnt@246tNt.com>
Subject: Re: Problems with Serial Port on IceCube 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have tried using another serial cable (as suggested by Wolfgang) but =
it
made no difference, but I did not expect it to as I get all the messages
from the bootroms OK.

I have have confirmed that I have (as suggested by Sylvian) set
CONFIG_CMDLINE=3D "console=3DttyS0" and have also tried =
"console=3DttyS0, 115200"
(as my serial port is set to 115200 on the icecube board) without any
messages after arch:exit.=20

Below is what I see when I try and boot Sylvians 2-6-10-rc2 kernel.

=3D> tftp 200000
Using FEC ETHERNET device
TFTP from server 192.168.1.101; our IP address is 192.168.1.201
Filename 'uImage'.
Load address: 0x200000
Loading: =
#################################################################
 #################################################################
 #################################################################
 #############################################################
done
Bytes transferred =3D 1305842 (13ecf2 hex)
=3D> bootm 200000
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.10-rc2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1305778 Bytes =3D  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
ocp: exit
arch: exit
            =20
At this point all output to the serial port stops but the board boots =
and I
can telnet to the IP address. It's not that important in the greater =
scheme
of things, just very annoying :-(

Below is a "printenv" from the icecube-uboot.

baudrate=3D115200
ethact=3DFEC ETHERNET
preboot=3Decho;echo AutoStarting. Press any key to abort ...;echo
ethaddr=3D00:04:9F:00:12:60
bootdelay=3D5
hostname=3Dicecube
flashboot=3Droot=3D/dev/mtdblock2 rw
rootfs=3Droot=3D/dev/nfs rw =
nfsroot=3D192.168.1.101:/work/ELDK-3.1/ppc_6xx
bootfile=3DuImage
nfsroot=3Droot=3D/dev/nfs rw =
nfsroot=3D192.168.1.101:/work/ELDK-3.1/ppc_6xx
ip=3Dip=3D192.168.1.201:192.168.1.101:192.168.1.101:255.255.255.0:icecube=
::off
bootargs=3Droot=3D/dev/nfs rw =
nfsroot=3D192.168.1.101:/work/ELDK-3.1/ppc_6xx
ip=3D192.16
8.1.201:192.168.1.101:192.168.1.101:255.255.255.0:icecube::off
filesize=3Db7d6e
fileaddr=3D100000
netmask=3D255.255.255.0
ipaddr=3D192.168.1.201
serverip=3D192.168.1.101
bootcmd=3Dbootm ff100000
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial


Any ideas????


Linas Petras
------------
I know not with which weapons World War III will be faught, but World =
War IV
will be faught with sticks and stones. - Albert Einstein.
