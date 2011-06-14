Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A3F5B717E
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 00:05:43 +1000 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 04/15] 8xx: Fix CONFIG_PIN_TLB
Date: Tue, 14 Jun 2011 15:54:49 +0200
Message-Id: <1308059700-10839-5-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1308059700-10839-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1308059700-10839-1-git-send-email-Joakim.Tjernlund@transmode.se>
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
index b3aff21..9d8a1b5 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -848,13 +848,13 @@ initial_mmu:
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
