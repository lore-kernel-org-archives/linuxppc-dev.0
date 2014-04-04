Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com, rostedt@goodmis.org, philippe.bergheaud@fr.ibm.com
Subject: [PATCH 5/7] powerpc/modules: Create module_trampoline_target()
Date: Fri,  4 Apr 2014 17:09:08 +1100
Message-Id: <1396591750-8203-6-git-send-email-anton@samba.org>
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
layout hidden inside it. Create module_trampoline_target() that gives
the target address of a kernel module trampoline.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/module.h |  2 ++
 arch/powerpc/kernel/module_64.c   | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index f2711f0..dcfcad1 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -79,6 +79,8 @@ struct mod_arch_specific {
 #endif
 
 bool is_module_trampoline(u32 *insns);
+int module_trampoline_target(struct module *mod, u32 *trampoline,
+			     unsigned long *target);
 
 struct exception_table_entry;
 void sort_ex_table(struct exception_table_entry *start,
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 4db5ecd..ef349d0 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -176,6 +176,35 @@ bool is_module_trampoline(u32 *p)
 	return true;
 }
 
+int module_trampoline_target(struct module *mod, u32 *trampoline,
+			     unsigned long *target)
+{
+	u32 buf[2];
+	u16 upper, lower;
+	long offset;
+	void *toc_entry;
+
+	if (probe_kernel_read(buf, trampoline, sizeof(buf)))
+		return -EFAULT;
+
+	upper = buf[0] & 0xffff;
+	lower = buf[1] & 0xffff;
+
+	/* perform the addis/addi, both signed */
+	offset = ((short)upper << 16) + (short)lower;
+
+	/*
+	 * Now get the address this trampoline jumps to. This
+	 * is always 32 bytes into our trampoline stub.
+	 */
+	toc_entry = (void *)mod->arch.toc + offset + 32;
+
+	if (probe_kernel_read(target, toc_entry, sizeof(*target)))
+		return -EFAULT;
+
+	return 0;
+}
+
 #endif
 
 /* Count how many different 24-bit relocations (different symbol,
-- 
1.8.3.2
