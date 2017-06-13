Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn94z34qRzDqLk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 23:06:27 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id s66so6773068pfs.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 06:06:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Vaidyanathan Srinivasan" <svaidy@linux.vnet.ibm.com>
Subject: [PATCH 05/13] powerpc/64s: interrupt replay balance the return branch
 predictor
Date: Tue, 13 Jun 2017 23:05:49 +1000
Message-Id: <20170613130557.26315-6-npiggin@gmail.com>
In-Reply-To: <20170613130557.26315-1-npiggin@gmail.com>
References: <20170613130557.26315-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The __replay_interrupt code is branched to with bl, but the caller is
returned to directly with rfid from the interrupt.

Instead, rfid to a stub that returns to the caller with blr, which
should keep the return branch predictor balanced.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a04ee0d7f88e..31a9114860c4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1579,6 +1579,10 @@ doorbell_super_common_msgclr:
  * Note: While MSR:EE is off, we need to make sure that _MSR
  * in the generated frame has EE set to 1 or the exception
  * handler will not properly re-enable them.
+ *
+ * Note that we don't specify LR as the NIP (return address) for
+ * the interrupt because that would unbalance the return branch
+ * predictor.
  */
 _GLOBAL(__replay_interrupt)
 	/* We are going to jump to the exception common code which
@@ -1586,7 +1590,7 @@ _GLOBAL(__replay_interrupt)
 	 * we don't give a damn about, so we don't bother storing them.
 	 */
 	mfmsr	r12
-	mflr	r11
+	LOAD_REG_ADDR(r11, .L__replay_interrupt_return)
 	mfcr	r9
 	ori	r12,r12,MSR_EE
 	cmpwi	r3,0x900
@@ -1604,4 +1608,6 @@ FTR_SECTION_ELSE
 	cmpwi	r3,0xa00
 	beq	doorbell_super_common_msgclr
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
+.L__replay_interrupt_return:
 	blr
+
-- 
2.11.0
