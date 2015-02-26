Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22f.google.com (mail-yk0-x22f.google.com
 [IPv6:2607:f8b0:4002:c07::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C5781A014D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 23:09:58 +1100 (AEDT)
Received: by yks20 with SMTP id 20so3835941yks.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 04:09:56 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 10/11] tty: kconfig: remove the superfluous dependency on
 PPC_OF
Date: Thu, 26 Feb 2015 20:08:22 +0800
Message-Id: <1424952503-8247-11-git-send-email-haokexin@gmail.com>
In-Reply-To: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
References: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org
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
v2: No change.

 drivers/tty/serial/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index d2501f01cd03..77471d3db8d3 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -835,7 +835,7 @@ config SERIAL_MCF_CONSOLE
 
 config SERIAL_PMACZILOG
 	tristate "Mac or PowerMac z85c30 ESCC support"
-	depends on (M68K && MAC) || (PPC_OF && PPC_PMAC)
+	depends on (M68K && MAC) || PPC_PMAC
 	select SERIAL_CORE
 	help
 	  This driver supports the Zilog z85C30 serial ports found on
@@ -1153,7 +1153,7 @@ config SERIAL_OMAP_CONSOLE
 
 config SERIAL_OF_PLATFORM_NWPSERIAL
 	tristate "NWP serial port driver"
-	depends on PPC_OF && PPC_DCR
+	depends on PPC_DCR
 	select SERIAL_OF_PLATFORM
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_CORE
-- 
1.9.3
