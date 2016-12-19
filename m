Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thtnS1HgvzDwJd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:39 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJ84Q25078710
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 03:07:37 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27e81q7ah6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 03:07:37 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 18:07:34 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 127E72BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:33 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBJ87XEj34930868
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:33 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBJ87Wi0027861
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:32 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v4 05/12] powerpc: reverse the soft_enable logic
Date: Mon, 19 Dec 2016 13:37:01 +0530
In-Reply-To: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1482134828-18811-6-git-send-email-maddy@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/hw_irq.h | 4 ++--
 arch/powerpc/kernel/entry_64.S    | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index c292ef4b4bc5..8359fbf83376 100644
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
