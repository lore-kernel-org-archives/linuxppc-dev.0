Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D865D1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:13 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:11 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A98FC38C8052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:55:09 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781t9rm58785928
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:09 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t9Qx012251
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:09 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 11/16] Measure the static core root of trust for measurements
Date: Fri,  7 Aug 2015 21:55:00 -0400
Message-Id: <1438998905-4085665-12-git-send-email-stefanb@linux.vnet.ibm.com>
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

This patch adds support for measuring the static core root of trust
(S-CRTM) and logging the measurements.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 board-qemu/slof/vio-vtpm-cdriver.fs |  2 ++
 lib/libtpm/tcgbios.c                | 37 +++++++++++++++++++++++++++++++++++++
 lib/libtpm/tcgbios.h                |  1 +
 lib/libtpm/tcgbios_int.h            |  2 ++
 lib/libtpm/tpm.code                 | 10 ++++++++++
 lib/libtpm/tpm.in                   |  1 +
 slof/fs/tpm/tpm-static.fs           | 11 +++++++++++
 7 files changed, 64 insertions(+)

diff --git a/board-qemu/slof/vio-vtpm-cdriver.fs b/board-qemu/slof/vio-vtpm-cdriver.fs
index 2fc1657..0b4ba41 100644
--- a/board-qemu/slof/vio-vtpm-cdriver.fs
+++ b/board-qemu/slof/vio-vtpm-cdriver.fs
@@ -72,3 +72,5 @@ vtpm-init
 
 \ setup the log
 include vtpm-sml.fs
+
+vtpm-measure-scrtm
diff --git a/lib/libtpm/tcgbios.c b/lib/libtpm/tcgbios.c
index 40557d6..adec313 100644
--- a/lib/libtpm/tcgbios.c
+++ b/lib/libtpm/tcgbios.c
@@ -1383,3 +1383,40 @@ bool tpm_is_working(void)
 {
 	return has_working_tpm();
 }
+
+uint32_t tpm_measure_scrtm(void)
+{
+	uint32_t rc;
+
+	extern long print_version, print_version_end;
+	extern long _slof_data, _slof_data_end;
+
+	char *version_start = (char *)&print_version;
+	uint32_t version_length = (long)&print_version_end - (long)&print_version;
+
+	char *slof_start = (char *)&_slof_data;
+	uint32_t slof_length = (long)&_slof_data_end - (long)&_slof_data;
+
+	const char *scrtm = "S-CRTM Contents";
+
+	dprintf("Measure S-CRTM Version: addr = %p, length = %d\n",
+		version_start, version_length);
+
+	rc = tpm_add_measurement_to_log(
+		0, EV_S_CRTM_VERSION,
+		version_start, version_length,
+		(uint8_t *)version_start, version_length);
+
+	if (rc)
+		return rc;
+
+	dprintf("Measure S-CRTM Content: start = %p, length = %d\n",
+		&slof_start, slof_length);
+
+	rc = tpm_add_measurement_to_log(
+		0, EV_S_CRTM_CONTENTS,
+		scrtm, strlen(scrtm),
+		(uint8_t *)slof_start, slof_length);
+
+	return rc;
+}
diff --git a/lib/libtpm/tcgbios.h b/lib/libtpm/tcgbios.h
index 902ea1f..9f07caf 100644
--- a/lib/libtpm/tcgbios.h
+++ b/lib/libtpm/tcgbios.h
@@ -24,6 +24,7 @@ enum ipltype {
 
 uint32_t tpm_start(void);
 uint32_t tpm_unassert_pp(void);
+uint32_t tpm_measure_scrtm(void);
 void tpm_set_log_parameters(void *address, unsigned int size);
 uint32_t tpm_get_logsize(void);
 uint32_t tpm_ipl(enum ipltype bootcd, const uint8_t *addr, uint32_t length);
diff --git a/lib/libtpm/tcgbios_int.h b/lib/libtpm/tcgbios_int.h
index 420049f..bedc2f1 100644
--- a/lib/libtpm/tcgbios_int.h
+++ b/lib/libtpm/tcgbios_int.h
@@ -57,6 +57,8 @@
 #define EV_SEPARATOR             4
 #define EV_ACTION                5
 #define EV_EVENT_TAG             6
+#define EV_S_CRTM_CONTENTS       7
+#define EV_S_CRTM_VERSION        8
 #define EV_COMPACT_HASH         12
 #define EV_IPL                  13
 #define EV_IPL_PARTITION_DATA   14
diff --git a/lib/libtpm/tpm.code b/lib/libtpm/tpm.code
index 66250d5..34b9cbc 100644
--- a/lib/libtpm/tpm.code
+++ b/lib/libtpm/tpm.code
@@ -122,3 +122,13 @@ PRIM(tpm_X2d_is_X2d_working)
 	PUSH;
 	TOS.n = tpm_is_working();
 MIRP
+
+/************************************************/
+/* Have the S-CRTM measured                     */
+/* SLOF:   tpm-measure-scrtm  ( -- errcode )    */
+/* LIBTPM: errcode = tpm_measure_scrtm          */
+/************************************************/
+PRIM(tpm_X2d_measure_X2d_scrtm)
+	PUSH;
+	TOS.n = tpm_measure_scrtm();
+MIRP
diff --git a/lib/libtpm/tpm.in b/lib/libtpm/tpm.in
index f2cc81e..48c0d75 100644
--- a/lib/libtpm/tpm.in
+++ b/lib/libtpm/tpm.in
@@ -23,3 +23,4 @@ cod(tpm-add-bcv)
 cod(tpm-process-opcode)
 cod(tpm-get-state)
 cod(tpm-is-working)
+cod(tpm-measure-scrtm)
diff --git a/slof/fs/tpm/tpm-static.fs b/slof/fs/tpm/tpm-static.fs
index bc5138a..1bc37c9 100644
--- a/slof/fs/tpm/tpm-static.fs
+++ b/slof/fs/tpm/tpm-static.fs
@@ -33,6 +33,17 @@ false VALUE vtpm-debug?
     THEN
 ;
 
+: vtpm-measure-scrtm
+    vtpm-available? IF
+        tpm-measure-scrtm                                 ( -- errcode )
+        vtpm-debug? IF
+            ." VTPM: Error code from tpm-measure-scrtm: " . cr
+        ELSE
+            drop
+        THEN
+    THEN
+;
+
 : vtpm-unassert-pp
     vtpm-available? IF
         tpm-unassert-pp                                    ( -- errcode )
-- 
1.9.3
