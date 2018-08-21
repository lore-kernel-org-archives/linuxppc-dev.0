Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41w007593zzF2FK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 04:42:15 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7LIdNTu053962
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 14:42:12 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m0ptakjcq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 14:42:12 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 21 Aug 2018 14:42:11 -0400
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH] powerpc/kernel: Fix potential spectre v1 in syscall
Date: Tue, 21 Aug 2018 15:42:06 -0300
Message-Id: <1534876926-21849-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The rtas syscall reads a value from a user-provided structure and uses it
to index an array, being a possible area for a potential spectre v1 attack.
This is the code that exposes this problem.

	args.rets = &args.args[nargs];

The nargs is an user provided value, and the below code is an example where
the 'nargs' value would be set to XX.

	struct rtas_args ra;
	ra.nargs = htobe32(XX);
	syscall(__NR_rtas, &ra);

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/rtas.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8afd146bc9c7..5ef3c863003d 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/reboot.h>
 #include <linux/syscalls.h>
+#include <linux/nospec.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -1056,7 +1057,7 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	struct rtas_args args;
 	unsigned long flags;
 	char *buff_copy, *errbuf = NULL;
-	int nargs, nret, token;
+	int index, nargs, nret, token;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1084,7 +1085,8 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	if (token == RTAS_UNKNOWN_SERVICE)
 		return -EINVAL;
 
-	args.rets = &args.args[nargs];
+	index = array_index_nospec(nargs, ARRAY_SIZE(args.args));
+	args.rets = &args.args[index];
 	memset(args.rets, 0, nret * sizeof(rtas_arg_t));
 
 	/* Need to handle ibm,suspend_me call specially */
-- 
2.16.3
