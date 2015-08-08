Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA6E51A0495
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:13 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:11 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1574B38C804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:55:09 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781t96947251586
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:09 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t8tA012191
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:08 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 07/16] Perform some initial measurements
Date: Fri,  7 Aug 2015 21:54:56 -0400
Message-Id: <1438998905-4085665-8-git-send-email-stefanb@linux.vnet.ibm.com>
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

This patch puts an 'event' separator into the log that can
then be seen in Linux's /sys/kernel/security/tpm0/ascii_bios_measurements.
More low-level C functions are added for measuring and logging of disk
related data, along with their FORTH-level counterparts. These functions
will be called in subsequent patches.

Logging follows the specifications found on the following page:

http://www.trustedcomputinggroup.org/resources/pc_client_work_group_specific_implementation_specification_for_conventional_bios

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 board-qemu/slof/OF.fs     |   1 +
 lib/libtpm/tcgbios.c      | 201 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/libtpm/tcgbios.h      |   9 +++
 lib/libtpm/tpm.code       |  34 ++++++++
 lib/libtpm/tpm.in         |   3 +
 slof/fs/tpm/tpm-static.fs |  11 +++
 6 files changed, 259 insertions(+)

diff --git a/board-qemu/slof/OF.fs b/board-qemu/slof/OF.fs
index bd9495e..1306371 100644
--- a/board-qemu/slof/OF.fs
+++ b/board-qemu/slof/OF.fs
@@ -304,6 +304,7 @@ cr
 #include "copyright-oss.fs"
 cr cr
 
+vtpm-add-event-separators
 vtpm-unassert-pp
 
 \ this CATCH is to ensure the code bellow always executes:  boot may ABORT!
diff --git a/lib/libtpm/tcgbios.c b/lib/libtpm/tcgbios.c
index e86cfc2..2f5b048 100644
--- a/lib/libtpm/tcgbios.c
+++ b/lib/libtpm/tcgbios.c
@@ -66,6 +66,8 @@ static const uint8_t GetCapability_Durations[] = {
 	0x00, 0x00, 0x01, 0x20
 };
 
