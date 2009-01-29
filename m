Return-Path: <brking@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE948DDF02
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 10:24:52 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0TNMhta014805
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 16:22:43 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0TNOlDD026702
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 16:24:47 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0TNOlnh000825
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 16:24:47 -0700
Message-Id: <200901292324.n0TNOktd000814@d03av02.boulder.ibm.com>
Subject: [PATCH 1/1] powerpc: Fix partition migration hang under load
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 29 Jan 2009 17:23:23 -0600
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


While testing partition migration with heavy CPU load using
shared processors, it was observed that sometimes the migration
would never complete and would appear to hang. Currently, the
migration code assumes that if H_SUCCESS is returned from the H_JOIN
then the migration is complete and the processor is waking up on
the target system. If there was an outstanding PROD to the processor
when the H_JOIN is called, however, it will return H_SUCCESS on the source
system, causing the migration to hang, or in some scenarios cause
the kernel to crash on the complete call waking the caller
of rtas_percpu_suspend_me. Fix this by calling H_JOIN multiple times
if necessary during the migration.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/rtas.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff -puN arch/powerpc/kernel/rtas.c~powerpc_migration_hang_fix arch/powerpc/kernel/rtas.c
--- linux-2.6/arch/powerpc/kernel/rtas.c~powerpc_migration_hang_fix	2009-01-29 17:19:58.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/kernel/rtas.c	2009-01-29 17:19:58.000000000 -0600
@@ -46,6 +46,7 @@ EXPORT_SYMBOL(rtas);
 
 struct rtas_suspend_me_data {
 	atomic_t working; /* number of cpus accessing this struct */
+	atomic_t done;
 	int token; /* ibm,suspend-me */
 	int error;
 	struct completion *complete; /* wait on this until working == 0 */
@@ -689,7 +690,7 @@ static int ibm_suspend_me_token = RTAS_U
 #ifdef CONFIG_PPC_PSERIES
 static void rtas_percpu_suspend_me(void *info)
 {
-	long rc;
+	long rc = H_SUCCESS;
 	unsigned long msr_save;
 	int cpu;
 	struct rtas_suspend_me_data *data =
@@ -701,7 +702,8 @@ static void rtas_percpu_suspend_me(void 
 	msr_save = mfmsr();
 	mtmsr(msr_save & ~(MSR_EE));
 
-	rc = plpar_hcall_norets(H_JOIN);
+	while (rc == H_SUCCESS && !atomic_read(&data->done))
+		rc = plpar_hcall_norets(H_JOIN);
 
 	mtmsr(msr_save);
 
@@ -724,6 +726,9 @@ static void rtas_percpu_suspend_me(void 
 		       smp_processor_id(), rc);
 		data->error = rc;
 	}
+
+	atomic_set(&data->done, 1);
+
 	/* This cpu did the suspend or got an error; in either case,
 	 * we need to prod all other other cpus out of join state.
 	 * Extra prods are harmless.
@@ -766,6 +771,7 @@ static int rtas_ibm_suspend_me(struct rt
 	}
 
 	atomic_set(&data.working, 0);
+	atomic_set(&data.done, 0);
 	data.token = rtas_token("ibm,suspend-me");
 	data.error = 0;
 	data.complete = &done;
_
