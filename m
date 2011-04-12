Return-Path: <B32579@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7EA4DB6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Apr 2011 14:56:14 +1000 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux.nics@intel.com>,
	<auke-jan.h.kok@intel.com>, <e1000-devel@lists.sourceforge.net>,
	<netdev@vger.kernel.org>
Subject: [PATCH] driver/e1000e: Fix default interrupt mode select
Date: Tue, 12 Apr 2011 10:26:03 +0530
Message-ID: <1302584163-22318-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meet2prabhu@gmail.com, Prabhakar <prabhakar@freescale.com>,
	Jin Qing <b24347@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Prabhakar <prabhakar@freescale.com>

The Intel e1000 device driver defaults to MSI interrupt mode, even if MSI
support is not enabled

Signed-off-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branch master)

 added  netdev mail-list and e1000 mail-list & maintainer

 drivers/net/e1000e/param.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/net/e1000e/param.c b/drivers/net/e1000e/param.c
index a150e48..7b3bbec 100644
--- a/drivers/net/e1000e/param.c
+++ b/drivers/net/e1000e/param.c
@@ -390,7 +390,11 @@ void __devinit e1000e_check_options(struct e1000_adapter *adapter)
 			.type = range_option,
 			.name = "Interrupt Mode",
 			.err  = "defaulting to 2 (MSI-X)",
+#ifdef CONFIG_PCI_MSI
 			.def  = E1000E_INT_MODE_MSIX,
+#else
+			.def  = E1000E_INT_MODE_LEGACY,
+#endif
 			.arg  = { .r = { .min = MIN_INTMODE,
 					 .max = MAX_INTMODE } }
 		};
-- 
1.7.3
