Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95F921A03B5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:13 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:11 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 62A3E6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:46:55 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781t92756492220
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:09 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t9la012274
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:09 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 13/16] Add TPM firmware API call get-maximum-cmd-size
Date: Fri,  7 Aug 2015 21:55:02 -0400
Message-Id: <1438998905-4085665-14-git-send-email-stefanb@linux.vnet.ibm.com>
In-Reply-To: <1438998905-4085665-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1438998905-4085665-1-git-send-email-stefanb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for the firmware API call get-maximum-cmd-size.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 board-qemu/slof/vio-vtpm-cdriver.fs |  7 ++++++
 board-qemu/slof/vtpm-sml.fs         |  6 +++++
 lib/libtpm/tcgbios.c                | 44 +++++++++++++++++++++++++++++++++++++
 lib/libtpm/tcgbios.h                |  1 +
 lib/libtpm/tcgbios_int.h            |  7 ++++++
 lib/libtpm/tpm.code                 | 10 +++++++++
 lib/libtpm/tpm.in                   |  1 +
 slof/fs/tpm/tpm-static.fs           | 12 ++++++++++
 8 files changed, 88 insertions(+)

diff --git a/board-qemu/slof/vio-vtpm-cdriver.fs b/board-qemu/slof/vio-vtpm-cdriver.fs
index 44e5aec..22fef4f 100644
--- a/board-qemu/slof/vio-vtpm-cdriver.fs
+++ b/board-qemu/slof/vio-vtpm-cdriver.fs
@@ -95,6 +95,13 @@ false VALUE vtpm-debug?
     THEN
 ;
 
+\ firmware API call
+: get-maximum-cmd-size ( -- maximum-size )
+    " get-maximum-cmd-size" call-forward IF
+        0
+    THEN
+;
+
 : open ( )
     vtpm-debug? IF ." VTPM: vTPM open()" cr THEN
     true
diff --git a/board-qemu/slof/vtpm-sml.fs b/board-qemu/slof/vtpm-sml.fs
index 8783bf1..e62c20c 100644
--- a/board-qemu/slof/vtpm-sml.fs
+++ b/board-qemu/slof/vtpm-sml.fs
@@ -73,6 +73,12 @@ log-base LOG-SIZE tpm-set-log-parameters
     vtpm-hash-log-extend-event
 ;
 
+: get-maximum-cmd-size ( -- max-size )
+    vtpm-debug? IF
+        ." Call to get-maximum-cmd-size" cr
+    THEN
+    vtpm-get-maximum-cmd-size
+;
 
 : open  true ;
 : close ;
diff --git a/lib/libtpm/tcgbios.c b/lib/libtpm/tcgbios.c
index 621c3e8..b306edf 100644
--- a/lib/libtpm/tcgbios.c
+++ b/lib/libtpm/tcgbios.c
@@ -35,6 +35,8 @@
 	} \
 } while (0);
 
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+
 static const uint8_t Startup_ST_CLEAR[] = { 0x00, TPM_ST_CLEAR };
 static const uint8_t Startup_ST_STATE[] = { 0x00, TPM_ST_STATE };
 
@@ -71,6 +73,11 @@ static const uint8_t GetCapability_Durations[] = {
 	0x00, 0x00, 0x01, 0x20
 };
 
+static const uint8_t GetCapability_BufferSize[] = {
+	0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x04,
+	0x00, 0x00, 0x01, 0x24
+};
+
 static uint8_t evt_separator[] = {0xff,0xff,0xff,0xff};
 
 struct tpm_state {
@@ -1461,3 +1468,40 @@ uint32_t tpm_measure_scrtm(void)
 
 	return rc;
 }
