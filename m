Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 6F842DE5C7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jun 2008 02:18:48 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K6pVV-0002uf-A7
	for linuxppc-embedded@ozlabs.org; Thu, 12 Jun 2008 16:18:38 +0000
Received: from fw-emea.rohde-schwarz.com ([80.246.32.33])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 12 Jun 2008 16:18:37 +0000
Received: from euphoria by fw-emea.rohde-schwarz.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 12 Jun 2008 16:18:37 +0000
To: linuxppc-embedded@ozlabs.org
From: Florian Boelstler <euphoria@arcor.de>
Subject: Reserving small amounts of memory with mem= (MPC85xx, 2.6.15 arch/ppc)
Date: Thu, 12 Jun 2008 18:18:26 +0200
Message-ID: <g2ri8j$qlk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I ran into problems reserving small amounts of memory using command line 
argument 'mem'.
Limiting a MPC8540 with 512MB physical available memory down to 256MB 
has been successfully done using U-Boot:

=> setenv bootargs console=ttyS0,115200 mem=256M
=> setenv initrd_high 10000000
=> bootm 0x02100000

## Booting image at 02100000 ...
    Image Name:   Linux 2.6.15
    Image Type:   PowerPC Linux Multi-File Image (gzip compressed)
    Data Size:    6965022 Bytes =  6.6 MB
    Load Address: 00000000
    Entry Point:  00000000
    Contents:
    Image 0:  1099550 Bytes =  1 MB
    Image 1:  5865458 Bytes =  5.6 MB
    Verifying Checksum ... OK
    Uncompressing Multi-File Image ... OK
[...]
    Loading Ramdisk to 0fa68000, end 0ffffff2 ... OK

Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.15 (flo@escape) (gcc version 3.4.3) #21 PREEMPT Fri 
Nov 30 16:47:32 CET 2007
[...]

root@mpc0:/# cat /proc/meminfo
MemTotal:       257272 kB
MemFree:        226332 kB
[...]

When a larger size for 'mem' (say 508M for reserving 4M) and appropriate 
'initrd_high' is used, U-Boot is still able to load the ramdisk to its 
correct place in RAM. However Linux seems to not accept that memory 
region and removes the memory using mem_pieces_remove(), which leads to 
a crash since it cannot access area used for the ramdisk(?).
In that case output of "residual" for CAM mapping shows a value != 0.

My assumption is that these CAM mappings cannot be used for memory 
portions less than a certain size.
I need to dig into that, please correct me if I'm wrong.

Linux 2.6.15 build for arch/ppc on custom MPC8540 board (Linux BSP 
similar to MPC8540ads). U-Boot 1.2.0.

Thanks for any suggestions.

   Florian
