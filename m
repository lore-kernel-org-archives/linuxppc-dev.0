Return-Path: <KokHow.Teh@marconi.com>
Received: from smtpoutuk02.marconi.com (smtpoutuk02.marconi.com
	[128.87.251.113]) by ozlabs.org (Postfix) with ESMTP id 2626B67B1D
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Mar 2006 16:05:24 +1100 (EST)
Received: from cvdgwy01.uk.marconicomms.com (cvis26.uk.marconicomms.com
	[128.87.251.109])
	by smtpoutuk02.marconi.com (8.12.11/8.12.11) with ESMTP id
	k2655Ih0011495
	for <linuxppc-embedded@ozlabs.org>; Mon, 6 Mar 2006 05:05:18 GMT
	(envelope-from KokHow.Teh@marconi.com)
Subject: Re: PQ2FADS_ZU: u-boot-1.1.4, eldk.3.1.1, linux-2.4.25 boots problem
To: linuxppc-embedded@ozlabs.org
From: "KokHow Teh" <KokHow.Teh@marconi.com>
Date: Mon, 6 Mar 2006 13:05:13 +0800
Message-ID: <OF6E9E7C95.591820AB-ON48257129.001B66B7@uk.marconicomms.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
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

>> Hi;
>>       I use the above software, apply
linuxppc-2005-03-06-2006-02-15.patch
>> from http://mpc8260sar.sourceforge.net/, `make PQ2FADS_config`, not
using
>> devfs and never manage to boot the kernel:
>>
>> u-boot>  printenv
>> ramboot=setenv bootargs root=/dev/ram rw;tftp $ramdiskaddr
$ramdiskfile;tftp $loadaddr $bootfile
>> ;bootm $loadaddr $ramdiskaddr
>> bootdelay=10
>> baudrate=115200
>> ethaddr=08:00:3E:33:44:56
>> ipaddr=147.128.28.44
>> serverip=147.128.28.42
>> rootpath="/fadsroot"
>> gatewayip=147.128.28.1
>> netmask=255.255.254.0
>> hostname=PQ2FADS-ZU
>> bootfile="uImage.linux"
>> netdev=eth0
>> ramdiskaddr=400000
>> ramdiskfile=uInitRD
>> ethact=FCC2 ETHERNET
>> testdramdata=y
>> testdramaddress=y
>> testdramwalk=n
>> x86_run_bios=on
>> bootcmd=run nfsboot
>> nfsargs=setenv bootargs $bootargs root=/dev/nfs rw
nfsroot=$serverip:$rootpath
>> setconsole=setenv bootargs $console
>> addip=setenv bootargs $bootargs
ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off
>> loadaddr=0x1000000
>> nfsboot=tftp $loadaddr $bootfile; run setconsole nfsargs addip; echo
$bootargs; bootm
>> console=console=ttyS0,115200n8 console=tty0
>> stdin=serial
>> stdout=serial
>> stderr=serial
>>
>> Environment size: 891/262140 bytes
>> u-boot>
>> u-boot> boot
>> Using FCC2 ETHERNET device
>> TFTP from server 147.128.28.42; our IP address is 147.128.28.44
>> Filename 'uImage.linux'.
>> Load address: 0x1000000
>> Loading:
#################################################################
>>
#################################################################
>>          ######################################################
>> done
>> Bytes transferred = 941606 (e5e26 hex)
>> console=ttyS0,115200n8 console=tty0 root=/dev/nfs rw
nfsroot=147.128.28.42:/fadsroot ip=147.128.
>> 28.44:147.128.28.42:147.128.28.1:255.255.254.0:PQ2FADS-ZU:eth0:off
>> ## Booting image at 01000000 ...
>>    Image Name:   Linux Kernel Image
>>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>>    Data Size:    941542 Bytes = 919.5 kB
>>    Load Address: 00000000
>>    Entry Point:  00000000
>>    Verifying Checksum ... OK
>>    Uncompressing Kernel Image ... OK
>>
>>
>> U-Boot 1.1.4 (Feb 15 2006 - 16:19:49)
>>
>> MPC8260 Reset Status: Check Stop, External Soft, External Hard
>>
>>
>>       I have tried console=ttyCPM0,115200n8 console=tty0 and it makes no
difference. BTW, which one should be used for serial console in 2.4.x
kernel
>> for this PowerQUICC II 8280 platform? ttySx or ttyCPMx?
>>       Any insight is appreciated.
>>

>The right thing is ttyS0 for 2.4.x...
>First, if that will not help, I suggest to comment out the PCI
initialization code, and to see if it will help.
>--
>Sincerely,
>Vitaly


I have taken out the PCI initialization code:

[root@ShrekII linux 4]# grep PCI .config
# CONFIG_PCI is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_NET_PCI is not set
[root@ShrekII linux 5]#

Here is the log_buf:

[root@ShrekII linux 3]# grep log_buf /fadsroot/boot/System.map
c01d40b4 b log_buf
[root@ShrekII linux 4]#

Here is what is in the log_buf after the system reboots when booting the linux kernel:

u-boot> md 0x1d40b4
001d40b4: 0007502d 0007502e 0007502f 00075030    ..P-..P...P/..P0
001d40c4: 00075031 00075032 00075033 00075034    ..P1..P2..P3..P4
001d40d4: 00075035 00075036 00075037 00075038    ..P5..P6..P7..P8
001d40e4: 00075039 0007503a 0007503b 0007503c    ..P9..P:..P;..P<
001d4104: 00075041 00075042 00075043 00075044    ..PA..PB..PC..PD
001d4114: 00075045 00075046 00075047 00075048    ..PE..PF..PG..PH
001d4124: 00075049 0007504a 0007504b 0007504c    ..PI..PJ..PK..PL
001d4134: 0007504d 0007504e 0007504f 00075050    ..PM..PN..PO..PP
001d4144: 00075051 00075052 00075053 00075054    ..PQ..PR..PS..PT
001d4154: 00075055 00075056 00075057 00075058    ..PU..PV..PW..PX
001d4164: 00075059 0007505a 0007505b 0007505c    ..PY..PZ..P[..P\
001d4174: 0007505d 0007505e 0007505f 00075060    ..P]..P^..P_..P`
001d4184: 00075061 00075062 00075063 00075064    ..Pa..Pb..Pc..Pd
001d4194: 00075065 00075066 00075067 00075068    ..Pe..Pf..Pg..Ph
001d41a4: 00075069 0007506a 0007506b 0007506c    ..Pi..Pj..Pk..Pl
u-boot>

I can't see any helpful information in this log_buf....:-<

Any insight is appreciated.

Regards,
TEH
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
