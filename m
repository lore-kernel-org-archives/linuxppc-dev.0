Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 09C1CDDDEC
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 22:52:07 +1100 (EST)
Date: Mon, 17 Dec 2007 14:54:35 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] [NET][POWERPC] ucc_geth: really fix section mismatch
Message-ID: <20071217115435.GA29857@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit ed7e63a51d46e835422d89c687b8a3e419a4212a has tried to fix
section mismatch:

WARNING: vmlinux.o(.init.text+0x17278): Section mismatch: reference to
.exit.text:uec_mdio_exit (between 'ucc_geth_init' and 'uec_mdio_init')

But that mismatch still happens.

This patch actually fixing section mismatch by removing __exit from
the header file.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/ucc_geth_mii.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ucc_geth_mii.h b/drivers/net/ucc_geth_mii.h
index d834370..1e45b20 100644
--- a/drivers/net/ucc_geth_mii.h
+++ b/drivers/net/ucc_geth_mii.h
@@ -96,5 +96,5 @@ enum enet_tbi_mii_reg {
 int uec_mdio_read(struct mii_bus *bus, int mii_id, int regnum);
 int uec_mdio_write(struct mii_bus *bus, int mii_id, int regnum, u16 value);
 int __init uec_mdio_init(void);
-void __exit uec_mdio_exit(void);
+void uec_mdio_exit(void);
 #endif				/* __UEC_MII_H */
-- 
1.5.2.2
