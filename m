Return-Path: <jdl@jdl.com>
Received: from jdl.com (mail.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E381F67B69
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 01:37:32 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1GAq7c-0005si-VE
	for linuxppc-dev@ozlabs.org; Wed, 09 Aug 2006 10:37:29 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Offer PCI as a CONFIG choice for PPC_86xx.
Date: Wed, 09 Aug 2006 10:37:28 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1GAq7c-0005si-VE@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also fix 80-column run-over.

Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

I misspoke myself on the earlier, ill-formed version of this patch. :-)

 arch/powerpc/Kconfig |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 13e583f..abb325e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -836,9 +836,10 @@ config MCA
 	bool
 
 config PCI
-	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) \
-				  || MPC7448HPC2
-	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx && !PPC_85xx && !PPC_86xx
+	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
+		|| PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) || MPC7448HPC2
+	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx \
+		&& !PPC_85xx && !PPC_86xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
 	help
