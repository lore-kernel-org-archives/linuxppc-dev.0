Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3297B714D
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 08:38:14 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 04/13] 8xx: Fix CONFIG_PIN_TLB
Date: Mon, 10 Jan 2011 22:37:50 +0100
Message-Id: <1294695479-344-5-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The wrong register was loaded into MD_RPN.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 57858ce..5269e5b 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -840,13 +840,13 @@ initial_mmu:
 	mtspr	MD_TWC, r9
 	li	r11, MI_BOOTINIT	/* Create RPN for address 0 */
 	addis	r11, r11, 0x0080	/* Add 8M */
-	mtspr	MD_RPN, r8
+	mtspr	MD_RPN, r11
 
 	addis	r8, r8, 0x0080		/* Add 8M */
 	mtspr	MD_EPN, r8
 	mtspr	MD_TWC, r9
 	addis	r11, r11, 0x0080	/* Add 8M */
-	mtspr	MD_RPN, r8
+	mtspr	MD_RPN, r11
 #endif
 
 	/* Since the cache is enabled according to the information we
-- 
1.7.3.4
