Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429XFy5v3nzF3MW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 05:41:10 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CJY3o4101741
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:41:09 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mf8mj1ct4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:41:08 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 12 Sep 2018 13:41:08 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, paulus@ozlabs.org, gromero@linux.vnet.ibm.com,
 mpe@ellerman.id.au, ldufour@linux.vnet.ibm.com,
 Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH 11/11] selftests/powerpc: Adapt the test
Date: Wed, 12 Sep 2018 16:40:19 -0300
In-Reply-To: <1536781219-13938-1-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
Message-Id: <1536781219-13938-12-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Documentation/powerpc/transactional_memory.txt says:

 "Syscalls made from within a suspended transaction are performed as normal
  and the transaction is not explicitly doomed by the kernel.  However,
  what the kernel does to perform the syscall may result in the transaction
  being doomed by the hardware."

With this new TM mechanism, the syscall will continue to be executed if the
syscall happens on a suspended syscall, but, the syscall will *fail* if the
transaction is still active during the syscall invocation.

On the syscall path, if the transaction is active and not suspended, it
will call TM_KERNEL_ENTRY which will reclaim and recheckpoint the
transaction, thus, dooming the transaction on userspace return, with
failure code TM_CAUSE_SYSCALL.

This new model will break part of this test, but I understand that that the
documentation above didn't guarantee that the syscall would succeed, and it
will never succeed anymore now on.

In fact, glibc is calling 'tabort' before every syscalls, thus, any syscall
called through glibc from inside a transaction will be doomed anyhow.

This patch updates the test case to not assume that a syscall inside a
active transaction will succeed, because it will not anymore.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/powerpc/tm/tm-syscall.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall.c b/tools/testing/selftests/powerpc/tm/tm-syscall.c
index 454b965a2db3..1439a87eba3a 100644
--- a/tools/testing/selftests/powerpc/tm/tm-syscall.c
+++ b/tools/testing/selftests/powerpc/tm/tm-syscall.c
@@ -78,12 +78,6 @@ int tm_syscall(void)
 	timeradd(&end, &now, &end);
 
 	for (count = 0; timercmp(&now, &end, <); count++) {
-		/*
-		 * Test a syscall within a suspended transaction and verify
-		 * that it succeeds.
-		 */
-		FAIL_IF(getppid_tm(true) == -1); /* Should succeed. */
-
 		/*
 		 * Test a syscall within an active transaction and verify that
 		 * it fails with the correct failure code.
-- 
2.19.0
