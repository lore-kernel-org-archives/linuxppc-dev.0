Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15B0C1A0021
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:13 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:11 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id DB03F38C8039
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:55:09 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781t9cv54198446
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:09 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t9Dq012264
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:09 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 12/16] Add TPM firmware API calls hash-all, log-event,
 hash-log-extend-event
Date: Fri,  7 Aug 2015 21:55:01 -0400
Message-Id: <1438998905-4085665-13-git-send-email-stefanb@linux.vnet.ibm.com>
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

Add the TPM firmware API calls hash-all, log-event, and hash-log-extend-event.
These firmware calls are implemented in /vdevice/vtpm and /ibm,vtpm but the
former merely forwards the calls to the latter. The implementation follows
the Virtual TPM firmware documentation.

These particular 3 API calls enable trusted grub extensions.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 board-qemu/slof/vio-vtpm-cdriver.fs | 37 +++++++++++++++++++++++++++++++++
 board-qemu/slof/vtpm-sml.fs         | 22 ++++++++++++++++++++
 lib/libtpm/tcgbios.c                | 41 +++++++++++++++++++++++++++++++++++++
 lib/libtpm/tcgbios.h                |  5 +++++
 lib/libtpm/tpm.code                 | 32 +++++++++++++++++++++++++++++
 lib/libtpm/tpm.in                   |  3 +++
 slof/fs/tpm/tpm-static.fs           | 40 ++++++++++++++++++++++++++++++++++++
 7 files changed, 180 insertions(+)

diff --git a/board-qemu/slof/vio-vtpm-cdriver.fs b/board-qemu/slof/vio-vtpm-cdriver.fs
index 0b4ba41..44e5aec 100644
--- a/board-qemu/slof/vio-vtpm-cdriver.fs
+++ b/board-qemu/slof/vio-vtpm-cdriver.fs
@@ -58,6 +58,43 @@ false VALUE vtpm-debug?
     r> to my-self
 ;
 
+\ forward a call to /ibm,vtpm, which implements the function with the
+\ given name
+: call-forward ( arg ... arg name namelen -- failure? ret ... ret )
+    s" /ibm,vtpm" open-dev ?dup IF
+        dup >r                         ( arg ... arg name namelen ihandle r:ihandle -- )
+        $call-method                   ( r:ihandle -- ret ... ret )
+        r> close-dev                   ( -- ret ... ret )
+        false                          ( -- false ret ... ret )
+    ELSE
+        true                           ( -- true )
+    THEN
+;
+
+\ firmware API call
+: hash-all ( data-ptr data-len hash-ptr -- )
+    " hash-all" call-forward IF
+        \ call-forward failed; clean up stack
+        3drop
+    THEN
+;
+
+\ firmware API call
+: log-event ( event-ptr -- success? )
+    " log-event" call-forward IF
+        drop
+        false
+    THEN
+;
+
+\ firmware API call
+: hash-log-extend-event ( event-ptr -- rc )
+    " hash-log-extend-event" call-forward IF
+        drop
+        9 \ TPM_FAIL
+    THEN
+;
+
 : open ( )
     vtpm-debug? IF ." VTPM: vTPM open()" cr THEN
     true
diff --git a/board-qemu/slof/vtpm-sml.fs b/board-qemu/slof/vtpm-sml.fs
index 28c30f1..8783bf1 100644
--- a/board-qemu/slof/vtpm-sml.fs
+++ b/board-qemu/slof/vtpm-sml.fs
@@ -52,6 +52,28 @@ log-base LOG-SIZE tpm-set-log-parameters
     move
 ;
 
+: hash-all ( data-ptr data-len hash-ptr -- )
+    vtpm-debug? IF
+        ." Call to hash-all" cr
+    THEN
+    vtpm-hash-all
+;
+
+: log-event ( event-ptr -- ok? )
+    vtpm-debug? IF
+        ." Call to log-event" cr
+    THEN
+    vtpm-log-event
+;
+
+: hash-log-extend-event ( event-ptr -- rc )
+    vtpm-debug? IF
+        ." Call to hash-log-extend-event" cr
+    THEN
+    vtpm-hash-log-extend-event
+;
+
+
 : open  true ;
 : close ;
 
