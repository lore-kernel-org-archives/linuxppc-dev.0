Return-Path: <B08248@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 90FBA2C0102
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 05:07:34 +1000 (EST)
From: Stuart Yoder <stuart.yoder@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: set stack limit properly in crit_transfer_to_handler
Date: Mon, 16 Jul 2012 14:06:48 -0500
Message-ID: <1342465608-20596-1-git-send-email-stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: sfr@canb.auug.org.au, Stuart Yoder <stuart.yoder@freescale.com>,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stuart Yoder <stuart.yoder@freescale.com>

without setting the stack limit like this there is the possibility
of stack overflow which corrupts the thread info but
is not detected by stack overflow detection

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---
 arch/powerpc/kernel/entry_32.S |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 5207d5a..ead5016 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -89,10 +89,14 @@ crit_transfer_to_handler:
 	mfspr	r0,SPRN_SRR1
 	stw	r0,_SRR1(r11)
 
+	/* set the stack limit to the current stack
+	 * and set the limit to protect the thread_info
+	 * struct
+	 */
 	mfspr	r8,SPRN_SPRG_THREAD
 	lwz	r0,KSP_LIMIT(r8)
 	stw	r0,SAVED_KSP_LIMIT(r11)
-	CURRENT_THREAD_INFO(r0, r1)
+	rlwimi	r0,r1,0,0,(31-THREAD_SHIFT)
 	stw	r0,KSP_LIMIT(r8)
 	/* fall through */
 #endif
@@ -109,10 +113,14 @@ crit_transfer_to_handler:
 	mfspr	r0,SPRN_SRR1
 	stw	r0,crit_srr1@l(0)
 
+	/* set the stack limit to the current stack
+	 * and set the limit to protect the thread_info
+	 * struct
+	 */
 	mfspr	r8,SPRN_SPRG_THREAD
 	lwz	r0,KSP_LIMIT(r8)
 	stw	r0,saved_ksp_limit@l(0)
-	CURRENT_THREAD_INFO(r0, r1)
+	rlwimi	r0,r1,0,0,(31-THREAD_SHIFT)
 	stw	r0,KSP_LIMIT(r8)
 	/* fall through */
 #endif
-- 
1.7.3.4
