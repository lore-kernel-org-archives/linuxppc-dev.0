Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7E230DDE19
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 04:52:56 +1100 (EST)
Date: Sat, 8 Nov 2008 20:52:54 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/qe: Select QE_USB with USB_GADGET_FSL_QE
Message-ID: <20081108175254.GA6444@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Boards should know when QE_USB is used, so that they can configure USB
clocks and pins.

Another option would be to add 'select QE_USB' into USB_GADGET_FSL_QE,
but selects are evil since they don't support dependencies.

While at it, also remove 'host' from the symbol description, since the
QE_USB code is used to support the gadget driver as well.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
index 76ffbc4..41ac3df 100644
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -22,5 +22,6 @@ config UCC
 
 config QE_USB
 	bool
+	default y if USB_GADGET_FSL_QE
 	help
-	  QE USB Host Controller support
+	  QE USB Controller support
-- 
1.5.6.3
