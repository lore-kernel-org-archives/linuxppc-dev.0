Return-Path: <rwoodworth@securics.com>
Received: from securics.com (dns.securics.com [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id 0F3CCDDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 02:28:51 +1000 (EST)
Received: from [192.168.0.38] (unknown [192.168.0.38])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by securics.com (Postfix) with ESMTP id 3CBE8B8C0B9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Aug 2007 10:00:55 -0600 (MDT)
Subject: Xilinx Virtex4 FX PPC
From: Robert Woodworth <rwoodworth@securics.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Mon, 20 Aug 2007 10:00:54 -0600
Message-Id: <1187625654.6336.28.camel@PisteOff>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello All!

I'm beginning development with a Xilinx PPC/FPGA.  I've now gotten my
feet wet and have a few successes and a few head scratches.

I have a Xilinx ML403 dev board.  I ran the Monta-Vista Linux 2.4 demo.
good.



Now for my own attempt.  
(Please reply if anything I'm doing is incorrect)

I found a pre-built toolchain for my i686 Debian host with 
gcc-4.1.1 + glibc6.  I downloaded kernel 2.6.23-rc3 after reading
several posts on this list about the ML403 and drivers in this kernel
version.

Problem 1:  The kernel did not have the correct memory information.  I
noticed in 'embed_config.c' that the board params are hard coded,
however my kernel was not linking with that version of embed_config().
It was linking with embed_config() in 'misc-embedded.c'   
Did I miss a config parameter in the kernel config??


My kernel now boots and mounts the MontaVista rootfs on the SystemACE
Flash!!! :)



Problem 2:  Build my own rootfs.
If I try to build my own programs (busybox and bash at this point) with
shared libc using the same glibc from my toolchain, I get an "Illegal
instruction" error.  Is my glibc not compatible with my Xilinx PPC 405??


If I try to build a rootfs with debian ppc packages I have the same
"Illegal instruction" error.



Question 1:
Do I need a special glibc for the Xilinx PPC 405????  
Does a normal PPC glibc have more "advanced" instructions compiled in
that will not work on a Xilinx PPC 405??

Question 2:
Is it true that the xparameters.h file produced by Xilinx EDK is not
compatible with the current 2.6.23 kernel??  It appears that if I change
params (addresses or IRQ's) in my Xilinx EDK I need to hand edit the
xparameters.h in the kernel source tree.  True?  


BTW: My Xilinx EDK is version 9.1i with full ISE 9.1i.




I'm looking forward to helping the Linux on Xilinx PPC effort!!

Woody.
