Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttpz26GzZzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 22:50:22 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v04BmwUp100697
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 06:50:20 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27ry3fb537-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 06:50:20 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 4 Jan 2017 21:50:17 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5FF782CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 22:50:14 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v04BoFTX51904728
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 22:50:15 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v04BoDp0010799
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 22:50:14 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v5 05/12] powerpc: reverse the soft_enable logic
Date: Wed,  4 Jan 2017 17:19:43 +0530
In-Reply-To: <1483530590-30274-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1483530590-30274-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1483530590-30274-6-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"paca->soft_enabled" is used as a flag to mask some of interrupts.
Currently supported flags values and their details:

soft_enabled    MSR[EE]

0               0       Disabled (PMI and HMI not masked)
1               1       Enabled

"paca->soft_enabled" is initialized to 1 to make the interripts as
enabled. arch_local_irq_disable() will toggle the value when interrupts
needs to disbled. At this point, the interrupts are not actually disabled,
instead, interrupt vector has code to check for the flag and mask it when it occurs.
By "mask it", it update interrupt paca->irq_happened and return.
arch_local_irq_restore() is called to re-enable interrupts, which checks and
replays interrupts if any occured.

Now, as mentioned, current logic doesnot mask "performance monitoring interrupts"
and PMIs are implemented as NMI. But this patchset depends on local_irq_*
for a successful local_* update. Meaning, mask all possible interrupts during
local_* update and replay them after the update.

So the idea here is to reserve the "paca->soft_enabled" logic. New values and
details:

soft_enabled    MSR[EE]

1               0       Disabled  (PMI and HMI not masked)
0               1       Enabled

Reason for the this change is to create foundation for a third mask value "0x2"
for "soft_enabled" to add support to mask PMIs. When ->soft_enabled is
set to a value "3", PMI interrupts are mask and when set to a value
of "1", PMI are not mask.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 4 ++--
 arch/powerpc/include/asm/hw_irq.h        | 6 +++---
 arch/powerpc/kernel/entry_64.S           | 5 ++---
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 27d75ec63b34..4e0c0fa60ab9 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -412,9 +412,9 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define __SOFTEN_TEST(h, vec)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
-	cmpwi	r10,IRQ_DISABLE_MASK_LINUX;				\
+	andi.	r10,r10,IRQ_DISABLE_MASK_LINUX;				\
 	li	r10,SOFTEN_VALUE_##vec;					\
-	beq	masked_##h##interrupt
+	bne	masked_##h##interrupt
 
 #define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
 
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index c292ef4b4bc5..f7c761902dc9 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -30,8 +30,8 @@
 /*
  * flags for paca->soft_enabled
  */
-#define IRQ_DISABLE_MASK_NONE	1
-#define IRQ_DISABLE_MASK_LINUX	0
+#define IRQ_DISABLE_MASK_NONE	0
+#define IRQ_DISABLE_MASK_LINUX	1
 
 #endif /* CONFIG_PPC64 */
 
@@ -134,7 +134,7 @@ static inline bool arch_irqs_disabled(void)
 	_was_enabled = local_paca->soft_enabled;	\
 	local_paca->soft_enabled = IRQ_DISABLE_MASK_LINUX;\
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
-	if (_was_enabled == IRQ_DISABLE_MASK_NONE)	\
+	if (!(_was_enabled & IRQ_DISABLE_MASK_LINUX))	\
 		trace_hardirqs_off();			\
 } while(0)
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 8e347ffca14e..7ef3064ddde1 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -132,8 +132,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	 */
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
 	lbz	r10,PACASOFTIRQEN(r13)
-	xori	r10,r10,IRQ_DISABLE_MASK_NONE
-1:	tdnei	r10,0
+1:	tdnei	r10,IRQ_DISABLE_MASK_NONE
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 
@@ -1010,7 +1009,7 @@ _GLOBAL(enter_rtas)
 	 * check it with the asm equivalent of WARN_ON
 	 */
 	lbz	r0,PACASOFTIRQEN(r13)
-1:	tdnei	r0,IRQ_DISABLE_MASK_LINUX
+1:	tdeqi	r0,IRQ_DISABLE_MASK_NONE
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 	
-- 
2.7.4
