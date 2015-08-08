Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59ABF1A075F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:14 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:11 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 73B3438C8026
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:55:08 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781t83P47251580
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:08 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t7NW012151
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:08 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 04/16] Add initial support for logging
Date: Fri,  7 Aug 2015 21:54:53 -0400
Message-Id: <1438998905-4085665-5-git-send-email-stefanb@linux.vnet.ibm.com>
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

This patch adds initial support for the logging that will be done
following measurements done by further code added to SLOF.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 board-qemu/slof/vtpm-sml.fs |  3 +++
 lib/libtpm/tcgbios.c        | 30 ++++++++++++++++++++++++++++++
 lib/libtpm/tcgbios.h        |  1 +
 lib/libtpm/tpm.code         | 11 +++++++++++
 lib/libtpm/tpm.in           |  1 +
 5 files changed, 46 insertions(+)

diff --git a/board-qemu/slof/vtpm-sml.fs b/board-qemu/slof/vtpm-sml.fs
index 72edac0..741a953 100644
--- a/board-qemu/slof/vtpm-sml.fs
+++ b/board-qemu/slof/vtpm-sml.fs
@@ -25,6 +25,9 @@ LOG-SIZE alloc-mem to log-base
 \ create /ibm,vtpm
 s" ibm,vtpm" 2dup device-name device-type
 
+\ convey logbase and size to the C driver
+log-base LOG-SIZE tpm-set-log-parameters
+
 : sml-get-allocated-size ( -- buffer-size)
     vtpm-debug? IF
         ." Call to sml-get-allocated-size; size = " LOG-SIZE . cr
diff --git a/lib/libtpm/tcgbios.c b/lib/libtpm/tcgbios.c
index efa4cdf..afbaede 100644
--- a/lib/libtpm/tcgbios.c
+++ b/lib/libtpm/tcgbios.c
@@ -77,10 +77,40 @@ static struct tpm_state tpm_state = {
 
 extern struct tpm_driver tpm_drivers[];
 
+static void *log_base;
+static uint32_t log_area_size;
+
 /********************************************************
   Extensions for TCG-enabled BIOS
  *******************************************************/
 
+void tpm_set_log_parameters(void *addr, unsigned int size)
+{
+	dprintf("Log is at 0x%llx; size is %u bytes\n",
+		(uint64_t)addr, size);
+	log_base = addr;
+	log_area_size = size;
+}
+
+static uint8_t *get_log_base_ptr(void)
+{
+	return log_base;
+}
+
+static uint32_t get_log_area_size(void)
+{
+	return log_area_size;
+}
+
+/* clear the OpenFirmware device tree log */
+static void reset_ofdt_log(void)
+{
+	uint8_t *log_area_start_address = get_log_base_ptr();
+
+	if (log_area_start_address)
+		memset(log_area_start_address, 0, get_log_area_size());
+}
+
 static bool is_tpm_present(void)
 {
 	bool rc = false;
diff --git a/lib/libtpm/tcgbios.h b/lib/libtpm/tcgbios.h
index c4c462e..9b51826 100644
--- a/lib/libtpm/tcgbios.h
+++ b/lib/libtpm/tcgbios.h
@@ -17,5 +17,6 @@
 
 uint32_t tpm_start(void);
 uint32_t tpm_unassert_pp(void);
+void tpm_set_log_parameters(void *address, unsigned int size);
 
 #endif /* TCGBIOS_H */
diff --git a/lib/libtpm/tpm.code b/lib/libtpm/tpm.code
index 567b384..a6b66a8 100644
--- a/lib/libtpm/tpm.code
+++ b/lib/libtpm/tpm.code
@@ -35,3 +35,14 @@ PRIM(tpm_X2d_unassert_X2d_pp)
 	PUSH;
 	TOS.n = tpm_unassert_pp();
 MIRP
+
+/*************************************************************/
+/* Convey log address and size                               */
+/* SLOF:   tpm-set-log-parameters  ( addr size -- )          */
+/* LIBTPM: tpm_set_log_parameters(void *addr, uint64_t size) */
+/*************************************************************/
+PRIM(tpm_X2d_set_X2d_log_X2d_parameters)
+	int size = TOS.u; POP;
+	void *addr = TOS.a; POP;
+	tpm_set_log_parameters(addr, size);
+MIRP
diff --git a/lib/libtpm/tpm.in b/lib/libtpm/tpm.in
index 266439e..a2f7cb9 100644
--- a/lib/libtpm/tpm.in
+++ b/lib/libtpm/tpm.in
@@ -15,3 +15,4 @@
 
 cod(tpm-start)
 cod(tpm-unassert-pp)
+cod(tpm-set-log-parameters)
-- 
1.9.3
