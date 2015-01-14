Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78AB41A0C76
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 22:13:47 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 14 Jan 2015 06:13:44 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E000A6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 06:05:34 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0EBDf1f26017812
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 11:13:41 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0EBDfo9005424
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 06:13:41 -0500
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: powernv: winkle: Restore LPCR with LPCR_PECE1 cleared
Date: Wed, 14 Jan 2015 16:43:21 +0530
Message-Id: <1421234001-24886-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

LPCR_PECE1 bit controls whether decrementer interrupts are allowed to
cause exit from power-saving mode. While waking up from winkle, restoring
LPCR with LPCR_PECE1 set (i.e Decrementer interrupts allowed) can cause
issue in the following scenario:

- All the threads in a core are offlined. The core enters deep winkle.
- Spurious interrupt wakes up a thread in the core. Here LPCR is restored
  with LPCR_PECE1 bit set.
- Since it was a spurious interrupt on a offline thread, the thread clears
  the interrupt and goes back to winkle.
- Here before the thread executes winkle and puts the core into deep winkle,
  if a decrementer interrupt occurs on any of the sibling threads in the core
  that thread wakes up. 
- Since in offline loop we are flushing interrupt only in case of external
  interrupt, the decrementer interrupt does not get flushed. So at this stage
  the thread is stuck in this is loop of waking up at 0x100 due to decrementer
  interrupt, not flushing the interrupt as only external interrupts get flushed,
  entering winkle, waking up at 0x100 again.

Fix this by programming PORE to restore LPCR with LPCR_PECE1 bit 
cleared when waking up from winkle.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
This issue is separate from the issue which Alexey has reported. Fix for that is
still pending.

 arch/powerpc/platforms/powernv/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index ad0e32e..83067b1 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -298,7 +298,7 @@ int pnv_save_sprs_for_winkle(void)
 	 * all cpus at boot. Get these reg values of current cpu and use the
 	 * same accross all cpus.
 	 */
-	uint64_t lpcr_val = mfspr(SPRN_LPCR);
+	uint64_t lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
 	uint64_t hid0_val = mfspr(SPRN_HID0);
 	uint64_t hid1_val = mfspr(SPRN_HID1);
 	uint64_t hid4_val = mfspr(SPRN_HID4);
-- 
1.9.3
