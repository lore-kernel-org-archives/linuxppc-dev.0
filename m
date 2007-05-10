Return-Path: <ajz@cambridgebroadband.com>
Received: from zambia.cambridgebroadband.com (ip-217-204-121-82.easynet.co.uk
	[217.204.121.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F046DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 May 2007 19:23:28 +1000 (EST)
Message-ID: <4642D65C.2000108@cambridgebroadband.com>
Date: Thu, 10 May 2007 09:22:52 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
Subject: Re: MPC832xEMDS: ttyS0 output stops mid boot
References: <8c4dd9590705030939i5df99f3fw83a59698fe3d30cc@mail.gmail.com>
In-Reply-To: <8c4dd9590705030939i5df99f3fw83a59698fe3d30cc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
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

For the record, I've just merged powerpc.git from kernel.org and it has started
working now!  Clearly this means it was a kernel issue rather than a bootloader
issue.

Regards,

Alex

Alex Zeffertt wrote:
> Hi,
> 
> Sorry about the cross posting, but I'm not sure which list I should send 
> to....
> 
> I'm trying to boot an up-to-date kernel on my MPC8323E-MDS-PB board, but 
> I the
> console output stops early on during the kernel boot.
> 
> I'm running the latest u-boot (git://www.denx.de/git/u-boot-mpc83xx.git) 
> with
> its default environment.  The kernel is built from Paulus' powerpc.git, 
> after
> checking out tag 2.6.21-rc5.  The dtb is build from
> arch/powerpc/boot/dts/mpc832x_mds.dts
> with the latest compiler (git://www.jdl.com/software/dtc.git).
> 
> Has anyone else been here before...?  If so I'd appreciate any help you can
> offer.
> 
> TIA,
> 
> Alex
> 
> -------------------my ttyS0 output------------------
> =>
> => printenv
> bootcmd=setenv bootargs root=/dev/nfs rw nfsroot=$serverip:$rootpath
> ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off
> console=$consoledev,$baudrate $othbootargs;tftp $loadaddr
> $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr - $fdtaddr
> ramboot=setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate
> $othbootargs;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr
> $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr $ramdiskaddr $fdtaddr
> nfsboot=setenv bootargs root=/dev/nfs rw nfsroot=$serverip:$rootpath
> ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off
> console=$consoledev,$baudrate $othbootargs;tftp $loadaddr
> $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr - $fdtaddr
> bootdelay=6
> baudrate=115200
> loads_echo=1
> ethaddr=00:04:9f:ef:03:01
> eth1addr=00:04:9f:ef:03:02
> loadaddr=200000
> netdev=eth0
> consoledev=ttyS0
> ramdiskaddr=1000000
> ramdiskfile=ramfs.83xx
> fdtaddr=400000
> fdtfile=mpc832xemds.dtb
> stdin=serial
> stdout=serial
> stderr=serial
> ethact=FSL UEC0
> 
> Environment size: 979/8188 bytes
> => setenv ramdiskfile uRamdisk
> => setenv fdtfile mpc832x_mds.dtb
> => setenv bootfile uImage
> => setenv serverip 10.0.0.107
> => setenv ipaddr 10.0.6.65
> => run ramboot
> Using FSL UEC0 device
> TFTP from server 10.0.0.107; our IP address is 10.0.6.65
> Filename 'uRamdisk'.
> Load address: 0x1000000
> Loading: #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         ###########################################################
> done
> Bytes transferred = 3296770 (324e02 hex)
> Using FSL UEC0 device
> TFTP from server 10.0.0.107; our IP address is 10.0.6.65
> Filename 'uImage'.
> Load address: 0x200000
> Loading: #################################################################
>         #################################################################
>         #################################################################
>         ##########################################
> done
> Bytes transferred = 1212615 (1280c7 hex)
> Using FSL UEC0 device
> TFTP from server 10.0.0.107; our IP address is 10.0.6.65
> Filename 'mpc832x_mds.dtb'.
> Load address: 0x400000
> Loading: ###
> done
> Bytes transferred = 12288 (3000 hex)
> ## Booting image at 00200000 ...
>   Image Name:   Linux-2.6.21-rc5
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    1212551 Bytes =  1.2 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
> ## Loading RAMDisk Image at 01000000 ...
>   Image Name:   uboot ext2 ramdisk rootfs
>   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>   Data Size:    3296706 Bytes =  3.1 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Booting using flat device tree at 0x400000
>   Loading Ramdisk to 07c87000, end 07fabdc2 ... OK
> Using MPC832x MDS machine description
> Linux version 2.6.21-rc5 (ajz@zambia) (gcc version 3.4.3) #2 Thu May 3
> 16:42:54 BST 2007
> Found initrd at 0xc7c87000:0xc7fabdc2
> setup_arch: bootmem
> mpc832x_sys_setup_arch()
> Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus 
> number: 0->0
> arch: exit
> Zone PFN ranges:
>  DMA             0 ->    32768
>  Normal      32768 ->    32768
> early_node_map[1] active PFN ranges
>    0:        0 ->    32768
> Built 1 zonelists.  Total pages: 32512
> Kernel command line: root=/dev/ram rw console=ttyS0,115200
> IPIC (128 IRQ sources) at fddf3700
> QEIC (64 IRQ sources) at fddf2080
> PID hash table entries: 512 (order: 9, 2048 bytes)
