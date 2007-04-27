Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id 84BE2DE1B8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 05:50:39 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org,
	paulus@samba.org
Subject: [PATCH 7/7] [PPC] Don't define a custom bd_t for Xilixn Virtex based
	boards.
Date: Fri, 27 Apr 2007 13:50:05 -0600
Message-Id: <11777034162194-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11777034164090-git-send-email-grant.likely@secretlab.ca>
References: <11777034052773-git-send-email-grant.likely@secretlab.ca>
	<1177703413970-git-send-email-grant.likely@secretlab.ca>
	<1177703413868-git-send-email-grant.likely@secretlab.ca>
	<11777034143069-git-send-email-grant.likely@secretlab.ca>
	<11777034141879-git-send-email-grant.likely@secretlab.ca>
	<11777034152490-git-send-email-grant.likely@secretlab.ca>
	<11777034153009-git-send-email-grant.likely@secretlab.ca>
	<11777034164090-git-send-email-grant.likely@secretlab.ca>
Cc: Peter Korsgaard <jacmet@sunsite.dk>,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Rick Moleres <Rick.Moleres@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Why create a platform specific board_info structure that is hacked
together, ugly, and dangerous, when we've got a perfectly fine common
board_info structure that is hacked-together, ugly and dangerous.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/ppc/platforms/4xx/virtex.h |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/arch/ppc/platforms/4xx/virtex.h b/arch/ppc/platforms/4xx/virtex.h
index 4fc76da..7382804 100644
--- a/arch/ppc/platforms/4xx/virtex.h
+++ b/arch/ppc/platforms/4xx/virtex.h
@@ -14,6 +14,7 @@
 #define __ASM_VIRTEX_H__
 
 #include <asm/ibm405.h>
+#include <asm/ppcboot.h>
 
 /* Ugly, ugly, ugly! BASE_BAUD defined here to keep 8250.c happy. */
 #if !defined(BASE_BAUD)
@@ -21,22 +22,8 @@
 #endif
 
 #ifndef __ASSEMBLY__
-typedef struct board_info {
-	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
-	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
-	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
-	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
-	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
-} bd_t;
-
-/* Some 4xx parts use a different timebase frequency from the internal clock.
- * the Virtex 405 does not, so just use a macro to make tbfreq match intfreq
-*/
-#define bi_tbfreq bi_intfreq
-
 extern const char* virtex_machine_name;
 #define PPC4xx_MACHINE_NAME (virtex_machine_name)
-
 #endif /* !__ASSEMBLY__ */
 
 /* We don't need anything mapped.  Size of zero will accomplish that. */
-- 
1.5.1
