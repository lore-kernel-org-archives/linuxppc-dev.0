Return-Path: <bunk@kernel.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by ozlabs.org (Postfix) with ESMTP id 8204DDE594
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 03:50:25 +1000 (EST)
Date: Mon, 23 Jun 2008 20:48:28 +0300
From: Adrian Bunk <bunk@kernel.org>
To: paulus@samba.org
Subject: [RFC: 2.6 patch] powerpc: asm/elf.h: reduce userspace header
Message-ID: <20080623174828.GG4756@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes asm/elf.h export less non-userspace stuff to userspace.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/asm-powerpc/elf.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

6e868802e4b350a9dac071044b7cf52af7404134 diff --git a/include/asm-powerpc/elf.h b/include/asm-powerpc/elf.h
index 9080d85..d1e3bda 100644
--- a/include/asm-powerpc/elf.h
+++ b/include/asm-powerpc/elf.h
@@ -224,8 +224,6 @@ extern int dump_task_altivec(struct task_struct *, elf_vrregset_t *vrregs);
 #define ELF_CORE_XFPREG_TYPE NT_PPC_VMX
 #endif
 
-#endif /* __KERNEL__ */
-
 /* ELF_HWCAP yields a mask that user programs can use to figure out what
    instruction set this cpu supports.  This could be done in userspace,
    but it's not easy, and we've already done it here.  */
@@ -243,8 +241,6 @@ extern int dump_task_altivec(struct task_struct *, elf_vrregset_t *vrregs);
 } while (0)
 #endif /* __powerpc64__ */
 
-#ifdef __KERNEL__
-
 #ifdef __powerpc64__
 # define SET_PERSONALITY(ex, ibcs2)				\
 do {								\
@@ -272,8 +268,6 @@ do {								\
 # define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
 #endif /* __powerpc64__ */
 
-#endif /* __KERNEL__ */
-
 extern int dcache_bsize;
 extern int icache_bsize;
 extern int ucache_bsize;
@@ -285,6 +279,8 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int executable_stack);
 #define VDSO_AUX_ENT(a,b) NEW_AUX_ENT(a,b);
 
+#endif /* __KERNEL__ */
+
 /*
  * The requirements here are:
  * - keep the final alignment of sp (sp & 0xf)
@@ -422,6 +418,8 @@ do {									\
 /* Keep this the last entry.  */
 #define R_PPC64_NUM		107
 
+#ifdef  __KERNEL__
+
 #ifdef CONFIG_SPU_BASE
 /* Notes used in ET_CORE. Note name is "SPU/<fd>/<filename>". */
 #define NT_SPU		1
@@ -430,4 +428,6 @@ do {									\
 
 #endif /* CONFIG_SPU_BASE */
 
+#endif /* __KERNEL */
+
 #endif /* _ASM_POWERPC_ELF_H */
