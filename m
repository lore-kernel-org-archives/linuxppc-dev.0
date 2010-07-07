Return-Path: <matt@ozlabs.org>
Message-ID: <4C343D68.5090909@ozlabs.org>
Date: Wed, 07 Jul 2010 18:40:08 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: miltonm@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: [PATCH] kexec/ppc64: Switch to a static PACA on the way out
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
 arch/powerpc/kernel/machine_kexec_64.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 040bd1d..1348e84 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -253,6 +253,12 @@ static void kexec_prepare_cpus(void)
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
@@ -280,6 +286,19 @@ void default_machine_kexec(struct kimage *image)
 	kexec_stack.thread_info.task = current_thread_info()->task;
 	kexec_stack.thread_info.flags = 0;
 
+	/* We need a static PACA, too; copy this CPU's PACA over and switch to
+	 * it.  Also make the SLB cache look invalid as it may have been touched
+	 * by an IRQ before we switch to it.
+	 */
+	memcpy(&kexec_paca, get_paca(), sizeof(struct paca_struct));
+	kexec_paca.slb_cache_ptr = SLB_CACHE_ENTRIES+1;
+	/* 'local_paca' boils down to GPR13 */
+	local_paca = &kexec_paca;
+
+	/* XXX: If anyone does 'dynamic lppacas' this will also need to be
+	 * switched to a static version!
+	 */
+
 	/* Some things are best done in assembly.  Finding globals with
 	 * a toc is easier in C, so pass in what we can.
 	 */
-- 
1.6.3.3
