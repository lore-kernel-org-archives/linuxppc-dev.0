Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E2A61A02E2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 07:23:37 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 4 Mar 2015 13:23:35 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A4B7E1FF0025
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 13:14:41 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t24KNZT338010958
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 13:23:43 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t24KMuEW022496
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 13:22:57 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/pseries: Simplify check for suspendability during
 suspend/migration
Date: Wed,  4 Mar 2015 12:22:27 -0800
Message-Id: <1425500547-22777-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: Cyril Bur <cyrilbur@gmail.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During suspend/migration operation we must wait for the VASI state reported
by the hypervisor to become Suspending prior to making the ibm,suspend-me
RTAS call. Calling routines to rtas_ibm_supend_me() pass a vasi_state variable
that exposes the VASI state to the caller. This is unnecessary as the caller
only really cares about the following three conditions; if there is an error
we should bailout, success indicating we have suspended and woken back up so
proceed to device tree updated, or we are not suspendable yet so try calling
rtas_ibm_suspend_me again shortly.

This patch removes the extraneous vasi_state variable and simply uses the
return code to communicate how to proceed. We either succeed, fail, or get
-EAGAIN in which case we sleep for a second before trying to call
rtas_ibm_suspend_me again.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: Cyril Bur <cyrilbur@gmail.com>
---

Changes in v2:
- Addressed Cyril's comments as follow:
- Removed unused vasi_rc variable
- Kept return behavior of ppc_rtas the same in the case of VASI error
- Updated rtas_ibm_suspend_me function definition for !CONFIG_PPC_PSERIES

 arch/powerpc/include/asm/rtas.h           |  2 +-
 arch/powerpc/kernel/rtas.c                | 26 +++++++++++++-------------
 arch/powerpc/platforms/pseries/mobility.c |  9 +++------
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 2e23e92..fc85eb0 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -327,7 +327,7 @@ extern int rtas_suspend_cpu(struct rtas_suspend_me_data *data);
 extern int rtas_suspend_last_cpu(struct rtas_suspend_me_data *data);
 extern int rtas_online_cpus_mask(cpumask_var_t cpus);
 extern int rtas_offline_cpus_mask(cpumask_var_t cpus);
-extern int rtas_ibm_suspend_me(u64 handle, int *vasi_return);
+extern int rtas_ibm_suspend_me(u64 handle);
 
 struct rtc_time;
 extern unsigned long rtas_get_boot_time(void);
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 21c45a2..b9a7b89 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -897,7 +897,7 @@ int rtas_offline_cpus_mask(cpumask_var_t cpus)
 }
 EXPORT_SYMBOL(rtas_offline_cpus_mask);
 
-int rtas_ibm_suspend_me(u64 handle, int *vasi_return)
+int rtas_ibm_suspend_me(u64 handle)
 {
 	long state;
 	long rc;
@@ -919,13 +919,11 @@ int rtas_ibm_suspend_me(u64 handle, int *vasi_return)
 		printk(KERN_ERR "rtas_ibm_suspend_me: vasi_state returned %ld\n",rc);
 		return rc;
 	} else if (state == H_VASI_ENABLED) {
-		*vasi_return = RTAS_NOT_SUSPENDABLE;
-		return 0;
+		return -EAGAIN;
 	} else if (state != H_VASI_SUSPENDING) {
 		printk(KERN_ERR "rtas_ibm_suspend_me: vasi_state returned state %ld\n",
 		       state);
-		*vasi_return = -1;
-		return 0;
+		return -EIO;
 	}
 
 	if (!alloc_cpumask_var(&offline_mask, GFP_TEMPORARY))
@@ -972,7 +970,7 @@ out:
 	return atomic_read(&data.error);
 }
 #else /* CONFIG_PPC_PSERIES */
-int rtas_ibm_suspend_me(u64 handle, int *vasi_return)
+int rtas_ibm_suspend_me(u64 handle)
 {
 	return -ENOSYS;
 }
@@ -1022,7 +1020,6 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
 	unsigned long flags;
 	char *buff_copy, *errbuf = NULL;
 	int nargs, nret, token;
-	int rc;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1054,15 +1051,18 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
 	if (token == ibm_suspend_me_token) {
 
 		/*
-		 * rtas_ibm_suspend_me assumes args are in cpu endian, or at least the
-		 * hcall within it requires it.
+		 * rtas_ibm_suspend_me assumes the streamid handle is in cpu
+		 * endian, or at least the hcall within it requires it.
 		 */
-		int vasi_rc = 0;
+		int rc = 0;
 		u64 handle = ((u64)be32_to_cpu(args.args[0]) << 32)
 		              | be32_to_cpu(args.args[1]);
-		rc = rtas_ibm_suspend_me(handle, &vasi_rc);
-		args.rets[0] = cpu_to_be32(vasi_rc);
-		if (rc)
+		rc = rtas_ibm_suspend_me(handle);
+		if (rc == -EAGAIN)
+			args.rets[0] = cpu_to_be32(RTAS_NOT_SUSPENDABLE);
+		else if (rc == -EIO)
+			args.rets[0] = cpu_to_be32(-1);
+		else if (rc)
 			return rc;
 		goto copy_return;
 	}
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 90cf3dc..c489701 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -318,22 +318,19 @@ static ssize_t migrate_store(struct class *class, struct class_attribute *attr,
 {
 	u64 streamid;
 	int rc;
-	int vasi_rc = 0;
 
 	rc = kstrtou64(buf, 0, &streamid);
 	if (rc)
 		return rc;
 
 	do {
-		rc = rtas_ibm_suspend_me(streamid, &vasi_rc);
-		if (!rc && vasi_rc == RTAS_NOT_SUSPENDABLE)
+		rc = rtas_ibm_suspend_me(streamid);
+		if (rc == -EAGAIN)
 			ssleep(1);
-	} while (!rc && vasi_rc == RTAS_NOT_SUSPENDABLE);
+	} while (rc == -EAGAIN);
 
 	if (rc)
 		return rc;
-	if (vasi_rc)
-		return vasi_rc;
 
 	post_mobility_fixup();
 	return count;
-- 
1.7.12.2
