Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9B445DE00B
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 02:37:34 +1000 (EST)
Date: Mon, 28 Jul 2008 02:37:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Karsten Keil <kkeil@suse.de>
Subject: [PATCH] isdn: mISDN HFC PCI support depends on virt_to_bus()
Message-Id: <20080728023732.090aff83.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On powerpc (allyesconfig build) we get this error:

drivers/isdn/hardware/mISDN/hfcpci.c:1991: error: implicit declaration of function 'virt_to_bus'

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/isdn/hardware/mISDN/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/Kconfig b/drivers/isdn/hardware/mISDN/Kconfig
index 1479348..9cd5f5f 100644
--- a/drivers/isdn/hardware/mISDN/Kconfig
+++ b/drivers/isdn/hardware/mISDN/Kconfig
@@ -7,6 +7,7 @@ config MISDN_HFCPCI
 	tristate "Support for HFC PCI cards"
 	depends on MISDN
 	depends on PCI
+	depends on VIRT_TO_BUS
 	help
 	  Enable support for cards with Cologne Chip AG's
           HFC PCI chip.
-- 
1.5.6.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
