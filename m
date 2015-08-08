Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 168A21A0522
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:13 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:11 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C9FE638C8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:55:08 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781t8Fj45219850
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:08 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t8PM012177
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:08 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 06/16] Return value of actual log in sml-get-handover-size
Date: Fri,  7 Aug 2015 21:54:55 -0400
Message-Id: <1438998905-4085665-7-git-send-email-stefanb@linux.vnet.ibm.com>
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

With the functions for calculating the actual size of the log in place,
use them to determine the exact size of the log that the firmware
API call sml-get-handover-size now returns.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 board-qemu/slof/vtpm-sml.fs |  4 ++--
 lib/libtpm/tcgbios.c        | 15 +++++++++++++++
 lib/libtpm/tcgbios.h        |  1 +
 lib/libtpm/tpm.code         | 10 ++++++++++
 lib/libtpm/tpm.in           |  1 +
 5 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/board-qemu/slof/vtpm-sml.fs b/board-qemu/slof/vtpm-sml.fs
index 741a953..28c30f1 100644
--- a/board-qemu/slof/vtpm-sml.fs
+++ b/board-qemu/slof/vtpm-sml.fs
@@ -37,9 +37,9 @@ log-base LOG-SIZE tpm-set-log-parameters
 
 : sml-get-handover-size ( -- size )
     vtpm-debug? IF
-        ." Call to sml-get-handover-size; size = " LOG-SIZE . cr
+        ." Call to sml-get-handover-size; size = " tpm-get-logsize . cr
     THEN
-    LOG-SIZE
+    tpm-get-logsize
 ;
 
 : sml-handover ( dest size -- )
diff --git a/lib/libtpm/tcgbios.c b/lib/libtpm/tcgbios.c
index 072ed4d..e86cfc2 100644
--- a/lib/libtpm/tcgbios.c
+++ b/lib/libtpm/tcgbios.c
@@ -416,6 +416,21 @@ static void *get_log_area_address_next(void)
 	return log_area_address_next;
 }
 
+uint32_t tpm_get_logsize(void)
+{
+	uint8_t *log_area_start_address = get_log_base_ptr();
+	uint8_t *log_area_address_next = get_log_area_address_next();
+	uint32_t logsize;
+
+	if (log_area_address_next) {
+		logsize = log_area_address_next - log_area_start_address;
+		dprintf("log size: %u\n", logsize);
+		return logsize;
+	}
+
+	return 0;
+}
+
 static uint32_t tpm_sha1_calc(const uint8_t *data, uint32_t length,
 			      uint8_t *hash)
 {
diff --git a/lib/libtpm/tcgbios.h b/lib/libtpm/tcgbios.h
index 9b51826..b217dd1 100644
--- a/lib/libtpm/tcgbios.h
+++ b/lib/libtpm/tcgbios.h
@@ -18,5 +18,6 @@
 uint32_t tpm_start(void);
 uint32_t tpm_unassert_pp(void);
 void tpm_set_log_parameters(void *address, unsigned int size);
+uint32_t tpm_get_logsize(void);
 
 #endif /* TCGBIOS_H */
diff --git a/lib/libtpm/tpm.code b/lib/libtpm/tpm.code
index a6b66a8..b868ca3 100644
--- a/lib/libtpm/tpm.code
+++ b/lib/libtpm/tpm.code
@@ -46,3 +46,13 @@ PRIM(tpm_X2d_set_X2d_log_X2d_parameters)
 	void *addr = TOS.a; POP;
 	tpm_set_log_parameters(addr, size);
 MIRP
+
+/************************************************/
+/* Get the size of the log                      */
+/* SLOF:   tpm-get-logsize         ( -- size )  */
+/* LIBTPM: logsize = tpm_get_logsize(void)      */
+/************************************************/
+PRIM(tpm_X2d_get_X2d_logsize)
+	PUSH;
+	TOS.n = tpm_get_logsize();
+MIRP
diff --git a/lib/libtpm/tpm.in b/lib/libtpm/tpm.in
index a2f7cb9..32d675f 100644
--- a/lib/libtpm/tpm.in
+++ b/lib/libtpm/tpm.in
@@ -16,3 +16,4 @@
 cod(tpm-start)
 cod(tpm-unassert-pp)
 cod(tpm-set-log-parameters)
+cod(tpm-get-logsize)
-- 
1.9.3