diff --git a/lib/libtpm/tcgbios.c b/lib/libtpm/tcgbios.c
index adec313..621c3e8 100644
--- a/lib/libtpm/tcgbios.c
+++ b/lib/libtpm/tcgbios.c
@@ -563,6 +563,20 @@ static uint32_t tpm_extend_ofdt_log(struct pcpes *pcpes,
 	return 0;
 }
 
+/*
+ * tpm_log_event: Function for interfacing with the firmware API
+ */
+bool tpm_log_event(struct pcpes *pcpes)
+{
+	const char *event = NULL;
+	uint32_t event_length = pcpes->eventdatasize;
+
+	if (event_length)
+		event = (void *)pcpes + offset_of(struct pcpes, event);
+
+	return (tpm_extend_ofdt_log(pcpes, event, event_length) == 0);
+}
+
 static uint32_t is_preboot_if_shutdown(void)
 {
 	return tpm_state.if_shutdown;
@@ -656,6 +670,14 @@ static uint32_t tpm_extend(uint8_t *hash, uint32_t pcrindex)
 }
 
 /*
+ * tpm_hash_all: Function for interfacing with the firmware API
+ */
+uint32_t tpm_hash_all(const void *data, uint32_t datalen, void *hashptr)
+{
+	return sha1(data, datalen, hashptr);
+}
+
+/*
  * Hash then given input data and append the hash to the log
  *
  * @hashdata: the data to hash
@@ -766,6 +788,25 @@ static uint32_t tpm_add_measurement(uint32_t pcrindex,
 }
 
 /*
+ * tpm_hash_log_extend_event: Function for interfacing with then firmware API
+ */
+uint32_t tpm_hash_log_extend_event(struct pcpes *pcpes)
+{
+	const char *event = NULL;
+	uint32_t event_length = pcpes->eventdatasize;
+
+	if (!has_working_tpm())
+		return TCGBIOS_GENERAL_ERROR;
+
+	if (event_length)
+		event = (void *)pcpes + offset_of(struct pcpes, event);
+
+	return hash_log_extend_event(&pcpes->event, pcpes->eventdatasize,
+				     pcpes, event, event_length,
+				     pcpes->pcrindex);
+}
+
+/*
  * Add event separators for PCRs 0 to 7
  */
 uint32_t tpm_add_event_separators(void)
diff --git a/lib/libtpm/tcgbios.h b/lib/libtpm/tcgbios.h
index 9f07caf..0dacba2 100644
--- a/lib/libtpm/tcgbios.h
+++ b/lib/libtpm/tcgbios.h
@@ -22,6 +22,8 @@ enum ipltype {
     IPL_EL_TORITO_2
 };
 
+struct pcpes;
+
 uint32_t tpm_start(void);
 uint32_t tpm_unassert_pp(void);
 uint32_t tpm_measure_scrtm(void);
@@ -31,6 +33,9 @@ uint32_t tpm_ipl(enum ipltype bootcd, const uint8_t *addr, uint32_t length);
 uint32_t tpm_add_bcv(uint32_t bootdrv, const uint8_t *addr, uint32_t length);
 uint32_t tpm_add_event_separators(void);
 uint32_t tpm_process_opcode(uint8_t op, bool verbose);
+uint32_t tpm_hash_log_extend_event(struct pcpes *pcpes);
+bool tpm_log_event(struct pcpes *pcpes);
+uint32_t tpm_hash_all(const void *data, uint32_t datalen, void *hashptr);
 
 /* flags returned by tpm_get_state */
 #define TPM_STATE_ENABLED        1
