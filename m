Return-Path: <alexander@mdivac.com>
Received: from mail.mdivac.com (adsl-68-253-104-89.dsl.bcvloh.ameritech.net
	[68.253.104.89]) by ozlabs.org (Postfix) with ESMTP id 3BA8D679F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Aug 2006 04:05:30 +1000 (EST)
Message-ID: <44DA210D.5010101@mdivac.com>
Date: Wed, 09 Aug 2006 13:53:17 -0400
From: stevea-mdi <alexander@mdivac.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: U-Boot on Xilinx ML403/patch for ml403&ml300 UBoot
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: alexander@mdivac.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ming Lui asks

>Are there any patches needed? Any document about this topic is 
>appreciated. Thanks a lot for your help.

Yes.  I'd recommend applying Ameet's patches at
http://www.linux.get2knowmore.com/
however you will still need to change a few macro lines for the
COMPACTFLASH addresses.

There is also a major error in the board_info structure.  Someone
changed this data structure for the ml403 & ml300 so that it
no longer matches the UBoot form.  The one in asm/ppcboot.h is
correct. Someone else asked about this back in June.  So ....


diff -Naur linux-2.6.17-4.patch1/arch/ppc/platforms/4xx/xilinx_ml300.h linux-2.6.17-4.working/arch/ppc/platforms/4xx/xilinx_ml300.h
--- linux-2.6.17-4.patch1/arch/ppc/platforms/4xx/xilinx_ml300.h 2006-07-25 16:42:50.000000000 -0400
+++ linux-2.6.17-4.working/arch/ppc/platforms/4xx/xilinx_ml300.h        2006-08-02 19:47:00.000000000 -0400
@@ -19,14 +19,7 @@
 #ifndef __ASSEMBLY__

 #include <linux/types.h>
-
-typedef struct board_info {
-       unsigned int     bi_memsize;            /* DRAM installed, in bytes */
-       unsigned char    bi_enetaddr[6];        /* Local Ethernet MAC address */
-       unsigned int     bi_intfreq;            /* Processor speed, in Hz */
-       unsigned int     bi_busfreq;            /* PLB Bus speed, in Hz */
-       unsigned int     bi_pci_busfreq;        /* PCI Bus speed, in Hz */
-} bd_t;
+#include <asm/ppcboot.h>

 /* Some 4xx parts use a different timebase frequency from the internal clock.
 */
diff -Naur linux-2.6.17-4.patch1/arch/ppc/platforms/4xx/xilinx_ml403.h linux-2.6.17-4.working/arch/ppc/platforms/4xx/xilinx_ml403.h
--- linux-2.6.17-4.patch1/arch/ppc/platforms/4xx/xilinx_ml403.h 2006-07-25 16:42:50.000000000 -0400
+++ linux-2.6.17-4.working/arch/ppc/platforms/4xx/xilinx_ml403.h        2006-08-02 19:46:46.000000000 -0400
@@ -23,14 +23,7 @@
 #ifndef __ASSEMBLY__

 #include <linux/types.h>
-
-typedef struct board_info {
-       unsigned int     bi_memsize;            /* DRAM installed, in bytes */
-       unsigned char    bi_enetaddr[6];        /* Local Ethernet MAC address */
-       unsigned int     bi_intfreq;            /* Processor speed, in Hz */
-       unsigned int     bi_busfreq;            /* PLB Bus speed, in Hz */
-       unsigned int     bi_pci_busfreq;        /* PCI Bus speed, in Hz */
-} bd_t;
+#include <asm/ppcboot.h>

 /* Some 4xx parts use a different timebase frequency from the internal clock.
 */
