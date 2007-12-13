Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DB2E3DE116
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 10:43:41 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: grant.likely@secretlab.ca, simekm2@fel.cvut.cz,
	jwilliams@itee.uq.edu.au, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/7] [POWERPC] Xilinx: clear data caches.
Date: Thu, 13 Dec 2007 15:43:28 -0800
In-Reply-To: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com>
Message-Id: <20071213234240.F3CC3AD805D@mail122-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This code is needed to boot without a boot loader.

Grant:  I'm not sure where the right place to put this is.  I'm assuming we'll actually need some boot code that is not generic?  Also, note that there is a V4FX errata workaround in arch/ppc/boot/head.S, which probably also needs to get pulled to powerpc.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 arch/powerpc/boot/raw-platform.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/raw-platform.c b/arch/powerpc/boot/raw-platform.c
index b9caeee..2a5e493 100644
--- a/arch/powerpc/boot/raw-platform.c
+++ b/arch/powerpc/boot/raw-platform.c
@@ -24,6 +24,28 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
                    unsigned long r6, unsigned long r7)
 {
 	u64 memsize64 = memsize[0];
+	static const unsigned long line_size = 32;
+	static const unsigned long congruence_classes = 256;
+	unsigned long addr;
+	unsigned long dccr;
+
+	/*
+	 * Invalidate the data cache if the data cache is turned off.
+	 * - The 405 core does not invalidate the data cache on power-up
+	 *   or reset but does turn off the data cache. We cannot assume
+	 *   that the cache contents are valid.
+	 * - If the data cache is turned on this must have been done by
+	 *   a bootloader and we assume that the cache contents are
+	 *   valid.
+	 */
+	__asm__("mfdccr %0": "=r" (dccr));
+	if (dccr == 0) {
+		for (addr = 0;
+		     addr < (congruence_classes * line_size);
+		     addr += line_size) {
+			__asm__("dccci 0,%0": :"b"(addr));
+		}
+	}
 
 	if (mem_size_cells == 2) {
 		memsize64 <<= 32;
-- 
1.5.3.4