diff --git a/lib/libtpm/tpm.code b/lib/libtpm/tpm.code
index 34b9cbc..acd3a10 100644
--- a/lib/libtpm/tpm.code
+++ b/lib/libtpm/tpm.code
@@ -132,3 +132,35 @@ PRIM(tpm_X2d_measure_X2d_scrtm)
 	PUSH;
 	TOS.n = tpm_measure_scrtm();
 MIRP
+
+/************************************************/
+/* Firmware API                                 */
+/* SLOF:   tpm-log-event ( eventptr -- ok? )    */
+/* LIBTPM: ok = tpm-log-event                   */
+/************************************************/
+PRIM(tpm_X2d_log_X2d_event)
+	void *eventptr = TOS.a;
+	TOS.n = tpm_log_event(eventptr);
+MIRP
+
+/********************************************************/
+/* Firmware API                                         */
+/* SLOF:   tpm-hash-log-extend-event ( eventptr -- rc ) */
+/* LIBTPM: errcode = tpm-hash-log-extend-event          */
+/********************************************************/
+PRIM(tpm_X2d_hash_X2d_log_X2d_extend_X2d_event)
+	void *eventptr = TOS.a;
+	TOS.n = tpm_hash_log_extend_event(eventptr);
+MIRP
+
+/*****************************************************************/
+/* Firmware API                                                  */
+/* SLOF:   tpm-hash-all ( data-ptr data-len hash-ptr -- errcode) */
+/* LIBTPM: errcode = tpm-hash-all                                */
+/*****************************************************************/
+PRIM(tpm_X2d_hash_X2d_all)
+	void *hashptr = TOS.a; POP;
+	int datalen = TOS.n; POP;
+	void *dataptr = TOS.a;
+	TOS.n = tpm_hash_all(dataptr, datalen, hashptr);
+MIRP
diff --git a/lib/libtpm/tpm.in b/lib/libtpm/tpm.in
index 48c0d75..ad57631 100644
--- a/lib/libtpm/tpm.in
+++ b/lib/libtpm/tpm.in
@@ -24,3 +24,6 @@ cod(tpm-process-opcode)
 cod(tpm-get-state)
 cod(tpm-is-working)
 cod(tpm-measure-scrtm)
+cod(tpm-log-event)
+cod(tpm-hash-log-extend-event)
+cod(tpm-hash-all)
diff --git a/slof/fs/tpm/tpm-static.fs b/slof/fs/tpm/tpm-static.fs
index 1bc37c9..31d3652 100644
--- a/slof/fs/tpm/tpm-static.fs
+++ b/slof/fs/tpm/tpm-static.fs
@@ -68,6 +68,46 @@ false VALUE vtpm-debug?
     THEN
 ;
 
+\ firmware API function
+: vtpm-log-event ( event-ptr -- ok? )
+    vtpm-available? IF
+        tpm-log-event
+        vtpm-debug? IF
+            ." VTPM: Returned bool from tpm-log-event: " dup . cr
+        THEN
+    ELSE
+        drop
+        false
+    THEN
+;
+
+\ firmware API function
+: vtpm-hash-log-extend-event ( event-ptr -- rc )
+    vtpm-available? IF
+        tpm-hash-log-extend-event
+        vtpm-debug? IF
+            ." VTPM: Error code from tpm-hash-log-extend-event: " dup . cr
+        THEN
+    ELSE
+        drop
+        9  \ Tpm-fail failure reason
+    THEN
+;
+
+\ firmware API function
+: vtpm-hash-all ( data-ptr data-len hash-ptr -- )
+    vtpm-available? IF
+        tpm-hash-all                               ( -- errcode )
+        vtpm-debug? IF
+            ." VTPM: Error code from tpm-hash-all: " . cr
+        ELSE
+            drop
+        THEN
+    ELSE
+        3drop
+    THEN
+;
+
 1 CONSTANT TPM_ST_ENABLED
 2 CONSTANT TPM_ST_ACTIVE
 4 CONSTANT TPM_ST_OWNED
-- 
1.9.3
