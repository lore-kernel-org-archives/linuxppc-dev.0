Return-Path: <xenidis@gmail.com>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D6B6B6FA5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Sep 2011 01:58:08 +1000 (EST)
Received: by gwj17 with SMTP id 17so1059672gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Sep 2011 08:58:00 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/3 v2] powerpc: icswx: Simple ACOP fault handler for both
	book3e and book3s parts.
Date: Fri, 23 Sep 2011 10:59:54 -0500
Message-Id: <1316793594-22407-3-git-send-email-jimix@pobox.com>
In-Reply-To: <1316793594-22407-1-git-send-email-jimix@pobox.com>
References: <1316793594-22407-1-git-send-email-jimix@pobox.com>
Cc: anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a fault handler that responds to illegal Coprocessor
types.  Currently all CTs are treated and illegal.  There are two ways
to report the fault back to the application.  If the application used
the record form ("icswx.") then the architected "reject" is emulated.
If the application did not used the record form ("icswx") then it is
selectable by config whether the failure is silent (as architected) or
a SIGILL is generated.

In all cases pr_warn() is used to log the bad CT.

Signed-off-by: Jimi Xenidis <jimix@pobox.com>

---
Re: galak@kernel.crashing.org
 - Fix Kconfig/CONFIG mismatch
 - Removed union/bitfields and inspect the bits directly
---
 arch/powerpc/mm/fault.c                |   16 +++++
 arch/powerpc/mm/icswx.c                |  113 ++++++++++++++++++++++++++++++++
 arch/powerpc/mm/icswx.h                |   24 +++++++
 arch/powerpc/platforms/Kconfig.cputype |   13 ++++-
 4 files changed, 165 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 5efe8c9..88abe70 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -43,6 +43,7 @@
 #include <asm/tlbflush.h>
 #include <asm/siginfo.h>
 #include <mm/mmu_decl.h>
+#include <mm/icswx.h>
 
 #ifdef CONFIG_KPROBES
 static inline int notify_page_fault(struct pt_regs *regs)
@@ -143,6 +144,21 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 	is_write = error_code & ESR_DST;
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
 
+#ifdef CONFIG_PPC_ICSWX
+	/*
+	 * we need to do this early because this "data storage
+	 * interrupt" does not update the DAR/DEAR so we don't want to
+	 * look at it
+	 */
+	if (error_code & ICSWX_DSI_UCT) {
+		int ret;
+
+		ret = acop_handle_fault(regs, address, error_code);
+		if (ret)
+			return ret;
+	}
+#endif
+
 	if (notify_page_fault(regs))
 		return 0;
 
diff --git a/arch/powerpc/mm/icswx.c b/arch/powerpc/mm/icswx.c
index 2f1dd29..c8626cc 100644
--- a/arch/powerpc/mm/icswx.c
+++ b/arch/powerpc/mm/icswx.c
@@ -17,6 +17,8 @@
 #include <linux/mm.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
+#include <linux/uaccess.h>
+
 #include "icswx.h"
 
 
@@ -160,3 +162,114 @@ void drop_cop(unsigned long acop, struct mm_struct *mm)
 	spin_unlock(&mm->page_table_lock);
 }
 EXPORT_SYMBOL_GPL(drop_cop);
