Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9DFE6DDE42
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 02:58:21 +1000 (EST)
Date: Mon, 17 Sep 2007 11:57:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 12/28] 8xx: Fix CONFIG_PIN_TLB.
Message-ID: <20070917165741.GL6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165643.GA6545@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1. Move CONSISTENT_START on 8xx so that it doesn't overlap the IMMR mapping.
2. The wrong register was being loaded into SPRN_MD_RPN.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Kconfig           |    1 +
 arch/powerpc/kernel/head_8xx.S |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 66a3295..2622f04 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -582,6 +582,7 @@ config CONSISTENT_START_BOOL
 
 config CONSISTENT_START
 	hex "Base virtual address of consistent memory pool" if CONSISTENT_START_BOOL
+	default "0xfd000000" if (NOT_COHERENT_CACHE && 8xx)
 	default "0xff100000" if NOT_COHERENT_CACHE
 
 config CONSISTENT_SIZE_BOOL
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index a6ecdd6..0ad0d17 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -727,13 +727,13 @@ initial_mmu:
 	mtspr	SPRN_MD_TWC, r9
 	li	r11, MI_BOOTINIT	/* Create RPN for address 0 */
 	addis	r11, r11, 0x0080	/* Add 8M */
-	mtspr	SPRN_MD_RPN, r8
+	mtspr	SPRN_MD_RPN, r11
 
 	addis	r8, r8, 0x0080		/* Add 8M */
 	mtspr	SPRN_MD_EPN, r8
 	mtspr	SPRN_MD_TWC, r9
 	addis	r11, r11, 0x0080	/* Add 8M */
-	mtspr	SPRN_MD_RPN, r8
+	mtspr	SPRN_MD_RPN, r11
 #endif
 
 	/* Since the cache is enabled according to the information we
-- 
1.5.3.1
