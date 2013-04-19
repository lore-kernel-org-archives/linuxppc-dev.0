Return-Path: <r61911@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B97472C0C20
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 20:56:27 +1000 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/fsl-pci: fix setup_pci_atmu() parameter issue
Date: Sat, 20 Apr 2013 02:55:33 +0800
Message-ID: <1366397734-1416-1-git-send-email-tie-fei.zang@freescale.com>
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

setup_pci_atmu() only has one parameter and remove the extra one, or
build will fail due to un-match.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 40ffe29..f823304 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -978,7 +978,7 @@ static int fsl_pci_resume(struct device *dev)
 		return -ENODEV;
 	}
 
-	setup_pci_atmu(hose, &pci_rsrc);
+	setup_pci_atmu(hose);
 
 	return 0;
 }
-- 
1.7.9.5
