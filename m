Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 2/4] powerpc: Add new save_tar() register function.
Date: Thu,  8 Aug 2013 12:33:55 +1000
Message-Id: <1375929237-19944-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1375929237-19944-1-git-send-email-mikey@neuling.org>
References: <1375929237-19944-1-git-send-email-mikey@neuling.org>
In-Reply-To: <25550.1375872955@ale.ozlabs.ibm.com>
References: <25550.1375872955@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add save_tar() function to save the Target Address Register (TAR).  This will
be used in a future patch to save the TAR earlier than it currently is.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org>
---
 arch/powerpc/include/asm/switch_to.h | 9 +++++++++
 arch/powerpc/kernel/entry_64.S       | 1 -
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 49a13e0..294c2ce 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -15,6 +15,15 @@ extern struct task_struct *__switch_to(struct task_struct *,
 struct thread_struct;
 extern struct task_struct *_switch(struct thread_struct *prev,
 				   struct thread_struct *next);
+#ifdef CONFIG_PPC_BOOK3S_64
+static inline void save_tar(struct thread_struct *prev)
+{
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		prev->tar = mfspr(SPRN_TAR);
+}
+#else
+static inline void save_tar(struct thread_struct *prev) {}
+#endif
 
 extern void giveup_fpu(struct task_struct *);
 extern void load_up_fpu(void);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 4674fe6..cfb6de4 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -389,7 +389,6 @@ DSCR_DEFAULT:
 	.tc dscr_default[TC],dscr_default
 
 	.section	".text"
-
 /*
  * This routine switches between two different tasks.  The process
  * state of one is saved on its kernel stack.  Then the state
-- 
1.8.1.2
