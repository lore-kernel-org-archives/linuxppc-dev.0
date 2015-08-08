Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F5201A0509
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:16 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:13 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C9667C90041
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:46:15 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781tAQG065800
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:10 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t9RE012311
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:10 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 16/16] Add TPM firmware API call get-failure-reason
Date: Fri,  7 Aug 2015 21:55:05 -0400
Message-Id: <1438998905-4085665-17-git-send-email-stefanb@linux.vnet.ibm.com>
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

This patch adds support for the TPM firmware API call get-failure-reason.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 board-qemu/slof/vio-vtpm-cdriver.fs |  8 ++++++++
 board-qemu/slof/vtpm-sml.fs         |  7 +++++++
 lib/libtpm/tcgbios.c                | 16 ++++++++++++++++
 lib/libtpm/tcgbios.h                |  1 +
 lib/libtpm/tpm.code                 | 10 ++++++++++
 lib/libtpm/tpm.in                   |  1 +
 slof/fs/tpm/tpm-static.fs           | 12 ++++++++++++
 7 files changed, 55 insertions(+)

diff --git a/board-qemu/slof/vio-vtpm-cdriver.fs b/board-qemu/slof/vio-vtpm-cdriver.fs
index 474c24c..18ee85a 100644
--- a/board-qemu/slof/vio-vtpm-cdriver.fs
+++ b/board-qemu/slof/vio-vtpm-cdriver.fs
@@ -80,6 +80,14 @@ false VALUE vtpm-debug?
 ;
 
 \ firmware API call
+: get-failure-reason ( -- reason )
+    " get-failure-reason" call-forward IF
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
index 449f6fc..a37aa80 100644
--- a/board-qemu/slof/vtpm-sml.fs
+++ b/board-qemu/slof/vtpm-sml.fs
@@ -59,6 +59,13 @@ log-base LOG-SIZE tpm-set-log-parameters
     vtpm-driver-get-state
 ;
 
+: get-failure-reason ( -- reason )
+    vtpm-debug? IF
+        ." Call to get-failure-reason" cr
+    THEN
+    vtpm-driver-get-failure-reason
+;
+
 : hash-all ( data-ptr data-len hash-ptr -- )
     vtpm-debug? IF
         ." Call to hash-all" cr
diff --git a/lib/libtpm/tcgbios.c b/lib/libtpm/tcgbios.c
index 02ad91a..7194141 100644
--- a/lib/libtpm/tcgbios.c
+++ b/lib/libtpm/tcgbios.c
@@ -1545,3 +1545,19 @@ uint32_t tpm_driver_get_state(void)
 
 	return td->getstate();
 }
+
+/*
+ * tpm_driver_get_failure_reason: Function for interfacing with the firmware
+ *                                API
+ */
+uint32_t tpm_driver_get_failure_reason(void)
+{
+	struct tpm_driver *td = tpm_state.tpm_driver_to_use;
+
+	/* do not check for a working TPM here */
+
+	if (!td)
+		return PFW_DRV_ERROR_NO_FAILURE;
+
+	return td->geterror();
+}
diff --git a/lib/libtpm/tcgbios.h b/lib/libtpm/tcgbios.h
index 05cadb0..c7fbc29 100644
--- a/lib/libtpm/tcgbios.h
+++ b/lib/libtpm/tcgbios.h
@@ -39,6 +39,7 @@ uint32_t tpm_hash_all(const void *data, uint32_t datalen, void *hashptr);
 uint32_t tpm_get_maximum_cmd_size(void);
 uint32_t tpm_pass_through_to_tpm(unsigned char *buf, uint32_t cmdlen);
 uint32_t tpm_driver_get_state(void);
+uint32_t tpm_driver_get_failure_reason(void);
 
 /* flags returned by tpm_get_state */
 #define TPM_STATE_ENABLED        1
diff --git a/lib/libtpm/tpm.code b/lib/libtpm/tpm.code
index 574c7eb..29e3b3d 100644
--- a/lib/libtpm/tpm.code
+++ b/lib/libtpm/tpm.code
@@ -163,6 +163,16 @@ PRIM(tpm_X2d_driver_X2d_get_X2d_state)
 	TOS.n = tpm_driver_get_state();
 MIRP
 
+/****************************************************/
+/* Firmware API                                     */
+/* SLOF:   tpm-driver-get-error ( -- errcode)       */
+/* LIBTPM: errcode = tpm_driver_get_error(void)     */
+/****************************************************/
+PRIM(tpm_X2d_driver_X2d_get_X2d_failure_X2d_reason)
+	PUSH;
+	TOS.n = tpm_driver_get_failure_reason();
+MIRP
+
 /*****************************************************************/
 /* Firmware API                                                  */
 /* SLOF:   tpm-hash-all ( data-ptr data-len hash-ptr -- errcode) */
diff --git a/lib/libtpm/tpm.in b/lib/libtpm/tpm.in
index 3dd78f4..5f33d05 100644
--- a/lib/libtpm/tpm.in
+++ b/lib/libtpm/tpm.in
@@ -30,3 +30,4 @@ cod(tpm-hash-all)
 cod(tpm-get-maximum-cmd-size)
 cod(tpm-pass-through-to-tpm)
 cod(tpm-driver-get-state)
+cod(tpm-driver-get-failure-reason)
diff --git a/slof/fs/tpm/tpm-static.fs b/slof/fs/tpm/tpm-static.fs
index 31ac815..cbd92cb 100644
--- a/slof/fs/tpm/tpm-static.fs
+++ b/slof/fs/tpm/tpm-static.fs
@@ -81,6 +81,18 @@ false VALUE vtpm-debug?
 ;
 
 \ firmware API function
+: vtpm-driver-get-failure-reason ( -- reason )
+    vtpm-available? IF
+        tpm-driver-get-failure-reason
+        vtpm-debug? IF
+            ." VTPM: Return value from tpm-driver-get-failure-reason: " dup . cr
+        THEN
+    ELSE
+        -1 \ no failure
+    THEN
+;
+
+\ firmware API function
 : vtpm-log-event ( event-ptr -- ok? )
     vtpm-available? IF
         tpm-log-event
-- 
1.9.3
