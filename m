Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B26F31A045F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:13 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:11 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B0CED38C8039
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:55:08 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781t8M362980266
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:08 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t8Jq012162
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:08 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 05/16] Extend internal firmware API
Date: Fri,  7 Aug 2015 21:54:54 -0400
Message-Id: <1438998905-4085665-6-git-send-email-stefanb@linux.vnet.ibm.com>
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

Extend the internal API of the TPM firmware support with additional
functions for hashing data, extending the TPM's platform configuration
registers with a hash, and appending to the log that is recording
what was hashed.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 lib/libtpm/tcgbios.c     | 276 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/libtpm/tcgbios_int.h |   1 +
 2 files changed, 277 insertions(+)

diff --git a/lib/libtpm/tcgbios.c b/lib/libtpm/tcgbios.c
index afbaede..072ed4d 100644
--- a/lib/libtpm/tcgbios.c
+++ b/lib/libtpm/tcgbios.c
@@ -24,6 +24,9 @@
 #include "tcgbios.h"
 #include "tcgbios_int.h"
 #include "stdio.h"
+#include "sha1.h"
+#include "stddef.h"
+#include "helpers.h"
 
 #define DEBUG 0
 #define dprintf(_x ...) do { \
@@ -79,6 +82,8 @@ extern struct tpm_driver tpm_drivers[];
 
 static void *log_base;
 static uint32_t log_area_size;
