Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0208.outbound.protection.outlook.com [207.46.163.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1429E2C0147
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2014 11:01:32 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 10/10] Revert "powerpc/watchdog: Don't enable interrupt on
 PPC64 BookE"
Date: Thu, 13 Mar 2014 19:00:49 -0500
Message-ID: <1394755249-8856-11-git-send-email-scottwood@freescale.com>
In-Reply-To: <1394755249-8856-1-git-send-email-scottwood@freescale.com>
References: <1394755249-8856-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tiejun Chen <tiejun.chen@windriver.com>, Wim Van Sebroeck <wim@iguana.be>,
 Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit 3978bdb4ed653342b0be66c031bf61b72cc55d60, now that
critical interrupts are properly supported on ppc64 booke.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/booke_wdt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index f1b8d55..a8dbceb3 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -138,14 +138,6 @@ static void __booke_wdt_enable(void *data)
 	val &= ~WDTP_MASK;
 	val |= (TCR_WIE|TCR_WRC(WRC_CHIP)|WDTP(booke_wdt_period));
 
-#ifdef CONFIG_PPC_BOOK3E_64
-	/*
-	 * Crit ints are currently broken on PPC64 Book-E, so
-	 * just disable them for now.
-	 */
-	val &= ~TCR_WIE;
-#endif
-
 	mtspr(SPRN_TCR, val);
 }
 
-- 
1.8.3.2
