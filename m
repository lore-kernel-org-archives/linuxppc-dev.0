Return-Path: <jirislaby@gmail.com>
Received: from smtp.pripojeni.net (mail.pripojeni.net [217.66.174.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 036F8B6FA7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Mar 2011 20:47:02 +1100 (EST)
From: Jiri Slaby <jslaby@suse.cz>
To: dbrownell@users.sourceforge.net
Subject: [PATCH 1/1] SPI: dw_spi, fix PPC build
Date: Fri, 18 Mar 2011 10:41:17 +0100
Message-Id: <1300441277-23961-1-git-send-email-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: jirislaby@gmail.com, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, spi-devel-general@lists.sourceforge.net,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, build on PPC dies with:
In file included from drivers/spi/dw_spi_mmio.c:16:
include/linux/spi/dw_spi.h:147: error: field ‘tx_sgl’ has incomplete type
include/linux/spi/dw_spi.h:149: error: field ‘rx_sgl’ has incomplete type

Add linux/scatterlist.h include to dw_spi.h, because we need to know
the contents of the structure.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 include/linux/spi/dw_spi.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/spi/dw_spi.h b/include/linux/spi/dw_spi.h
index 6cd10f6..fb0bce5 100644
--- a/include/linux/spi/dw_spi.h
+++ b/include/linux/spi/dw_spi.h
@@ -2,6 +2,7 @@
 #define DW_SPI_HEADER_H
 
 #include <linux/io.h>
+#include <linux/scatterlist.h>
 
 /* Bit fields in CTRLR0 */
 #define SPI_DFS_OFFSET			0
-- 
1.7.4.1
