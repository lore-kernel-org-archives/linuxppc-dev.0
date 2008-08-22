Return-Path: <skepper@chara.vm.bytemark.co.uk>
Received: from chara.vm.bytemark.co.uk (chara.vm.bytemark.co.uk [80.68.89.253])
	by ozlabs.org (Postfix) with ESMTP id 6DC47DE6A1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 01:53:03 +1000 (EST)
Received: from skepper (helo=localhost)
	by chara.vm.bytemark.co.uk with local-esmtp (Exim 3.36 #1 (Debian))
	id 1KWYZt-0008Gc-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 22 Aug 2008 16:29:29 +0100
Date: Fri, 22 Aug 2008 16:29:29 +0100 (BST)
From: Chris Skepper <skepper@ukf.net>
To: linuxppc-embedded@ozlabs.org
Subject: Early boot problem with MPC8247 and Linux 2.6.26
Message-ID: <Pine.LNX.4.62.0808221515450.31216@chara.vm.bytemark.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: Chris Skepper <skepper@chara.vm.bytemark.co.uk>
Reply-To: skepper@ukf.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have a custom MPC8247 based board which has been running U-boot 1.3.5 
and Linux 2.6.26.  It has been working fine with ARCH=ppc, but I now want 
to make it work using ARCH=powerpc.

However, using ARCH=powerpc I have encountered a problem.  Whatever I do 
it always appears to reset in the very early stages of booting the kernel. 
This is before the kernel can print anything on the console, so the last 
thing you see is this from the bootloader:

## Booting kernel from Legacy Image at 00400000 ...
    Image Name:   Linux-2.6.26
    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
    Data Size:    1555842 Bytes =  1.5 MB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
    Uncompressing Kernel Image ... OK
## Current stack ends at 0x07bb6c68
*  fdt: cmdline image address = 0x00800000
## Checking for 'FDT'/'FDT Image' at 00800000
*  fdt: raw FDT blob
## Flattened Device Tree blob at 00800000
    Booting using the fdt blob at 0x800000
    of_flat_tree at 0x00800000 size 0x00000d3d
## device tree at 0x00800000 ... 0x00800D3C (len=15677=0x3D3D)
    Loading Device Tree to 007fc000, end 007ffd3c ... OK
## Transferring control to Linux (at address 00000000) ...
    Booting using OF flat tree...

I am using U-boot to pass a DTB, which could be buggy or incomplete, 
however, I think it encounters problems before the DTB is accessed by the 
kernel.

Using code to flash an LED I have traced execution from the entry point in 
head_32.S, through to call_setup_cpu in misc.S, __setup_cpu_603 and into 
setup_common_caches in cpu_setup_6xx.S.  It appears to reset when enabling 
the cache on the CPU:

setup_common_caches:
 	mfspr	r11,SPRN_HID0
 	andi.	r0,r11,HID0_DCE
 	ori	r11,r11,HID0_ICE|HID0_DCE
 	ori	r8,r11,HID0_ICFI
 	bne	1f			/* don't invalidate the D-cache */
 	ori	r8,r8,HID0_DCI		/* unless it wasn't enabled */
1:	sync
     /* Chris: Reaches here. */
 	mtspr	SPRN_HID0,r8		/* enable and invalidate caches */
 	sync
 	mtspr	SPRN_HID0,r11		/* enable caches */
 	sync
 	isync
     /* Chris: Never gets to here. */
 	blr

FWIW, commenting out the lines above causes it to hang when attempting to 
enable the MMU, which is the next step in the process.

I assume it's likely that something has already gone wrong before this 
point.  Has anyone got any idea how the CPU could have got into a state 
where trying to enable the caches could cause it to reset?

Also, can anyone confirm that the MPC8247 is supported by a 2.6.26 kernel 
with ARCH=powerpc mode?  I think it should be, but it would be good to 
know that someone has tried it.

Cheers,

Chris.
