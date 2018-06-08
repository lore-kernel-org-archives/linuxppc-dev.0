Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 4125p937jXzF33h
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 12:24:33 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>
Message-Id: <f760116a6fb63c15ac2545f52abde40ae2599e4c.1528423341.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528423341.git.fthain@telegraphics.com.au>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 07/12] macintosh/via-pmu: Make CONFIG_PPC_PMAC Kconfig deps
 explicit
Date: Thu,  7 Jun 2018 22:24:29 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At present, CONFIG_ADB_PMU depends on CONFIG_PPC_PMAC. When this gets
relaxed to CONFIG_PPC_PMAC || CONFIG_MAC, those Kconfig symbols with
implicit deps on PPC_PMAC will need explicit deps. Add them now.
No functional change.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 9c6452b38c36..26abae4c899d 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -79,7 +79,7 @@ config ADB_PMU
 
 config ADB_PMU_LED
 	bool "Support for the Power/iBook front LED"
-	depends on ADB_PMU
+	depends on PPC_PMAC && ADB_PMU
 	select NEW_LEDS
 	select LEDS_CLASS
 	help
@@ -122,7 +122,7 @@ config PMAC_MEDIABAY
 
 config PMAC_BACKLIGHT
 	bool "Backlight control for LCD screens"
-	depends on ADB_PMU && FB = y && (BROKEN || !PPC64)
+	depends on PPC_PMAC && ADB_PMU && FB = y && (BROKEN || !PPC64)
 	select FB_BACKLIGHT
 	help
 	  Say Y here to enable Macintosh specific extensions of the generic
-- 
2.16.4
