Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 898761400E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:15 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 14 May 2014 14:12:15 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0603D3578057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:07 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4E4BpIo62914808
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:11:51 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4E4C6B9004902
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:06 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 6/8] powerpc: Extend syscall ppc_rtas()
Date: Wed, 14 May 2014 14:12:00 +1000
Message-Id: <1400040722-29608-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, agraf@suse.de, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Originally, syscall ppc_rtas() can be used to invoke RTAS call from
user space. Utility "errinjct" is using it to inject various errors
to the system for testing purpose. The patch intends to extend the
syscall to support both pSeries and PowerNV platform. With that,
RTAS and OPAL call can be invoked from user space. In turn, utility
"errinjct" can be supported on pSeries and PowerNV platform at same
time.

The original syscall handler ppc_rtas() is renamed to ppc_firmware(),
which calls ppc_call_rtas() or ppc_call_opal() depending on the
running platform. The data transported between userland and kerenl is
by "struct rtas_args". It's platform specific on how to use the data.

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h        | 10 +++++-
 arch/powerpc/include/asm/syscalls.h    |  2 +-
 arch/powerpc/include/asm/systbl.h      |  2 +-
 arch/powerpc/include/uapi/asm/unistd.h |  2 +-
 arch/powerpc/kernel/rtas.c             | 57 +++++++---------------------------
 arch/powerpc/kernel/syscalls.c         | 50 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c  |  7 +++++
 kernel/sys_ni.c                        |  2 +-
 8 files changed, 82 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index b390f55..3428524 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -20,7 +20,7 @@
 #define RTAS_UNKNOWN_SERVICE (-1)
 #define RTAS_INSTANTIATE_MAX (1ULL<<30) /* Don't instantiate rtas at/above this value */
 
-/* Buffer size for ppc_rtas system call. */
+/* Buffer size for ppc_firmware system call. */
 #define RTAS_RMOBUF_MAX (64 * 1024)
 
 /* RTAS return status codes */
@@ -427,9 +427,17 @@ static inline int page_is_rtas_user_buf(unsigned long pfn)
 /* Not the best place to put pSeries_coalesce_init, will be fixed when we
  * move some of the rtas suspend-me stuff to pseries */
 extern void pSeries_coalesce_init(void);
+extern int ppc_call_rtas(struct rtas_args *args);
 #else
 static inline int page_is_rtas_user_buf(unsigned long pfn) { return 0;}
 static inline void pSeries_coalesce_init(void) { }
+static inline int ppc_call_rtas(struct rtas_args *args) { return -ENXIO; }
+#endif
+
+#ifdef CONFIG_PPC_POWERNV
+extern int ppc_call_opal(struct rtas_args *args);
+#else
+static inline int ppc_call_opal(struct rtas_arts *args) { return -ENXIO; }
 #endif
 
 extern int call_rtas(const char *, int, int, unsigned long *, ...);
diff --git a/arch/powerpc/include/asm/syscalls.h b/arch/powerpc/include/asm/syscalls.h
index 23be8f1..3383e50 100644
--- a/arch/powerpc/include/asm/syscalls.h
+++ b/arch/powerpc/include/asm/syscalls.h
@@ -15,7 +15,7 @@ asmlinkage unsigned long sys_mmap2(unsigned long addr, size_t len,
 		unsigned long prot, unsigned long flags,
 		unsigned long fd, unsigned long pgoff);
 asmlinkage long ppc64_personality(unsigned long personality);
-asmlinkage int ppc_rtas(struct rtas_args __user *uargs);
+asmlinkage int ppc_firmware(struct rtas_args __user *uargs);
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_SYSCALLS_H */
diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 3ddf702..00f8bb2 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -259,7 +259,7 @@ COMPAT_SYS_SPU(utimes)
 COMPAT_SYS_SPU(statfs64)
 COMPAT_SYS_SPU(fstatfs64)
 SYSX(sys_ni_syscall, ppc_fadvise64_64, ppc_fadvise64_64)
-PPC_SYS_SPU(rtas)
+PPC_SYS_SPU(firmware)
 OLDSYS(debug_setcontext)
 SYSCALL(ni_syscall)
 COMPAT_SYS(migrate_pages)
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 881bf2e..3aee765 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -273,7 +273,7 @@
 #ifndef __powerpc64__
 #define __NR_fadvise64_64	254
 #endif
-#define __NR_rtas		255
+#define __NR_firmware		255
 #define __NR_sys_debug_setcontext 256
 /* Number 257 is reserved for vserver */
 #define __NR_migrate_pages	258
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8cd5ed0..5d829a72 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1017,59 +1017,32 @@ struct pseries_errorlog *get_pseries_errorlog(struct rtas_error_log *log,
 }
 
 /* We assume to be passed big endian arguments */
-asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
+int ppc_call_rtas(struct rtas_args *args)
 {
-	struct rtas_args args;
 	unsigned long flags;
 	char *buff_copy, *errbuf = NULL;
-	int nargs, nret, token;
 	int rc;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	if (copy_from_user(&args, uargs, 3 * sizeof(u32)) != 0)
-		return -EFAULT;
-
-	nargs = be32_to_cpu(args.nargs);
-	nret  = be32_to_cpu(args.nret);
-	token = be32_to_cpu(args.token);
-
-	if (nargs > ARRAY_SIZE(args.args)
-	    || nret > ARRAY_SIZE(args.args)
-	    || nargs + nret > ARRAY_SIZE(args.args))
-		return -EINVAL;
-
-	/* Copy in args. */
-	if (copy_from_user(args.args, uargs->args,
-			   nargs * sizeof(rtas_arg_t)) != 0)
-		return -EFAULT;
-
-	if (token == RTAS_UNKNOWN_SERVICE)
-		return -EINVAL;
-
-	args.rets = &args.args[nargs];
-	memset(args.rets, 0, nret * sizeof(rtas_arg_t));
-
 	/* Need to handle ibm,suspend_me call specially */
-	if (token == ibm_suspend_me_token) {
-		rc = rtas_ibm_suspend_me(&args);
+	if (args->token == ibm_suspend_me_token) {
+		rc = rtas_ibm_suspend_me(args);
 		if (rc)
 			return rc;
-		goto copy_return;
+		goto out;
 	}
 
 	buff_copy = get_errorlog_buffer();
 
 	flags = lock_rtas();
-
-	rtas.args = args;
+	rtas.args = *args;
 	enter_rtas(__pa(&rtas.args));
-	args = rtas.args;
+	*args = rtas.args;
 
-	/* A -1 return code indicates that the last command couldn't
-	   be completed due to a hardware error. */
-	if (be32_to_cpu(args.rets[0]) == -1)
+	/*
+	 * A -1 return code indicates that the last command couldn't
+	 * be completed due to a hardware error.
+	 */
+	if (be32_to_cpu(args->rets[0]) == -1)
 		errbuf = __fetch_rtas_last_error(buff_copy);
 
 	unlock_rtas(flags);
@@ -1080,13 +1053,7 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
 		kfree(buff_copy);
 	}
 
- copy_return:
-	/* Copy out args. */
-	if (copy_to_user(uargs->args + nargs,
-			 args.args + nargs,
-			 nret * sizeof(rtas_arg_t)) != 0)
-		return -EFAULT;
-
+out:
 	return 0;
 }
 
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index cd9be9a..bcb7483 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -40,6 +40,56 @@
 #include <asm/syscalls.h>
 #include <asm/time.h>
 #include <asm/unistd.h>
+#include <asm/machdep.h>
+#include <asm/rtas.h>
+
+asmlinkage int ppc_firmware(struct rtas_args __user *uargs)
+{
+	int rc;
+	int nargs, nret, token;
+	struct rtas_args args;
+
+	/* Copy over common header */
+	if (copy_from_user(&args, uargs, 3 * sizeof(u32)))
+		return -EFAULT;
+	nargs = be32_to_cpu(args.nargs);
+	nret  = be32_to_cpu(args.nret);
+	token = be32_to_cpu(args.token);
+
+	/* Parameter overflow ? */
+	if (nargs > ARRAY_SIZE(args.args)
+	    || nret > ARRAY_SIZE(args.args)
+	    || nargs + nret > ARRAY_SIZE(args.args))
+                return -EINVAL;
+
+	/* Copy over all arguments */
+        if (copy_from_user(args.args, uargs->args,
+			   nargs * sizeof(rtas_arg_t)))
+		return -EFAULT;
+
+	/* Invalid token ? */
+	if (token == RTAS_UNKNOWN_SERVICE)
+		return -EINVAL;
+
+	/* Clean out return values */
+        args.rets = &args.args[nargs];
+        memset(args.rets, 0, nret * sizeof(rtas_arg_t));
+
+	/* Route to correct platform */
+	if (machine_is(pseries))
+		rc = ppc_call_rtas(&args);
+	else if (machine_is(powernv))
+		rc = ppc_call_opal(&args);
+	else
+		return -ENXIO;
+
+	/* Copy result to user space */
+	if (copy_to_user(uargs->args + nargs, args.args + nargs,
+                         nret * sizeof(rtas_arg_t)))
+		return -EFAULT;
+
+	return rc;
+}
 
 static inline unsigned long do_mmap2(unsigned long addr, size_t len,
 			unsigned long prot, unsigned long flags,
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 360ad80c..ad33c2b 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -25,6 +25,7 @@
 #include <asm/opal.h>
 #include <asm/firmware.h>
 #include <asm/mce.h>
+#include <asm/rtas.h>
 
 #include "powernv.h"
 
@@ -701,3 +702,9 @@ void opal_free_sg_list(struct opal_sg_list *sg)
 			sg = NULL;
 	}
 }
+
+/* Extend it later */
+int ppc_call_opal(struct rtas_args *args)
+{
+	return 0;
+}
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index bc8d1b7..2c5b3fa 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -159,7 +159,7 @@ cond_syscall(sys_pciconfig_read);
 cond_syscall(sys_pciconfig_write);
 cond_syscall(sys_pciconfig_iobase);
 cond_syscall(compat_sys_s390_ipc);
-cond_syscall(ppc_rtas);
+cond_syscall(ppc_firmware);
 cond_syscall(sys_spu_run);
 cond_syscall(sys_spu_create);
 cond_syscall(sys_subpage_prot);
-- 
1.8.3.2
