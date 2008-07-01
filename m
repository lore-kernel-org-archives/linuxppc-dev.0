Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Tue, 01 Jul 2008 14:01:39 +1000
Subject: [PATCH 2/2] powerpc: Update for VSX core file and ptrace
In-Reply-To: <1214884899.54079.831141965275.qpush@coopers>
Message-Id: <20080701040140.2F4CE702CA@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This correctly hooks the VSX dump into Roland McGrath core file
infrastructure.  It adds the VSX dump information as an additional elf
note in the core file (after talking more to the tool chain/gdb guys).
This also ensures the formats are consistent between signals, ptrace
and core files.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/process.c |   19 +------------------
 arch/powerpc/kernel/ptrace.c  |   21 +++++++++++++--------
 include/asm-powerpc/elf.h     |    4 ++--
 include/linux/elf.h           |    1 +
 4 files changed, 17 insertions(+), 28 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/process.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/process.c
@@ -162,7 +162,7 @@ void flush_altivec_to_thread(struct task
 	}
 }
 
-int dump_task_altivec(struct task_struct *tsk, elf_vrreg_t *vrregs)
+int dump_task_altivec(struct task_struct *tsk, elf_vrregset_t *vrregs)
 {
 	/* ELF_NVRREG includes the VSCR and VRSAVE which we need to save
 	 * separately, see below */
@@ -249,23 +249,6 @@ int dump_task_vsx(struct task_struct *ts
 }
 #endif /* CONFIG_VSX */
 
-int dump_task_vector(struct task_struct *tsk, elf_vrregset_t *vrregs)
-{
-	int rc = 0;
-	elf_vrreg_t *regs = (elf_vrreg_t *)vrregs;
-#ifdef CONFIG_ALTIVEC
-	rc = dump_task_altivec(tsk, regs);
-	if (rc)
-		return rc;
-	regs += ELF_NVRREG;
-#endif
-
-#ifdef CONFIG_VSX
-	rc = dump_task_vsx(tsk, regs);
-#endif
-	return rc;
-}
-
 #ifdef CONFIG_SPE
 
 void enable_kernel_spe(void)
Index: linux-2.6-ozlabs/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/ptrace.c
@@ -368,13 +368,15 @@ static int vsr_get(struct task_struct *t
 		   unsigned int pos, unsigned int count,
 		   void *kbuf, void __user *ubuf)
 {
-	int ret;
+	double buf[32];
+	int ret, i;
 
 	flush_vsx_to_thread(target);
 
+	for (i = 0; i < 32 ; i++)
+		buf[i] = current->thread.fpr[i][TS_VSRLOWOFFSET];
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  target->thread.fpr, 0,
-				  32 * sizeof(vector128));
+				  buf, 0, 32 * sizeof(double));
 
 	return ret;
 }
@@ -383,13 +385,16 @@ static int vsr_set(struct task_struct *t
 		   unsigned int pos, unsigned int count,
 		   const void *kbuf, const void __user *ubuf)
 {
-	int ret;
+	double buf[32];
+	int ret,i;
 
 	flush_vsx_to_thread(target);
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 target->thread.fpr, 0,
-				 32 * sizeof(vector128));
+				 buf, 0, 32 * sizeof(double));
+	for (i = 0; i < 32 ; i++)
+		current->thread.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+
 
 	return ret;
 }
@@ -499,8 +504,8 @@ static const struct user_regset native_r
 #endif
 #ifdef CONFIG_VSX
 	[REGSET_VSX] = {
-		.n = 32,
-		.size = sizeof(vector128), .align = sizeof(vector128),
+		.core_note_type = NT_PPC_VSX, .n = 32,
+		.size = sizeof(double), .align = sizeof(double),
 		.active = vsr_active, .get = vsr_get, .set = vsr_set
 	},
 #endif
Index: linux-2.6-ozlabs/include/asm-powerpc/elf.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/elf.h
+++ linux-2.6-ozlabs/include/asm-powerpc/elf.h
@@ -221,8 +221,8 @@ extern int dump_task_fpu(struct task_str
 typedef elf_vrregset_t elf_fpxregset_t;
 
 #ifdef CONFIG_ALTIVEC
-extern int dump_task_vector(struct task_struct *, elf_vrregset_t *vrregs);
-#define ELF_CORE_COPY_XFPREGS(tsk, regs) dump_task_vector(tsk, regs)
+extern int dump_task_altivec(struct task_struct *, elf_vrregset_t *vrregs);
+#define ELF_CORE_COPY_XFPREGS(tsk, regs) dump_task_altivec(tsk, regs)
 #define ELF_CORE_XFPREG_TYPE NT_PPC_VMX
 #endif
 
Index: linux-2.6-ozlabs/include/linux/elf.h
===================================================================
--- linux-2.6-ozlabs.orig/include/linux/elf.h
+++ linux-2.6-ozlabs/include/linux/elf.h
@@ -358,6 +358,7 @@ typedef struct elf64_shdr {
 #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */
 #define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
 #define NT_PPC_SPE	0x101		/* PowerPC SPE/EVR registers */
+#define NT_PPC_VSX	0x102		/* PowerPC VSX registers */
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 
 
