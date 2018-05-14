Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40l54z3WCwzF3Dy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 02:00:19 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id w129-v6so6236384pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 09:00:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/2] powerpc/powernv: Fix opal_event_shutdown() called with
 interrupts disabled
Date: Tue, 15 May 2018 01:59:46 +1000
Message-Id: <20180514155947.22753-2-npiggin@gmail.com>
In-Reply-To: <20180514155947.22753-1-npiggin@gmail.com>
References: <20180514155947.22753-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A kernel crash in process context that calls emergency_restart from
panic will end up calling opal_event_shutdown with interrupts disabled
but not in interrupt. This causes a sleeping function to be called
which gives the following warning with sysrq+c:

    Rebooting in 10 seconds..
    BUG: sleeping function called from invalid context at kernel/locking/mutex.c:238
    in_atomic(): 0, irqs_disabled(): 1, pid: 7669, name: bash
    CPU: 20 PID: 7669 Comm: bash Tainted: G      D W         4.17.0-rc5+ #3
    Call Trace:
    dump_stack+0xb0/0xf4 (unreliable)
    ___might_sleep+0x174/0x1a0
    mutex_lock+0x38/0xb0
    __free_irq+0x68/0x460
    free_irq+0x70/0xc0
    opal_event_shutdown+0xb4/0xf0
    opal_shutdown+0x24/0xa0
    pnv_shutdown+0x28/0x40
    machine_shutdown+0x44/0x60
    machine_restart+0x28/0x80
    emergency_restart+0x30/0x50
    panic+0x2a0/0x328
    oops_end+0x1ec/0x1f0
    bad_page_fault+0xe8/0x154
    handle_page_fault+0x34/0x38
    --- interrupt: 300 at sysrq_handle_crash+0x44/0x60
    LR = __handle_sysrq+0xfc/0x260
    flag_spec.62335+0x12b844/0x1e8db4 (unreliable)
    __handle_sysrq+0xfc/0x260
    write_sysrq_trigger+0xa8/0xb0
    proc_reg_write+0xac/0x110
    __vfs_write+0x6c/0x240
    vfs_write+0xd0/0x240
    ksys_write+0x6c/0x110

Fixes: 9f0fd0499d30 ("powerpc/powernv: Add a virtual irqchip for opal events")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-irqchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index 9d1b8c0aaf93..05ffe05f0fdc 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -177,7 +177,7 @@ void opal_event_shutdown(void)
 		if (!opal_irqs[i])
 			continue;
 
-		if (in_interrupt())
+		if (in_interrupt() || irqs_disabled())
 			disable_irq_nosync(opal_irqs[i]);
 		else
 			free_irq(opal_irqs[i], NULL);
-- 
2.17.0
