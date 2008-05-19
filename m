Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 483F1DDFB3
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 09:00:09 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JyEKp-0002cw-2Q
	for linuxppc-dev@ozlabs.org; Mon, 19 May 2008 23:00:03 +0000
Received: from dogwood.cspi.com ([192.41.172.172])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 23:00:03 +0000
Received: from ghannon by dogwood.cspi.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 23:00:03 +0000
To: linuxppc-dev@ozlabs.org
From: Gary Hannon <ghannon@cspi.com>
Subject: .dtb file for =?utf-8?b?bXBjODY0MV9ocGNu?= failing on recent
	kernel/u-boot.
Date: Mon, 19 May 2008 22:57:29 +0000 (UTC)
Message-ID: <loom.20080519T223903-170@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

I'm trying to boot a recent (2.6.25.4) kernel with 
a recent u-boot (1.3.3) and it's getting stuck very 
early in the boot.

I'm using

../dtc -I dts -O dtb mpc8641_hpcn.dts > mpc8641_hpcn.dtb

    in arch/powerpc/boot/dts/ to create the .dtb file.


=> boot
Speed: 100, full duplex
Using eTSEC1 device
TFTP from server 192.41.172.8; our IP address is 192.41.172.157
Filename 'pluto.uImage'.
Load address: 0x1000000
Loading: #################################################################
         #################################################################
         ###############################
done
Bytes transferred = 2352548 (23e5a4 hex)
Speed: 100, full duplex
Using eTSEC1 device
TFTP from server 192.41.172.8; our IP address is 192.41.172.157
Filename 'pluto.dtb'.
Load address: 0xc00000
Loading: #
done
Bytes transferred = 8722 (2212 hex)
## Booting kernel from Legacy Image at 01000000 ...
   Image Name:   Linux-2.6.25.4
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    2352484 Bytes =  2.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
WARNING: adjusting available memory to 10000000
## Flattened Device Tree blob at 00c00000
   Booting using the fdt blob at 0xc00000
   Loading Device Tree to 007fd000, end 007ff211 ... OK
WARNING: could not create /chosen FDT_ERR_NOSPACE.
ERROR: /chosen node create failed - must RESET the board to recover.

U-Boot 1.3.3 (May 19 2008 - 15:59:50)

Freescale PowerPC
CPU:
    Core: E600 Core 0, Version: 0.2, (0x80040202)
    System: Unknown, Version: 2.0, (0x80900120)
    Clocks: CPU:1000 MHz, MPX: 400 MHz, DDR: 200 MHz, LBC:  50 MHz
    L2: Enabled
Board: MPC8641HPCN

Results I get when booting are...

.
.
.
Continues in an infinite loop.

I've not changed anything in the kernel or u-boot source.

Do I need to add anything to u-boot's environment?
Am I using the .dtb file incorrectly?
Am I missing a flag on the dtc?

Thanks for any pointers,

Gary Hannon
CSPI
ghannon@cspi.com
