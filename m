Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 08/18] drivers/macintosh/smu.c: Replace abs_to_virt() with
 __va()
Date: Thu, 26 Jul 2012 17:19:54 +1000
Message-Id: <1343287204-7700-8-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
References: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

abs_to_virt() is just a wrapper around __va(), call __va() directly.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/macintosh/smu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 54ac7ff..7d5a6b4 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -45,7 +45,6 @@
 #include <asm/pmac_feature.h>
 #include <asm/smu.h>
 #include <asm/sections.h>
-#include <asm/abs_addr.h>
 #include <asm/uaccess.h>
 
 #define VERSION "0.7"
@@ -502,7 +501,7 @@ int __init smu_init (void)
 	 * 32 bits value safely
 	 */
 	smu->cmd_buf_abs = (u32)smu_cmdbuf_abs;
-	smu->cmd_buf = (struct smu_cmd_buf *)abs_to_virt(smu_cmdbuf_abs);
+	smu->cmd_buf = __va(smu_cmdbuf_abs);
 
 	smu->db_node = of_find_node_by_name(NULL, "smu-doorbell");
 	if (smu->db_node == NULL) {
-- 
1.7.9.5
