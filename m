Return-Path: <dgalari@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.238])
	by ozlabs.org (Postfix) with ESMTP id D9DF2DDF6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 04:57:02 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so1499818wxd
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 05 Mar 2007 09:57:00 -0800 (PST)
Message-ID: <3184691b0703050957n6ccbdd84x6e01dba9985d5b2c@mail.gmail.com>
Date: Mon, 5 Mar 2007 18:57:00 +0100
From: "Juan Lopez" <dgalari@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: boot LITE5200B
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

I have a problem to boot a linux image in a Freescale LITE5200B, I
compile a Kernel image and a rootfs image with the scripts where I
found in the page http://cross-stuff.sourceforge.net/ , the LITE5200B
post in the screen:

## Booting image at ff0a0000 ...
   Image Name:   Linux MPC5200
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1298549 Bytes =  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
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


and my  variables are:

=> printenv
baudrate=115200
preboot=echo;echo Type "run flash_nfs" to mount root filesystem over NFS;echo
skipnetcheck=y
skippcicheck=y
skipidecheck=y
verify=n
netdev=eth0
nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=$(serverip):$(rootpath)
ramargs=setenv bootargs root=/dev/ram rw
addip=setenv bootargs $(bootargs)
ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):off
panic=1
flash_nfs=run nfsargs addip;bootm $(kernel_addr)
flash_self=run ramargs addip;bootm $(kernel_addr) $(ramdisk_addr)
net_nfs=tftp 200000 $(bootfile);run nfsargs addip;bootm
rootpath=/opt/eldk/ppc_82xx
autoload=no
autostart=no
ethaddr=00:04:9f:00:5b:46
ethact=FEC ETHERNET
mtd_args=setenv bootargs
root=8.142.77:10.48.142.152:10.48.142.152:255.255.255.0:::off
jff2args=setenv bootargs root=/dev/mtdblock0 rw rootfstype=jffs2
flash_jffs2=run jffs2args
kernel_adrr=0xFF0A0000
kernel_addr=0xFF0A0000
hostname=dhcp30-56139
dnsip=10.30.1.2
bootfile=uImage-LITE5200
ipddr=192.168.0.20
filesize=f8
fileaddr=200000
gatewayip=192.168.0.1
netmask=255.255.0.0
ipaddr=192.168.0.20
serverip=192.168.0.11
bootdelay=3
bootargs=root=/dev/mtdblock3 ro console=ttyS1 rootfstype=jffs2
bootcmd=bootm 0xFF0A0000
stdin=serial
stdout=serial
stderr=serial

Environment size: 1348/65524 bytes


somebody knows that it happens??

Thanks
