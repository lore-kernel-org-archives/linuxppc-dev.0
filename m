Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lFrG3w17zDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 23:35:09 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w77DSoJo113658
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Aug 2018 09:35:07 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kqbsba3cv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Aug 2018 09:35:07 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 7 Aug 2018 07:35:06 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, Breno Leitao <leitao@debian.org>
Subject: [PATCH v2] powerpc/tm: Print 64-bits MSR
Date: Tue,  7 Aug 2018 10:35:00 -0300
In-Reply-To: <5b85006b6695bd94f4818357be607036e9df8696.camel@neuling.org>
References: <5b85006b6695bd94f4818357be607036e9df8696.camel@neuling.org>
Message-Id: <1533648900-7933-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On a kernel TM Bad thing program exception, the Machine State Register
(MSR) is not being properly displayed. The exception code dumps a 32-bits
value but MSR is a 64 bits register for all platforms that have HTM
enabled.

This patch dumps the MSR value as a 64-bits value instead of 32 bits. In
order to do so, the 'reason' variable could not be used, since it trimmed
MSR to 32-bits (int).

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
