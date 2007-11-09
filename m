Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id D0038DDDF2
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 07:44:23 +1100 (EST)
Date: Fri, 9 Nov 2007 14:44:08 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] fix multiple bugs in rtas_ibm_suspend_me code
Message-ID: <20071109204408.GS9695@localdomain>
References: <20071106044309.GK9695@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071106044309.GK9695@localdomain>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are several issues with the rtas_ibm_suspend_me code, which
enables platform-assisted suspension of an LPAR for migration or
hibernation as covered in PAPR 2.2.

1.) rtas_ibm_suspend_me uses on_each_cpu() to invoke
rtas_percpu_suspend_me on all cpus via IPI:

if (on_each_cpu(rtas_percpu_suspend_me, &data, 1, 0))
...

'data' is on the calling task's stack, but rtas_ibm_suspend_me takes
no measures to ensure that all instances of rtas_percpu_suspend_me are
finished accessing 'data' before returning.  This can result in the
IPI'd cpus accessing random stack data and getting stuck in H_JOIN.

This is addressed by using an atomic count of workers and a completion
on the stack.

2.) rtas_percpu_suspend_me is needlessly calling H_JOIN in a loop.
The only event that can cause a cpu to return from H_JOIN is an H_PROD
from another cpu or a NMI/system reset.  Each cpu need call H_JOIN
only once per suspend operation.

Remove the loop and the now unnecessary 'waiting' state variable.

3.) H_JOIN must be called with MSR[EE] off, but lazy interrupt
disabling may cause the caller of rtas_ibm_suspend_me to call H_JOIN
with it on; the local_irq_disable() in on_each_cpu() is not
sufficient.

Fix this by explicitly saving the MSR and clearing the EE bit before
calling H_JOIN.

4.) H_PROD is being called with the Linux logical cpu number as the
parameter, not the platform interrupt server value.  (It's also being
called for all possible cpus, which is harmless, but unnecessary.)

This is fixed by calling H_PROD for each online cpu using
get_hard_smp_processor_id(cpu) for the argument.

Signed-off-by: Nathan Lynch <ntl@pobox.com>

---
 arch/powerpc/kernel/rtas.c |   94 +++++++++++++++++++++++++-------------------
 1 files changed, 53 insertions(+), 41 deletions(-)

Changes since v1:
- the completion is adequate for ensuring that all IPIs have
completed, so there's no need for a mutex and rtas_suspend_me_data
can be on the stack as before.

- add fix for hard-disabling interrupts before H_JOIN

- remove unnecessary H_JOIN loop and state machinery

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 2147807..3afe771 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -41,8 +41,10 @@ struct rtas_t rtas = {
 EXPORT_SYMBOL(rtas);
 
 struct rtas_suspend_me_data {
-	long waiting;
-	struct rtas_args *args;
+	atomic_t working; /* number of cpus accessing this struct */
+	int token; /* ibm,suspend-me */
+	int error;
+	struct completion *complete; /* wait on this until working == 0 */
 };
 
 DEFINE_SPINLOCK(rtas_data_buf_lock);
@@ -657,50 +659,62 @@ static int ibm_suspend_me_token = RTAS_UNKNOWN_SERVICE;
 #ifdef CONFIG_PPC_PSERIES
 static void rtas_percpu_suspend_me(void *info)
 {
-	int i;
 	long rc;
-	long flags;
+	unsigned long msr_save;
+	int cpu;
 	struct rtas_suspend_me_data *data =
 		(struct rtas_suspend_me_data *)info;
 
-	/*
-	 * We use "waiting" to indicate our state.  As long
-	 * as it is >0, we are still trying to all join up.
-	 * If it goes to 0, we have successfully joined up and
-	 * one thread got H_CONTINUE.  If any error happens,
-	 * we set it to <0.
-	 */
-	local_irq_save(flags);
-	do {
-		rc = plpar_hcall_norets(H_JOIN);
-		smp_rmb();
-	} while (rc == H_SUCCESS && data->waiting > 0);
-	if (rc == H_SUCCESS)
-		goto out;
+	atomic_inc(&data->working);
+
+	/* really need to ensure MSR.EE is off for H_JOIN */
+	msr_save = mfmsr();
+	mtmsr(msr_save & ~(MSR_EE));
+
+	rc = plpar_hcall_norets(H_JOIN);
+
+	mtmsr(msr_save);
 
-	if (rc == H_CONTINUE) {
-		data->waiting = 0;
-		data->args->args[data->args->nargs] =
-			rtas_call(ibm_suspend_me_token, 0, 1, NULL);
-		for_each_possible_cpu(i)
-			plpar_hcall_norets(H_PROD,i);
+	if (rc == H_SUCCESS) {
+		/* This cpu was prodded and the suspend is complete. */
+		goto out;
+	} else if (rc == H_CONTINUE) {
+		/* All other cpus are in H_JOIN, this cpu does
+		 * the suspend.
+		 */
+		printk(KERN_DEBUG "calling ibm,suspend-me on cpu %i\n",
+		       smp_processor_id());
+		data->error = rtas_call(data->token, 0, 1, NULL);
+
+		if (data->error)
+			printk(KERN_DEBUG "ibm,suspend-me returned %d\n",
+			       data->error);
 	} else {
-		data->waiting = -EBUSY;
-		printk(KERN_ERR "Error on H_JOIN hypervisor call\n");
+		printk(KERN_ERR "H_JOIN on cpu %i failed with rc = %ld\n",
+		       smp_processor_id(), rc);
+		data->error = rc;
 	}
-
+	/* This cpu did the suspend or got an error; in either case,
+	 * we need to prod all other other cpus out of join state.
+	 * Extra prods are harmless.
+	 */
+	for_each_online_cpu(cpu)
+		plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
 out:
-	local_irq_restore(flags);
-	return;
+	if (atomic_dec_return(&data->working) == 0)
+		complete(data->complete);
 }
 
 static int rtas_ibm_suspend_me(struct rtas_args *args)
 {
-	int i;
 	long state;
 	long rc;
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 	struct rtas_suspend_me_data data;
+	DECLARE_COMPLETION_ONSTACK(done);
+
+	if (!rtas_service_present("ibm,suspend-me"))
+		return -ENOSYS;
 
 	/* Make sure the state is valid */
 	rc = plpar_hcall(H_VASI_STATE, retbuf,
@@ -721,25 +735,23 @@ static int rtas_ibm_suspend_me(struct rtas_args *args)
 		return 0;
 	}
 
-	data.waiting = 1;
-	data.args = args;
+	atomic_set(&data.working, 0);
+	data.token = rtas_token("ibm,suspend-me");
+	data.error = 0;
+	data.complete = &done;
 
 	/* Call function on all CPUs.  One of us will make the
 	 * rtas call
 	 */
 	if (on_each_cpu(rtas_percpu_suspend_me, &data, 1, 0))
-		data.waiting = -EINVAL;
+		data.error = -EINVAL;
 
-	if (data.waiting != 0)
-		printk(KERN_ERR "Error doing global join\n");
+	wait_for_completion(&done);
 
-	/* Prod each CPU.  This won't hurt, and will wake
-	 * anyone we successfully put to sleep with H_JOIN.
-	 */
-	for_each_possible_cpu(i)
-		plpar_hcall_norets(H_PROD, i);
+	if (data.error != 0)
+		printk(KERN_ERR "Error doing global join\n");
 
-	return data.waiting;
+	return data.error;
 }
 #else /* CONFIG_PPC_PSERIES */
 static int rtas_ibm_suspend_me(struct rtas_args *args)
-- 
1.5.3.4.206.g58ba4
