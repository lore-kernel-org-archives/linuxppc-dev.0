Return-Path: <brking@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 630A6B7E4D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 06:53:29 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4AKeHQl029715
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 16:40:17 -0400
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4AKrPgv140518
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 16:53:25 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4AKrFbj017807
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2010 14:53:16 -0600
Message-Id: <201005102053.o4AKrFTX017787@d03av05.boulder.ibm.com>
Subject: [PATCHv2 1/3] powerpc: Migration code reorganization / hibernation
	prep
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 10 May 2010 15:53:11 -0500
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Partition hibernation will use some of the same code as is
currently used for Live Partition Migration. This function
further abstracts this code such that code outside of rtas.c
can utilize it. It also changes the error field in the suspend
me data structure to be an atomic type, since it is set and
checked on different cpus without any barriers or locking.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/rtas.h |   10 +++
 arch/powerpc/kernel/rtas.c      |  106 ++++++++++++++++++++++++++--------------
 2 files changed, 81 insertions(+), 35 deletions(-)

diff -puN arch/powerpc/include/asm/rtas.h~powerpc_rtas_hibernate_prep arch/powerpc/include/asm/rtas.h
--- linux-2.6/arch/powerpc/include/asm/rtas.h~powerpc_rtas_hibernate_prep	2010-05-10 14:10:37.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/include/asm/rtas.h	2010-05-10 14:16:23.000000000 -0500
@@ -63,6 +63,14 @@ struct rtas_t {
 	struct device_node *dev;	/* virtual address pointer */
 };
 
+struct rtas_suspend_me_data {
+	atomic_t working; /* number of cpus accessing this struct */
+	atomic_t done;
+	int token; /* ibm,suspend-me */
+	atomic_t error;
+	struct completion *complete; /* wait on this until working == 0 */
+};
+
 /* RTAS event classes */
 #define RTAS_INTERNAL_ERROR		0x80000000 /* set bit 0 */
 #define RTAS_EPOW_WARNING		0x40000000 /* set bit 1 */
