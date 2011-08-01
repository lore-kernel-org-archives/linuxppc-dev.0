Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 09/15] ps3: Limit the number of regions per storage device
Date: Mon,  1 Aug 2011 22:03:00 +0200
Message-Id: <1312228986-32307-10-git-send-email-a.heider@gmail.com>
In-Reply-To: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There can be only 8 regions, add a sanity check

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/powerpc/include/asm/ps3stor.h       |    1 +
 arch/powerpc/platforms/ps3/device-init.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3stor.h b/arch/powerpc/include/asm/ps3stor.h
index 6fcaf71..d51e53c 100644
--- a/arch/powerpc/include/asm/ps3stor.h
+++ b/arch/powerpc/include/asm/ps3stor.h
@@ -25,6 +25,7 @@
 
 #include <asm/ps3.h>
 
+#define PS3_STORAGE_MAX_REGIONS		(8)
 
 struct ps3_storage_region {
 	unsigned int id;
diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index 6c4b583..830d741 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -349,6 +349,14 @@ static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
 		return -ENODEV;
 	}
 
+	if (num_regions > PS3_STORAGE_MAX_REGIONS) {
+		pr_warning("%s:%u: device %u:%u reported %u regions, "
+			   "limiting to %u\n", __func__, __LINE__,
+			   num_regions, repo->bus_index, repo->dev_index,
+			   PS3_STORAGE_MAX_REGIONS);
+		num_regions = PS3_STORAGE_MAX_REGIONS;
+	}
+
 	pr_debug("%s:%u: (%u:%u:%u): port %llu blk_size %llu num_blocks %llu "
 		 "num_regions %u\n", __func__, __LINE__, repo->bus_index,
 		 repo->dev_index, repo->dev_type, port, blk_size, num_blocks,
-- 
1.7.5.4
