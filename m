Return-Path: <benjamin.zores@alcatel-lucent.fr>
Received: from smail4.alcatel.fr (smail4.alcatel.fr [62.23.212.167])
	by ozlabs.org (Postfix) with ESMTP id 020B9DDEBC
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 19:20:52 +1000 (EST)
Received: from bsf.alcatel.fr (mail205.sxb.bsf.alcatel.fr [155.132.205.115])
	by smail4.alcatel.fr (ALCANET/NETFR) with ESMTP id l3B9DvlF021762
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 11:13:58 +0200
Received: from mail (mail-bsf-alcatel-fr.sxb.bsf.alcatel.fr [155.132.205.91])
	by bsf.alcatel.fr (8.8.8p2+Sun/8.9.3) with ESMTP id LAA04526
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 11:13:57 +0200 (MET DST)
Received: from frilld0063506 (frilld0063506 [172.25.48.83])
	by mail (8.8.8p2+Sun/) with SMTP id LAA04522
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 11:13:57 +0200 (MET DST)
Date: Wed, 11 Apr 2007 11:09:35 +0200
From: Benjamin Zores <benjamin.zores@alcatel-lucent.fr>
To: linuxppc-dev@ozlabs.org
Subject: Strange behavior when booting MPC8349E-mITX card.
Message-Id: <20070411110935.1161908f.benjamin.zores@alcatel-lucent.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I've noticed a strange behavior when booting an MPC8349E-mITX card
in PowerPC architecture (not ppc) on Linux 2.6.19.2.

It seems like early parts of the kernel featuring platform configuration are executed twice ? I don't know if it's intended or not but at least the card
works pretty well. I boots completely and there's no problem with that.
I just want to understand why it does such a thing.

I'm running a vanilla 2.6.19.2 kernel, ARCH=powerpc make mpc834x_itx_defconfig
and the vanilla DTS file for this card.

I don't have other platform to test this behavior.
Does anyone else noticed the same thing ?

Below is u-boot sequence + early kernel logs.

Ben

*********************

## Booting image at 00200000 ...
   Image Name:   Linux-2.6.19.2
   Created:      2007-04-03  13:34:56 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1434995 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00500000 ...
   Image Name:   uboot ext2 ramdisk rootfs
   Created:      2006-10-19  21:17:10 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1911054 Bytes =  1.8 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Booting using flat device tree at 0x400000
   Loading Ramdisk to 0fda1000, end 0ff7390e ... OK
Using MPC834x ITX machine description
Linux version 2.6.19.2 (bezores@frilld0063506) (gcc version 4.1.1) #6 Tue Apr 3 15:34:49 C7
Found initrd at 0xcfda1000:0xcff7390e
setup_arch: bootmem
mpc834x_itx_setup_arch()
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus number: 0->0
Found MPC83xx PCI host bridge at 0x00000000e0008600. Firmware bus number: 1->1
arch: exit
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
early_node_map[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists.  Total pages: 65024
Kernel command line: root=/dev/ram console=ttyS0,115200
IPIC (128 IRQ sources) at fbffb700
PID hash table entries: 1024 (order: 10, 4096 bytes)
             
Using MPC834x ITX machine description
Linux version 2.6.19.2 (bezores@frilld0063506) (gcc version 4.1.1) #6 Tue Apr 3 15:34:49 C7
Found initrd at 0xcfda1000:0xcff7390e
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus number: 0->0
Found MPC83xx PCI host bridge at 0x00000000e0008600. Firmware bus number: 1->1
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
early_node_map[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists.  Total pages: 65024
Kernel command line: root=/dev/ram console=ttyS0,115200
IPIC (128 IRQ sources) at fbffb700
PID hash table entries: 1024 (order: 10, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 254592k/262144k available (2808k kernel code, 7240k reserved, 112k data, 91k bss, )
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1866k freed
...
