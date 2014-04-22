Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, hegdevasant@linux.vnet.ibm.com,
 stewart@linux.vnet.ibm.com
Subject: [PATCH 4/6] powerpc/powernv: Fix little endian issues in OPAL error
 log code
Date: Tue, 22 Apr 2014 15:01:25 +1000
Message-Id: <1398142887-24109-4-git-send-email-anton@samba.org>
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

Fix little endian issues with the OPAL error log code.

Signed-off-by: Anton Blanchard <anton@samba.org>
Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h            | 2 +-
 arch/powerpc/platforms/powernv/opal-elog.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index cb7d52e..1a752ac 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -859,7 +859,7 @@ int64_t opal_lpc_read(uint32_t chip_id, enum OpalLPCAddressType addr_type,
 		      uint32_t addr, __be32 *data, uint32_t sz);
 
 int64_t opal_read_elog(uint64_t buffer, uint64_t size, uint64_t log_id);
-int64_t opal_get_elog_size(uint64_t *log_id, uint64_t *size, uint64_t *elog_type);
+int64_t opal_get_elog_size(__be64 *log_id, __be64 *size, __be64 *elog_type);
 int64_t opal_write_elog(uint64_t buffer, uint64_t size, uint64_t offset);
 int64_t opal_send_ack_elog(uint64_t log_id);
 void opal_resend_pending_logs(void);
diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 7e3821e..10268c4 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -238,18 +238,25 @@ static struct elog_obj *create_elog_obj(uint64_t id, size_t size, uint64_t type)
 
 static void elog_work_fn(struct work_struct *work)
 {
+	__be64 size;
+	__be64 id;
+	__be64 type;
 	uint64_t elog_size;
 	uint64_t log_id;
 	uint64_t elog_type;
 	int rc;
 	char name[2+16+1];
 
-	rc = opal_get_elog_size(&log_id, &elog_size, &elog_type);
+	rc = opal_get_elog_size(&id, &size, &type);
 	if (rc != OPAL_SUCCESS) {
 		pr_err("ELOG: Opal log read failed\n");
 		return;
 	}
 
+	elog_size = be64_to_cpu(size);
+	log_id = be64_to_cpu(id);
+	elog_type = be64_to_cpu(type);
+
 	BUG_ON(elog_size > OPAL_MAX_ERRLOG_SIZE);
 
 	if (elog_size >= OPAL_MAX_ERRLOG_SIZE)
-- 
1.8.3.2
