Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbtp35vlCzDqYw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 11:51:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	anton@samba.org
Subject: [PATCH] powerpc/64s: Fix replay interrupt return label name
Date: Tue, 22 Aug 2017 11:51:37 +1000
Message-Id: <1503366697-17226-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In __replay_interrupt() we take the address of a local label so we can
return to it later. However the assembler turns the local label into a
symbol with a name like ".L1^B42" - where "^B" is literally "\002".
This does not make for pleasant stack traces. Fix it by giving the
label a sensible name.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 1a4c809e841b..b97a40e18cd3 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1671,7 +1671,7 @@ _GLOBAL(__replay_interrupt)
 	 * we don't give a damn about, so we don't bother storing them.
 	 */
 	mfmsr	r12
-	LOAD_REG_ADDR(r11, 1f)
+	LOAD_REG_ADDR(r11, replay_interrupt_return)
 	mfcr	r9
 	ori	r12,r12,MSR_EE
 	cmpwi	r3,0x900
@@ -1689,7 +1689,7 @@ FTR_SECTION_ELSE
 	cmpwi	r3,0xa00
 	beq	doorbell_super_common_msgclr
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
-1:
+replay_interrupt_return:
 	blr
 
 _ASM_NOKPROBE_SYMBOL(__replay_interrupt)
-- 
2.7.4
