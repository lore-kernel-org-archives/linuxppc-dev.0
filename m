Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FDB31A09FD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:57:05 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/4] powrepc/qe: drop unused ucc_slow_poll_transmitter_now
Date: Fri, 20 Mar 2015 10:56:28 +0700
Message-Id: <1426823789-949-4-git-send-email-asolokha@kb.kras.ru>
In-Reply-To: <1426823789-949-1-git-send-email-asolokha@kb.kras.ru>
References: <1424768706-23150-1-git-send-email-asolokha@kb.kras.ru>
 <1426823789-949-1-git-send-email-asolokha@kb.kras.ru>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>, Arseny Solokha <asolokha@kb.kras.ru>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drop ucc_slow_poll_transmitter_now() which has no users since its
inception in 2007 in commit 986585385131 ("[POWERPC] Add QUICC
Engine (QE) infrastructure").

Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
---
 arch/powerpc/include/asm/ucc_slow.h   | 13 -------------
 arch/powerpc/sysdev/qe_lib/ucc_slow.c |  5 -----
 2 files changed, 18 deletions(-)

diff --git a/arch/powerpc/include/asm/ucc_slow.h b/arch/powerpc/include/asm/ucc_slow.h
index c44131e..233ef5f 100644
--- a/arch/powerpc/include/asm/ucc_slow.h
+++ b/arch/powerpc/include/asm/ucc_slow.h
@@ -251,19 +251,6 @@ void ucc_slow_enable(struct ucc_slow_private * uccs, enum comm_dir mode);
  */
 void ucc_slow_disable(struct ucc_slow_private * uccs, enum comm_dir mode);
 
-/* ucc_slow_poll_transmitter_now
- * Immediately forces a poll of the transmitter for data to be sent.
- * Typically, the hardware performs a periodic poll for data that the
- * transmit routine has set up to be transmitted. In cases where
- * this polling cycle is not soon enough, this optional routine can
- * be invoked to force a poll right away, instead. Proper use for
- * each transmission for which this functionality is desired is to
- * call the transmit routine and then this routine right after.
- *
- * uccs - (In) pointer to the slow UCC structure.
- */
-void ucc_slow_poll_transmitter_now(struct ucc_slow_private * uccs);
-
 /* ucc_slow_graceful_stop_tx
  * Smoothly stops transmission on a specified slow UCC.
  *
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
index befaf11..5f91628 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -43,11 +43,6 @@ u32 ucc_slow_get_qe_cr_subblock(int uccs_num)
 }
 EXPORT_SYMBOL(ucc_slow_get_qe_cr_subblock);
 
-void ucc_slow_poll_transmitter_now(struct ucc_slow_private * uccs)
-{
-	out_be16(&uccs->us_regs->utodr, UCC_SLOW_TOD);
-}
-
 void ucc_slow_graceful_stop_tx(struct ucc_slow_private * uccs)
 {
 	struct ucc_slow_info *us_info = uccs->us_info;
-- 
2.3.3
