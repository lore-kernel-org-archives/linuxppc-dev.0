Return-Path: <frank.beesley@aeroflex.com>
Received: from mail7.ifrsys.com (unknown [65.196.219.163])
	by ozlabs.org (Postfix) with ESMTP id 7A5C468164
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Sep 2005 08:21:56 +1000 (EST)
Message-ID: <4320B90F.3070804@aeroflex.com>
Date: Thu, 08 Sep 2005 17:19:59 -0500
From: Frank Beesley <frank.beesley@aeroflex.com>
MIME-Version: 1.0
To: Bob Peterson <bob@acdstar.com>
References: <431F6CDC.7030908@aeroflex.com>
	<6.2.3.4.1.20050908091250.01eea878@mail.int.acdstar.com>
In-Reply-To: <6.2.3.4.1.20050908091250.01eea878@mail.int.acdstar.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jeff Angielski <jangiels@speakeasy.net>, linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 Linux Init Problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> Hi Frank,
>
> I recommend you first try to boot using tftp to get your kernel and 
> nfs to get
> your root filesystem.  Once that boots, you can play with MTD to make 
> sure
> your flash chips have full addressability and all, and you can mount your
> jffs partition manually and look at it from the client.
>
> Also, it would be interesting to see what u-boot messages you receive at
> power-on.  You may also want to do a printenv command in u-boot and
> post what your u-boot settings are.
>
> Regards,
>
> Bob Peterson
> Advanced Communication Design
>
Here is the Uboot message and env:

U-Boot 1.1.3-ppc-0_3 (Aug 31 2005 - 17:55:35)                         
                                                                                

CPU:   MPC5200 v1.2 at 396 
MHz                                                 
       Bus 132 MHz, IPB 66 MHz, PCI 66 
MHz                                     
Board: Aeroflex-Wichita 
CAI                                                    
DRAM:  128 
MB                                                                  
FLASH: 32 
MB                                                                   
Using default 
environment                                                      
                                                                                

In:    
serial                                                                  
Out:   
serial                                                                  
Err:   
serial                                                                  
                                                                                

Autostarting. Press any key to 
abort..                                         
                                                                                

Hit any key to stop autoboot:  
0                                               
Eric-CAI=> 
printenv                                                            
bootcmd=bootm 
FA200000                                                         
bootdelay=10                                                                    

baudrate=115200                                                                 

preboot=echo;echo Autostarting.  Press any key to 
abort..;echo                 
bootargs=root=/dev/mtdblock2                                                    

                                                                                

Environment size: 144/65532 bytes


I don't have an ethernet connection on my custom board - bummer. TFTP 
and NFS are out. To further explain my custom board, I have an Intel 
host (running linux also) that is connected to an FPGA over the PCI bus. 
The FPGA then shares the flash interface with the MPC5200. The Intel 
host maps the flash using MTD drivers, writes the images, then releases 
the flash to the MPC5200. At that point the MPC5200 is brought out of 
reset and boots from flash. I have the flash partitioned for uboot, 
kernel, rootfs, and a spare data partition. Uboot is at FA000000 (CS1 
after initial assembly setup), kernel is at FA200000, rootfs is at 
FA800000, spare is at FB800000.
0x00000000-0x00200000 : 
"UBoot"                                                
0x00200000-0x00800000 : 
"Kernel"                                               
0x00800000-0x01800000 : 
"Rootfs"                                               
0x01800000-0x02000000 : 
"Cals"                                                 

The rootfs is crossing my CS1-CS2 boundary (FA000000, FB000000). I tried 
putting my rootfs image in the cals partitions and changed my boot args 
to /dev/mtdblock3. This didn't seem to change things. I believe my chip 
selects are working properly - this does not rule out the MTD driver 
though. I am working on a test now that tests (from uboot) the 30 MB of 
flash area beyond uboot.

Any other ideas?

Frank