+
+static int acop_use_cop(int ct)
+{
+	/* todo */
+	return -1;
+}
+
+/*
+ * Get the instruction word at the NIP
+ */
+static u32 acop_get_inst(struct pt_regs *regs)
+{
+	u32 inst;
+	u32 __user *p;
+
+	p = (u32 __user *)regs->nip;
+	if (!access_ok(VERIFY_READ, p, sizeof(*p)))
+		return 0;
+
+	if (__get_user(inst, p))
+		return 0;
+
+	return inst;
+}
+
+/**
+ * @regs: regsiters at time of interrupt
+ * @address: storage address
+ * @error_code: Fault code, usually the DSISR or ESR depending on
+ *		processor type
+ *
+ * Return 0 if we are able to resolve the data storage fault that
+ * results from a CT miss in the ACOP register.
+ */
+int acop_handle_fault(struct pt_regs *regs, unsigned long address,
+		      unsigned long error_code)
+{
+	int ct;
+	u32 inst = 0;
+
+	if (!cpu_has_feature(CPU_FTR_ICSWX)) {
+		pr_info("No coprocessors available");
+		_exception(SIGILL, regs, ILL_ILLOPN, address);
+	}
+
+	if (!user_mode(regs)) {
+		/* this could happen if the HV denies the
+		 * kernel access, for now we just die */
+		die("ICSWX from kernel failed", regs, SIGSEGV);
+	}
+
+	/* Some implementations leave us a hint for the CT */
+	ct = ICSWX_GET_CT_HINT(error_code);
+	if (ct < 0) {
+		/* we have to peek at the instruction word to figure out CT */
+		u32 ccw;
+		u32 rs;
+
+		inst = acop_get_inst(regs);
+		if (inst == 0)
+			return -1;
+
+		rs = (inst >> (31 - 10)) & 0x1f;
+		ccw = regs->gpr[rs];
+		ct = (ccw >> 16) & 0x3f;
+	}
+
+	if (!acop_use_cop(ct))
+		return 0;
+
+	/* at this point the CT is unknown to the system */
+	pr_warn("%s[%d]: Coprocessor %d is unavailable",
+		current->comm, current->pid, ct);
+
+	/* get inst if we don't already have it */
+	if (inst == 0) {
+		inst = acop_get_inst(regs);
+		if (inst == 0)
+			return -1;
+	}
+
+	/* Check if the instruction is the "record form" */
+	if (inst & 1) {
+		/*
+		 * the instruction is "record" form so we can reject
+		 * using CR0
+		 */
+		regs->ccr &= ~(0xful << 28);
+		regs->ccr |= ICSWX_RC_NOT_FOUND << 28;
+
+		/* Move on to the next instruction */
+		regs->nip += 4;
+	} else {
+		/*
+		 * There is no architected mechanism to report a bad
+		 * CT so we could either SIGILL or report nothing.
+		 * Since the non-record version should only bu used
+		 * for "hints" or "don't care" we should probably do
+		 * nothing.  However, I could see how some people
+		 * might want an SIGILL so it here if you want it.
+		 */
+#ifdef CONFIG_PPC_ICSWX_USE_SIGILL
+		_exception(SIGILL, regs, ILL_ILLOPN, address);
+#else
+		regs->nip += 4;
+#endif
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acop_handle_fault);
diff --git a/arch/powerpc/mm/icswx.h b/arch/powerpc/mm/icswx.h
index 5121ddd..4c1ecc3 100644
--- a/arch/powerpc/mm/icswx.h
+++ b/arch/powerpc/mm/icswx.h
@@ -32,3 +32,27 @@ extern void free_cop_pid(int free_pid);
 #define disable_cop_pid(m) (COP_PID_NONE)
 #define free_cop_pid(p)
 #endif
+
+/*
+ * These are implementation bits for architected registers.  If this
+ * ever becomes architecture the should be moved to reg.h et. al.
+ */
+/* UCT is the same bit for Server and Embedded */
+#define ICSWX_DSI_UCT		0x00004000  /* Unavailable Coprocessor Type */
+
+#ifdef CONFIG_BOOKE
+/* Embedded implementation gives us no hits as to what the CT is */
+#define ICSWX_GET_CT_HINT(x) (-1)
+#else
+/* Server implementation contains the CT value in the DSISR */
+#define ICSWX_DSISR_CTMASK	0x00003f00
+#define ICSWX_GET_CT_HINT(x)	(((x) & ICSWX_DSISR_CTMASK) >> 8)
+#endif
+
+#define ICSWX_RC_STARTED	0x8	/* The request has been started */
+#define ICSWX_RC_NOT_IDLE	0x4	/* No coprocessor found idle */
+#define ICSWX_RC_NOT_FOUND	0x2	/* No coprocessor found */
+#define ICSWX_RC_UNDEFINED	0x1	/* Reserved */
+
+extern int acop_handle_fault(struct pt_regs *regs, unsigned long address,
+			     unsigned long error_code);
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 3cd22e5..4173129 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -255,9 +255,20 @@ config PPC_ICSWX_PID
 	depends on PPC_ICSWX && POWER4
 	default y
 	---help---
-	  PID register in server is used explicitly for ICSWX.  In
+	  The PID register in server is used explicitly for ICSWX.  In
 	  embedded systems PID managment is done by the system.
 
+config PPC_ICSWX_USE_SIGILL
+	bool "Should a bad CT cause a SIGILL?"
+	depends on PPC_ICSWX
+	default n
+	---help---
+	  Should a bad CT used for "non-record form ICSWX" cause an
+	  illegal intruction signal or should it be silent as
+	  architected.
+
+	  If in doubt, say N here.
+
 config SPE
 	bool "SPE Support"
 	depends on E200 || (E500 && !PPC_E500MC)
-- 
1.7.0.4
