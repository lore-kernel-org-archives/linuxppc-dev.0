Return-Path: <anton@samba.org>
Date: Thu, 27 Mar 2014 16:18:49 +1100
From: Anton Blanchard <anton@samba.org>
To: stewart@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/4] powerpc/powernv: Use uint64_t instead of size_t in OPAL
 APIs
Message-ID: <20140327161849.791432d0@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Using size_t in our APIs is asking for trouble, especially
when some OPAL calls use size_t pointers.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/include/asm/opal.h
===================================================================
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -850,8 +850,8 @@ int64_t opal_lpc_write(uint32_t chip_id,
 int64_t opal_lpc_read(uint32_t chip_id, enum OpalLPCAddressType addr_type,
 		      uint32_t addr, __be32 *data, uint32_t sz);
 
-int64_t opal_read_elog(uint64_t buffer, size_t size, uint64_t log_id);
-int64_t opal_get_elog_size(uint64_t *log_id, size_t *size, uint64_t *elog_type);
+int64_t opal_read_elog(uint64_t buffer, uint64_t size, uint64_t log_id);
+int64_t opal_get_elog_size(uint64_t *log_id, uint64_t *size, uint64_t *elog_type);
 int64_t opal_write_elog(uint64_t buffer, uint64_t size, uint64_t offset);
 int64_t opal_send_ack_elog(uint64_t log_id);
 void opal_resend_pending_logs(void);
@@ -866,13 +866,13 @@ int64_t opal_dump_read(uint32_t dump_id,
 int64_t opal_dump_ack(uint32_t dump_id);
 int64_t opal_dump_resend_notification(void);
 
-int64_t opal_get_msg(uint64_t buffer, size_t size);
-int64_t opal_check_completion(uint64_t buffer, size_t size, uint64_t token);
+int64_t opal_get_msg(uint64_t buffer, uint64_t size);
+int64_t opal_check_completion(uint64_t buffer, uint64_t size, uint64_t token);
 int64_t opal_sync_host_reboot(void);
 int64_t opal_get_param(uint64_t token, uint32_t param_id, uint64_t buffer,
-		size_t length);
+		uint64_t length);
 int64_t opal_set_param(uint64_t token, uint32_t param_id, uint64_t buffer,
-		size_t length);
+		uint64_t length);
 int64_t opal_sensor_read(uint32_t sensor_hndl, int token,
 		uint32_t *sensor_data);
 
Index: b/arch/powerpc/platforms/powernv/opal-elog.c
===================================================================
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -243,7 +243,7 @@ static struct elog_obj *create_elog_obj(
 
 static void elog_work_fn(struct work_struct *work)
 {
-	size_t elog_size;
+	uint64_t elog_size;
 	uint64_t log_id;
 	uint64_t elog_type;
 	int rc;
