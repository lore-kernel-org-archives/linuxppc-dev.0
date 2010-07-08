Return-Path: <matt@ozlabs.org>
Message-ID: <4C358479.1090502@ozlabs.org>
Date: Thu, 08 Jul 2010 17:55:37 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/kexec: Switch to a static PACA on the way out
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With dynamic PACAs, the kexecing CPU's PACA won't lie within the kernel
static data and there is a chance that something may stomp it when preparing
to kexec.  This patch switches this final CPU to a static PACA just before
we pull the switch.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
v2:	Changes from Milton's review:
	- Use setup_paca() and move from setup_64.c,
	- SLB cache inval. not required,
	- Adjust 'paca' (oops..), and
	- Poison data_offset/per_cpu_offset

 arch/powerpc/include/asm/paca.h        |    2 +-
 arch/powerpc/kernel/machine_kexec_64.c |   20 ++++++++++++++++++++
 arch/powerpc/kernel/paca.c             |   10 ++++++++++
 arch/powerpc/kernel/setup_64.c         |   10 ----------
 4 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 8ce7963..1ff6662 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -146,7 +146,7 @@ struct paca_struct {
 extern struct paca_struct *paca;
 extern __initdata struct paca_struct boot_paca;
 extern void initialise_paca(struct paca_struct *new_paca, int cpu);
-
+extern void setup_paca(struct paca_struct *new_paca);
 extern void allocate_pacas(void);
 extern void free_unused_pacas(void);
 
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 26f9900..c4d0123 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -273,6 +273,12 @@ static void kexec_prepare_cpus(void)
 static union thread_union kexec_stack __init_task_data =
 	{ };
 
+/*
+ * For similar reasons to the stack above, the kexecing CPU needs to be on a
+ * static PACA; we switch to kexec_paca.
+ */
+struct paca_struct kexec_paca;
+
 /* Our assembly helper, in kexec_stub.S */
 extern NORET_TYPE void kexec_sequence(void *newstack, unsigned long start,
 					void *image, void *control,
@@ -300,6 +306,20 @@ void default_machine_kexec(struct kimage *image)
 	kexec_stack.thread_info.task = current_thread_info()->task;
 	kexec_stack.thread_info.flags = 0;
 
+	/* We need a static PACA, too; copy this CPU's PACA over and switch to
+	 * it.  Also poison per_cpu_offset to catch anyone using non-static
+	 * data.
+	 */
+	memcpy(&kexec_paca, get_paca(), sizeof(struct paca_struct));
+	kexec_paca.data_offset = 0xedeaddeadeeeeeeeUL;
+	paca = (struct paca_struct *)RELOC_HIDE(&kexec_paca, 0) -
+		kexec_paca.paca_index;
+	setup_paca(&kexec_paca);
+
+	/* XXX: If anyone does 'dynamic lppacas' this will also need to be
+	 * switched to a static version!
+	 */
+
 	/* Some things are best done in assembly.  Finding globals with
 	 * a toc is easier in C, so pass in what we can.
 	 */
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index f88acf0..3db8d64 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -105,6 +105,16 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 #endif /* CONFIG_PPC_STD_MMU_64 */
 }
 
+/* Put the paca pointer into r13 and SPRG_PACA */
+void setup_paca(struct paca_struct *new_paca)
+{
+	local_paca = new_paca;
+	mtspr(SPRN_SPRG_PACA, local_paca);
+#ifdef CONFIG_PPC_BOOK3E
+	mtspr(SPRN_SPRG_TLB_EXFRAME, local_paca->extlb);
+#endif
+}
+
 static int __initdata paca_size;
 
 void __init allocate_pacas(void)
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f3fb5a7..6efbed4 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -142,16 +142,6 @@ early_param("smt-enabled", early_smt_enabled);
 #define check_smt_enabled()
 #endif /* CONFIG_SMP */
 
-/* Put the paca pointer into r13 and SPRG_PACA */
-static void __init setup_paca(struct paca_struct *new_paca)
-{
-	local_paca = new_paca;
-	mtspr(SPRN_SPRG_PACA, local_paca);
-#ifdef CONFIG_PPC_BOOK3E
-	mtspr(SPRN_SPRG_TLB_EXFRAME, local_paca->extlb);
-#endif
-}
-
 /*
  * Early initialization entry point. This is called by head.S
  * with MMU translation disabled. We rely on the "feature" of
-- 
1.6.3.3
