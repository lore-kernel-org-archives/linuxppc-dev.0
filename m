Return-Path: <chandan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkN0M5x5rzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 20:07:31 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G94T1n052525
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 05:07:26 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 297c4b3sxm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 05:07:26 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <chandan@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 05:07:25 -0400
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 Chris.Packham@alliedtelesis.co.nz, mpe@ellerman.id.au
Subject: [PATCH] powerpc: Wire up statx() syscall
Date: Thu, 16 Mar 2017 14:37:11 +0530
Message-Id: <1489655231-10582-1-git-send-email-chandan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Test runs on a ppc64 BE guest succeeded. linux/samples/statx/test-statx
program was executed on the following file types,

1. Regular file
2. Directory
3. device file
4. symlink
5. Named pipe

The test run also included invoking test-statx with the runtime options
provided in the main() function of test-statx.c

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/systbl.h      | 1 +
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 4b369d8..1c94708 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -387,3 +387,4 @@ SYSCALL(copy_file_range)
 COMPAT_SYS_SPU(preadv2)
 COMPAT_SYS_SPU(pwritev2)
 SYSCALL(kexec_file_load)
+SYSCALL(statx)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index eb1acee..9ba11db 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		383
+#define NR_syscalls		384
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 2f26335..b85f142 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -393,5 +393,6 @@
 #define __NR_preadv2		380
 #define __NR_pwritev2		381
 #define __NR_kexec_file_load	382
+#define __NR_statx		383
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.5.5
