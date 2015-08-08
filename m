Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7DB481A075F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:16 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:14 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5A1A038C803B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:55:10 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781tAmw65273958
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:10 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t9kW012300
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:10 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 15/16] Add TPM firmware API call get-state
Date: Fri,  7 Aug 2015 21:55:04 -0400
Message-Id: <1438998905-4085665-16-git-send-email-stefanb@linux.vnet.ibm.com>
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

This patch adds support for the TPM firmware API call get-state.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 board-qemu/slof/vio-vtpm-cdriver.fs |  8 ++++++++
 board-qemu/slof/vtpm-sml.fs         |  7 +++++++
 lib/libtpm/tcgbios.c                | 12 ++++++++++++
 lib/libtpm/tcgbios.h                |  1 +
 lib/libtpm/tpm.code                 | 10 ++++++++++
 lib/libtpm/tpm.in                   |  1 +
 slof/fs/tpm/tpm-static.fs           | 12 ++++++++++++
 7 files changed, 51 insertions(+)

diff --git a/board-qemu/slof/vio-vtpm-cdriver.fs b/board-qemu/slof/vio-vtpm-cdriver.fs
index 5d55148..474c24c 100644
--- a/board-qemu/slof/vio-vtpm-cdriver.fs
+++ b/board-qemu/slof/vio-vtpm-cdriver.fs
@@ -72,6 +72,14 @@ false VALUE vtpm-debug?
 ;
 
 \ firmware API call
+: get-state ( -- state )
+    " get-state" call-forward IF
+        \ call-forward failed; return a value
+        0 \ invalid
+    THEN
+;
+
+\ firmware API call
 : hash-all ( data-ptr data-len hash-ptr -- )
     " hash-all" call-forward IF
         \ call-forward failed; clean up stack
diff --git a/board-qemu/slof/vtpm-sml.fs b/board-qemu/slof/vtpm-sml.fs
index 3ce1ace..449f6fc 100644
--- a/board-qemu/slof/vtpm-sml.fs
+++ b/board-qemu/slof/vtpm-sml.fs
@@ -52,6 +52,13 @@ log-base LOG-SIZE tpm-set-log-parameters
     move
 ;
 
+: get-state ( -- state )
+    vtpm-debug? IF
+        ." Call to get-state" cr
+    THEN
+    vtpm-driver-get-state
+;
+
 : hash-all ( data-ptr data-len hash-ptr -- )
     vtpm-debug? IF
         ." Call to hash-all" cr
diff --git a/lib/libtpm/tcgbios.c b/lib/libtpm/tcgbios.c
index 6c991b2..02ad91a 100644
--- a/lib/libtpm/tcgbios.c
+++ b/lib/libtpm/tcgbios.c
@@ -1533,3 +1533,15 @@ err_exit:
 
 	return 0;
 }
+
+uint32_t tpm_driver_get_state(void)
+{
+	struct tpm_driver *td = tpm_state.tpm_driver_to_use;
+
+	/* do not check for a working TPM here */
+
+	if (!td)
+		return PFW_DRV_STATE_INVALID;
+
+	return td->getstate();
+}
diff --git a/lib/libtpm/tcgbios.h b/lib/libtpm/tcgbios.h
index 6951af3..05cadb0 100644
--- a/lib/libtpm/tcgbios.h
+++ b/lib/libtpm/tcgbios.h
@@ -38,6 +38,7 @@ bool tpm_log_event(struct pcpes *pcpes);
 uint32_t tpm_hash_all(const void *data, uint32_t datalen, void *hashptr);
 uint32_t tpm_get_maximum_cmd_size(void);
 uint32_t tpm_pass_through_to_tpm(unsigned char *buf, uint32_t cmdlen);
+uint32_t tpm_driver_get_state(void);
 
 /* flags returned by tpm_get_state */
 #define TPM_STATE_ENABLED        1
diff --git a/lib/libtpm/tpm.code b/lib/libtpm/tpm.code
index e763f45..574c7eb 100644
--- a/lib/libtpm/tpm.code
+++ b/lib/libtpm/tpm.code
@@ -153,6 +153,16 @@ PRIM(tpm_X2d_hash_X2d_log_X2d_extend_X2d_event)
 	TOS.n = tpm_hash_log_extend_event(eventptr);
 MIRP
 
+/****************************************************/
+/* Firmware API                                     */
+/* SLOF:   tpm-driver-get-state ( -- state)         */
+/* LIBTPM: state = tpm_driver_get_state(void)       */
+/****************************************************/
+PRIM(tpm_X2d_driver_X2d_get_X2d_state)
+	PUSH;
+	TOS.n = tpm_driver_get_state();
+MIRP
+
 /*****************************************************************/
 /* Firmware API                                                  */
 /* SLOF:   tpm-hash-all ( data-ptr data-len hash-ptr -- errcode) */
diff --git a/lib/libtpm/tpm.in b/lib/libtpm/tpm.in
index 8b7cde8..3dd78f4 100644
--- a/lib/libtpm/tpm.in
+++ b/lib/libtpm/tpm.in
@@ -29,3 +29,4 @@ cod(tpm-hash-log-extend-event)
 cod(tpm-hash-all)
 cod(tpm-get-maximum-cmd-size)
 cod(tpm-pass-through-to-tpm)
+cod(tpm-driver-get-state)
diff --git a/slof/fs/tpm/tpm-static.fs b/slof/fs/tpm/tpm-static.fs
index f9583b0..31ac815 100644
--- a/slof/fs/tpm/tpm-static.fs
+++ b/slof/fs/tpm/tpm-static.fs
@@ -69,6 +69,18 @@ false VALUE vtpm-debug?
 ;
 
 \ firmware API function
+: vtpm-driver-get-state ( -- state )
+    vtpm-available? IF
+        tpm-driver-get-state
+        vtpm-debug? IF
+            ." VTPM: Return value from tpm-driver-get-state: " dup . cr
+        THEN
+    ELSE
+        0 \ invalid
+    THEN
+;
+
+\ firmware API function
 : vtpm-log-event ( event-ptr -- ok? )
     vtpm-available? IF
         tpm-log-event
-- 
1.9.3
