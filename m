Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com, rostedt@goodmis.org, philippe.bergheaud@fr.ibm.com
Subject: [PATCH 4/7] powerpc/modules: Create is_module_trampoline()
Date: Fri,  4 Apr 2014 17:09:07 +1100
Message-Id: <1396591750-8203-5-git-send-email-anton@samba.org>
In-Reply-To: <1396591750-8203-1-git-send-email-anton@samba.org>
References: <1396591750-8203-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ftrace has way too much knowledge of our kernel module trampoline
layout hidden inside it. Create is_module_trampoline() that can
abstract this away inside the module loader code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/module.h |  1 +
 arch/powerpc/kernel/module_64.c   | 51 +++++++++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index c9c7aaa..f2711f0 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -78,6 +78,7 @@ struct mod_arch_specific {
 #    endif	/* MODULE */
 #endif
 
+bool is_module_trampoline(u32 *insns);
 
 struct exception_table_entry;
 void sort_ex_table(struct exception_table_entry *start,
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 0423601..4db5ecd 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <linux/ftrace.h>
 #include <linux/bug.h>
+#include <linux/uaccess.h>
 #include <asm/module.h>
 #include <asm/firmware.h>
 #include <asm/code-patching.h>
@@ -102,7 +103,9 @@ static unsigned int local_entry_offset(const Elf64_Sym *sym)
    jump, actually, to reset r2 (TOC+0x8000). */
 struct ppc64_stub_entry
 {
-	/* 28 byte jump instruction sequence (7 instructions) */
+	/* 28 byte jump instruction sequence (7 instructions). We only
+	 * need 6 instructions on ABIv2 but we always allocate 7 so
+	 * so we don't have to modify the trampoline load instruction. */
 	u32 jump[7];
 	u32 unused;
 	/* Data for the above code */
@@ -122,8 +125,8 @@ struct ppc64_stub_entry
  * end of the stub code, and patch the stub address (32-bits relative
  * to the TOC ptr, r2) into the stub.
  */
-static struct ppc64_stub_entry ppc64_stub =
-{ .jump = {
+
+static u32 ppc64_stub_insns[] = {
 	0x3d620000,			/* addis   r11,r2, <high> */
 	0x396b0000,			/* addi    r11,r11, <low> */
 	/* Save current r2 value in magic place on the stack. */
@@ -135,7 +138,45 @@ static struct ppc64_stub_entry ppc64_stub =
 #endif
 	0x7d8903a6,			/* mtctr   r12 */
 	0x4e800420			/* bctr */
-} };
+};
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+static u32 ppc64_stub_mask[] = {
+	0xffff0000,
+	0xffff0000,
+	0xffffffff,
+	0xffffffff,
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
+	0xffffffff,
+#endif
+	0xffffffff,
+	0xffffffff
+};
+
+bool is_module_trampoline(u32 *p)
+{
+	unsigned int i;
+	u32 insns[ARRAY_SIZE(ppc64_stub_insns)];
+
+	BUILD_BUG_ON(sizeof(ppc64_stub_insns) != sizeof(ppc64_stub_mask));
+
+	if (probe_kernel_read(insns, p, sizeof(insns)))
+		return -EFAULT;
+
+	for (i = 0; i < ARRAY_SIZE(ppc64_stub_insns); i++) {
+		u32 insna = insns[i];
+		u32 insnb = ppc64_stub_insns[i];
+		u32 mask = ppc64_stub_mask[i];
+
+		if ((insna & mask) != (insnb & mask))
+			return false;
+	}
+
+	return true;
+}
+
+#endif
 
 /* Count how many different 24-bit relocations (different symbol,
    different addend) */
@@ -350,7 +391,7 @@ static inline int create_stub(Elf64_Shdr *sechdrs,
 {
 	long reladdr;
 
-	*entry = ppc64_stub;
+	memcpy(entry->jump, ppc64_stub_insns, sizeof(ppc64_stub_insns));
 
 	/* Stub uses address relative to r2. */
 	reladdr = (unsigned long)entry - my_r2(sechdrs, me);
-- 
1.8.3.2
