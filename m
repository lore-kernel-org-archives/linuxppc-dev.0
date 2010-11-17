Return-Path: <anton@samba.org>
Date: Wed, 17 Nov 2010 11:31:30 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Per process DSCR
Message-ID: <20101117113130.3702897c@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to add per process control of the DSCR, the following patch emulates
read/write of the DSCR from userspace and saves and restores it on context
switch. We add emulated stats to track how many times we do this.

While writing this patch a few things were apparent:

- How will this work with the global DSCR setting in
  /sys/devices/system/cpu/cpu*/dscr? Do we deprecate it? One thought is
  to add a new sysfs entry (eg dscr_enabled), which tells us to
  override any per process settings. Another way would be to overload
  the dscr sysfs entry and make -1 mean the system wide dscr setting is
  disabled.

- Do we need an out of band method of changing the DSCR so another
  process or could modify it? We may want to modify the DSCR of a long
  running process, eg a HPC job.

- To improve context switch speed we should probably check the old and
  new DSCR values are identical and avoid the SPR write.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/emulated_ops.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/emulated_ops.h	2010-10-26 08:27:15.241519117 +1100
+++ powerpc.git/arch/powerpc/include/asm/emulated_ops.h	2010-10-26 08:30:29.033192033 +1100
@@ -52,6 +52,10 @@ extern struct ppc_emulated {
 #ifdef CONFIG_VSX
 	struct ppc_emulated_entry vsx;
 #endif
+#ifdef CONFIG_PPC64
+	struct ppc_emulated_entry mfdscr;
+	struct ppc_emulated_entry mtdscr;
+#endif
 } ppc_emulated;
 
 extern u32 ppc_warn_emulated;
Index: powerpc.git/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/ppc-opcode.h	2010-10-26 08:21:09.307248476 +1100
+++ powerpc.git/arch/powerpc/include/asm/ppc-opcode.h	2010-10-26 08:41:51.383886171 +1100
@@ -39,6 +39,10 @@
 #define PPC_INST_RFCI			0x4c000066
 #define PPC_INST_RFDI			0x4c00004e
 #define PPC_INST_RFMCI			0x4c00004c
+#define PPC_INST_MFSPR_DSCR		0x7c1102a6
+#define PPC_INST_MFSPR_DSCR_MASK	0xfc1fffff
+#define PPC_INST_MTSPR_DSCR		0x7c1103a6
+#define PPC_INST_MTSPR_DSCR_MASK	0xfc1fffff
 
 #define PPC_INST_STRING			0x7c00042a
 #define PPC_INST_STRING_MASK		0xfc0007fe
Index: powerpc.git/arch/powerpc/include/asm/processor.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/processor.h	2010-10-26 08:15:39.811410266 +1100
+++ powerpc.git/arch/powerpc/include/asm/processor.h	2010-10-26 08:15:48.981017521 +1100
@@ -240,6 +240,9 @@ struct thread_struct {
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
 	void*		kvm_shadow_vcpu; /* KVM internal data */
 #endif /* CONFIG_KVM_BOOK3S_32_HANDLER */
+#ifdef CONFIG_PPC64
+	unsigned long	dscr;
+#endif
 };
 
 #define ARCH_MIN_TASKALIGN 16
Index: powerpc.git/arch/powerpc/kernel/traps.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/traps.c	2010-10-26 08:20:13.849632922 +1100
+++ powerpc.git/arch/powerpc/kernel/traps.c	2010-10-26 08:43:18.200159027 +1100
@@ -919,6 +919,26 @@ static int emulate_instruction(struct pt
 		return emulate_isel(regs, instword);
 	}
 
+#ifdef CONFIG_PPC64
+	/* Emulate the mfspr rD, DSCR. */
+	if (((instword & PPC_INST_MFSPR_DSCR_MASK) == PPC_INST_MFSPR_DSCR) &&
+			cpu_has_feature(CPU_FTR_DSCR)) {
+		PPC_WARN_EMULATED(mfdscr, regs);
+		rd = (instword >> 21) & 0x1f;
+		regs->gpr[rd] = mfspr(SPRN_DSCR);
+		return 0;
+	}
+
+	/* Emulate the mtspr DSCR, rD. */
+	if (((instword & PPC_INST_MTSPR_DSCR_MASK) == PPC_INST_MTSPR_DSCR) &&
+			cpu_has_feature(CPU_FTR_DSCR)) {
+		PPC_WARN_EMULATED(mtdscr, regs);
+		rd = (instword >> 21) & 0x1f;
+		mtspr(SPRN_DSCR, regs->gpr[rd]);
+		return 0;
+	}
+#endif
+
 	return -EINVAL;
 }
 
Index: powerpc.git/arch/powerpc/kernel/entry_64.S
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/entry_64.S	2010-10-26 08:45:18.075013145 +1100
+++ powerpc.git/arch/powerpc/kernel/entry_64.S	2010-10-26 08:50:38.991238792 +1100
@@ -421,6 +421,12 @@ BEGIN_FTR_SECTION
 	std	r24,THREAD_VRSAVE(r3)
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_PPC64
+BEGIN_FTR_SECTION
+	mfspr	r25,SPRN_DSCR
+	std	r25,THREAD_DSCR(r3)
+END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
+#endif
 	and.	r0,r0,r22
 	beq+	1f
 	andc	r22,r22,r0
@@ -522,6 +528,12 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_VRSAVE,r0		/* if G4, restore VRSAVE reg */
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_PPC64
+BEGIN_FTR_SECTION
+	ld	r0,THREAD_DSCR(r4)
+	mtspr	SPRN_DSCR,r0
+END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
+#endif
 
 	/* r3-r13 are destroyed -- Cort */
 	REST_8GPRS(14, r1)
Index: powerpc.git/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/asm-offsets.c	2010-10-26 08:51:07.799998249 +1100
+++ powerpc.git/arch/powerpc/kernel/asm-offsets.c	2010-10-26 08:51:52.688065383 +1100
@@ -74,6 +74,7 @@ int main(void)
 	DEFINE(AUDITCONTEXT, offsetof(struct task_struct, audit_context));
 	DEFINE(SIGSEGV, SIGSEGV);
 	DEFINE(NMI_MASK, NMI_MASK);
+	DEFINE(THREAD_DSCR, offsetof(struct thread_struct, dscr));
 #else
 	DEFINE(THREAD_INFO, offsetof(struct task_struct, stack));
 #endif /* CONFIG_PPC64 */
