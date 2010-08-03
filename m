Return-Path: <tie-fei.zang@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141]) by ozlabs.org (Postfix) with ESMTP id EAFC01007D3
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 13:41:49 +1000 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: linux-mmc@vger.kernel.org
Subject: [PATCH 3/3 v2] dts: Add ESDHC weird voltage bits workaround
Date: Tue, 3 Aug 2010 11:11:12 +0800
Message-ID: <1280805072-26112-3-git-send-email-tie-fei.zang@freescale.com>
In-Reply-To: <1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
	<1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P4080 ESDHC controller does not support 1.8V and 3.0V voltage. but the
host controller capabilities register wrongly set the bits.
This patch adds the workaround to correct the weird voltage setting bits.
Only 3.3V voltage is supported for P4080 ESDHC controller.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/boot/dts/p4080ds.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index efa0091..2f0de24 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -280,6 +280,7 @@
 			reg = <0x114000 0x1000>;
 			interrupts = <48 2>;
 			interrupt-parent = <&mpic>;
+			voltage-ranges = <3300 3300>;
 			sdhci,auto-cmd12;
 		};
 
-- 
1.5.6.5
