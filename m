Return-Path: <R1AAHA@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 681DE2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2012 10:37:34 +1100 (EST)
Received: from mail172-co1 (localhost [127.0.0.1])	by
 mail172-co1-R.bigfish.com (Postfix) with ESMTP id D81CA5C02B0	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2012 23:37:29 +0000 (UTC)
Received: from CO1EHSMHS028.bigfish.com (unknown [10.243.78.228])	by
 mail172-co1.bigfish.com (Postfix) with ESMTP id 7FFCB5A0117	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2012 23:37:28 +0000 (UTC)
Received: from x9.am.freescale.net (x9.am.freescale.net [10.82.120.9])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id qAUNbQ3B017956	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2012 16:37:27 -0700
From: Kim Phillips <kim.phillips@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/4] powerpc/fsl: fsl_soc: sparse fixes
Date: Fri, 30 Nov 2012 17:35:02 -0600
Message-ID: <1354318502-367-4-git-send-email-kim.phillips@freescale.com>
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

arch/powerpc/sysdev/fsl_soc.c:70:67: warning: incorrect type in argument 2 (different base types)
arch/powerpc/sysdev/fsl_soc.c:70:67:    expected restricted __be32 const [usertype] *addr
arch/powerpc/sysdev/fsl_soc.c:70:67:    got unsigned int const [usertype] *

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 97118dc..228cf91 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -58,10 +58,10 @@ phys_addr_t get_immrbase(void)
 	if (soc) {
 		int size;
 		u32 naddr;
-		const u32 *prop = of_get_property(soc, "#address-cells", &size);
+		const __be32 *prop = of_get_property(soc, "#address-cells", &size);
 
 		if (prop && size == 4)
-			naddr = *prop;
+			naddr = be32_to_cpup(prop);
 		else
 			naddr = 2;
 
-- 
1.8.0.1
