Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 08/33] powerpc: Remove function descriptors and dot symbols on
 new ABI
Date: Tue, 25 Mar 2014 22:44:14 +1100
Message-Id: <1395747879-5948-9-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ABIv2 doesn't have function descriptors or dot symbols. One
new thing it does add is a function global and a local entry
point, so add that to our _GLOBAL macro.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/ftrace.h  |  2 ++
 arch/powerpc/include/asm/linkage.h |  2 ++
 arch/powerpc/include/asm/ppc_asm.h | 22 ++++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 169d039..e366187 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -61,6 +61,7 @@ struct dyn_arch_ftrace {
 #endif
 
 #if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_PPC64) && !defined(__ASSEMBLY__)
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
 #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
 static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
 {
@@ -72,6 +73,7 @@ static inline bool arch_syscall_match_sym_name(const char *sym, const char *name
 	 */
 	return !strcmp(sym + 4, name + 3);
 }
+#endif
 #endif /* CONFIG_FTRACE_SYSCALLS && CONFIG_PPC64 && !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_FTRACE */
diff --git a/arch/powerpc/include/asm/linkage.h b/arch/powerpc/include/asm/linkage.h
index b36f650..e3ad5c7 100644
--- a/arch/powerpc/include/asm/linkage.h
+++ b/arch/powerpc/include/asm/linkage.h
@@ -2,6 +2,7 @@
 #define _ASM_POWERPC_LINKAGE_H
 
 #ifdef CONFIG_PPC64
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
 #define cond_syscall(x) \
 	asm ("\t.weak " #x "\n\t.set " #x ", sys_ni_syscall\n"		\
 	     "\t.weak ." #x "\n\t.set ." #x ", .sys_ni_syscall\n")
@@ -9,5 +10,6 @@
 	asm ("\t.globl " #alias "\n\t.set " #alias ", " #name "\n"	\
 	     "\t.globl ." #alias "\n\t.set ." #alias ", ." #name)
 #endif
+#endif
 
 #endif	/* _ASM_POWERPC_LINKAGE_H */
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 61992d8..5394d41 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -192,6 +192,26 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #define __STK_PARAM(i)	(48 + ((i)-3)*8)
 #define STK_PARAM(i)	__STK_PARAM(__REG_##i)
 
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+
+#define _GLOBAL(name) \
+	.section ".text"; \
+	.align 2 ; \
+	.type name,@function; \
+	.globl name; \
+name:
+
+#define _KPROBE(name) \
+	.section ".kprobes.text","a"; \
+	.align 2 ; \
+	.type name,@function; \
+	.globl name; \
+name:
+
+#define DOTSYM(a)	a
+
+#else
+
 #define XGLUE(a,b) a##b
 #define GLUE(a,b) XGLUE(a,b)
 
@@ -225,6 +245,8 @@ GLUE(.,name):
 
 #define DOTSYM(a)	GLUE(.,a)
 
+#endif
+
 #else /* 32-bit */
 
 #define _ENTRY(n)	\
-- 
1.8.3.2
