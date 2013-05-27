Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 4/5] powerpc/tm: Move TM abort cause codes to uapi
In-reply-to: <1369627781-31088-5-git-send-email-mikey@neuling.org>
References: <1369627781-31088-1-git-send-email-mikey@neuling.org>
 <1369627781-31088-5-git-send-email-mikey@neuling.org>
Date: Mon, 27 May 2013 14:30:56 +1000
Message-ID: <6216.1369629056@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These cause codes are usable by userspace, so let's export to uapi.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org> # v3.9
--
v2:
  add uapi/tm.h to Kbuild so it gets exported correctly

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index d0528e0..4a9e408 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -111,20 +111,6 @@
 #define MSR_TM_TRANSACTIONAL(x)	(((x) & MSR_TS_MASK) == MSR_TS_T)
 #define MSR_TM_SUSPENDED(x)	(((x) & MSR_TS_MASK) == MSR_TS_S)
 
-/* Reason codes describing kernel causes for transaction aborts.  By
-   convention, bit0 is copied to TEXASR[56] (IBM bit 7) which is set if
-   the failure is persistent.  PAPR saves 0xff-0xe0 for the hypervisor.
-*/
-#define TM_CAUSE_PERSISTENT	0x01
-#define TM_CAUSE_RESCHED	0xde
-#define TM_CAUSE_TLBI		0xdc
-#define TM_CAUSE_FAC_UNAV	0xda
-#define TM_CAUSE_SYSCALL	0xd8  /* future use */
-#define TM_CAUSE_MISC		0xd6  /* future use */
-#define TM_CAUSE_SIGNAL		0xd4
-#define TM_CAUSE_ALIGNMENT	0xd2
-#define TM_CAUSE_EMULATE	0xd0
-
 #if defined(CONFIG_PPC_BOOK3S_64)
 #define MSR_64BIT	MSR_SF
 
diff --git a/arch/powerpc/include/asm/tm.h b/arch/powerpc/include/asm/tm.h
index 4b4449a..9dfbc34 100644
--- a/arch/powerpc/include/asm/tm.h
+++ b/arch/powerpc/include/asm/tm.h
@@ -5,6 +5,8 @@
  * Copyright 2012 Matt Evans & Michael Neuling, IBM Corporation.
  */
 
+#include <uapi/asm/tm.h>
+
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 extern void do_load_up_transact_fpu(struct thread_struct *thread);
 extern void do_load_up_transact_altivec(struct thread_struct *thread);
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index f7bca63..5182c86 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -40,6 +40,7 @@ header-y += statfs.h
 header-y += swab.h
 header-y += termbits.h
 header-y += termios.h
+header-y += tm.h
 header-y += types.h
 header-y += ucontext.h
 header-y += unistd.h
diff --git a/arch/powerpc/include/uapi/asm/tm.h b/arch/powerpc/include/uapi/asm/tm.h
new file mode 100644
index 0000000..85059a0
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/tm.h
@@ -0,0 +1,18 @@
+#ifndef _ASM_POWERPC_TM_H
+#define _ASM_POWERPC_TM_H
+
+/* Reason codes describing kernel causes for transaction aborts.  By
+ * convention, bit0 is copied to TEXASR[56] (IBM bit 7) which is set if
+ * the failure is persistent.  PAPR saves 0xff-0xe0 for the hypervisor.
+ */
+#define TM_CAUSE_PERSISTENT	0x01
+#define TM_CAUSE_RESCHED	0xde
+#define TM_CAUSE_TLBI		0xdc
+#define TM_CAUSE_FAC_UNAV	0xda
+#define TM_CAUSE_SYSCALL	0xd8  /* future use */
+#define TM_CAUSE_MISC		0xd6  /* future use */
+#define TM_CAUSE_SIGNAL		0xd4
+#define TM_CAUSE_ALIGNMENT	0xd2
+#define TM_CAUSE_EMULATE	0xd0
+
+#endif
