Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0126.outbound.protection.outlook.com [65.55.169.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC4511A013E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 02:27:04 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <scottwood@freescale.com>, Andrew Morton
 <akpm@linux-foundation.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Hongtao Jia <hongtao.jia@freescale.com>
Subject: [PATCH] powerpc/fsl_pci: Check for get_user/probe_kernel_address
 failure
Date: Mon, 24 Aug 2015 11:26:44 -0500
Message-ID: <1440433604-1520-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
Reported-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hongtao Jia <hongtao.jia@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index ebc1f412..5dab1fd 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1002,7 +1002,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
 			ret = probe_kernel_address(regs->nip, inst);
 		}
 
-		if (mcheck_handle_load(regs, inst)) {
+		if (ret && mcheck_handle_load(regs, inst)) {
 			regs->nip += 4;
 			return 1;
 		}
-- 
2.1.4
