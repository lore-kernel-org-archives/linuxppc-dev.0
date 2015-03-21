Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0145.outbound.protection.outlook.com [157.56.110.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62CEA1A005A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 12:04:34 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/mpic: Add get_version API both for internal and
 external use
Date: Fri, 20 Mar 2015 20:04:15 -0500
Message-ID: <1426899855-4897-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, Arseny Solokha <asolokha@kb.kras.ru>,
 Hongtao Jia <hongtao.jia@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongtao Jia <hongtao.jia@freescale.com>

MPIC version is useful information for both mpic_alloc() and mpic_init().
The patch provide an API to get MPIC version for reusing the code.
Also, some other IP block may need MPIC version for their own use.
The API for external use is also provided.

This function had been previously added but was removed by commit
5e86bfde9cd93f2 ("powerpc/mpic: remove unused functions") due to the
lack of a user.  This function will be used by "powerpc/mpic: Add
get_version API both for internal and external use".

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
[scottwood@freescale.com: changelog update]
Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Arseny Solokha <asolokha@kb.kras.ru>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
I plan to push this patch and the patch that depends on it
(http://patchwork.ozlabs.org/patch/443826/) for this merge window.

 arch/powerpc/include/asm/mpic.h |  3 +++
 arch/powerpc/sysdev/mpic.c      | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index 6ce63a7..9869761 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -391,6 +391,9 @@ extern struct bus_type mpic_subsys;
 #define	MPIC_REGSET_STANDARD		MPIC_REGSET(0)	/* Original MPIC */
 #define	MPIC_REGSET_TSI108		MPIC_REGSET(1)	/* Tsi108/109 PIC */
 
+/* Get the version of primary MPIC */
+extern u32 fsl_mpic_primary_get_version(void);
+
 /* Allocate the controller structure and setup the linux irq descs
  * for the range if interrupts passed in. No HW initialization is
  * actually performed.
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index f72b592..2c817a7 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1219,6 +1219,16 @@ static u32 fsl_mpic_get_version(struct mpic *mpic)
  * Exported functions
  */
 
+u32 fsl_mpic_primary_get_version(void)
+{
+	struct mpic *mpic = mpic_primary;
+
+	if (mpic)
+		return fsl_mpic_get_version(mpic);
+
+	return 0;
+}
+
 struct mpic * __init mpic_alloc(struct device_node *node,
 				phys_addr_t phys_addr,
 				unsigned int flags,
-- 
2.1.0
