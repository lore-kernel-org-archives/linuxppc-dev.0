Return-Path: <iluri@fagorautomation.es>
Received: from correo2.sarenet.es (correo2.sarenet.es [194.30.0.12])
	by ozlabs.org (Postfix) with ESMTP id C9F63679E6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 20:36:27 +1000 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by correo2.sarenet.es (Postfix) with ESMTP id 2C58F368A6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 12:36:10 +0200 (CEST)
Message-ID: <44718702.1070809@fagorautomation.es>
Date: Mon, 22 May 2006 11:40:18 +0200
From: Igor Luri <iluri@fagorautomation.es>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: CRAMFS: Error -3 while decompressing!
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

Hi all!

We have a mpc5200liteB evaluation board with u-boot 1.1.4 and linux 
2.4.25 from Denx.  We have grabed a cramfs  root fs on a mtd partition 
and we are able to boot linux without problems:

    setenv bootargs root=/dev/mtdblock4 rw rootfstype=cramfs
    console=ttyS0 console=ttyS0 init=/sbin/init ip=on
    ....
    NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
    VFS: Mounted root (cramfs
    filesystem).                                                                         

    Freeing unused kernel memory: 96k
    init                                                                         
                                                                                                                                                                                                                                         

    BusyBox v1.00 (2006.03.06-10:43+0000) Built-in shell
    (ash)                                                     
    Enter 'help' for a list of built-in commands.           
    #


However, we are not able to boot linux with the same rootfs image (with 
the u-boot header) loaded from RAM.

        setenv bootargs root=/dev/rw rw console=ttyS0 console=ttyS0
        init=/sbin/init ip=on

        ## Booting image at 00500000 ...
           Image Name:   Linux-2.4.25-rthal5-TRACE
           Created:      2006-05-11   9:37:52 UTC
           Image Type:   PowerPC Linux Kernel Image (gzip compressed)
           Data Size:    1000166 Bytes = 976.7 kB
           Load Address: 00000000
           Entry Point:  00000000
           Verifying Checksum ... OK
           Uncompressing Kernel Image ... OK
        ## Loading RAMDisk Image at 01000000 ...
           Image Name:   Ramdisk Image
           Created:      2006-05-22   8:12:03 UTC
           Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
           Data Size:    1191936 Bytes =  1.1 MB
           Load Address: 00000000
           Entry Point:  00000000
           Verifying Checksum ... OK
           Loading Ramdisk to 0fe22000, end 0ff45000 ... OK
        Memory BAT mapping: BAT2=256Mb, BAT3=0Mb, residual: 0Mb
        Linux version 2.4.25-rthal5-TRACE (igor@ILURI_LINUX) (gcc
        version 3.3.6) #300 jue may 11 11:33:57 CEST 2006
        On node 0 totalpages: 65536
        zone(0): 65536 pages.
        zone(1): 0 pages.

        ....
        NET4: Unix domain sockets 1.0/SMP for Linux
        NET4.0.                                                             
        RAMDISK: cramfs filesystem found at block
        0                                                                   
         
        RAMDISK: Loading 1164 blocks [1 disk] into ram disk...
        done.                                                    
        Freeing initrd memory: 1164k
        freed                                                                            
         
        VFS: Mounted root (cramfs filesystem)
        readonly.                                                               
         
        Freeing unused kernel memory: 96k
        init                                                                        
         
        Error -3 while
        decompressing!                                                                                 
         
        c0224e84(1616147664)->c0214000(4096)                                                                          
         
        Error -3 while
        decompressing!                                                                                 
         
        c02286d8(-965246762)->cff41000(4096)                                                                          
         
        Kernel panic: No init found.  Try passing init= option to
        kernel.                                               
         <0>Rebooting in 180 seconds..                         

We have configured linux with option " Board uses U-Boot CONFIG_UBOOT " 
and CRAMFS image is built with correct endianess:

    file initrd.cramfs

    Linux Compressed ROM File System data, big endian size 1191936
    version #2 sorted_dirs CRC 0xac3c8f59, edition 0, 719 blocks, 433 files


We suspect it could be related with the SDRAM, but we are lost here.

Someone knows what we are doing wrong? Any help would be appretiated.


Thanks in advance.
