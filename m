Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CDFB61A0C70
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 19:05:57 +1100 (AEDT)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 19 Jan 2015 01:05:55 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 58EDC3E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 01:03:41 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0J85qPr35979388
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 01:05:52 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0J85p9t027418
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 01:05:52 -0700
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] powerpc: powernv: winkle: Restore LPCR with LPCR_PECE1
 cleared
Date: Mon, 19 Jan 2015 13:35:27 +0530
Message-Id: <1421654727-31656-2-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1421654727-31656-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1421654727-31656-1-git-send-email-shreyas@linux.vnet.ibm.com>
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
Changes is v2:
==============
Using the helper function introduced in the previous patch.

 arch/powerpc/platforms/powernv/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index ad0e32e..ded7fc8 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -298,7 +298,7 @@ int pnv_save_sprs_for_winkle(void)
 	 * all cpus at boot. Get these reg values of current cpu and use the
 	 * same accross all cpus.
 	 */
-	uint64_t lpcr_val = mfspr(SPRN_LPCR);
+	uint64_t lpcr_val = LPCR_CLEAR_PECE1(mfspr(SPRN_LPCR));
 	uint64_t hid0_val = mfspr(SPRN_HID0);
 	uint64_t hid1_val = mfspr(SPRN_HID1);
 	uint64_t hid4_val = mfspr(SPRN_HID4);
-- 
1.9.3
