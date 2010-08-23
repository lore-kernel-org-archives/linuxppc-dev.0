Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A72DDB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Aug 2010 03:36:44 +1000 (EST)
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 78EFA1C15552
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Aug 2010 19:36:41 +0200 (CEST)
Received: from igel.home (ppp-93-104-152-196.dynamic.mnet-online.de
	[93.104.152.196])
	by mail.mnet-online.de (Postfix) with ESMTP id A15671C000EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Aug 2010 19:36:41 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/platforms: fix config dependency problem
Date: Mon, 23 Aug 2010 19:36:41 +0200
Message-ID: <m28w3xz0wm.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPIC_U3_HT_IRQS is selected both by PPC_PMAC64 and PPC_MAPLE, but depends
on PPC_MAPLE, so a PPC_PMAC64-only config gets this warning:

warning: (PPC_PMAC64 && PPC_PMAC && POWER4 || PPC_MAPLE && PPC64 && PPC_BOOK3S) selects MPIC_U3_HT_IRQS which has unmet direct dependencies (PPC_MAPLE)

Fix that by removing the dependency on PPC_MAPLE.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/platforms/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index d1663db..81c9208 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -106,8 +106,7 @@ config MMIO_NVRAM
 
 config MPIC_U3_HT_IRQS
 	bool
-	depends on PPC_MAPLE
-	default y
+	default n
 
 config MPIC_BROKEN_REGREAD
 	bool
-- 
1.7.2.2


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
