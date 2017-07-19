Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC7F56FjmzDrV9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 16:59:37 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id q85so5430822pfq.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 23:59:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH v2 3/3] powerpc: machine check interrupt is a non-maskable
 interrupt
Date: Wed, 19 Jul 2017 16:59:12 +1000
Message-Id: <20170719065912.19183-4-npiggin@gmail.com>
In-Reply-To: <20170719065912.19183-1-npiggin@gmail.com>
References: <20170719065912.19183-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use nmi_enter similarly to system reset interrupts. This uses NMI
printk NMI buffers and turns off various debugging facilities that
helps avoid tripping on ourselves or other CPUs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/traps.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 2849c4f50324..6d31f9d7c333 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -789,8 +789,10 @@ int machine_check_generic(struct pt_regs *regs)
 
 void machine_check_exception(struct pt_regs *regs)
 {
-	enum ctx_state prev_state = exception_enter();
 	int recover = 0;
+	bool nested = in_nmi();
+	if (!nested)
+		nmi_enter();
 
 	__this_cpu_inc(irq_stat.mce_exceptions);
 
@@ -820,10 +822,11 @@ void machine_check_exception(struct pt_regs *regs)
 
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
-		panic("Unrecoverable Machine check");
+		nmi_panic(regs, "Unrecoverable Machine check");
 
 bail:
-	exception_exit(prev_state);
+	if (!nested)
+		nmi_exit();
 }
 
 void SMIException(struct pt_regs *regs)
-- 
2.11.0
