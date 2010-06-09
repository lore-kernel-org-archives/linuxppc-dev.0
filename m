Return-Path: <siccegge@cs.fau.de>
Received: from faui40.informatik.uni-erlangen.de
	(faui40.informatik.uni-erlangen.de [131.188.34.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80CE0B7D5B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 20:09:47 +1000 (EST)
Date: Wed, 9 Jun 2010 12:00:46 +0200
From: Christoph Egger <siccegge@cs.fau.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Removing dead CONFIG_SERIAL_TEXT_DEBUG
Message-ID: <ddcbd960ff300073939bb0c6f20a38118c0875d4.1275925219.git.siccegge@cs.fau.de>
References: <cover.1275925219.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1275925219.git.siccegge@cs.fau.de>
Cc: vamos@i4.informatik.uni-erlangen.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_SERIAL_TEXT_DEBUG doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/powerpc/kernel/head_40x.S |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index a90625f..1a10e4d 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -939,25 +939,6 @@ initial_mmu:
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
1.6.3.3
