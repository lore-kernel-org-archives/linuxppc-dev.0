Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 85F66B6F95
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2011 02:20:51 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <greg@kroah.com>, <sfr@canb.auug.org.au>, <linux-next@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] tty/powerpc: fix build break with ehv_bytechan.c on
	allyesconfig
Date: Thu, 25 Aug 2011 11:20:45 -0500
Message-ID: <1314289245-14946-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Kconfig for the ePAPR hypervisor byte channel driver has a "depends on PPC",
which means it would compile on all PowerPC platforms, even though it's
only been tested on Freescale platforms.  Change the Kconfig to depend on
FSL_SOC instead.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/tty/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index f1ea59b..535af0a 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -353,7 +353,7 @@ config TRACE_SINK
 
 config PPC_EPAPR_HV_BYTECHAN
 	tristate "ePAPR hypervisor byte channel driver"
-	depends on PPC
+	depends on FSL_SOC
 	help
 	  This driver creates /dev entries for each ePAPR hypervisor byte
 	  channel, thereby allowing applications to communicate with byte
-- 
1.7.3.4
