Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 2/4] powerpc: Add new save_tar() register function.
In-reply-to: <1375929237-19944-2-git-send-email-mikey@neuling.org>
References: <1375929237-19944-1-git-send-email-mikey@neuling.org>
 <25550.1375872955@ale.ozlabs.ibm.com>
 <1375929237-19944-2-git-send-email-mikey@neuling.org>
Date: Fri, 09 Aug 2013 13:43:47 +1000
Message-ID: <7325.1376019827@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc: Add new save_tar() register function.

Add save_tar() function to save the Target Address Register (TAR).  This will
be used in a future patch to save the TAR earlier than it currently is.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org>
---
v3: remove whitespace screw age noticed by sfr

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
