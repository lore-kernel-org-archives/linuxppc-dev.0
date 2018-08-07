Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kwTh1Gk2zDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 10:32:55 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w770TCek132996
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2018 20:32:53 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kpugk31tf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Aug 2018 20:32:53 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 6 Aug 2018 18:32:53 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, Breno Leitao <leitao@debian.org>
Subject: [PATCH] powerpc/tm: Print 64-bits MSR
Date: Mon,  6 Aug 2018 21:32:44 -0300
Message-Id: <1533601964-20157-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On a kernel TM Bad thing program exception, the MSR is not being properly
displayed, since it dumps a 32-bits value. MSR is a 64 bits register for
all platforms that have HTM enabled.

This patch dumps the MSR value as 64-bits instead of 32 bits.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0e17dcb48720..cd561fd89532 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1402,7 +1402,7 @@ void program_check_exception(struct pt_regs *regs)
 			goto bail;
 		} else {
 			printk(KERN_EMERG "Unexpected TM Bad Thing exception "
-			       "at %lx (msr 0x%x)\n", regs->nip, reason);
+			       "at %lx (msr 0x%lx)\n", regs->nip, regs->msr);
 			die("Unrecoverable exception", regs, SIGABRT);
 		}
 	}
-- 
2.16.3
