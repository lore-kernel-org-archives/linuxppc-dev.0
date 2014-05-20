Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews08.kpnxchange.com (cpsmtpb-ews08.kpnxchange.com
 [213.75.39.13])
 by lists.ozlabs.org (Postfix) with ESMTP id EDC6A1A04BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 07:03:01 +1000 (EST)
Message-ID: <1400619776.4912.71.camel@x220>
Subject: [PATCH] powerpc: remove check for CONFIG_SERIAL_TEXT_DEBUG
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Tue, 20 May 2014 23:02:56 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Kconfig symbol SERIAL_TEXT_DEBUG was removed from
arch/powerpc/Kconfig.debug in v2.6.22. (In v2.6.27 it was also removed
from arch/ppc/Kconfig.debug.) So the check for its macro has evaluated
to false for over five years now. Remove that check and the few lines
of code hidden behind it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 arch/powerpc/kernel/head_40x.S | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 67ee0d6c1070..7d7d8635227a 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -930,25 +930,6 @@ initial_mmu:
 	tlbwe	r4,r0,TLB_DATA		/* Load the data portion of the entry */
 	tlbwe	r3,r0,TLB_TAG		/* Load the tag portion of the entry */
 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) && defined(SERIAL_DEBUG_IO_BASE)
-
-	/* Load a TLB entry for the UART, so that ppc4xx_progress() can use
-	 * the UARTs nice and early.  We use a 4k real==virtual mapping. */
-
-	lis	r3,SERIAL_DEBUG_IO_BASE@h
-	ori	r3,r3,SERIAL_DEBUG_IO_BASE@l
-	mr	r4,r3
-	clrrwi	r4,r4,12
-	ori	r4,r4,(TLB_WR|TLB_I|TLB_M|TLB_G)
-
-	clrrwi	r3,r3,12
-	ori	r3,r3,(TLB_VALID | TLB_PAGESZ(PAGESZ_4K))
-
-	li	r0,0			/* TLB slot 0 */
-	tlbwe	r4,r0,TLB_DATA
-	tlbwe	r3,r0,TLB_TAG
-#endif /* CONFIG_SERIAL_DEBUG_TEXT && SERIAL_DEBUG_IO_BASE */
-
 	isync
 
 	/* Establish the exception vector base
-- 
1.9.0
