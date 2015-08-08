Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9987E1A045F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:14 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:12 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 7B0E9C90046
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:46:15 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781tATQ56230124
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:10 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t9Lt012287
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:09 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 14/16] Add TPM firmware API call pass-through-to-tpm
Date: Fri,  7 Aug 2015 21:55:03 -0400
Message-Id: <1438998905-4085665-15-git-send-email-stefanb@linux.vnet.ibm.com>
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

This patch adds support for the firmware API call pass-through-to-tpm.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 board-qemu/slof/vio-vtpm-cdriver.fs |  8 ++++++++
 board-qemu/slof/vtpm-sml.fs         |  7 +++++++
 lib/libtpm/tcgbios.c                | 28 ++++++++++++++++++++++++++++
 lib/libtpm/tcgbios.h                |  1 +
 lib/libtpm/tpm.code                 | 11 +++++++++++
 lib/libtpm/tpm.in                   |  1 +
 slof/fs/tpm/tpm-static.fs           | 13 +++++++++++++
 7 files changed, 69 insertions(+)

diff --git a/board-qemu/slof/vio-vtpm-cdriver.fs b/board-qemu/slof/vio-vtpm-cdriver.fs
index 22fef4f..5d55148 100644
--- a/board-qemu/slof/vio-vtpm-cdriver.fs
+++ b/board-qemu/slof/vio-vtpm-cdriver.fs
@@ -96,6 +96,14 @@ false VALUE vtpm-debug?
 ;
 
 \ firmware API call
+: pass-through-to-tpm ( buf-addr buf-size -- response-size )
+    " pass-through-to-tpm" call-forward IF
+        2drop
+        0
+    THEN
+;
+
+\ firmware API call
 : get-maximum-cmd-size ( -- maximum-size )
     " get-maximum-cmd-size" call-forward IF
         0
diff --git a/board-qemu/slof/vtpm-sml.fs b/board-qemu/slof/vtpm-sml.fs
index e62c20c..3ce1ace 100644
--- a/board-qemu/slof/vtpm-sml.fs
+++ b/board-qemu/slof/vtpm-sml.fs
@@ -80,6 +80,13 @@ log-base LOG-SIZE tpm-set-log-parameters
     vtpm-get-maximum-cmd-size
 ;
 
+: pass-through-to-tpm ( buf-addr cmd-size -- rsp-size )
+    vtpm-debug? IF
+        ." Call to pass-through-to-tpm" cr
+    THEN
+    vtpm-pass-through-to-tpm
+;
+
 : open  true ;
 : close ;
 
diff --git a/lib/libtpm/tcgbios.c b/lib/libtpm/tcgbios.c
index b306edf..6c991b2 100644
--- a/lib/libtpm/tcgbios.c
+++ b/lib/libtpm/tcgbios.c
@@ -640,6 +640,34 @@ static bool pass_through_to_tpm(unsigned char *req,
 }
 
 /*
+ * tpm_pass_through_to_tpm: Function for interfacing with the firmware API
+ *
+ * buf: buffer holding the command; also used for holding the entire response
+ * cmdlen: length of the command in the buffer
+ *
+ * Returns 0 in case of failure, the size of the response otherwise.
+ */
+uint32_t tpm_pass_through_to_tpm(unsigned char *buf, uint32_t cmdlen)
+{
+	uint32_t resplen = PAPR_VTPM_MAX_BUFFER_SIZE;
+
+	/*
+	 * API spec: caller must ensure that the buffer is large
+	 *           enough to receive the full response into
+	 *           the same buffer where the command is in.
+	 *           We anticipate the largest possible buffer
+	 *           the driver supports in 'resplen'.
+	 * For duration we use the worst-case timeout 'LONG'
+	 * so that any command can be sent and will not time out.
+	 */
+	if (pass_through_to_tpm(buf, cmdlen,
+				TPM_DURATION_TYPE_LONG,
+				buf, &resplen))
+		return 0;
+	return resplen;
+}
+
+/*
  * Extend a PCR of the TPM with the given hash
  *
  * @hash: sha1 hash (20 bytes) to extend PCR with
diff --git a/lib/libtpm/tcgbios.h b/lib/libtpm/tcgbios.h
index 2aa7d20..6951af3 100644
--- a/lib/libtpm/tcgbios.h
+++ b/lib/libtpm/tcgbios.h
@@ -37,6 +37,7 @@ uint32_t tpm_hash_log_extend_event(struct pcpes *pcpes);
 bool tpm_log_event(struct pcpes *pcpes);
 uint32_t tpm_hash_all(const void *data, uint32_t datalen, void *hashptr);
 uint32_t tpm_get_maximum_cmd_size(void);
+uint32_t tpm_pass_through_to_tpm(unsigned char *buf, uint32_t cmdlen);
 
 /* flags returned by tpm_get_state */
 #define TPM_STATE_ENABLED        1
diff --git a/lib/libtpm/tpm.code b/lib/libtpm/tpm.code
index 5c3d4db..e763f45 100644
--- a/lib/libtpm/tpm.code
+++ b/lib/libtpm/tpm.code
@@ -174,3 +174,14 @@ PRIM(tpm_X2d_get_X2d_maximum_X2d_cmd_X2d_size)
 	PUSH;
 	TOS.n = tpm_get_maximum_cmd_size();
 MIRP
+
+/*******************************************************************/
+/* Firmware API                                                    */
+/* SLOF:   tpm-pass-through-to-tpm (buf-addr cmd-size -- rsp-size) */
+/* LIBTPM: respsize = tpm_pass_through_to_tpm(buf, cmdsize)        */
+/*******************************************************************/
+PRIM(tpm_X2d_pass_X2d_through_X2d_to_X2d_tpm)
+	int cmdsize = TOS.n; POP;
+	void *buf = TOS.a;
+	TOS.n = tpm_pass_through_to_tpm(buf, cmdsize);
+MIRP
diff --git a/lib/libtpm/tpm.in b/lib/libtpm/tpm.in
index 0923fc0..8b7cde8 100644
--- a/lib/libtpm/tpm.in
+++ b/lib/libtpm/tpm.in
@@ -28,3 +28,4 @@ cod(tpm-log-event)
 cod(tpm-hash-log-extend-event)
 cod(tpm-hash-all)
 cod(tpm-get-maximum-cmd-size)
+cod(tpm-pass-through-to-tpm)
diff --git a/slof/fs/tpm/tpm-static.fs b/slof/fs/tpm/tpm-static.fs
index fca0058..f9583b0 100644
--- a/slof/fs/tpm/tpm-static.fs
+++ b/slof/fs/tpm/tpm-static.fs
@@ -120,6 +120,19 @@ false VALUE vtpm-debug?
     THEN
 ;
 
+\ firmware API function
+: vtpm-pass-through-to-tpm ( buf-addr cmd-size -- rsp-size )
+    vtpm-available? IF
+        tpm-pass-through-to-tpm                            ( -- rsp-size )
+        vtpm-debug? IF
+            ." VTPM: Return value from tpm-pass-through-to-tpm: " dup . cr
+        THEN
+    ELSE
+        2drop
+        0
+    THEN
+;
+
 1 CONSTANT TPM_ST_ENABLED
 2 CONSTANT TPM_ST_ACTIVE
 4 CONSTANT TPM_ST_OWNED
-- 
1.9.3
