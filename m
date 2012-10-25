Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Remove no longer used ppc_md.idle_loop()
Date: Thu, 25 Oct 2012 14:21:09 +1100
Message-Id: <1351135269-14672-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The last user of ppc_md.idle_loop() was removed when we dropped the
legacy iSeries code, in commit 8ee3e0d.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/machdep.h |    3 ---
 arch/powerpc/kernel/idle.c         |    3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index c423197..a338bc7 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -166,9 +166,6 @@ struct machdep_calls {
 						unsigned long size,
 						pgprot_t vma_prot);
 
-	/* Idle loop for this platform, leave empty for default idle loop */
-	void		(*idle_loop)(void);
-
 	/*
 	 * Function for waiting for work with reduced power in idle loop;
 	 * called with interrupts disabled.
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 2099d9a..ea78761 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -55,9 +55,6 @@ __setup("powersave=off", powersave_off);
  */
 void cpu_idle(void)
 {
-	if (ppc_md.idle_loop)
-		ppc_md.idle_loop();	/* doesn't return */
-
 	set_thread_flag(TIF_POLLING_NRFLAG);
 	while (1) {
 		tick_nohz_idle_enter();
-- 
1.7.9.5
