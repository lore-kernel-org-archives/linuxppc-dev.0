Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rykl7435FzDrFh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:07 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PEn3kD039948
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:53:06 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24c1fjknpw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:53:05 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 00:53:03 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DB0283578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:00 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6PEr0fO29753408
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:00 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6PEr0as012518
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:00 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH 5/9] powerpc: reverse the soft_enable logic
Date: Mon, 25 Jul 2016 20:22:18 +0530
In-Reply-To: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1469458342-26233-6-git-send-email-maddy@linux.vnet.ibm.com>
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

soft_enabled		MSR[EE]

0			0	Disabled (PMI and HMI not masked)
1			1	Enabled

"paca->soft_enabled" is initialed to 1 to make the interripts as
enabled. arch_local_irq_disable() will toggle the value when interrupts
needs to disbled. At this point, the interrupts are not actually disabled,
instead, interrupt vector has code to check for the flag and mask it when it occurs.
By "mask it", it updated interrupt paca->irq_happened and return.
arch_local_irq_restore() is called to re-enable interrupts, which checks and
replays interrupts if any occured.

Now, as mentioned, current logic doesnot mask "performance monitoring interrupts"
and PMIs are implemented as NMI. But this patchset depends on local_irq_*
for a successful local_* update. Meaning, mask all possible interrupts during
local_* update and replay them after the update.

So the idea here is to reserve the "paca->soft_enabled" logic. New values and
details:

soft_enabled		MSR[EE]

1			0	Disabled  (PMI and HMI not masked)
0			1	Enabled

Reason for the this change is to create foundation for a third flag value "2"
for "soft_enabled" to add support to mask PMIs. When arch_irq_disable_* is
called with a value "2", PMI interrupts are mask. But when called with a value
of "1", PMI are not mask.

With new flag value for "soft_enabled", states looks like:

soft_enabled		MSR[EE]

2			0	Disbaled PMIs also
1			0	Disabled  (PMI and HMI not masked)
0			1	Enabled

And interrupt handler code for checking has been modified to check for
for "greater than or equal" to 1 condition instead.

Comment here explains the logic changes that are implemented in the following
patches. But this patch primarly does only reserve the logic. Following patches
will make the corresponding changes.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 09491417fbf7..2b87930e0e82 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -30,8 +30,8 @@
 /*
  * flags for paca->soft_enabled
  */
-#define LAZY_INTERRUPT_ENABLED		1
-#define LAZY_INTERRUPT_DISABLED		0
+#define LAZY_INTERRUPT_ENABLED		0
+#define LAZY_INTERRUPT_DISABLED		1
 
 
 #endif /* CONFIG_PPC64 */
-- 
2.7.4
