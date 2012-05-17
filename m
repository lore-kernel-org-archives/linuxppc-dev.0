Return-Path: <frank.svendsboe@gmail.com>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CCDF8B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2012 06:43:45 +1000 (EST)
Received: by lban1 with SMTP id n1so1639214lba.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2012 13:43:40 -0700 (PDT)
From: Frank Svendsboe <frank.svendsboe@gmail.com>
To: linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: Fix typo in Kconfig
Date: Thu, 17 May 2012 22:43:09 +0200
Message-Id: <1337287389-28386-1-git-send-email-frank.svendsboe@gmail.com>
Cc: dbaryshkov@gmail.com, randy.dunlap@oracle.com,
 linuxppc-dev@lists.ozlabs.org, Frank Svendsboe <frank.svendsboe@gmail.com>,
 dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MTD_OF_PARTS and the default setting is not working due to using 'Y'
instead of 'y', introduced in commit
d6137badeff1ef64b4e0092ec249ebdeaeb3ff37. This made our board, and
possibly other boards using DTS defined partitions and not having
CONFIG_MTD_OF_PARTS=y defined in the defconfig, fail to mount root
after v3.1.

Signed-off-by: Frank Svendsboe <frank.svendsboe@gmail.com>
---
 drivers/mtd/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 5760c1a..27143e0 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -128,7 +128,7 @@ config MTD_AFS_PARTS
 
 config MTD_OF_PARTS
 	tristate "OpenFirmware partitioning information support"
-	default Y
+	default y
 	depends on OF
 	help
 	  This provides a partition parsing function which derives
-- 
1.7.5.4
