Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de [83.120.0.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 74C00679E6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Apr 2006 20:19:06 +1100 (EST)
Received: from server.idefix.loc (ppp-82-135-78-215.mnet-online.de
	[82.135.78.215]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.4/8.13.4) with ESMTP id k319J07S095112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 1 Apr 2006 11:19:01 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.loc with local (Exim 4.60 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1FPcG4-0001LD-P9
	for linuxppc-embedded@ozlabs.org; Sat, 01 Apr 2006 11:19:00 +0200
Date: Sat, 1 Apr 2006 11:19:00 +0200
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel for MPC Lite 5200 will not compile
Message-ID: <20060401091900.GA2740@server.idefix.loc>
References: <20060328000703.GA95672@server.idefix.loc>
	<4b73d43f0603271701q24910d9rf4e61e5136c2b727@mail.gmail.com>
	<20060328094939.GA43123@server.idefix.loc>
	<4b73d43f0603280815n3fc7bb5dq38b72f87f18b905f@mail.gmail.com>
	<4429A0E5.8010308@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4429A0E5.8010308@246tNt.com>
Sender: Matthias Fechner <idefix@fechner.net>
Reply-To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Sylvain,

* Sylvain Munaut <tnt@246tNt.com> [28-03-06 22:47]:
> If it still doesnt work, report it and I'll have a closer look. Maybe
> something changed
> recently and I didn't update my tree since a few days ...

ok, I have now the board to really test it.
I tried to boot over NFS, the kernel was loaded successfully but it
will not really boot, I got:
--- cut ---
U-Boot 1.1.4 (Jan 23 2006 - 11:03:09)

CPU:   MPC5200 v1.2 at 396 MHz
       Bus 132 MHz, IPB 66 MHz, PCI 33 MHz
       Board: Motorola MPC5200 (IceCube)
       I2C:   85 kHz, ready
       DRAM:  64 MB
       FLASH: 16 MB
       PCI:   Bus Dev VenId DevId Class Int
               00  1a  1057  5803  0680  00
       In:    serial
       Out:   serial
       Err:   serial
       Net:   FEC ETHERNET
       IDE:   Bus 0: not available  
	       
Autostarting.V13_02_06_OP. Press any key to abort..
	       
Hit any key to stop autoboot:  0 
Using FEC ETHERNET device
TFTP from server 192.168.0.151; our IP address is 192.168.0.101
Filename 'MPC5200/uImage'.
Load address: 0x200000
Loading: #################################################################
         #################################################################
         #################################################################
         ############
done
Bytes transferred = 1057133 (10216d hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.16-rc1-gaf4f75fd
   Created:      2006-03-29  16:45:14 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1057069 Bytes =  1 MB
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
arch: exit
--- cut ---

After this the board wait for something until it will reboot.
I have the following variables set in U-Boot:
--- cut ---
baudrate=115200
ethact=FEC ETHERNET
1ipaddr=192.168.10.101
ethaddr=00:04:9F:00:11:02
stdin=serial
stdout=serial
stderr=serial
bootcmd=tftp 200000; bootm 200000
preboot=echo;echo Autostarting. Press any key to abort..;echo
serverip=192.168.0.151
ipaddr=192.168.0.101
netmask=255.255.255.0
bootdelay=5
hostname=icecube
nfsroot=root=/dev/nfs rw nfsroot=192.168.0.151:/usr/local/eldk/ppc_6xx
ip=ip=192.168.0.101:192.168.0.151:192.168.0.151:255.255.255.0:icecube::off
flashroot=root=/dev/mtdblock2 rw
rootfs=root=/dev/nfs rw nfsroot=192.168.0.151:/usr/local/eldk/ppc_6xx
bootfile=MPC5200/uImage
bootargs=root=/dev/nfs rw nfsroot=192.168.0.151:/usr/local/eldk/ppc_6xx ip=192.168.0.101:192.168.0.151:192.168.0.151:255.255.255.0:icecube::off
--- cut ---

The kernel is built with nfs support:
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y

I tried to find if the networkcard from the board will work, but I
cannot find a driver in the kernel for it.
What can be the problem for this?

Thx a lot!

Best regards,
Matthias
