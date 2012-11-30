Return-Path: <R1AAHA@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A40E2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2012 10:37:37 +1100 (EST)
Received: from mail137-co1 (localhost [127.0.0.1])	by
 mail137-co1-R.bigfish.com (Postfix) with ESMTP id 80A3F3802AF	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2012 23:37:31 +0000 (UTC)
Received: from CO1EHSMHS011.bigfish.com (unknown [10.243.78.245])	by
 mail137-co1.bigfish.com (Postfix) with ESMTP id 0A7FB440212	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2012 23:37:28 +0000 (UTC)
Received: from x9.am.freescale.net (x9.am.freescale.net [10.82.120.9])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id qAUNbQ38017956	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2012 16:37:26 -0700
From: Kim Phillips <kim.phillips@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/4] powerpc/fsl: msi: sparse fixes
Date: Fri, 30 Nov 2012 17:34:59 -0600
Message-ID: <1354318502-367-1-git-send-email-kim.phillips@freescale.com>
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

arch/powerpc/sysdev/fsl_msi.c:31:1: warning: symbol 'msi_head' was not declared. Should it be static?
arch/powerpc/sysdev/fsl_msi.c:138:40: warning: incorrect type in argument 1 (different base types)
arch/powerpc/sysdev/fsl_msi.c:138:40:    expected restricted __be64 const [usertype] *p
arch/powerpc/sysdev/fsl_msi.c:138:40:    got unsigned long long const [usertype] *[assigned] reg

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 63c5f04..a57ef97 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -28,7 +28,7 @@
 #include "fsl_msi.h"
 #include "fsl_pci.h"
 
-LIST_HEAD(msi_head);
+static LIST_HEAD(msi_head);
 
 struct fsl_msi_feature {
 	u32 fsl_pic_ip;
@@ -130,7 +130,7 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	u64 address; /* Physical address of the MSIIR */
 	int len;
-	const u64 *reg;
+	const __be64 *reg;
 
 	/* If the msi-address-64 property exists, then use it */
 	reg = of_get_property(hose->dn, "msi-address-64", &len);
-- 
1.8.0.1
