Return-Path: <cyrilbur@gmail.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10E591A0C1C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 13:32:38 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 21 Jan 2015 12:32:37 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 383482CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 13:32:36 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0L2WaoY44564506
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 13:32:36 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0L2WZFv018548
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 13:32:35 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: fix endian problems with LE migration
Date: Wed, 21 Jan 2015 13:32:00 +1100
Message-Id: <1421807520-12030-1-git-send-email-cyrilbur@gmail.com>
Cc: Cyril Bur <cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The need to handle ibm,suspend_me specially from within ppc_rtas has left an
endian bug exposed as rtas_ibm_suspend_me actually performs HCALLs and should
have its params in CPU endian.

Have ppc_rtas send the params correctly and also interpret the result
correctly.

Removed the convoluted use of the rtas_args struct to pass params to
rtas_ibm_suspend_me in favour of passing what it needs directly.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
This patch has been tested with KVM both LE and BE and on PowerVM both LE and
BE. Under QEMU/KVM the migration happens without touching the these code
pathes.
For PowerVM there is no obvious regression on BE and the LE code path now
provides the correct parameters to the hypervisor

---
 arch/powerpc/include/asm/rtas.h           |  2 +-
 arch/powerpc/kernel/rtas.c                | 22 +++++++++++++++-------
 arch/powerpc/platforms/pseries/mobility.c | 22 ++++++----------------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index b390f55..2e23e92 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -327,7 +327,7 @@ extern int rtas_suspend_cpu(struct rtas_suspend_me_data *data);
 extern int rtas_suspend_last_cpu(struct rtas_suspend_me_data *data);
 extern int rtas_online_cpus_mask(cpumask_var_t cpus);
 extern int rtas_offline_cpus_mask(cpumask_var_t cpus);
-extern int rtas_ibm_suspend_me(struct rtas_args *);
+extern int rtas_ibm_suspend_me(u64 handle, int *vasi_return);
 
 struct rtc_time;
 extern unsigned long rtas_get_boot_time(void);
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 4af905e..21c45a2 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -897,7 +897,7 @@ int rtas_offline_cpus_mask(cpumask_var_t cpus)
 }
 EXPORT_SYMBOL(rtas_offline_cpus_mask);
 
-int rtas_ibm_suspend_me(struct rtas_args *args)
+int rtas_ibm_suspend_me(u64 handle, int *vasi_return)
 {
 	long state;
 	long rc;
@@ -911,8 +911,7 @@ int rtas_ibm_suspend_me(struct rtas_args *args)
 		return -ENOSYS;
 
 	/* Make sure the state is valid */
-	rc = plpar_hcall(H_VASI_STATE, retbuf,
-			 ((u64)args->args[0] << 32) | args->args[1]);
+	rc = plpar_hcall(H_VASI_STATE, retbuf, handle);
 
 	state = retbuf[0];
 
@@ -920,12 +919,12 @@ int rtas_ibm_suspend_me(struct rtas_args *args)
 		printk(KERN_ERR "rtas_ibm_suspend_me: vasi_state returned %ld\n",rc);
 		return rc;
 	} else if (state == H_VASI_ENABLED) {
-		args->args[args->nargs] = RTAS_NOT_SUSPENDABLE;
+		*vasi_return = RTAS_NOT_SUSPENDABLE;
 		return 0;
 	} else if (state != H_VASI_SUSPENDING) {
 		printk(KERN_ERR "rtas_ibm_suspend_me: vasi_state returned state %ld\n",
 		       state);
-		args->args[args->nargs] = -1;
+		*vasi_return = -1;
 		return 0;
 	}
 
@@ -973,7 +972,7 @@ out:
 	return atomic_read(&data.error);
 }
 #else /* CONFIG_PPC_PSERIES */
-int rtas_ibm_suspend_me(struct rtas_args *args)
+int rtas_ibm_suspend_me(u64 handle, int *vasi_return)
 {
 	return -ENOSYS;
 }
@@ -1053,7 +1052,16 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
 
 	/* Need to handle ibm,suspend_me call specially */
 	if (token == ibm_suspend_me_token) {
-		rc = rtas_ibm_suspend_me(&args);
+
+		/*
+		 * rtas_ibm_suspend_me assumes args are in cpu endian, or at least the
+		 * hcall within it requires it.
+		 */
+		int vasi_rc = 0;
+		u64 handle = ((u64)be32_to_cpu(args.args[0]) << 32)
+		              | be32_to_cpu(args.args[1]);
+		rc = rtas_ibm_suspend_me(handle, &vasi_rc);
+		args.rets[0] = cpu_to_be32(vasi_rc);
 		if (rc)
 			return rc;
 		goto copy_return;
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index e7cb6d4..90cf3dc 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -316,34 +316,24 @@ void post_mobility_fixup(void)
 static ssize_t migrate_store(struct class *class, struct class_attribute *attr,
 			     const char *buf, size_t count)
 {
-	struct rtas_args args;
 	u64 streamid;
 	int rc;
+	int vasi_rc = 0;
 
 	rc = kstrtou64(buf, 0, &streamid);
 	if (rc)
 		return rc;
 
-	memset(&args, 0, sizeof(args));
-	args.token = rtas_token("ibm,suspend-me");
-	args.nargs = 2;
-	args.nret = 1;
-
-	args.args[0] = streamid >> 32 ;
-	args.args[1] = streamid & 0xffffffff;
-	args.rets = &args.args[args.nargs];
-
 	do {
-		args.rets[0] = 0;
-		rc = rtas_ibm_suspend_me(&args);
-		if (!rc && args.rets[0] == RTAS_NOT_SUSPENDABLE)
+		rc = rtas_ibm_suspend_me(streamid, &vasi_rc);
+		if (!rc && vasi_rc == RTAS_NOT_SUSPENDABLE)
 			ssleep(1);
-	} while (!rc && args.rets[0] == RTAS_NOT_SUSPENDABLE);
+	} while (!rc && vasi_rc == RTAS_NOT_SUSPENDABLE);
 
 	if (rc)
 		return rc;
-	else if (args.rets[0])
-		return args.rets[0];
+	if (vasi_rc)
+		return vasi_rc;
 
 	post_mobility_fixup();
 	return count;
-- 
1.9.1
