Return-Path: <urwithsudheer@gmail.com>
Received: from predator.gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 6501167B26
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 16:53:54 +1000 (EST)
Received: from predator.gdatech.co.in (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 163AC1242EF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 12:23:30 +0530 (IST)
Received: from predator.gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Propel SE relay 1.0.0.3430
	$Rev$) id r66r122329-01-2
	for linuxppc-embedded@ozlabs.org; Tue, 27 Jun 2006 12:23:30 +0530
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id A6BCE1242DE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 12:23:29 +0530 (IST)
Message-ID: <44A0D5EF.7030807@gmail.com>
Date: Tue, 27 Jun 2006 12:23:35 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, dwh@ovro.caltech.edu
Subject: Re: Need help ragarding MPC8360 Kernel bootup failure - got solved
References: <44A00EF4.6000109@gmail.com>
In-Reply-To: <44A00EF4.6000109@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello All,

I got this problem sorted out.
I have changed the bootargs at u-boot to
setenv bootargs root=/dev/ram rw console=uart,io,0xfe004500
Now i could boot the linux and login.

Thanks & Regards
Sudheer



sudheer wrote:

>Hello all,
>
>I need help regarding the bootup of linux on MPC8360 MDS Board.
>
>After doing tftp the uImage from u-boot, with the bootm command  the 
>kernel gets uncompressed and stops there.
>The serial output from kernel could  not be seen.
>
>Source being used:
> uboot - U-Boot-1.1.3
> linux - Linux-2.6.11 supporting mpc8360epb.
>board - MPC8360 MDS
>
>The dump is below:
>
>U-Boot 1.1.3 (ppc83xx-20050315-dev) (Dec 14 2005 - 09:37:59) MPC83XX
>
>Clock configuration:
>  Coherent System Bus:  264 MHz
>  Core:                 528 MHz
>  QE:                   396 MHz
>  Local Bus Controller: 264 MHz
>  Local Bus:             66 MHz
>  DDR:                  264 MHz
>  DDR Secondary:        264 MHz
>  I2C:                  264 MHz
>CPU: MPC83xx, Rev: 20 at 528 MHz
>Board: Freescale MPC8360EPB
>I2C:   ready
>DRAM:
>   SDRAM on Local Bus: 64 MB
>   DDR RAM: 256 MB
>FLASH: 16 MB
>In:    serial
>Out:   serial
>Err:   serial
>Net:   FSL GETH0
>Hit any key to stop autoboot:  0
>=> printenv
>bootcmd=setenv bootargs root=/dev/nfs rw nfsroot=$serverip:$rootpath
>ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netrramboot=setenv
>bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;tftp
>$ramdiskaddr $ramdiskfile;tftp $loarnfsboot=setenv bootargs root=/dev/nfs
>rw nfsroot=$serverip:$rootpath
>ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netrbootdelay=6
>baudrate=115200
>loads_echo=1
>ethaddr=00:04:9f:11:22:33
>eth1addr=00:E0:0C:00:7D:01
>hostname=unknown
>loadaddr=200000
>netdev=eth0
>consoledev=ttyS0
>ramdiskaddr=400000
>ramdiskfile=ramfs.83xx
>ethact=FSL GETH0
>filesize=2d030a
>fileaddr=20000
>gatewayip=192.168.3.1
>netmask=255.255.255.0
>serverip=192.168.3.81
>bootfile=/tftpboot/vmlinux.gz
>ipaddr=192.168.3.253
>stdin=serial
>stdout=serial
>stderr=serial
>
>Environment size: 1005/8188 bytes
>=> setenv bootargs console=ttyS1 root=/dev/ram
>=> tftp 200000 uImage_test
>Auto negotiating done
>switching to rgmii 100
>duplexity: full
>mac speed set to: 100
>Using FSL GETH0 device
>TFTP from server 192.168.3.81; our IP address is 192.168.3.253
>Filename 'uImage_test'.
>Load address: 0x200000
>Loading: #################################################################
>         #################################################################
>         #################################################################
>         #######
>done
>Bytes transferred = 1033098 (fc38a hex)
>=> bootm 200000
>## Booting image at 00200000 ...
>   Image Name:   Linux-2.6.11.12
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    1033034 Bytes = 1008.8 kB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
>
> CTRL-A Z for help |115200 8N1 | NOR | Minicom 2.00.0 | VT102 |      Offline
>
>------------
>After Uncompressing kernel, nothing comes onto the minicom.
>I have tried the console env in bootargs to ttyS0,  ttyS1, ttyCPM0, ttyCPM1, ttyUCC0. But could not succeed.
>
>Anyone Please help me in this regard.
>
>Thanks & Regards
>Sudheer
>
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>  
>
