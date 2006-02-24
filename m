Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 35AC3679FC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Feb 2006 23:54:22 +1100 (EST)
Received: from vitb.ru.mvista.com ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k1OCsKt27679
	for <linuxppc-embedded@ozlabs.org>; Fri, 24 Feb 2006 16:54:20 +0400
Date: Fri, 24 Feb 2006 15:54:20 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PQ2FADS_ZU: u-boot-1.1.4, eldk.3.1.1, linux-2.4.25 boots problem
Message-ID: <20060224155420.170dca13@vitb.ru.mvista.com>
In-Reply-To: <OFB33741BA.EBB350F9-ON4825711F.003669C0@uk.marconicomms.com>
References: <OFB33741BA.EBB350F9-ON4825711F.003669C0@uk.marconicomms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 24 Feb 2006 18:03:21 +0800
"KokHow Teh" <KokHow.Teh@marconi.com> wrote:

> Hi;
>       I use the above software, apply linuxppc-2005-03-06-2006-02-15.patch
> from http://mpc8260sar.sourceforge.net/, `make PQ2FADS_config`, not using
> devfs and never manage to boot the kernel:
> 
> u-boot>  printenv
> ramboot=setenv bootargs root=/dev/ram rw;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile
> ;bootm $loadaddr $ramdiskaddr
> bootdelay=10
> baudrate=115200
> ethaddr=08:00:3E:33:44:56
> ipaddr=147.128.28.44
> serverip=147.128.28.42
> rootpath="/fadsroot"
> gatewayip=147.128.28.1
> netmask=255.255.254.0
> hostname=PQ2FADS-ZU
> bootfile="uImage.linux"
> netdev=eth0
> ramdiskaddr=400000
> ramdiskfile=uInitRD
> ethact=FCC2 ETHERNET
> testdramdata=y
> testdramaddress=y
> testdramwalk=n
> x86_run_bios=on
> bootcmd=run nfsboot
> nfsargs=setenv bootargs $bootargs root=/dev/nfs rw nfsroot=$serverip:$rootpath
> setconsole=setenv bootargs $console
> addip=setenv bootargs $bootargs ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off
> loadaddr=0x1000000
> nfsboot=tftp $loadaddr $bootfile; run setconsole nfsargs addip; echo $bootargs; bootm
> console=console=ttyS0,115200n8 console=tty0
> stdin=serial
> stdout=serial
> stderr=serial
> 
> Environment size: 891/262140 bytes
> u-boot>
> u-boot> boot
> Using FCC2 ETHERNET device
> TFTP from server 147.128.28.42; our IP address is 147.128.28.44
> Filename 'uImage.linux'.
> Load address: 0x1000000
> Loading: #################################################################
>          #################################################################
>          ######################################################
> done
> Bytes transferred = 941606 (e5e26 hex)
> console=ttyS0,115200n8 console=tty0 root=/dev/nfs rw nfsroot=147.128.28.42:/fadsroot ip=147.128.
> 28.44:147.128.28.42:147.128.28.1:255.255.254.0:PQ2FADS-ZU:eth0:off
> ## Booting image at 01000000 ...
>    Image Name:   Linux Kernel Image
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    941542 Bytes = 919.5 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> 
> 
> U-Boot 1.1.4 (Feb 15 2006 - 16:19:49)
> 
> MPC8260 Reset Status: Check Stop, External Soft, External Hard
> 
> 
>       I have tried console=ttyCPM0,115200n8 console=tty0 and it makes no difference. BTW, which one should be used for serial console in 2.4.x kernel
> for this PowerQUICC II 8280 platform? ttySx or ttyCPMx?
>       Any insight is appreciated.
> 
> Regards,
> TEH
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

The right thing is ttyS0 for 2.4.x... 
First, if that will not help, I suggest to comment out the PCI initialization code, and to see if it will help.

-- 
Sincerely, 
Vitaly
