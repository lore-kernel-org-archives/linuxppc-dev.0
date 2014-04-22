Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, hegdevasant@linux.vnet.ibm.com,
 stewart@linux.vnet.ibm.com
Subject: [PATCH 6/6] powerpc/powernv: Fix little endian issues in OPAL dump
 code
Date: Tue, 22 Apr 2014 15:01:27 +1000
Message-Id: <1398142887-24109-6-git-send-email-anton@samba.org>
In-Reply-To: <1398142887-24109-1-git-send-email-anton@samba.org>
References: <1398142887-24109-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/opal.h            |  4 ++--
 arch/powerpc/platforms/powernv/opal-dump.c | 13 +++++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index afb0fed..66ad7a7 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -868,8 +868,8 @@ int64_t opal_validate_flash(uint64_t buffer, uint32_t *size, uint32_t *result);
 int64_t opal_manage_flash(uint8_t op);
 int64_t opal_update_flash(uint64_t blk_list);
 int64_t opal_dump_init(uint8_t dump_type);
-int64_t opal_dump_info(uint32_t *dump_id, uint32_t *dump_size);
-int64_t opal_dump_info2(uint32_t *dump_id, uint32_t *dump_size, uint32_t *dump_type);
+int64_t opal_dump_info(__be32 *dump_id, __be32 *dump_size);
+int64_t opal_dump_info2(__be32 *dump_id, __be32 *dump_size, __be32 *dump_type);
 int64_t opal_dump_read(uint32_t dump_id, uint64_t buffer);
 int64_t opal_dump_ack(uint32_t dump_id);
 int64_t opal_dump_resend_notification(void);
diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index f0b4724..788a197 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -209,15 +209,20 @@ static struct kobj_type dump_ktype = {
 	.default_attrs = dump_default_attrs,
 };
 
-static int64_t dump_read_info(uint32_t *id, uint32_t *size, uint32_t *type)
+static int64_t dump_read_info(uint32_t *dump_id, uint32_t *dump_size, uint32_t *dump_type)
 {
+	__be32 id, size, type;
 	int rc;
-	*type = 0xffffffff;
 
-	rc = opal_dump_info2(id, size, type);
+	type = cpu_to_be32(0xffffffff);
 
+	rc = opal_dump_info2(&id, &size, &type);
 	if (rc == OPAL_PARAMETER)
-		rc = opal_dump_info(id, size);
+		rc = opal_dump_info(&id, &size);
+
+	*dump_id = be32_to_cpu(id);
+	*dump_size = be32_to_cpu(size);
+	*dump_type = be32_to_cpu(type);
 
 	if (rc)
 		pr_warn("%s: Failed to get dump info (%d)\n",
-- 
1.8.3.2
