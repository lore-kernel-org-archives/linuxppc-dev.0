Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xKQYb1tyPzDrhq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 22:50:43 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id r63so1696079pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 05:50:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64s: watchdog fix stack setup
Date: Sat, 29 Jul 2017 22:50:27 +1000
Message-Id: <20170729125027.31835-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The watchdog soft-NMI exception stack setup loads a stack pointer
twice, which is an obvious error. It ends up using the system reset
interrupt (true-NMI) stack, which is also a bug because the watchdog
could be preempted by a system reset interrupt that overwrites the
NMI stack.

Change the soft-NMI to use the "emergency stack". The current kernel
stack is not used, because of the longer-term goal to prevent
asynchronous stack access using soft-disable.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

This was tested by booting a kernel and verifying there was some
soft NMI activity, and also by deliberately causing a watchdog
lockup from the soft NMI path. Seems to be working.

In the system simulator you can inject a system reset when in the
soft_nmi_interrupt function and things go haywire without this
patch. 

 arch/powerpc/kernel/exceptions-64s.S | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9029afd1fa2a..f14f3c04ec7e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1325,10 +1325,18 @@ EXC_VIRT_NONE(0x5800, 0x100)
 	std	r10,PACA_EXGEN+EX_R13(r13);		\
 	EXCEPTION_PROLOG_PSERIES_1(soft_nmi_common, _H)
 
+/*
+ * Branch to soft_nmi_interrupt using the emergency stack. The emergency
+ * stack is one that is usable by maskable interrupts so long as MSR_EE
+ * remains off. It is used for recovery when something has corrupted the
+ * normal kernel stack, for example. The "soft NMI" must not use the process
+ * stack because we want irq disabled sections to avoid touching the stack
+ * at all (other than PMU interrupts), so use the emergency stack for this,
+ * and run it entirely with interrupts hard disabled.
+ */
 EXC_COMMON_BEGIN(soft_nmi_common)
 	mr	r10,r1
 	ld	r1,PACAEMERGSP(r13)
-	ld	r1,PACA_NMI_EMERG_SP(r13)
 	subi	r1,r1,INT_FRAME_SIZE
 	EXCEPTION_COMMON_NORET_STACK(PACA_EXGEN, 0x900,
 			system_reset, soft_nmi_interrupt,
-- 
2.11.0
