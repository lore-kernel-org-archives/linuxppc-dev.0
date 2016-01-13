Return-Path: <chandan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79D291A099E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 03:51:43 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <chandan@linux.vnet.ibm.com>;
 Thu, 14 Jan 2016 02:51:42 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 03BA12BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 03:51:38 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0DGpTYp29032594
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 03:51:37 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0DGp4Q7021917
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 03:51:05 +1100
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, chandan@mykolab.com
Subject: [PATCH] powerpc: Wire up copy_file_range() syscall
Date: Wed, 13 Jan 2016 22:20:22 +0530
Message-Id: <1452703822-29844-1-git-send-email-chandan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Test runs on a ppc64 BE guest succeeded.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
The "yet to be upstreamed" fstests test
(https://github.com/chandanr/xfstests/commit/c2ce6196711e02792b434448e29f45b5f9a955f6)
was used to test the syscall. The test in turn depends on the usage of xfs_io's
copy_file_range command.
(https://github.com/chandanr/xfsprogs-dev/commit/9222b48a3d03fb9d690323b460d882e559bd1080)
I will post these patches to the respective mailing lists once this patch is
mainlined.

 arch/powerpc/include/asm/systbl.h      | 1 +
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 5654ece..3fa9df7 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -383,3 +383,4 @@ SYSCALL(ni_syscall)
 SYSCALL(ni_syscall)
 SYSCALL(ni_syscall)
 SYSCALL(mlock2)
+SYSCALL(copy_file_range)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 6a5ace5..1f2594d 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		379
+#define NR_syscalls		380
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 12a0565..940290d 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -389,5 +389,6 @@
 #define __NR_userfaultfd	364
 #define __NR_membarrier		365
 #define __NR_mlock2		378
+#define __NR_copy_file_range	379
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.1.0