+
+/*
+ * tpm_get_maximum_cmd_size: Function for interfacing with the firmware API
+ *
+ * This function returns the maximum size a TPM command (or response) may have.
+ */
+uint32_t tpm_get_maximum_cmd_size(void)
+{
+	uint32_t rc;
+	uint32_t returnCode;
+	struct tpm_res_getcap_buffersize buffersize;
+	uint32_t result;
+	struct tpm_driver *td = tpm_state.tpm_driver_to_use;
+
+	if (!has_working_tpm())
+		return 0;
+
+	rc = build_and_send_cmd(TPM_ORD_GetCapability,
+				GetCapability_BufferSize,
+				sizeof(GetCapability_BufferSize),
+				(uint8_t *)&buffersize, sizeof(buffersize),
+				&returnCode, TPM_DURATION_TYPE_SHORT);
+
+	if (rc || returnCode)
+		goto err_exit;
+
+	result = MIN(cpu_to_be32(buffersize.buffersize), td->getbuffersize());
+
+	return result;
+
+err_exit:
+	dprintf("TPM malfunctioning (line %d).\n", __LINE__);
+
+	tpm_state.tpm_working = 0;
+
+	return 0;
+}
diff --git a/lib/libtpm/tcgbios.h b/lib/libtpm/tcgbios.h
index 0dacba2..2aa7d20 100644
--- a/lib/libtpm/tcgbios.h
+++ b/lib/libtpm/tcgbios.h
@@ -36,6 +36,7 @@ uint32_t tpm_process_opcode(uint8_t op, bool verbose);
 uint32_t tpm_hash_log_extend_event(struct pcpes *pcpes);
 bool tpm_log_event(struct pcpes *pcpes);
 uint32_t tpm_hash_all(const void *data, uint32_t datalen, void *hashptr);
+uint32_t tpm_get_maximum_cmd_size(void);
 
 /* flags returned by tpm_get_state */
 #define TPM_STATE_ENABLED        1
diff --git a/lib/libtpm/tcgbios_int.h b/lib/libtpm/tcgbios_int.h
index bedc2f1..249e205 100644
--- a/lib/libtpm/tcgbios_int.h
+++ b/lib/libtpm/tcgbios_int.h
@@ -177,6 +177,13 @@ struct tpm_res_getcap_durations {
     uint32_t    durations[TPM_NUM_DURATIONS];
 } __attribute__((packed));
 
+struct tpm_res_getcap_buffersize {
+    TPM_RSP_HEADER
+    uint32_t    size;
+    uint32_t    buffersize;
+} __attribute__((packed));
+
+
 struct tpm_res_sha1start {
     TPM_RSP_HEADER
     uint32_t    max_num_bytes;
diff --git a/lib/libtpm/tpm.code b/lib/libtpm/tpm.code
index acd3a10..5c3d4db 100644
--- a/lib/libtpm/tpm.code
+++ b/lib/libtpm/tpm.code
@@ -164,3 +164,13 @@ PRIM(tpm_X2d_hash_X2d_all)
 	void *dataptr = TOS.a;
 	TOS.n = tpm_hash_all(dataptr, datalen, hashptr);
 MIRP
+
+/****************************************************/
+/* Firmware API                                     */
+/* SLOF:   tpm-get-maximum-cmd-size ( -- max-size)  */
+/* LIBTPM: maxsize = tpm_get_maximum_cmd_size()     */
+/****************************************************/
+PRIM(tpm_X2d_get_X2d_maximum_X2d_cmd_X2d_size)
+	PUSH;
+	TOS.n = tpm_get_maximum_cmd_size();
+MIRP
diff --git a/lib/libtpm/tpm.in b/lib/libtpm/tpm.in
index ad57631..0923fc0 100644
--- a/lib/libtpm/tpm.in
+++ b/lib/libtpm/tpm.in
@@ -27,3 +27,4 @@ cod(tpm-measure-scrtm)
 cod(tpm-log-event)
 cod(tpm-hash-log-extend-event)
 cod(tpm-hash-all)
+cod(tpm-get-maximum-cmd-size)
diff --git a/slof/fs/tpm/tpm-static.fs b/slof/fs/tpm/tpm-static.fs
index 31d3652..fca0058 100644
--- a/slof/fs/tpm/tpm-static.fs
+++ b/slof/fs/tpm/tpm-static.fs
@@ -108,6 +108,18 @@ false VALUE vtpm-debug?
     THEN
 ;
 
+\ firmware API function
+: vtpm-get-maximum-cmd-size ( -- max-size )
+    vtpm-available? IF
+        tpm-get-maximum-cmd-size                            ( -- max-size )
+        vtpm-debug? IF
+            ." VTPM: Return value from tpm-get-maximum-cmd-size: " dup . cr
+        THEN
+    ELSE
+        0
+    THEN
+;
+
 1 CONSTANT TPM_ST_ENABLED
 2 CONSTANT TPM_ST_ACTIVE
 4 CONSTANT TPM_ST_OWNED
-- 
1.9.3
