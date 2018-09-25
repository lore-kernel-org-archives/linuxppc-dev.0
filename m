Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KNkx6dPFzDr8p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 00:30:01 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8PEPpvg127187
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 10:29:58 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mqpf5hbep-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 10:29:57 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 25 Sep 2018 10:29:39 -0400
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, Breno Leitao <leitao@debian.org>
Subject: [PATCH] powerpc/powernv: Mark function as __noreturn
Date: Tue, 25 Sep 2018 11:29:33 -0300
Message-Id: <1537885773-18564-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a mismatch between function pnv_platform_error_reboot() definition
and declaration regarding function modifiers. In the declaration part, it
contains the function attribute __noreturn, while function definition
itself lacks it.

This was reported by sparse tool as an error:

  arch/powerpc/platforms/powernv/opal.c:538:6: error: symbol 'pnv_platform_error_reboot' redeclared with different type (originally declared at arch/powerpc/platforms/powernv/powernv.h:11) - different modifiers

I checked and the function is already being considered as being 'noreturn'
by the compiler, thus, I understand this patch does not change any code
being generated.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/platforms/powernv/opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 38fe4087484a..a4641515956f 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -535,7 +535,7 @@ static int opal_recover_mce(struct pt_regs *regs,
 	return recovered;
 }
 
-void pnv_platform_error_reboot(struct pt_regs *regs, const char *msg)
+void __noreturn pnv_platform_error_reboot(struct pt_regs *regs, const char *msg)
 {
 	panic_flush_kmsg_start();
 
-- 
2.17.1
