Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x230.google.com (mail-yk0-x230.google.com
 [IPv6:2607:f8b0:4002:c07::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBEDC1A1189
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:48:59 +1100 (AEDT)
Received: by mail-yk0-f176.google.com with SMTP id q200so19117874ykb.7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:48:57 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 13/15] tty: kconfig: remove the superfluous dependency on
 PPC_OF
Date: Sat, 31 Jan 2015 21:47:43 +0800
Message-Id: <1422712065-9403-14-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kevin Hao <haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the current kernel, the CONFIG_PPC_OF is always 'y' for the ppc
arch. So we don't need to check it with other ppc specific options.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/tty/serial/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 59332afc72e9..117ae252d622 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -844,7 +844,7 @@ config SERIAL_MCF_CONSOLE
 
 config SERIAL_PMACZILOG
 	tristate "Mac or PowerMac z85c30 ESCC support"
-	depends on (M68K && MAC) || (PPC_OF && PPC_PMAC)
+	depends on (M68K && MAC) || PPC_PMAC
 	select SERIAL_CORE
 	help
 	  This driver supports the Zilog z85C30 serial ports found on
@@ -1152,7 +1152,7 @@ config SERIAL_OMAP_CONSOLE
 
 config SERIAL_OF_PLATFORM_NWPSERIAL
 	tristate "NWP serial port driver"
-	depends on PPC_OF && PPC_DCR
+	depends on PPC_DCR
 	select SERIAL_OF_PLATFORM
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_CORE
-- 
1.9.3
