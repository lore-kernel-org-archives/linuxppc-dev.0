Return-Path: <roland@redhat.com>
Received: from QMTA03.westchester.pa.mail.comcast.net
	(qmta03.westchester.pa.mail.comcast.net [76.96.62.32])
	by ozlabs.org (Postfix) with ESMTP id 34014DDED9
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 23:36:56 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: Roland McGrath's message of  Thursday,
	20 December 2007 03:52:00 -0800
	<20071220115200.C767E26F98A@magilla.localdomain>
References: <20071220115200.C767E26F98A@magilla.localdomain>
Subject: [PATCH -mm 15/43] powerpc user_regset_view
Message-Id: <20071220115800.C538426F98D@magilla.localdomain>
Date: Thu, 20 Dec 2007 03:58:00 -0800 (PST)
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This provides the task_user_regset_view entry point and support for all the
native-mode (64 on CONFIG_PPC64, 32 on CONFIG_PPC32) thread register state.
This will enable generic machine-independent code to access user-mode
threads' registers for debugging and dumping.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/Makefile |    2 +
 arch/powerpc/kernel/ptrace.c |   52 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ca51f0c..615ed96 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux kernel.
 #
 
+CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
+
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS	+= -mno-minimal-toc
 endif
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index e493fc0..b32ac5f 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -455,6 +455,58 @@ static int set_evrregs(struct task_struct *task, unsigned long *data)
 #endif /* CONFIG_SPE */
 
 
+/*
+ * These are our native regset flavors.
+ */
+enum powerpc_regset {
+	REGSET_GPR,
+	REGSET_FPR,
+#ifdef CONFIG_ALTIVEC
+	REGSET_VMX,
+#endif
+#ifdef CONFIG_SPE
+	REGSET_SPE,
+#endif
+};
+
+static const struct user_regset native_regsets[] = {
+	[REGSET_GPR] = {
+		.core_note_type = NT_PRSTATUS, .n = ELF_NGREG,
+		.size = sizeof(long), .align = sizeof(long),
+		.get = gpr_get, .set = gpr_set
+	},
+	[REGSET_FPR] = {
+		.core_note_type = NT_PRFPREG, .n = ELF_NFPREG,
+		.size = sizeof(double), .align = sizeof(double),
+		.get = fpr_get, .set = fpr_set
+	},
+#ifdef CONFIG_ALTIVEC
+	[REGSET_VMX] = {
+		.core_note_type = NT_PPC_VMX, .n = 34,
+		.size = sizeof(vector128), .align = sizeof(vector128),
+		.active = vr_active, .get = vr_get, .set = vr_set
+	},
+#endif
+#ifdef CONFIG_SPE
+	[REGSET_SPE] = {
+		.n = 35,
+		.size = sizeof(u32), .align = sizeof(u32),
+		.active = evr_active, .get = evr_get, .set = evr_set
+	},
+#endif
+};
+
+static const struct user_regset_view user_ppc_native_view = {
+	.name = UTS_MACHINE, .e_machine = ELF_ARCH, .ei_osabi = ELF_OSABI,
+	.regsets = native_regsets, .n = ARRAY_SIZE(native_regsets)
+};
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *task)
+{
+	return &user_ppc_native_view;
+}
+
+
 void user_enable_single_step(struct task_struct *task)
 {
 	struct pt_regs *regs = task->thread.regs;
-- 
1.5.3.6
