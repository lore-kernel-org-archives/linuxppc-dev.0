Return-Path: <R1AAHA@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 691402C0089
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2012 10:37:36 +1100 (EST)
Received: from mail153-co1 (localhost [127.0.0.1])	by
 mail153-co1-R.bigfish.com (Postfix) with ESMTP id 26F3580028D	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2012 23:37:30 +0000 (UTC)
Received: from CO1EHSMHS011.bigfish.com (unknown [10.243.78.253])	by
 mail153-co1.bigfish.com (Postfix) with ESMTP id 47672A40046	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2012 23:37:28 +0000 (UTC)
Received: from x9.am.freescale.net (x9.am.freescale.net [10.82.120.9])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id qAUNbQ3A017956	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2012 16:37:26 -0700
From: Kim Phillips <kim.phillips@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/4] powerpc/fsl: ifc: sparse fixes
Date: Fri, 30 Nov 2012 17:35:01 -0600
Message-ID: <1354318502-367-3-git-send-email-kim.phillips@freescale.com>
In-Reply-To: <1354318502-367-1-git-send-email-kim.phillips@freescale.com>
References: <1354318502-367-1-git-send-email-kim.phillips@freescale.com>
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

arch/powerpc/sysdev/fsl_ifc.c:66:38: warning: incorrect type in initializer (different base types)
arch/powerpc/sysdev/fsl_ifc.c:66:38:    expected restricted __be32 [usertype] cspr
arch/powerpc/sysdev/fsl_ifc.c:66:38:    got unsigned int
arch/powerpc/sysdev/fsl_ifc.c:67:21: warning: restricted __be32 degrades to integer
arch/powerpc/sysdev/fsl_ifc.c:67:39: warning: restricted __be32 degrades to integer

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/sysdev/fsl_ifc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_ifc.c b/arch/powerpc/sysdev/fsl_ifc.c
index 097cc9d2..dc11413 100644
--- a/arch/powerpc/sysdev/fsl_ifc.c
+++ b/arch/powerpc/sysdev/fsl_ifc.c
@@ -63,7 +63,7 @@ int fsl_ifc_find(phys_addr_t addr_base)
 		return -ENODEV;
 
 	for (i = 0; i < ARRAY_SIZE(fsl_ifc_ctrl_dev->regs->cspr_cs); i++) {
-		__be32 cspr = in_be32(&fsl_ifc_ctrl_dev->regs->cspr_cs[i].cspr);
+		u32 cspr = in_be32(&fsl_ifc_ctrl_dev->regs->cspr_cs[i].cspr);
 		if (cspr & CSPR_V && (cspr & CSPR_BA) ==
 				convert_ifc_address(addr_base))
 			return i;
-- 
1.8.0.1
