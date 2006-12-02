Return-Path: <trevor@vocaro.com>
Received: from relay2.es.uci.edu (relay2.es.uci.edu [128.200.80.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE2D967BD3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Dec 2006 21:34:01 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v752.3)
To: linuxppc-embedded@ozlabs.org
Message-Id: <7CE50161-1D3D-4069-8672-C625B134F95A@vocaro.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-18--85591712
Subject: Patch for newer EP405 boards...maybe
From: Trevor Harmon <trevor@vocaro.com>
Date: Sat, 2 Dec 2006 01:44:45 -0800
Cc: mlocke@mvista.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Apple-Mail-18--85591712
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

I have an Embedded Planet EP405, revision 1.3, running the PlanetCore  
bootloader v1.09. The main kernel tree has built-in support for this  
board. There's even a ready-made config file for it: arch/ppc/configs/ 
ep405_defconfig

Unfortunately, it seems that the EP405 support in the kernel must  
have been designed for a different (older?) board revision, perhaps  
different PlanetCore firmware too, because the stock kernel doesn't  
work with my EP405. The problem is that the serial baud rate is  
wrong, causing gibberish to appear on the console.

I was able to fix the problem with a couple of very small patches  
(attached). I'd like to submit them to the main kernel, but I can't  
because they'd break support for EP405 revisions other than mine. I'm  
not sure how to modify them so that the kernel works with my board  
while still maintaining compatibility with other revisions. Are there  
any EP405 hackers who could help me resolve this? Thanks,

Trevor


--Apple-Mail-18--85591712
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=embed_config.c.patch
Content-Disposition: attachment;
	filename=embed_config.c.patch

--- linux-2.6.19.orig/arch/ppc/boot/simple/embed_config.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/arch/ppc/boot/simple/embed_config.c	2006-12-01 21:29:59.000000000 -0800
@@ -867,11 +867,9 @@
 	   now, however the baud rates in ep405.h are for the internal
 	   clock. */
 	chcr0 = mfdcr(DCRN_CHCR0);
-	if ( (chcr0 & 0x1fff) != 0x103e ) {
-		mtdcr(DCRN_CHCR0, (chcr0 & 0xffffe000) | 0x103e);
+		mtdcr(DCRN_CHCR0, 0x10fe);
 		/* The following tricks serial_init() into resetting the baud rate */
 		writeb(0, UART0_IO_BASE + UART_LCR);
-	}
 
 	/* We haven't seen actual problems with the EP405 leaving the
 	 * EMAC running (as we have on Walnut).  But the registers

--Apple-Mail-18--85591712
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=ep405.h.patch
Content-Disposition: attachment;
	filename=ep405.h.patch

--- linux-2.6.19.orig/arch/ppc/platforms/4xx/ep405.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/arch/ppc/platforms/4xx/ep405.h	2006-12-02 00:08:53.000000000 -0800
@@ -43,7 +43,7 @@
 #define EP405_NVRAM_PADDR	((uint)0xf4200000)
 
 /* serial defines */
-#define BASE_BAUD		399193
+#define BASE_BAUD		(11059200 / 16)
 
 #define PPC4xx_MACHINE_NAME "Embedded Planet 405GP"
 

--Apple-Mail-18--85591712--