+static uint8_t evt_separator[] = {0xff,0xff,0xff,0xff};
+
 struct tpm_state {
 	uint8_t	  tpm_probed:1;
 	uint8_t   tpm_found:1;
@@ -690,3 +692,202 @@ static uint32_t hash_log_extend_event(const void *hashdata,
 
 	return tpm_extend(pcpes->digest, pcrindex);
 }
+
+/*
+ * Add a measurement to the log;
+ *
+ * Input parameters:
+ *  @pcrindex : PCR to extend
+ *  @event_type : type of event
+ *  @info : pointer to info (i.e., string) to be added to the log as-is
+ *  @info_length: length of the info
+ *  @data : pointer to data to be hashed
+ *  @data_length: length of the data
+ *
+ */
+static uint32_t tpm_add_measurement_to_log(uint32_t pcrindex,
+					   uint32_t eventtype,
+					   const char *info,
+					   uint32_t infolen,
+					   const uint8_t *data,
+					   uint32_t datalen)
+{
+	struct pcpes pcpes;
+
+	pcpes.pcrindex	= pcrindex;
+	pcpes.eventtype = eventtype;
+	memset(&pcpes.digest, 0, sizeof(pcpes.digest));
+
+	return hash_log_extend_event(data, datalen, &pcpes,
+				     info, infolen, pcrindex);
+}
+
+/*
+ * Add a measurement to the list of measurements
+ * pcrindex   : PCR to be extended
+ * event_type : type of event
+ * string     : string describing the event; used if event_type is EV_ACTION
+ */
+static uint32_t tpm_add_measurement(uint32_t pcrindex,
+				    uint16_t event_type,
+				    const char *string)
+{
+	uint32_t rc;
+	uint32_t len;
+
+	switch (event_type) {
+	case EV_SEPARATOR:
+		len = sizeof(evt_separator);
+		rc = tpm_add_measurement_to_log(pcrindex, event_type,
+			NULL, 0,
+			(uint8_t *)evt_separator, len);
+		break;
+
+	case EV_ACTION:
+		rc = tpm_add_measurement_to_log(pcrindex, event_type,
+			string, strlen(string),
+			(uint8_t *)string, strlen(string));
+		break;
+
+	default:
+		rc = TCGBIOS_INVALID_INPUT_PARA;
+	}
+
+	return rc;
+}
+
+/*
+ * Add event separators for PCRs 0 to 7
+ */
+uint32_t tpm_add_event_separators(void)
+{
+	uint32_t rc;
+	uint32_t pcrindex = 0;
+
+	if (!has_working_tpm())
+		return TCGBIOS_GENERAL_ERROR;
+
+	while (pcrindex <= 7) {
+		rc = tpm_add_measurement(pcrindex, EV_SEPARATOR, NULL);
+		if (rc)
+			break;
+		pcrindex ++;
+	}
+
+	return rc;
+}
+
+/*
+ * Add a measurement regarding the boot device (CDRom, Floppy, HDD) to
+ * the list of measurements.
+ */
+static uint32_t tpm_add_bootdevice(uint32_t bootcd, uint32_t bootdrv)
+{
+	const char *string;
+
+	dprintf("add bootdevice: bootcd = %d, bootdrv = 0x%x\n", bootcd, bootdrv);
+
+	if (!has_working_tpm())
+		return TCGBIOS_GENERAL_ERROR;
+
+	switch (bootcd) {
+	case 0:
+		switch (bootdrv) {
+		case 0:
+			string = "Booting BCV device 00h (Floppy)";
+			break;
+
+		case 0x80:
+			string = "Booting BCV device 80h (HDD)";
+			break;
+
+		default:
+			string = "Booting unknown device";
+			break;
+		}
+		break;
+
+	default:
+		string = "Booting from CD ROM device";
+	}
+
+	return tpm_add_measurement_to_log(4, EV_ACTION,
+					  string, strlen(string),
+					  (uint8_t *)string, strlen(string));
+}
+
+/*
+ * Add a measurement to the log. Creates two log entries
+ *
+ * Input parameter:
+ *  bootcd : 0: MBR of hdd, 1: boot image, 2: boot catalog of El Torito
+ *  addr   : address where the IP data are located
+ *  length : IP data length in bytes
+ */
+uint32_t tpm_ipl(enum ipltype bootcd, const uint8_t *addr, uint32_t length)
+{
+	uint32_t rc;
+	const char *string;
+
+	dprintf("tpm_ipl: bootcd = %d, addr = %p, length = 0x%x\n",
+		bootcd, addr, length);
+
+	if (!has_working_tpm())
+		return TCGBIOS_GENERAL_ERROR;
+
+	switch (bootcd) {
+	case IPL_EL_TORITO_1:
+		/* specs: see section 'El Torito' */
+		string = "EL TORITO IPL";
+		rc = tpm_add_measurement_to_log(4, EV_IPL,
+						string, strlen(string),
+						addr, length);
+	break;
+
+	case IPL_EL_TORITO_2:
+		/* specs: see section 'El Torito' */
+		string = "BOOT CATALOG";
+		rc = tpm_add_measurement_to_log(5, EV_IPL_PARTITION_DATA,
+						string, strlen(string),
+						addr, length);
+	break;
+
+	default:
+		/*
+		 * equivalent to:
+		 * dd if=/dev/hda ibs=1 count=440 | sha1sum
+		 */
+		string = "MBR";
+		rc = tpm_add_measurement_to_log(4, EV_IPL,
+						string, strlen(string),
+						addr, 0x1b8);
+
+		if (rc)
+			break;
+
+		/*
+		 * equivalent to:
+		 * dd if=/dev/hda ibs=1 count=72 skip=440 | sha1sum
+		 */
+		string = "MBR PARTITION TABLE";
+		rc = tpm_add_measurement_to_log(5, EV_IPL_PARTITION_DATA,
+						string, strlen(string),
+						addr + 0x1b8, 0x48);
+	}
+
+	return rc;
+}
+
+uint32_t tpm_add_bcv(uint32_t bootdrv, const uint8_t *addr, uint32_t length)
+{
+	uint32_t rc;
+
+	if (!has_working_tpm())
+		return TCGBIOS_GENERAL_ERROR;
+
+	rc = tpm_add_bootdevice(0, bootdrv);
+	if (rc)
+		return rc;
+
+	return tpm_ipl(IPL_BCV, addr, length);
+}
diff --git a/lib/libtpm/tcgbios.h b/lib/libtpm/tcgbios.h
index b217dd1..9b43ce3 100644
--- a/lib/libtpm/tcgbios.h
+++ b/lib/libtpm/tcgbios.h
@@ -15,9 +15,18 @@
 
 #include <stdint.h>
 
+enum ipltype {
+    IPL_BCV = 0,
+    IPL_EL_TORITO_1,
+    IPL_EL_TORITO_2
+};
+
 uint32_t tpm_start(void);
 uint32_t tpm_unassert_pp(void);
 void tpm_set_log_parameters(void *address, unsigned int size);
 uint32_t tpm_get_logsize(void);
+uint32_t tpm_ipl(enum ipltype bootcd, const uint8_t *addr, uint32_t length);
+uint32_t tpm_add_bcv(uint32_t bootdrv, const uint8_t *addr, uint32_t length);
+uint32_t tpm_add_event_separators(void);
 
 #endif /* TCGBIOS_H */
diff --git a/lib/libtpm/tpm.code b/lib/libtpm/tpm.code
index b868ca3..de90717 100644
--- a/lib/libtpm/tpm.code
+++ b/lib/libtpm/tpm.code
@@ -56,3 +56,37 @@ PRIM(tpm_X2d_get_X2d_logsize)
 	PUSH;
 	TOS.n = tpm_get_logsize();
 MIRP
+
+/************************************************/
+/* Measure and log event separators             */
+/* SLOF:   tpm-add-event-separators  ( -- )     */
+/* LIBTPM: tpm_add_event_separators(void)       */
+/************************************************/
+PRIM(tpm_X2d_add_X2d_event_X2d_separators)
+	PUSH;
+	TOS.n = tpm_add_event_separators();
+MIRP
+
+/************************************************/
+/* Measure and log IPL                          */
+/* SLOF:   tpm-ipl  ( ipltype addr length -- )  */
+/* LIBTPM: tpm_ipl(void)                        */
+/************************************************/
+PRIM(tpm_X2d_ipl)
+	int length = TOS.u; POP;
+	void *addr = TOS.a; POP;
+	int bootcd = TOS.u;
+	TOS.n = tpm_ipl(bootcd, addr, length);
+MIRP
+
+/****************************************************/
+/* Measure and log bcv IPL                          */
+/* SLOF:   tpm-add-bcv  ( bootdrv addr length -- )  */
+/* LIBTPM: tpm_add_bcv(void)                        */
+/****************************************************/
+PRIM(tpm_X2d_add_X2d_bcv)
+	int length = TOS.u; POP;
+	void *addr = TOS.a; POP;
+	int bootdrv = TOS.u;
+	TOS.n = tpm_add_bcv(bootdrv, addr, length);
+MIRP
diff --git a/lib/libtpm/tpm.in b/lib/libtpm/tpm.in
index 32d675f..06b0672 100644
--- a/lib/libtpm/tpm.in
+++ b/lib/libtpm/tpm.in
@@ -17,3 +17,6 @@ cod(tpm-start)
 cod(tpm-unassert-pp)
 cod(tpm-set-log-parameters)
 cod(tpm-get-logsize)
+cod(tpm-add-event-separators)
+cod(tpm-ipl)
+cod(tpm-add-bcv)
diff --git a/slof/fs/tpm/tpm-static.fs b/slof/fs/tpm/tpm-static.fs
index 11e4ad5..d425693 100644
--- a/slof/fs/tpm/tpm-static.fs
+++ b/slof/fs/tpm/tpm-static.fs
@@ -22,6 +22,17 @@ false VALUE vtpm-debug?
     THEN
 ;
 
+: vtpm-add-event-separators
+    vtpm-available? IF
+        tpm-add-event-separators                          ( -- errcode )
+        vtpm-debug? IF
+            ." VTPM: Error code from tpm-add-event-separators: " . cr
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
