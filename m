Return-Path: <B40534@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C4CB22C0096
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jun 2013 16:08:45 +1000 (EST)
From: Wang Dongsheng <dongsheng.wang@freescale.com>
To: <benh@kernel.crashing.org>, <johannes@sipsolutions.net>, <anton@enomsg.org>
Subject: [PATCH v2 2/2] powerpc/hibernate: PPC64 fix user threads access to
 kernel space
Date: Sun, 9 Jun 2013 13:22:32 +0800
Message-ID: <1370755352-29901-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If PID is used in the TLB, after hibernation resume, the user
threads will access to kernel space.

We must restore PID register, because TLB will use PID. The
hibernation suspend flow is trapped from user space to kernel
space, the PID register is user thread pid.

The hibernation resume is begin in kernel start flow, the PID
alway 0. After the kernel thread back to user thread, there is
not have context switch and the pid can not update, because the
kernel thread is trapped form user space. So if we did't restore
PID the user space of thread will be addressing in the kernel
space.

There are two ways to restore PID:
1/ In swsusp_arch_suspend/swsusp_arch_resume, save/resotre PID register.
2/ Form restore_processor_state to restore. this function will
   do context switch.
   switch_mmu_context(current->active_mm, current->active_mm)

PPC32 Using the second method. For consistency reason, PPC64 using
the same way.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
 arch/powerpc/kernel/swsusp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/swsusp.c b/arch/powerpc/kernel/swsusp.c
index eae33e1..1930e44 100644
--- a/arch/powerpc/kernel/swsusp.c
+++ b/arch/powerpc/kernel/swsusp.c
@@ -32,7 +32,5 @@ void save_processor_state(void)
 
 void restore_processor_state(void)
 {
-#ifdef CONFIG_PPC32
 	switch_mmu_context(current->active_mm, current->active_mm);
-#endif
 }
-- 
1.8.0
