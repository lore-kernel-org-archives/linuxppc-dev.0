Message-ID: <DF2B720CF774D21189EE00805FA7FA220517838F@nmrusdunsx3.nielsenmedia.com>
From: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
To: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: What Does a Linux Image Expect From U-boot?
Date: Fri, 7 Feb 2003 15:47:11 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

I'm doing an "off the books" project here at work to bring up Linux on one
of our in-house designed targets.  We have several designs that share the
same core architecture: MPC850 @ 80 MHz., 32 M-byte SDRAM, 4 M-byte boot
flash, SMC console, and Ethernet.  These designs are quite stable and
already in production.  We also have visionICE/visionCLICK debugging tools.

Our low-level boot code sets up the UPMA table and the basic address map
(SDRAM at 0x00000000, IMMR at 0xfb000000, FLASH at 0xffc00000), moves an
image from either FLASH or UDP/IP/Ethernet into SDRAM, turns off all I/O,
and jumps to the loaded image.  All of this works quite nicely with our
current production software.  Switching to u-boot at this point is not a
desirable option.

Because of the similarity to our targets, I've built an RPXLite image from
Rev. 4.2.19 sources.  I have made modifications of the sources to
accommodate differences between our board and the RPXLite (e.g., we don't
have a configuration register).  I have also built a root filesystem image
from the sources available on the "www.embeddedlinuxinterfacing.com" web
site.  All of this has been combined into a single compressed image and all
looks good.  When I run this image it hangs in panic.  I don't have console
I/O yet.  No joy in Mudville.

My strategy has been to put whatever code is necessary at the beginning of
"linux/arch/ppc/boot/simple/head.S" to make the compressed image think it
just got control from u-boot.  Since I have the SDRAM setup at location
0x00000000 and the FLASH and IMMR are up high out of the way, this seems
reasonable.

I've found definitions for the bd_info structure in
"linux/include/asm/rpxlite.h" and in "linux/include/asm/ppcboot.h".  I
believe I've setup a bd_info structure as specified in "ppcboot.h" since
this matches "u-boot-0.2.0/include/asm-ccp/u-boot.h".  I'm still not sure
I've got everything setup correctly.

Question: Is there a specification of how the compressed Linux image expects
an MPC8xx system to be set up (i.e., a requirements spec.) or is
"linux/.../ppcboot.h" and "u-boot/.../u-boot.h" it?  Does the SMC need to be
initialized?  How about Ethernet?, etc., etc.  Any guidance would be
appreciated.

Regards,
Charlie

Charles.Wells@NielsenMedia.com
727.738.3000 ext.2756

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
