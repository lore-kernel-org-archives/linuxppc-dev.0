Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51104DDEFF
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 00:47:01 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4FEkwAp004326
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 10:46:58 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4FEkwlR082966
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 08:46:58 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4FEkvC5028163
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 08:46:57 -0600
Received: from zod.rchland.ibm.com (wecm-9-67-211-47.wecm.ibm.com
	[9.67.211.47])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m4FEkul2028121
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 08:46:57 -0600
Date: Thu, 15 May 2008 09:43:46 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] 4xx: Workaround for CHIP_11 Errata
Message-ID: <20080515094346.3338e1f3@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PowerPC 440EP, 440GR, 440EPx, and 440GRx chips have an issue that
causes the PLB3-to-PLB4 bridge to wait indefinitely for transaction
requests that cross the end-of-memory-range boundary.  Since the DDR
controller only returns the valid portion of a read request, the bridge
will prevent other PLB masters from completing their transactions.

This implements the recommended workaround for this errata for chips that
use older versions of firmware that do not already handle it.  The last
4KiB of memory are hidden from the kernel to prevent the problem
transactions from occurring.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/4xx.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- linux-2.6.orig/arch/powerpc/boot/4xx.c
+++ linux-2.6/arch/powerpc/boot/4xx.c
@@ -21,6 +21,25 @@
 #include "reg.h"
 #include "dcr.h"
 
+static unsigned long chip_11_errata(unsigned long memsize)
+{
+	unsigned long pvr;
+
+	pvr = mfpvr();
+
+	switch (pvr & 0xf0000ff0) {
+		case 0x40000850:
+		case 0x400008d0:
+		case 0x200008d0:
+			memsize -= 4096;
+			break;
+		default:
+			break;
+	}
+
+	return memsize;
+}
+
 /* Read the 4xx SDRAM controller to get size of system memory. */
 void ibm4xx_sdram_fixup_memsize(void)
 {
@@ -34,6 +53,7 @@ void ibm4xx_sdram_fixup_memsize(void)
 			memsize += SDRAM_CONFIG_BANK_SIZE(bank_config);
 	}
 
+	memsize = chip_11_errata(memsize);
 	dt_fixup_memory(0, memsize);
 }
 
@@ -199,6 +219,7 @@ void ibm4xx_denali_fixup_memsize(void)
 		bank = 4; /* 4 banks */
 
 	memsize = cs * (1 << (col+row)) * bank * dpath;
+	memsize = chip_11_errata(memsize);
 	dt_fixup_memory(0, memsize);
 }
 
