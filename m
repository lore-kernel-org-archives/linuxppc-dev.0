Return-Path: <dave.long@linaro.org>
Received: from mail-qg0-x230.google.com (mail-qg0-x230.google.com
 [IPv6:2607:f8b0:400d:c04::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 681A71A0191
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 16:39:04 +1100 (AEDT)
Received: by mail-qg0-x230.google.com with SMTP id y89so60255709qge.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Feb 2016 21:39:04 -0800 (PST)
From: David Long <dave.long@linaro.org>
To: "H. Peter Anvin" <hpa@zytor.com>,
 "chengang@emindsoft.com.cn" <chengang@emindsoft.com.cn>,
 Andy Lutomirski <luto@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>,
 David Hildenbrand <dahi@linux.vnet.ibm.com>,
 Denys Vlasenko <dvlasenk@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Oleg Nesterov <oleg@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Rich Felker <dalias@libc.org>, Richard Kuo <rkuo@codeaurora.org>,
 Roland McGrath <roland@hack.frob.com>,
 Russell King <linux@arm.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v3 1/2] Move the pt_regs_offset struct definition from arch to
 common include file
Date: Tue,  9 Feb 2016 00:38:56 -0500
Message-Id: <1454996337-7935-2-git-send-email-dave.long@linaro.org>
In-Reply-To: <1454996337-7935-1-git-send-email-dave.long@linaro.org>
References: <1454996337-7935-1-git-send-email-dave.long@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "David A. Long" <dave.long@linaro.org>

The pt_regs_offset structure is used for the HAVE_REGS_AND_STACK_ACCESS_API
feature and has identical definitions in four different arch ptrace.h
include files. It seems unlikely that definition would ever need to be
changed regardless of architecture so lets move it into
include/linux/ptrace.h, along with macros commonly used to access it.

Signed-off-by: David A. Long <dave.long@linaro.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/arm/kernel/ptrace.c     |   7 +-
 arch/powerpc/kernel/ptrace.c |  31 ++++-----
 arch/sh/include/asm/ptrace.h |   9 +--
 arch/sh/kernel/ptrace_32.c   |  48 +++++++-------
 arch/sh/kernel/ptrace_64.c   | 152 +++++++++++++++++++++----------------------
 arch/x86/kernel/ptrace.c     |  59 ++++++++---------
 include/linux/ptrace.h       |  12 ++++
 7 files changed, 152 insertions(+), 166 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ef9119f..3b5a2ba 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -59,14 +59,9 @@
 #define BREAKINST_THUMB	0xde01
 #endif
 
-struct pt_regs_offset {
-	const char *name;
-	int offset;
-};
 
 #define REG_OFFSET_NAME(r) \
 	{.name = #r, .offset = offsetof(struct pt_regs, ARM_##r)}
-#define REG_OFFSET_END {.name = NULL, .offset = 0}
 
 static const struct pt_regs_offset regoffset_table[] = {
 	REG_OFFSET_NAME(r0),
@@ -87,7 +82,7 @@ static const struct pt_regs_offset regoffset_table[] = {
 	REG_OFFSET_NAME(pc),
 	REG_OFFSET_NAME(cpsr),
 	REG_OFFSET_NAME(ORIG_r0),
-	REG_OFFSET_END,
+	REGS_OFFSET_END,
 };
 
 /**
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 30a03c0..77bd4c4 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -52,17 +52,10 @@
 #define PARAMETER_SAVE_AREA_OFFSET	48  /* bytes */
 #endif
 
-struct pt_regs_offset {
-	const char *name;
-	int offset;
-};
-
 #define STR(s)	#s			/* convert to string */
-#define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
 #define GPR_OFFSET_NAME(num)	\
 	{.name = STR(r##num), .offset = offsetof(struct pt_regs, gpr[num])}, \
 	{.name = STR(gpr##num), .offset = offsetof(struct pt_regs, gpr[num])}
-#define REG_OFFSET_END {.name = NULL, .offset = 0}
 
 static const struct pt_regs_offset regoffset_table[] = {
 	GPR_OFFSET_NAME(0),
@@ -97,21 +90,21 @@ static const struct pt_regs_offset regoffset_table[] = {
 	GPR_OFFSET_NAME(29),
 	GPR_OFFSET_NAME(30),
 	GPR_OFFSET_NAME(31),
-	REG_OFFSET_NAME(nip),
-	REG_OFFSET_NAME(msr),
-	REG_OFFSET_NAME(ctr),
-	REG_OFFSET_NAME(link),
-	REG_OFFSET_NAME(xer),
-	REG_OFFSET_NAME(ccr),
+	REGS_OFFSET_NAME(nip),
+	REGS_OFFSET_NAME(msr),
+	REGS_OFFSET_NAME(ctr),
+	REGS_OFFSET_NAME(link),
+	REGS_OFFSET_NAME(xer),
+	REGS_OFFSET_NAME(ccr),
 #ifdef CONFIG_PPC64
-	REG_OFFSET_NAME(softe),
+	REGS_OFFSET_NAME(softe),
 #else
-	REG_OFFSET_NAME(mq),
+	REGS_OFFSET_NAME(mq),
 #endif
-	REG_OFFSET_NAME(trap),
-	REG_OFFSET_NAME(dar),
-	REG_OFFSET_NAME(dsisr),
-	REG_OFFSET_END,
+	REGS_OFFSET_NAME(trap),
+	REGS_OFFSET_NAME(dar),
+	REGS_OFFSET_NAME(dsisr),
+	REGS_OFFSET_END,
 };
 
 /**
diff --git a/arch/sh/include/asm/ptrace.h b/arch/sh/include/asm/ptrace.h
index 2506c7d..523955f 100644
--- a/arch/sh/include/asm/ptrace.h
+++ b/arch/sh/include/asm/ptrace.h
@@ -23,17 +23,10 @@
 /*
  * kprobe-based event tracer support
  */
-struct pt_regs_offset {
-	const char *name;
-	int offset;
-};
-
-#define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
-#define REGS_OFFSET_NAME(num)	\
+#define REG_OFFSET_NAME(num)	\
 	{.name = __stringify(r##num), .offset = offsetof(struct pt_regs, regs[num])}
 #define TREGS_OFFSET_NAME(num)	\
 	{.name = __stringify(tr##num), .offset = offsetof(struct pt_regs, tregs[num])}
-#define REG_OFFSET_END {.name = NULL, .offset = 0}
 
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index c1a6b89..e6fe4f4 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -277,30 +277,30 @@ static int dspregs_active(struct task_struct *target,
 #endif
 
 const struct pt_regs_offset regoffset_table[] = {
-	REGS_OFFSET_NAME(0),
-	REGS_OFFSET_NAME(1),
-	REGS_OFFSET_NAME(2),
-	REGS_OFFSET_NAME(3),
-	REGS_OFFSET_NAME(4),
-	REGS_OFFSET_NAME(5),
-	REGS_OFFSET_NAME(6),
-	REGS_OFFSET_NAME(7),
-	REGS_OFFSET_NAME(8),
-	REGS_OFFSET_NAME(9),
-	REGS_OFFSET_NAME(10),
-	REGS_OFFSET_NAME(11),
-	REGS_OFFSET_NAME(12),
-	REGS_OFFSET_NAME(13),
-	REGS_OFFSET_NAME(14),
-	REGS_OFFSET_NAME(15),
-	REG_OFFSET_NAME(pc),
-	REG_OFFSET_NAME(pr),
-	REG_OFFSET_NAME(sr),
-	REG_OFFSET_NAME(gbr),
-	REG_OFFSET_NAME(mach),
-	REG_OFFSET_NAME(macl),
-	REG_OFFSET_NAME(tra),
-	REG_OFFSET_END,
+	REG_OFFSET_NAME(0),
+	REG_OFFSET_NAME(1),
+	REG_OFFSET_NAME(2),
+	REG_OFFSET_NAME(3),
+	REG_OFFSET_NAME(4),
+	REG_OFFSET_NAME(5),
+	REG_OFFSET_NAME(6),
+	REG_OFFSET_NAME(7),
+	REG_OFFSET_NAME(8),
+	REG_OFFSET_NAME(9),
+	REG_OFFSET_NAME(10),
+	REG_OFFSET_NAME(11),
+	REG_OFFSET_NAME(12),
+	REG_OFFSET_NAME(13),
+	REG_OFFSET_NAME(14),
+	REG_OFFSET_NAME(15),
+	REGS_OFFSET_NAME(pc),
+	REGS_OFFSET_NAME(pr),
+	REGS_OFFSET_NAME(sr),
+	REGS_OFFSET_NAME(gbr),
+	REGS_OFFSET_NAME(mach),
+	REGS_OFFSET_NAME(macl),
+	REGS_OFFSET_NAME(tra),
+	REGS_OFFSET_END,
 };
 
 /*
diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
index 5cea973..af55bb6 100644
--- a/arch/sh/kernel/ptrace_64.c
+++ b/arch/sh/kernel/ptrace_64.c
@@ -253,82 +253,82 @@ static int fpregs_active(struct task_struct *target,
 #endif
 
 const struct pt_regs_offset regoffset_table[] = {
-	REG_OFFSET_NAME(pc),
-	REG_OFFSET_NAME(sr),
-	REG_OFFSET_NAME(syscall_nr),
-	REGS_OFFSET_NAME(0),
-	REGS_OFFSET_NAME(1),
-	REGS_OFFSET_NAME(2),
-	REGS_OFFSET_NAME(3),
-	REGS_OFFSET_NAME(4),
-	REGS_OFFSET_NAME(5),
-	REGS_OFFSET_NAME(6),
-	REGS_OFFSET_NAME(7),
-	REGS_OFFSET_NAME(8),
-	REGS_OFFSET_NAME(9),
-	REGS_OFFSET_NAME(10),
-	REGS_OFFSET_NAME(11),
-	REGS_OFFSET_NAME(12),
-	REGS_OFFSET_NAME(13),
-	REGS_OFFSET_NAME(14),
-	REGS_OFFSET_NAME(15),
-	REGS_OFFSET_NAME(16),
-	REGS_OFFSET_NAME(17),
-	REGS_OFFSET_NAME(18),
-	REGS_OFFSET_NAME(19),
-	REGS_OFFSET_NAME(20),
-	REGS_OFFSET_NAME(21),
-	REGS_OFFSET_NAME(22),
-	REGS_OFFSET_NAME(23),
-	REGS_OFFSET_NAME(24),
-	REGS_OFFSET_NAME(25),
-	REGS_OFFSET_NAME(26),
-	REGS_OFFSET_NAME(27),
-	REGS_OFFSET_NAME(28),
-	REGS_OFFSET_NAME(29),
-	REGS_OFFSET_NAME(30),
-	REGS_OFFSET_NAME(31),
-	REGS_OFFSET_NAME(32),
-	REGS_OFFSET_NAME(33),
-	REGS_OFFSET_NAME(34),
-	REGS_OFFSET_NAME(35),
-	REGS_OFFSET_NAME(36),
-	REGS_OFFSET_NAME(37),
-	REGS_OFFSET_NAME(38),
-	REGS_OFFSET_NAME(39),
-	REGS_OFFSET_NAME(40),
-	REGS_OFFSET_NAME(41),
-	REGS_OFFSET_NAME(42),
-	REGS_OFFSET_NAME(43),
-	REGS_OFFSET_NAME(44),
-	REGS_OFFSET_NAME(45),
-	REGS_OFFSET_NAME(46),
-	REGS_OFFSET_NAME(47),
-	REGS_OFFSET_NAME(48),
-	REGS_OFFSET_NAME(49),
-	REGS_OFFSET_NAME(50),
-	REGS_OFFSET_NAME(51),
-	REGS_OFFSET_NAME(52),
-	REGS_OFFSET_NAME(53),
-	REGS_OFFSET_NAME(54),
-	REGS_OFFSET_NAME(55),
-	REGS_OFFSET_NAME(56),
-	REGS_OFFSET_NAME(57),
-	REGS_OFFSET_NAME(58),
-	REGS_OFFSET_NAME(59),
-	REGS_OFFSET_NAME(60),
-	REGS_OFFSET_NAME(61),
-	REGS_OFFSET_NAME(62),
-	REGS_OFFSET_NAME(63),
-	TREGS_OFFSET_NAME(0),
-	TREGS_OFFSET_NAME(1),
-	TREGS_OFFSET_NAME(2),
-	TREGS_OFFSET_NAME(3),
-	TREGS_OFFSET_NAME(4),
-	TREGS_OFFSET_NAME(5),
-	TREGS_OFFSET_NAME(6),
-	TREGS_OFFSET_NAME(7),
-	REG_OFFSET_END,
+	REGS_OFFSET_NAME(pc),
+	REGS_OFFSET_NAME(sr),
+	REGS_OFFSET_NAME(syscall_nr),
+	REG_OFFSET_NAME(0),
+	REG_OFFSET_NAME(1),
+	REG_OFFSET_NAME(2),
+	REG_OFFSET_NAME(3),
+	REG_OFFSET_NAME(4),
+	REG_OFFSET_NAME(5),
+	REG_OFFSET_NAME(6),
+	REG_OFFSET_NAME(7),
+	REG_OFFSET_NAME(8),
+	REG_OFFSET_NAME(9),
+	REG_OFFSET_NAME(10),
+	REG_OFFSET_NAME(11),
+	REG_OFFSET_NAME(12),
+	REG_OFFSET_NAME(13),
+	REG_OFFSET_NAME(14),
+	REG_OFFSET_NAME(15),
+	REG_OFFSET_NAME(16),
+	REG_OFFSET_NAME(17),
+	REG_OFFSET_NAME(18),
+	REG_OFFSET_NAME(19),
+	REG_OFFSET_NAME(20),
+	REG_OFFSET_NAME(21),
+	REG_OFFSET_NAME(22),
+	REG_OFFSET_NAME(23),
+	REG_OFFSET_NAME(24),
+	REG_OFFSET_NAME(25),
+	REG_OFFSET_NAME(26),
+	REG_OFFSET_NAME(27),
+	REG_OFFSET_NAME(28),
+	REG_OFFSET_NAME(29),
+	REG_OFFSET_NAME(30),
+	REG_OFFSET_NAME(31),
+	REG_OFFSET_NAME(32),
+	REG_OFFSET_NAME(33),
+	REG_OFFSET_NAME(34),
+	REG_OFFSET_NAME(35),
+	REG_OFFSET_NAME(36),
+	REG_OFFSET_NAME(37),
+	REG_OFFSET_NAME(38),
+	REG_OFFSET_NAME(39),
+	REG_OFFSET_NAME(40),
+	REG_OFFSET_NAME(41),
+	REG_OFFSET_NAME(42),
+	REG_OFFSET_NAME(43),
+	REG_OFFSET_NAME(44),
+	REG_OFFSET_NAME(45),
+	REG_OFFSET_NAME(46),
+	REG_OFFSET_NAME(47),
+	REG_OFFSET_NAME(48),
+	REG_OFFSET_NAME(49),
+	REG_OFFSET_NAME(50),
+	REG_OFFSET_NAME(51),
+	REG_OFFSET_NAME(52),
+	REG_OFFSET_NAME(53),
+	REG_OFFSET_NAME(54),
+	REG_OFFSET_NAME(55),
+	REG_OFFSET_NAME(56),
+	REG_OFFSET_NAME(57),
+	REG_OFFSET_NAME(58),
+	REG_OFFSET_NAME(59),
+	REG_OFFSET_NAME(60),
+	REG_OFFSET_NAME(61),
+	REG_OFFSET_NAME(62),
+	REG_OFFSET_NAME(63),
+	TREG_OFFSET_NAME(0),
+	TREG_OFFSET_NAME(1),
+	TREG_OFFSET_NAME(2),
+	TREG_OFFSET_NAME(3),
+	TREG_OFFSET_NAME(4),
+	TREG_OFFSET_NAME(5),
+	TREG_OFFSET_NAME(6),
+	TREG_OFFSET_NAME(7),
+	REGS_OFFSET_END,
 };
 
 /*
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 32e9d9c..ff3314f 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -51,45 +51,38 @@ enum x86_regset {
 	REGSET_IOPERM32,
 };
 
-struct pt_regs_offset {
-	const char *name;
-	int offset;
-};
-
-#define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
-#define REG_OFFSET_END {.name = NULL, .offset = 0}
 
 static const struct pt_regs_offset regoffset_table[] = {
 #ifdef CONFIG_X86_64
-	REG_OFFSET_NAME(r15),
-	REG_OFFSET_NAME(r14),
-	REG_OFFSET_NAME(r13),
-	REG_OFFSET_NAME(r12),
-	REG_OFFSET_NAME(r11),
-	REG_OFFSET_NAME(r10),
-	REG_OFFSET_NAME(r9),
-	REG_OFFSET_NAME(r8),
+	REGS_OFFSET_NAME(r15),
+	REGS_OFFSET_NAME(r14),
+	REGS_OFFSET_NAME(r13),
+	REGS_OFFSET_NAME(r12),
+	REGS_OFFSET_NAME(r11),
+	REGS_OFFSET_NAME(r10),
+	REGS_OFFSET_NAME(r9),
+	REGS_OFFSET_NAME(r8),
 #endif
-	REG_OFFSET_NAME(bx),
-	REG_OFFSET_NAME(cx),
-	REG_OFFSET_NAME(dx),
-	REG_OFFSET_NAME(si),
-	REG_OFFSET_NAME(di),
-	REG_OFFSET_NAME(bp),
-	REG_OFFSET_NAME(ax),
+	REGS_OFFSET_NAME(bx),
+	REGS_OFFSET_NAME(cx),
+	REGS_OFFSET_NAME(dx),
+	REGS_OFFSET_NAME(si),
+	REGS_OFFSET_NAME(di),
+	REGS_OFFSET_NAME(bp),
+	REGS_OFFSET_NAME(ax),
 #ifdef CONFIG_X86_32
-	REG_OFFSET_NAME(ds),
-	REG_OFFSET_NAME(es),
-	REG_OFFSET_NAME(fs),
-	REG_OFFSET_NAME(gs),
+	REGS_OFFSET_NAME(ds),
+	REGS_OFFSET_NAME(es),
+	REGS_OFFSET_NAME(fs),
+	REGS_OFFSET_NAME(gs),
 #endif
-	REG_OFFSET_NAME(orig_ax),
-	REG_OFFSET_NAME(ip),
-	REG_OFFSET_NAME(cs),
-	REG_OFFSET_NAME(flags),
-	REG_OFFSET_NAME(sp),
-	REG_OFFSET_NAME(ss),
-	REG_OFFSET_END,
+	REGS_OFFSET_NAME(orig_ax),
+	REGS_OFFSET_NAME(ip),
+	REGS_OFFSET_NAME(cs),
+	REGS_OFFSET_NAME(flags),
+	REGS_OFFSET_NAME(sp),
+	REGS_OFFSET_NAME(ss),
+	REGS_OFFSET_END,
 };
 
 /**
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 504c98a..4e1c6fd 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -406,4 +406,16 @@ extern int task_current_syscall(struct task_struct *target, long *callno,
 				unsigned long args[6], unsigned int maxargs,
 				unsigned long *sp, unsigned long *pc);
 
+#ifdef	CONFIG_HAVE_REGS_AND_STACK_ACCESS_API
+
+#define REGS_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
+#define REGS_OFFSET_END {.name = NULL, .offset = 0}
+
+struct pt_regs_offset {
+	const char *name;
+	int offset;
+};
+
+#endif	/* CONFIG_HAVE_REGS_AND_STACK_ACCESS_API */
+
 #endif
-- 
2.5.0
