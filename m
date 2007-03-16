Return-Path: <linuxppcemb@lkmail.de>
Received: from pm1.terions.de (pm1.terions.de [83.137.96.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.s-s-l.net",
	Issuer "Equifax Secure Global eBusiness CA-1" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A27B7DDEF7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 19:11:04 +1100 (EST)
From: "Lorenz Kolb" <linuxppcemb@lkmail.de>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.1.1174006801.15907.linuxppc-embedded@ozlabs.org>
Subject: RE: u-boot+linux for ML403 board;
	Linuxppc-embedded Digest, Vol 31, Issue 35
Date: Fri, 16 Mar 2007 09:10:39 +0100
Message-ID: <001301c767a2$96a07710$10b2a8c0@lorenzulm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.1.1174006801.15907.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Leonid,

The only thing I had to do with the kernel 2.6.19 from denx.de (but this was
the 2.6.19 don't know about newer ones) is the typical board_info struct
patch:

diff -Naur linux-2.6.19/arch/ppc/platforms/4xx/xilinx_ml403.h
../linux-2.6.19-xemac/arch/ppc/platforms/4xx/xilinx_ml403.h
--- linux-2.6.19/arch/ppc/platforms/4xx/xilinx_ml403.h	2007-01-05
11:12:24.000000000 +0100
+++ ../linux-2.6.19-xemac/arch/ppc/platforms/4xx/xilinx_ml403.h	2007-01-12
14:47:24.000000000 +0100
@@ -24,13 +24,7 @@
 
 #include <linux/types.h>
 
-typedef struct board_info {
-	unsigned int	 bi_memsize;		/* DRAM installed, in bytes
*/
-	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC
address */
-	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
-	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
-	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
-} bd_t;
+#include <asm/ppcboot.h>
 
 /* Some 4xx parts use a different timebase frequency from the internal
clock.
 */

Greetings,

Lorenz
 
> 
> Message: 3
> Date: Thu, 15 Mar 2007 16:50:15 -0700
> From: "Leonid" <Leonid@a-k-a.net>
> Subject: u-boot+linux for ML403 board.
> To: <linuxppc-embedded@ozlabs.org>
> Message-ID:
> 	
> <406A31B117F2734987636D6CCC93EE3C0129DDD5@ehost011-3.exch011.i
ntermedia.net>
> 	
> Content-Type: text/plain;	charset="us-ascii"
> 
> Hi:
> 
> Does anybody use u-boot+linux on ML403 board? If yes, can 
> somebody give
> me kernel or kernel patch to any open source kernel tree (DENX or
> kernel.org).
> 
> I couldn't prepare uImage which is working with u-boot on 
> ML403 board -
> it hangs forever:
> 
> TFTP from server 192.168.0.141; our IP address is 192.168.0.203
> Filename 'LM200/rel/1.0.1d-403/uImage'.
> Load address: 0x400000
> Loading: T
> #################################################################
>  
> #################################################################
>          #######################################
> done
> Bytes transferred = 861911 (d26d7 hex)
> ## Booting image at 00400000 ...
>    Image Name:   Linux-2.6.19.2
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    861847 Bytes = 841.6 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Current stack ends at 0x03E676F0 => set upper limit to 0x00800000
> Board Info pointer (kbd) at 007ffe80 ## cmdline at 0x007FFF00 ...
> 0x007FFFF8
> memstart    = 0x00000000
> memsize     = 0x04000000
> flashstart  = 0x28000000
> flashsize   = 0x00800000
> flashoffset = 0x00000000
> sramstart   = 0x00000000
> sramsize    = 0x00000000
> bootflags   = 0x00000000
> procfreq    =    300 MHz
> plb_busfreq =    100 MHz
> ethaddr     = 00:01:02:CB:CB:71
> IP addr     = 192.168.0.203
> baudrate    = 115200 bps
> No initrd
> ## Transferring control to Linux (at address 00000000) ..
> 
> Thanks,
> 
> Leonid.
> 
> 
> ------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> End of Linuxppc-embedded Digest, Vol 31, Issue 35
> *************************************************
> 
