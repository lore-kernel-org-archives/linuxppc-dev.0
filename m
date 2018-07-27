Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cVqB4ZtVzF0tD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 23:55:44 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6RDsS5q136100
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 09:55:41 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kg3quamkv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 09:55:41 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Fri, 27 Jul 2018 09:55:40 -0400
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>,
 David Howells <dhowells@redhat.com>
Subject: [PATCH] powerpc: Wire up file system mount new syscalls
Date: Fri, 27 Jul 2018 10:55:02 -0300
Message-Id: <1532699702-15515-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wire up the new file system mount syscalls for Powerpc. The new syscall being
contemplated by this patch are those already available in the linux-next tree:
open_tree(), move_mount(), fsopen(), fsmount(), fspick() and fsinfo().

These system calls were tested with David Howells test case[1], as some others I
wrote[2]. For testing purpose, I also made usage of the new, but yet not
integrated, fsconfig() syscall.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-context&id=2bae6fd63259c5244bd9de1b46cca706c4808438
[2] https://github.com/leitao/mcontext/

CC: David Howells <dhowells@redhat.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/include/asm/systbl.h      | 6 ++++++
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 01b5171ea189..68d8dc0f8338 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -394,3 +394,9 @@ SYSCALL(pkey_free)
 SYSCALL(pkey_mprotect)
 SYSCALL(rseq)
 COMPAT_SYS(io_pgetevents)
+SYSCALL(open_tree)
+SYSCALL(move_mount)
+SYSCALL(fsopen)
+SYSCALL(fsmount)
+SYSCALL(fspick)
+SYSCALL(fsinfo)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index c19379f0a32e..e6cf3bb0ed2f 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		389
+#define NR_syscalls		395
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 985534d0b448..89b450c6a246 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -400,5 +400,11 @@
 #define __NR_pkey_mprotect	386
 #define __NR_rseq		387
 #define __NR_io_pgetevents	388
+#define __NR_open_tree		389
+#define __NR_move_mount	390
+#define __NR_fsopen		391
+#define __NR_fsmount		392
+#define __NR_fspick		393
+#define __NR_fsinfo		394
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.16.3
