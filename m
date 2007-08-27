Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 808FEDE50A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 23:35:41 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IPekj-0000sO-MV
	for linuxppc-embedded@ozlabs.org; Mon, 27 Aug 2007 06:35:37 -0700
Message-ID: <12347049.post@talk.nabble.com>
Date: Mon, 27 Aug 2007 06:35:37 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Linux doesn not boot from u-boot on ML403
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi All,

     I run Linux 2.6.21 (by Grant) on my Avnet Virtex-4 evaluation board
(ML403 like). When I load zIinux.elf
via jtag to the board it runs properly:

loaded at:     00400000 004F9138                                                                                                  
board data at: 004F7120 004F7138                                                                                                  
relocated to:  004040B4 004040CC                                                                                                  
zimage at:     00404E59 004F6EE6                                                                                                  
avail ram:     004FA000 01FFFFFF                                                                                                                                                                                                                                     
Linux/PPC load: console=ttyUL0,9600 root=/dev/nfs rw
nfsroot=129.117.144.113:/opt/eldk41/ppc_4xx,tcp 
ip=::::virtex4-mirek:eth0:dhcp panic=1
Uncompressing Linux...done.                                                                                                       
Now booting the kernel                                                                                                             
[0.000000] Linux version 2.6.21-rc6 (root@pc5215) (gcc version 4.0.2) #11
Tue Aug 7 13:46:19 EST 2007                 
[0.000000] Xilinx ML403 Reference System (Virtex-4 FX)                                                                         
.
.
.
.
It goes to the successful end.

I have build u-boot 1.2.0 with uart lite and temac support.

When I am trying to run uImage (build out of zImage) it does not run.

The steps I do are as following:

1. I build uImage withing the kernel tree (make uImage)
2. I load via jtag the u-boot 1.2.0

XMD% dow u-boot.elf
        section, .text: 0x00800000-0x0081513c
        section, .resetvec: 0x0081513c-0x00815140
        section, .rodata: 0x00815140-0x00817ce0
        section, .reloc: 0x00817d00-0x00818674
        section, .data: 0x00818674-0x00818b08
        section, .data.rel: 0x00818b08-0x00818b34
        section, .data.rel.local: 0x00818b34-0x00818f6c
        section, .u_boot_cmd: 0x00818f6c-0x008191dc
        section, .bss: 0x00819200-0x0081dd04

3. I transfer uImage to the RAM memory of my Avnet board:
TFTP from server 129.129.144.113; our IP address is 129.129.144.157                                                               
Filename 'uImage'.                                                                                                                 
Load address: 0x1000000                                                                                                           
Loading: #################################################################                                                                 
#################################################################                                                                 
################################################################                                                         
done                                                                                                                              
Bytes transferred = 991438 (f20ce hex)                                                                                            

4. I am trying to start the kernel

=> bootm 0x1000000
                                                                                                                                                                                                                                          
## Booting image at 01000000 ...                                                                                                     
Image Name:   Linux-2.6.21-rc6                                                                                                    
Image Type:   PowerPC Linux Kernel Image (gzip compressed)                                                                        
Data Size:    991375 Bytes = 968.1 kB                                                                                             
Load Address: 00000000                                                                                                            
Entry Point:  00000000                                                                                                            
Verifying Checksum ... OK                                                                                                         
Uncompressing Kernel Image ... OK                                                                                              


After all system hangs

I have tried to change the Load Address and Entry Point to 0x400000 (mkimage
-a 0x400000 -e 0x400000)
but the system hangs like in the first case.

my bootargs are:
console=ttyUL0,9600 root=/dev/nfs rw
nfsroot=129.117.144.113:/opt/eldk41/ppc_4xx,tcp 
ip=::::virtex4-mirek:eth0:dhcp panic=1

Those bootargs where tested with zImage.elf and seem to be fine.

Does somebody has some suggestion?

Thank you in advance for any hint on that.

Mirek

-- 
View this message in context: http://www.nabble.com/Linux-doesn-not-boot-from-u-boot-on-ML403-tf4335322.html#a12347049
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