@@ -174,6 +182,8 @@ extern int rtas_set_indicator(int indica
 extern int rtas_set_indicator_fast(int indicator, int index, int new_value);
 extern void rtas_progress(char *s, unsigned short hex);
 extern void rtas_initialize(void);
+extern int rtas_suspend_cpu(struct rtas_suspend_me_data *data);
+extern int rtas_suspend_last_cpu(struct rtas_suspend_me_data *data);
 
 struct rtc_time;
 extern unsigned long rtas_get_boot_time(void);
diff -puN arch/powerpc/kernel/rtas.c~powerpc_rtas_hibernate_prep arch/powerpc/kernel/rtas.c
--- linux-2.6/arch/powerpc/kernel/rtas.c~powerpc_rtas_hibernate_prep	2010-05-10 14:10:37.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/kernel/rtas.c	2010-05-10 14:16:23.000000000 -0500
@@ -47,14 +47,6 @@ struct rtas_t rtas = {
 };
 EXPORT_SYMBOL(rtas);
 
-struct rtas_suspend_me_data {
-	atomic_t working; /* number of cpus accessing this struct */
-	atomic_t done;
-	int token; /* ibm,suspend-me */
-	int error;
-	struct completion *complete; /* wait on this until working == 0 */
-};
-
 DEFINE_SPINLOCK(rtas_data_buf_lock);
 EXPORT_SYMBOL(rtas_data_buf_lock);
 
@@ -711,14 +703,54 @@ void rtas_os_term(char *str)
 
 static int ibm_suspend_me_token = RTAS_UNKNOWN_SERVICE;
 #ifdef CONFIG_PPC_PSERIES
-static void rtas_percpu_suspend_me(void *info)
+static int __rtas_suspend_last_cpu(struct rtas_suspend_me_data *data, int wake_when_done)
+{
+	u16 slb_size = mmu_slb_size;
+	int rc = H_MULTI_THREADS_ACTIVE;
+	int cpu;
+
+	atomic_inc(&data->working);
+
+	slb_set_size(SLB_MIN_SIZE);
+	printk(KERN_DEBUG "calling ibm,suspend-me on cpu %i\n", smp_processor_id());
+
+	while (rc == H_MULTI_THREADS_ACTIVE && !atomic_read(&data->done) &&
+	       !atomic_read(&data->error))
+		rc = rtas_call(data->token, 0, 1, NULL);
+
+	if (rc || atomic_read(&data->error)) {
+		printk(KERN_DEBUG "ibm,suspend-me returned %d\n", rc);
+		slb_set_size(slb_size);
+	}
+
+	if (atomic_read(&data->error))
+		rc = atomic_read(&data->error);
+
+	atomic_set(&data->error, rc);
+
+	if (wake_when_done) {
+		atomic_set(&data->done, 1);
+
+		for_each_online_cpu(cpu)
+			plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
+	}
+
+	if (atomic_dec_return(&data->working) == 0)
+		complete(data->complete);
+
+	return rc;
+}
+
+int rtas_suspend_last_cpu(struct rtas_suspend_me_data *data)
+{
+	return __rtas_suspend_last_cpu(data, 0);
+}
+
+static int __rtas_suspend_cpu(struct rtas_suspend_me_data *data, int wake_when_done)
 {
 	long rc = H_SUCCESS;
 	unsigned long msr_save;
-	u16 slb_size = mmu_slb_size;
 	int cpu;
-	struct rtas_suspend_me_data *data =
-		(struct rtas_suspend_me_data *)info;
 
 	atomic_inc(&data->working);
 
@@ -726,7 +758,7 @@ static void rtas_percpu_suspend_me(void
 	msr_save = mfmsr();
 	mtmsr(msr_save & ~(MSR_EE));
 
-	while (rc == H_SUCCESS && !atomic_read(&data->done))
+	while (rc == H_SUCCESS && !atomic_read(&data->done) && !atomic_read(&data->error))
 		rc = plpar_hcall_norets(H_JOIN);
 
 	mtmsr(msr_save);
@@ -738,33 +770,37 @@ static void rtas_percpu_suspend_me(void
 		/* All other cpus are in H_JOIN, this cpu does
 		 * the suspend.
 		 */
-		slb_set_size(SLB_MIN_SIZE);
-		printk(KERN_DEBUG "calling ibm,suspend-me on cpu %i\n",
-		       smp_processor_id());
-		data->error = rtas_call(data->token, 0, 1, NULL);
-
-		if (data->error) {
-			printk(KERN_DEBUG "ibm,suspend-me returned %d\n",
-			       data->error);
-			slb_set_size(slb_size);
-		}
+		return __rtas_suspend_last_cpu(data, wake_when_done);
 	} else {
 		printk(KERN_ERR "H_JOIN on cpu %i failed with rc = %ld\n",
 		       smp_processor_id(), rc);
-		data->error = rc;
+		atomic_set(&data->error, rc);
 	}
 
-	atomic_set(&data->done, 1);
+	if (wake_when_done) {
+		atomic_set(&data->done, 1);
 
-	/* This cpu did the suspend or got an error; in either case,
-	 * we need to prod all other other cpus out of join state.
-	 * Extra prods are harmless.
-	 */
-	for_each_online_cpu(cpu)
-		plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
+		/* This cpu did the suspend or got an error; in either case,
+		 * we need to prod all other other cpus out of join state.
+		 * Extra prods are harmless.
+		 */
+		for_each_online_cpu(cpu)
+			plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
+	}
 out:
 	if (atomic_dec_return(&data->working) == 0)
 		complete(data->complete);
+	return rc;
+}
+
+int rtas_suspend_cpu(struct rtas_suspend_me_data *data)
+{
+	return __rtas_suspend_cpu(data, 0);
+}
+
+static void rtas_percpu_suspend_me(void *info)
+{
+	__rtas_suspend_cpu((struct rtas_suspend_me_data *)info, 1);
 }
 
 static int rtas_ibm_suspend_me(struct rtas_args *args)
@@ -799,22 +835,22 @@ static int rtas_ibm_suspend_me(struct rt
 
 	atomic_set(&data.working, 0);
 	atomic_set(&data.done, 0);
+	atomic_set(&data.error, 0);
 	data.token = rtas_token("ibm,suspend-me");
-	data.error = 0;
 	data.complete = &done;
 
 	/* Call function on all CPUs.  One of us will make the
 	 * rtas call
 	 */
 	if (on_each_cpu(rtas_percpu_suspend_me, &data, 0))
-		data.error = -EINVAL;
+		atomic_set(&data.error, -EINVAL);
 
 	wait_for_completion(&done);
 
-	if (data.error != 0)
+	if (atomic_read(&data.error) != 0)
 		printk(KERN_ERR "Error doing global join\n");
 
-	return data.error;
+	return atomic_read(&data.error);
 }
 #else /* CONFIG_PPC_PSERIES */
 static int rtas_ibm_suspend_me(struct rtas_args *args)
_
