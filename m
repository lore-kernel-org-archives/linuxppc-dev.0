Return-Path: <nathael.pajani@cpe.fr>
Received: from smtp-out.completel.net (smtp-out.completel.net [83.145.110.35])
	by ozlabs.org (Postfix) with ESMTP id EF84C685A1
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Oct 2005 22:01:32 +1000 (EST)
Received: from [192.52.109.152] (unknown [83.145.98.3])
	by smtp-out.completel.net (Postfix) with ESMTP id 34D3925C06E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Oct 2005 14:01:29 +0200 (CEST)
Message-ID: <435392FC.1000702@cpe.fr>
Date: Mon, 17 Oct 2005 14:03:08 +0200
From: Nathael PAJANI <nathael.pajani@cpe.fr>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20051017090007.A5070685B3@ozlabs.org>
In-Reply-To: <20051017090007.A5070685B3@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: kernel panic with VFS unable to mount root fs on 01:00 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

linuxppc-embedded-request@ozlabs.org wrote:
> i use MPC862 with 64mb ram on my custom board , i use eldk 3.1.1 , with linux-2.4.25 and
 > ramdisk_image.gz provided by  denx eldk ,
> 
> when i boot kernel with ramdisk image , kernel at 0x500000 and ramdisk at 0x600000 ,
 > i get the following message given below ,
> on uboot i use smc2 , on linux i use scc4 , as i got som eproblem getting smc2 up on linux kernel ,
 > i get always kernel panic with VFS unable to mount root fs on 01:00 ,
> i used even multi image clubbing vmlinux.gz and ramdisk_image.gz even this gives me the same result , 
> 
> is there something else i should configure or i am missing something else imp ,
> 
> thanks in advance 
> regards
> neelu
> 
> __ioremap(): phys addr 03e13000 is RAM lr c000c1c8                             
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize          
> NET4: Linux TCP/IP 1.0 for NET4.0                                              
> IP Protocols: ICMP, UDP, TCP                                                   
> IP: routing cache hash table of 512 buckets, 4Kbytes                           
> TCP: Hash tables configured (established 4096 bind 8192)                       
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.                            
> Kernel panic: VFS: Unable to mount root fs on 01:00                            
> <0>Rebooting in 180 seconds..                                                 
>                                   
> #
> # Platform support
> #
> CONFIG_PPC=y
> CONFIG_PPC32=y
> CONFIG_8xx=y
> # CONFIG_PPC_STD_MMU is not set
> CONFIG_SERIAL_CONSOLE=y
> CONFIG_NOT_COHERENT_CACHE=y
> CONFIG_MBX=y
> CONFIG_MATH_EMULATION=y
> CONFIG_EMBEDDEDBOOT=y
> 
> #
> # General setup
> #
> # CONFIG_HIGHMEM is not set
> CONFIG_HIGHMEM_START=0xfe000000
> CONFIG_LOWMEM_SIZE=0x30000000
> CONFIG_KERNEL_START=0xc0000000
> CONFIG_TASK_SIZE=0x80000000

> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_BLK_DEV_INITRD=y
> #
> # File systems
> #
> CONFIG_AUTOFS_FS=y
> CONFIG_RAMFS=y
> CONFIG_PROC_FS=y
> CONFIG_EXT2_FS=y


 > CONFIG_BLK_DEV_RAM_SIZE=4096

You should try with 8K (this solved the problem for me)


and on my side the command line root option is root=/dev/ram, but I'm 
using a ramdisk made by someone else so I do not know much about it, and 
a 2.6.13 kernel, so this may be different.
and before VFS outputs any message, RAMDISK says:

RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).

And make sure the file system in the ramfs is ext2.. but I think the 
message would be different in this case.