+/* next log entry goes here */
+static void *log_area_address_next;
 
 /********************************************************
   Extensions for TCG-enabled BIOS
@@ -89,6 +94,7 @@ void tpm_set_log_parameters(void *addr, unsigned int size)
 	dprintf("Log is at 0x%llx; size is %u bytes\n",
 		(uint64_t)addr, size);
 	log_base = addr;
+	log_area_address_next = addr;
 	log_area_size = size;
 }
 
@@ -399,3 +405,273 @@ err_exit:
 		return rc;
 	return TCGBIOS_COMMAND_ERROR;
 }
+
+static void set_log_area_address_next(void *next)
+{
+	log_area_address_next = next;
+}
+
+static void *get_log_area_address_next(void)
+{
+	return log_area_address_next;
+}
+
+static uint32_t tpm_sha1_calc(const uint8_t *data, uint32_t length,
+			      uint8_t *hash)
+{
+	uint32_t rc;
+	uint32_t returnCode;
+	struct tpm_res_sha1start start;
+	struct tpm_res_sha1complete complete;
+	uint32_t blocks = length / 64;
+	uint32_t rest = length & 0x3f;
+	uint32_t numbytes, numbytes_no;
+	uint32_t offset = 0;
+
+	rc = build_and_send_cmd(TPM_ORD_SHA1Start,
+				NULL, 0,
+				(uint8_t *)&start, sizeof(start),
+				&returnCode, TPM_DURATION_TYPE_SHORT);
+
+	if (rc || returnCode)
+		goto err_exit;
+
+	while (blocks > 0) {
+
+		numbytes = be32_to_cpu(start.max_num_bytes);
+		if (numbytes > blocks * 64)
+			 numbytes = blocks * 64;
+
+		numbytes_no = cpu_to_be32(numbytes);
+
+		rc = build_and_send_cmd_od(TPM_ORD_SHA1Update,
+					   (uint8_t *)&numbytes_no,
+					   sizeof(numbytes_no),
+					   NULL, 0, &returnCode,
+					   &data[offset], numbytes,
+					   TPM_DURATION_TYPE_SHORT);
+
+		if (rc || returnCode)
+			goto err_exit;
+
+		offset += numbytes;
+		blocks -= (numbytes / 64);
+	}
+
+	numbytes_no = cpu_to_be32(rest);
+
+	rc = build_and_send_cmd_od(TPM_ORD_SHA1Complete,
+				  (uint8_t *)&numbytes_no, sizeof(numbytes_no),
+				  (uint8_t *)&complete, sizeof(complete),
+				  &returnCode,
+				  &data[offset], rest,
+				  TPM_DURATION_TYPE_SHORT);
+
+	if (rc || returnCode)
+		goto err_exit;
+
+	memcpy(hash, complete.hash, sizeof(complete.hash));
+
+	return 0;
+
+err_exit:
+	dprintf("TPM SHA1 malfunctioning.\n");
+
+	tpm_state.tpm_working = 0;
+	if (rc)
+		return rc;
+	return TCGBIOS_COMMAND_ERROR;
+}
+
+static uint32_t sha1_calc(const uint8_t *data, uint32_t length, uint8_t *hash)
+{
+	if (tpm_state.tpm_driver_to_use &&
+	    length < tpm_state.tpm_driver_to_use->sha1threshold)
+		return tpm_sha1_calc(data, length, hash);
+
+	return sha1(data, length, hash);
+}
+
+/*
+ * Extend the ACPI log with the given entry by copying the
+ * entry data into the log.
+ *
+ * @pcpes: Pointer to the structure to be copied into the log
+ * @event: The event to be appended to 'pcpes'
+ * @event_length: The length of the event
+ *
+ * Output:
+ *  lower 16 bits of return code contain entry number
+ *  if entry number is '0', then upper 16 bits contain error code.
+ */
+static uint32_t tpm_extend_ofdt_log(struct pcpes *pcpes,
+				    const char *event, uint32_t event_length)
+{
+	uint32_t size;
+	uint32_t log_area_size = get_log_area_size();
+	uint8_t *log_area_start_address = get_log_base_ptr();
+	uint8_t *log_area_address_next = get_log_area_address_next();
+
+	dprintf("LASA_BASE = %p, LASA_NEXT = %p\n",
+		log_area_start_address, log_area_address_next);
+
+	if (!log_area_address_next || log_area_size == 0)
+		return TCGBIOS_LOGOVERFLOW;
+
+	size = offset_of(struct pcpes, event) + event_length;
+
+	if ((log_area_address_next + size - log_area_start_address) >
+	     log_area_size) {
+		dprintf("LOG OVERFLOW: size = %d\n", size);
+		return TCGBIOS_LOGOVERFLOW;
+	}
+
+	pcpes->eventdatasize = event_length;
+
+	memcpy(log_area_address_next, pcpes, offset_of(struct pcpes, event));
+	memcpy(log_area_address_next + offset_of(struct pcpes, event),
+	       event, event_length);
+
+	set_log_area_address_next(log_area_address_next + size);
+
+	return 0;
+}
+
+static uint32_t is_preboot_if_shutdown(void)
+{
+	return tpm_state.if_shutdown;
+}
+
+static uint32_t shutdown_preboot_interface(void)
+{
+	uint32_t rc = 0;
+
+	if (!is_preboot_if_shutdown()) {
+		tpm_state.if_shutdown = 1;
+	} else {
+		rc = TCGBIOS_INTERFACE_SHUTDOWN;
+	}
+
+	return rc;
+}
+
+static void tpm_shutdown(void)
+{
+	reset_ofdt_log();
+	shutdown_preboot_interface();
+}
+
+/*
+ * Pass a TPM command through to the TPM
+ *
+ * @req: request buffer to send
+ * @reqlen: request buffer length
+ * @to_t: timeout type
+ * @rsp: response buffer
+ * @rsplen: size of response buffer in input
+ *          on output the number of bytes used in the buffer
+ *
+ * Returns an error code or 0 for successful sending of command
+ * and reception of response.
+ */
+static bool pass_through_to_tpm(unsigned char *req,
+				uint32_t reqlen,
+				enum tpmDurationType to_t,
+				unsigned char *rsp,
+				uint32_t *rsplen)
+{
+	uint8_t locty = 0;
+	struct iovec iovec[2] = {{ 0 }};
+
+	if (!has_working_tpm())
+	       return TCGBIOS_FATAL_COM_ERROR;
+
+	iovec[0].data = req;
+	iovec[0].length = reqlen;
+
+	return transmit(locty, iovec, rsp, rsplen, to_t);
+}
+
+/*
+ * Extend a PCR of the TPM with the given hash
+ *
+ * @hash: sha1 hash (20 bytes) to extend PCR with
+ * @pcrindex: the PCR to extend [ 0..23 ]
+ */
+static uint32_t tpm_extend(uint8_t *hash, uint32_t pcrindex)
+{
+	struct tpm_req_extend req = {
+		.tag	  = cpu_to_be16(TPM_TAG_RQU_CMD),
+		.totlen   = cpu_to_be32(sizeof(req)),
+		.ordinal  = cpu_to_be32(TPM_ORD_Extend),
+		.pcrindex = cpu_to_be32(pcrindex),
+	};
+	struct tpm_rsp_extend rsp;
+	uint32_t rsplen = sizeof(rsp);
+	uint32_t rc;
+
+	memcpy(req.digest, hash, sizeof(req.digest));
+
+	rc = pass_through_to_tpm((unsigned char *)&req, sizeof(req),
+				 TPM_DURATION_TYPE_SHORT,
+				 (unsigned char *)&rsp, &rsplen);
+	if (!rc) {
+		if (rsplen != sizeof(rsp)) {
+			dprintf("TPM_Extend response has unexpected size: %u\n",
+				rsplen);
+			rc = TCGBIOS_FATAL_COM_ERROR;
+		}
+	}
+
+	if (rc)
+		tpm_shutdown();
+
+	return rc;
+}
+
+/*
+ * Hash then given input data and append the hash to the log
+ *
+ * @hashdata: the data to hash
+ * @hashdatalen: the size of the data to hash
+ * @pcpes: the 'pcpes' to append to the log; the hash will be written into this
+ *         structure
+ * @event: the event to append to the pcpes
+ * @event_length: the lenth of the event array
+ */
+static uint32_t hash_log_event(const void *hashdata,
+			       uint32_t hashdatalen,
+			       struct pcpes *pcpes,
+			       const char *event, uint32_t event_length)
+{
+	uint32_t rc;
+
+	if (is_preboot_if_shutdown())
+		return TCGBIOS_INTERFACE_SHUTDOWN;
+
+	if (pcpes->pcrindex >= 24)
+		return TCGBIOS_INVALID_INPUT_PARA;
+
+	if (hashdata) {
+		rc = sha1_calc(hashdata, hashdatalen, pcpes->digest);
+		if (rc)
+			return rc;
+	}
+
+	return tpm_extend_ofdt_log(pcpes, event, event_length);
+}
+
+static uint32_t hash_log_extend_event(const void *hashdata,
+				      uint32_t hashdatalen,
+				      struct pcpes *pcpes,
+				      const char *event, uint32_t event_length,
+				      uint32_t pcrindex)
+{
+	uint32_t rc = 0;
+
+	rc = hash_log_event(hashdata, hashdatalen, pcpes, event, event_length);
+	if (rc)
+		return rc;
+
+	return tpm_extend(pcpes->digest, pcrindex);
+}
diff --git a/lib/libtpm/tcgbios_int.h b/lib/libtpm/tcgbios_int.h
index c8caf3b..888186c 100644
--- a/lib/libtpm/tcgbios_int.h
+++ b/lib/libtpm/tcgbios_int.h
@@ -46,6 +46,7 @@
 #define TPM_ST_DEACTIVATED               0x3
 
 #define TPM_TAG_RQU_CMD                  0x00c1
+#define TPM_TAG_RSP_CMD                  0x00c4
 
 /* TPM command error codes */
 #define TPM_INVALID_POSTINIT             0x26
-- 
1.9.3
