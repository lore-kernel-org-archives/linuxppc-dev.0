Return-Path: <R1AAHA@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 64FA42C0089
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2012 10:37:34 +1100 (EST)
Received: from mail108-co1 (localhost [127.0.0.1])	by
 mail108-co1-R.bigfish.com (Postfix) with ESMTP id 04B4B200323	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2012 23:37:30 +0000 (UTC)
Received: from CO1EHSMHS029.bigfish.com (unknown [10.243.78.242])	by
 mail108-co1.bigfish.com (Postfix) with ESMTP id 5AD5B88004A	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2012 23:37:28 +0000 (UTC)
Received: from x9.am.freescale.net (x9.am.freescale.net [10.82.120.9])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id qAUNbQ39017956	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2012 16:37:26 -0700
From: Kim Phillips <kim.phillips@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/4] powerpc/fsl: lbc: sparse fixes
Date: Fri, 30 Nov 2012 17:35:00 -0600
Message-ID: <1354318502-367-2-git-send-email-kim.phillips@freescale.com>
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

arch/powerpc/sysdev/fsl_lbc.c:77:36: warning: incorrect type in initializer (different base types)
arch/powerpc/sysdev/fsl_lbc.c:77:36:    expected restricted __be32 [usertype] br
arch/powerpc/sysdev/fsl_lbc.c:77:36:    got unsigned int
arch/powerpc/sysdev/fsl_lbc.c:78:36: warning: incorrect type in initializer (different base types)
arch/powerpc/sysdev/fsl_lbc.c:78:36:    expected restricted __be32 [usertype] or
arch/powerpc/sysdev/fsl_lbc.c:78:36:    got unsigned int
arch/powerpc/sysdev/fsl_lbc.c:80:21: warning: restricted __be32 degrades to integer
arch/powerpc/sysdev/fsl_lbc.c:80:38: warning: restricted __be32 degrades to integer
arch/powerpc/sysdev/fsl_lbc.c:111:12: warning: incorrect type in assignment (different base types)
arch/powerpc/sysdev/fsl_lbc.c:111:12:    expected restricted __be32 [usertype] br
arch/powerpc/sysdev/fsl_lbc.c:111:12:    got unsigned int
arch/powerpc/sysdev/fsl_lbc.c:113:17: warning: restricted __be32 degrades to integer
arch/powerpc/sysdev/fsl_lbc.c:127:17: warning: restricted __be32 degrades to integer

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/sysdev/fsl_lbc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index 483126d..2ee3967 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -74,8 +74,8 @@ int fsl_lbc_find(phys_addr_t addr_base)
 
 	lbc = fsl_lbc_ctrl_dev->regs;
 	for (i = 0; i < ARRAY_SIZE(lbc->bank); i++) {
-		__be32 br = in_be32(&lbc->bank[i].br);
-		__be32 or = in_be32(&lbc->bank[i].or);
+		u32 br = in_be32(&lbc->bank[i].br);
+		u32 or = in_be32(&lbc->bank[i].or);
 
 		if (br & BR_V && (br & or & BR_BA) == fsl_lbc_addr(addr_base))
 			return i;
@@ -97,7 +97,7 @@ EXPORT_SYMBOL(fsl_lbc_find);
 int fsl_upm_find(phys_addr_t addr_base, struct fsl_upm *upm)
 {
 	int bank;
-	__be32 br;
+	u32 br;
 	struct fsl_lbc_regs __iomem *lbc;
 
 	bank = fsl_lbc_find(addr_base);
-- 
1.8.0.1
