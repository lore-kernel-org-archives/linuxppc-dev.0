Return-Path: <anton@samba.org>
Date: Thu, 27 Mar 2014 16:20:56 +1100
From: Anton Blanchard <anton@samba.org>
To: stewart@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 4/4] powerpc/powernv: Fix little endian issues OPAL error
 log code
Message-ID: <20140327162056.5a57c4c9@kryten>
In-Reply-To: <20140327161849.791432d0@kryten>
References: <20140327161849.791432d0@kryten>
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


Fix little endian issues with the OPAL error log code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/platforms/powernv/opal-elog.c
===================================================================
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -243,18 +243,25 @@ static struct elog_obj *create_elog_obj(
 
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
Index: b/arch/powerpc/include/asm/opal.h
===================================================================
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -851,7 +851,7 @@ int64_t opal_lpc_read(uint32_t chip_id,
 		      uint32_t addr, __be32 *data, uint32_t sz);
 
 int64_t opal_read_elog(uint64_t buffer, uint64_t size, uint64_t log_id);
-int64_t opal_get_elog_size(uint64_t *log_id, uint64_t *size, uint64_t *elog_type);
+int64_t opal_get_elog_size(__be64 *log_id, __be64 *size, __be64 *elog_type);
 int64_t opal_write_elog(uint64_t buffer, uint64_t size, uint64_t offset);
 int64_t opal_send_ack_elog(uint64_t log_id);
 void opal_resend_pending_logs(void);
