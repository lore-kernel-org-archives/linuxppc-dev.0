Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419w685ZnXzF0vb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 05:35:28 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5KJStRJ038088
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 15:35:25 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jqw3fg8wr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 15:35:25 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 20 Jun 2018 13:35:25 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] powerpc: Wire up io_pgetevents
Date: Wed, 20 Jun 2018 16:35:16 -0300
Message-Id: <1529523316-25027-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wire up io_pgetevents system call on powerpc.

io_pgetevents is a new syscall to read asynchronous I/O events from the
completion queue.

Tested with libaio branch aio-poll[1] and the io_pgetevents test (#22) passed
on both ppc64 LE and BE modes.

[1] https://pagure.io/libaio/branch/aio-poll

CC: Christoph Hellwig <hch@lst.de>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/include/asm/systbl.h      | 1 +
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index cfcf6a874cfa..01b5171ea189 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -393,3 +393,4 @@ SYSCALL(pkey_alloc)
 SYSCALL(pkey_free)
 SYSCALL(pkey_mprotect)
 SYSCALL(rseq)
+COMPAT_SYS(io_pgetevents)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 1e9708632dce..c19379f0a32e 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		388
+#define NR_syscalls		389
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index ac5ba55066dd..985534d0b448 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -399,5 +399,6 @@
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
 #define __NR_rseq		387
+#define __NR_io_pgetevents	388
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.16.3
