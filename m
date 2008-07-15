Return-Path: <arnd@arndb.de>
Message-Id: <20080715195739.275018637@arndb.de>
References: <20080715195139.316677337@arndb.de>
Date: Tue, 15 Jul 2008 21:51:42 +0200
From: arnd@arndb.de
To: benh@kernel.crashing.org, cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: [patch 3/9] powerpc/axonram: enable partitioning of the Axons DDR2
	DIMMs
Cc: Maxim Shchetynin <maxim@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Maxim Shchetynin <maxim@de.ibm.com>

DDR2 memory DIMMs on the Axon could be accessed only as one partition
when using file system drivers which are using the direct_access() method.
This patch enables for such file system drivers to access Axon's DDR2 memory
even if it is splitted in several partitions.

Signed-off-by: Maxim Shchetynin <maxim@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/sysdev/axonram.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index 9b639ed..9e105cb 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -150,7 +150,10 @@ axon_ram_direct_access(struct block_device *device, sector_t sector,
 	struct axon_ram_bank *bank = device->bd_disk->private_data;
 	loff_t offset;
 
-	offset = sector << AXON_RAM_SECTOR_SHIFT;
+	offset = sector;
+	if (device->bd_part != NULL)
+		offset += device->bd_part->start_sect;
+	offset <<= AXON_RAM_SECTOR_SHIFT;
 	if (offset >= bank->size) {
 		dev_err(&bank->device->dev, "Access outside of address space\n");
 		return -ERANGE;
-- 
1.5.4.3

-- 
