Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <sbcfef39.080@siemens.com.br>
Date: Fri, 19 Oct 2001 10:15:11 -0300
From: "PAULO SELEME CORREA PAULO" <paulo.correa@siemens.com.br>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re:ramdisk initrd
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Wolfgang Denk,

     Thank you very much for your answer, I am sorry if I counldn't explain my self clrearer but I will try to show what I did and what I am still trying to do...

      I made the ram disk image with the following script :

     dd if=/dev/zero of=/dev/ram bs=1k count=4096
     mke2fs -vm0 /dev/ram 4096
     mkdir -p /mnt/ram
     (cd file_system; cp -a * /mnt/ram)
     umount /mnt/ram
     rmdir /mnt/ram
     dd if=/dev/ram of=fs_images/ramdiskimage bs=1k count=4096
     gzip -v9f ramdisk.image

     I copied the ramdisk.image.gz to /opt/hardhat/devkit/ppc/8xx/target/boot
     and
     executed ./mkimage -n "ramdiskimage"-d  ramdisk.image.gz ramdiskimage

     I compiled a new kernel with the support for ramdisk and copied the image to      /opt/hardhat/devkit/ppc/8xx/target/boot

     I set the boot parameters to download the kernel via tftp to the target board so when I reset the board it runs ppcboot download the kernel uncompress it and then try to mout the root file system.
      What I didn't understand is how can I download the RAMDISK image to a specific memory area during the boot so when mounting the root filesystem it can find the ramdisk image in memory.

      And I don't know how to download the RAMDISK image to the memory to execute the bootm command as explained in PPcboot README  :
If you want to boot a Linux kernel with initial ram disk, you pass
the memory addreses of both the kernel and the initrd image (PPBCOOT
format!) to the "bootm" command:
...
        => bootm 40100000 40200000
        ## Booting Linux kernel at 40100000 ...
           Image Name:   2.2.13 for initrd on TQM850L
           Image Type:   PowerPC Linux Kernel Image (gzip compressed)
           Data Size:    335725 Bytes = 327 kB = 0 MB
           Load Address: 00000000
           Entry Point:  0000000c
           Verifying Checksum ... OK
           Uncompressing Kernel Image ... OK
        ## Loading RAMDisk Image at 40200000 ...
           Image Name:   Simple Ramdisk Image
           Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
           Data Size:    566530 Bytes = 553 kB = 0 MB
           Load Address: 00000000
           Entry Point:  00000000
           Verifying Checksum ... OK
           Loading Ramdisk ... OK
        Linux version 2.2.13 (wd@denx.local.net) (gcc version 2.95.2 19991024 (release)) #1 Wed Jul 19 02:32:08 MEST 2000

       I tried the loads command but had no success

       I apologise if it is still confusing and thank you in advance for your help

       Paulo Correa


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
