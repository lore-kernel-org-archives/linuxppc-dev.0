Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 53970DDF1B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 03:17:00 +1000 (EST)
Message-ID: <46F7F0BF.5040605@scram.de>
Date: Mon, 24 Sep 2007 19:15:43 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH#2 4/4] [POWERPC] Fix cpm_uart driver
Content-Type: multipart/mixed; boundary="------------090203050004050103050109"
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090203050004050103050109
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


in cpm_uart_cpm1.h, DPRAM_BASE is assigned an address derived from cpmp.
On ARC=ppc, this is a physical address with 1:1 DMA mapping which can't
be used for arithmetric compare operations with virtual addresses
returned by cpm_dpram_addr. This patch changes the assignment to use
cpm_dpram_addr as well, like in cpm_uart_cpm2.h.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 drivers/serial/cpm_uart/cpm_uart_cpm1.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

--------------090203050004050103050109
Content-Type: text/x-patch;
 name="e99364db4224fcfaf74389d1b59ec0637d899c17.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e99364db4224fcfaf74389d1b59ec0637d899c17.diff"

diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.h b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
index a99e45e..2a64778 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
@@ -37,6 +37,6 @@ static inline void cpm_set_smc_fcr(volatile smc_uart_t * up)
 	up->smc_tfcr = SMC_EB;
 }
 
-#define DPRAM_BASE	((unsigned char *)&cpmp->cp_dpmem[0])
+#define DPRAM_BASE	((unsigned char *)cpm_dpram_addr(0))
 
 #endif


--------------090203050004050103050109--
