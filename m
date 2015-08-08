Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C0111A03B5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:14 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:11 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A3C5E6E801D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:46:54 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781t94K47382728
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:09 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t8IX012204
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:08 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 08/16] Add support for controlling the states of the TPM
Date: Fri,  7 Aug 2015 21:54:57 -0400
Message-Id: <1438998905-4085665-9-git-send-email-stefanb@linux.vnet.ibm.com>
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

This patch adds support for controlling the various states of
the TPM, such as enabling and disabling the TPM, deactivating
and activating it, and clearing ownership.

The TPM menu implementation will call these functions by
calling tpm_process_opcode with an opcode indicating as to
how the state of the TPM is to be changed.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 lib/libtpm/tcgbios.c     | 459 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/libtpm/tcgbios.h     |   2 +
 lib/libtpm/tcgbios_int.h |  34 ++++
 lib/libtpm/tpm.code      |  12 ++
 lib/libtpm/tpm.in        |   1 +
 5 files changed, 508 insertions(+)

diff --git a/lib/libtpm/tcgbios.c b/lib/libtpm/tcgbios.c
index 2f5b048..cabd980 100644
--- a/lib/libtpm/tcgbios.c
+++ b/lib/libtpm/tcgbios.c
@@ -51,6 +51,11 @@ static const uint8_t GetCapability_Permanent_Flags[] = {
 	0x00, 0x00, 0x01, 0x08
 };
 
+static const uint8_t GetCapability_STClear_Flags[] = {
+	0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x04,
+	0x00, 0x00, 0x01, 0x09
+};
+
 static const uint8_t GetCapability_OwnerAuth[] = {
 	0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x04,
 	0x00, 0x00, 0x01, 0x11
@@ -82,6 +87,10 @@ static struct tpm_state tpm_state = {
 
 extern struct tpm_driver tpm_drivers[];
 
+typedef struct {
+	uint8_t  op;
+} tpm_bios_cfg;
+
 static void *log_base;
 static uint32_t log_area_size;
 /* next log entry goes here */
@@ -891,3 +900,453 @@ uint32_t tpm_add_bcv(uint32_t bootdrv, const uint8_t *addr, uint32_t length)
 
 	return tpm_ipl(IPL_BCV, addr, length);
 }
+
+static uint32_t read_stclear_flags(char *buf, int buf_len)
+{
+	uint32_t rc;
+	uint32_t returnCode;
+	struct tpm_res_getcap_stclear_flags stcf;
+
+	memset(buf, 0, buf_len);
+
+	rc = build_and_send_cmd(TPM_ORD_GetCapability,
+				GetCapability_STClear_Flags,
+				sizeof(GetCapability_STClear_Flags),
+				(uint8_t *)&stcf, sizeof(stcf),
+				&returnCode, TPM_DURATION_TYPE_SHORT);
+
+	dprintf("Return code from TPM_GetCapability() = 0x%08x\n",
+		returnCode);
+
+	if (rc || returnCode)
+		goto err_exit;
+
+	memcpy(buf, &stcf.stclear_flags, buf_len);
+
+	return 0;
+
+err_exit:
+	dprintf("TPM malfunctioning (line %d).\n", __LINE__);
+
+	tpm_state.tpm_working = 0;
+	if (rc)
+		return rc;
+	return TCGBIOS_COMMAND_ERROR;
+}
+
+static uint32_t assert_physical_presence(bool verbose)
+{
+	uint32_t rc = 0;
+	uint32_t returnCode;
+	struct tpm_stclear_flags stcf;
+
+	rc = read_stclear_flags((char *)&stcf, sizeof(stcf));
+	if (rc) {
+		dprintf("Error reading STClear flags: 0x%08x\n", rc);
+		return rc;
+	}
+
+	if (stcf.flags[STCLEAR_FLAG_IDX_PHYSICAL_PRESENCE])
+		/* physical presence already asserted */
+		return 0;
+
+	rc = build_and_send_cmd(TPM_ORD_PhysicalPresence,
+				PhysicalPresence_CMD_ENABLE,
+				sizeof(PhysicalPresence_CMD_ENABLE),
+				NULL, 0, &returnCode,
+				TPM_DURATION_TYPE_SHORT);
+
+	dprintf("Return code from TSC_PhysicalPresence(CMD_ENABLE) = 0x%08x\n",
+		returnCode);
+
+	if (rc || returnCode) {
+		if (verbose)
+			printf("Error: Could not enable physical presence.\n\n");
+		goto err_exit;
+	}
+
+	rc = build_and_send_cmd(TPM_ORD_PhysicalPresence,
+				PhysicalPresence_PRESENT,
+				sizeof(PhysicalPresence_PRESENT),
+				NULL, 0, &returnCode,
+				TPM_DURATION_TYPE_SHORT);
+
+	dprintf("Return code from TSC_PhysicalPresence(PRESENT) = 0x%08x\n",
+		returnCode);
+
+	if (rc || returnCode) {
+		if (verbose)
+			printf("Error: Could not set presence flag.\n\n");
+		goto err_exit;
+	}
+
+	return 0;
+
+err_exit:
+	dprintf("TPM malfunctioning (line %d).\n", __LINE__);
+
+	tpm_state.tpm_working = 0;
+	if (rc)
+		return rc;
+	return TCGBIOS_COMMAND_ERROR;
+}
+
+static uint32_t read_permanent_flags(char *buf, int buf_len)
+{
+	uint32_t rc;
+	uint32_t returnCode;
+	struct tpm_res_getcap_perm_flags pf;
+
+	memset(buf, 0, buf_len);
+
+	rc = build_and_send_cmd(TPM_ORD_GetCapability,
+				GetCapability_Permanent_Flags,
+				sizeof(GetCapability_Permanent_Flags),
+				(uint8_t *)&pf, sizeof(pf),
+				&returnCode, TPM_DURATION_TYPE_SHORT);
+
+	dprintf("Return code from TPM_GetCapability() = 0x%08x\n",
+		returnCode);
+
+	if (rc || returnCode)
+		goto err_exit;
+
+	memcpy(buf, &pf.perm_flags, buf_len);
+
+	return 0;
+
+err_exit:
+	dprintf("TPM malfunctioning (line %d).\n", __LINE__);
+
+	tpm_state.tpm_working = 0;
+	if (rc)
+		return rc;
+	return TCGBIOS_COMMAND_ERROR;
+}
+
+static uint32_t read_has_owner(bool *has_owner)
+{
+	uint32_t rc;
+	uint32_t returnCode;
+	struct tpm_res_getcap_ownerauth oauth;
+
+	rc = build_and_send_cmd(TPM_ORD_GetCapability,
+				GetCapability_OwnerAuth,
+				sizeof(GetCapability_OwnerAuth),
+				(uint8_t *)&oauth, sizeof(oauth),
+				&returnCode, TPM_DURATION_TYPE_SHORT);
+
+	dprintf("Return code from TPM_GetCapability() = 0x%08x\n",
+		returnCode);
+
+	if (rc || returnCode)
+		goto err_exit;
+
+	*has_owner = oauth.flag;
+
+	return 0;
+
+err_exit:
+	dprintf("TPM malfunctioning (line %d).\n", __LINE__);
+
+	tpm_state.tpm_working = 0;
+	if (rc)
+		return rc;
+	return TCGBIOS_COMMAND_ERROR;
+}
+
+static uint32_t enable_tpm(bool enable, uint32_t *returnCode, bool verbose)
+{
+	uint32_t rc;
+	struct tpm_permanent_flags pf;
+
+	rc = read_permanent_flags((char *)&pf, sizeof(pf));
+	if (rc)
+		return rc;
+
+	if (!!pf.flags[PERM_FLAG_IDX_DISABLE] == !enable)
+		return 0;
+
+	rc = assert_physical_presence(verbose);
+	if (rc) {
+		dprintf("Asserting physical presence failed.\n");
+		return rc;
+	}
+
+	rc = build_and_send_cmd(enable ? TPM_ORD_PhysicalEnable
+				       : TPM_ORD_PhysicalDisable,
+				NULL, 0, NULL, 0, returnCode,
+				TPM_DURATION_TYPE_SHORT);
+	if (enable) {
+		dprintf("Return code from TPM_PhysicalEnable = 0x%08x\n",
+			*returnCode);
+	} else {
+		dprintf("Return code from TPM_PhysicalDisable = 0x%08x\n",
+			*returnCode);
+	}
+
+	if (rc || *returnCode)
+		goto err_exit;
+
+	return 0;
+
+err_exit:
+	if (enable) {
+		dprintf("Enabling the TPM failed.\n");
+	} else {
+		dprintf("Disabling the TPM failed.\n");
+	}
+	dprintf("TPM malfunctioning (line %d).\n", __LINE__);
+
+	tpm_state.tpm_working = 0;
+	if (rc)
+		return rc;
+	return TCGBIOS_COMMAND_ERROR;
+}
+
+static uint32_t activate_tpm(bool activate, bool allow_reset,
+			     uint32_t *returnCode, bool verbose)
+{
+	uint32_t rc;
+	struct tpm_permanent_flags pf;
+
+	rc = read_permanent_flags((char *)&pf, sizeof(pf));
+	if (rc)
+		return rc;
+
+	if (!!pf.flags[PERM_FLAG_IDX_DEACTIVATED] == !activate)
+		return 0;
+
+	if (pf.flags[PERM_FLAG_IDX_DISABLE])
+		return 0;
+
+	rc = assert_physical_presence(verbose);
+	if (rc) {
+		dprintf("Asserting physical presence failed.\n");
+		return rc;
+	}
+
+	rc = build_and_send_cmd(TPM_ORD_PhysicalSetDeactivated,
+				activate ? CommandFlag_FALSE
+					 : CommandFlag_TRUE,
+				activate ? sizeof(CommandFlag_FALSE)
+					 : sizeof(CommandFlag_TRUE),
+				NULL, 0, returnCode,
+				TPM_DURATION_TYPE_SHORT);
+
+	dprintf("Return code from PhysicalSetDeactivated(%d) = 0x%08x\n",
+		activate ? 0 : 1, *returnCode);
+
+	if (rc || *returnCode)
+		goto err_exit;
+
+	if (activate && allow_reset) {
+		if (verbose) {
+			printf("Requiring a reboot to activate the TPM.\n");
+		}
+	}
+
+	return 0;
+
+err_exit:
+	dprintf("TPM malfunctioning (line %d).\n", __LINE__);
+
+	tpm_state.tpm_working = 0;
+	if (rc)
+		return rc;
+	return TCGBIOS_COMMAND_ERROR;
+}
+
+static uint32_t enable_activate(int allow_reset, uint32_t *returnCode,
+				bool verbose)
+{
+	uint32_t rc;
+
+	rc = enable_tpm(true, returnCode, verbose);
+	if (rc)
+		return rc;
+
+	rc = activate_tpm(true, allow_reset, returnCode, verbose);
+
+	return rc;
+}
+
+static uint32_t force_clear(bool enable_activate_before,
+			    bool enable_activate_after,
+			    uint32_t *returnCode, bool verbose)
+{
+	uint32_t rc;
+	bool has_owner;
+
+	rc = read_has_owner(&has_owner);
+	if (rc)
+		return rc;
+	if (!has_owner) {
+		if (verbose)
+			printf("TPM does not have an owner.\n");
+		return 0;
+	}
+
+	if (enable_activate_before) {
+		rc = enable_activate(0, returnCode, verbose);
+		if (rc) {
+			dprintf("Enabling/activating the TPM failed.\n");
+			return rc;
+		}
+	}
+
+	rc = assert_physical_presence(verbose);
+	if (rc) {
+		dprintf("Asserting physical presence failed.\n");
+		return rc;
+	}
+
+	rc = build_and_send_cmd(TPM_ORD_ForceClear,
+				NULL, 0, NULL, 0, returnCode,
+				TPM_DURATION_TYPE_SHORT);
+
+	dprintf("Return code from TPM_ForceClear() = 0x%08x\n",
+		*returnCode);
+
+	if (rc || *returnCode)
+		goto err_exit;
+
+	if (!enable_activate_after) {
+		if (verbose)
+			printf("Owner successfully cleared.\n"
+			       "You will need to enable/activate the TPM again.\n\n");
+		return 0;
+	}
+
+	enable_activate(true, returnCode, verbose);
+
+	return 0;
+
+err_exit:
+	dprintf("TPM malfunctioning (line %d).\n", __LINE__);
+
+	tpm_state.tpm_working = 0;
+	if (rc)
+		return rc;
+	return TCGBIOS_COMMAND_ERROR;
+}
+
+static uint32_t set_owner_install(bool allow, uint32_t *returnCode,
+				  bool verbose)
+{
+	uint32_t rc;
+	bool has_owner;
+	struct tpm_permanent_flags pf;
+
+	rc = read_has_owner(&has_owner);
+	if (rc)
+		return rc;
+	if (has_owner) {
+		if (verbose)
+			printf("Must first remove owner.\n");
+		return 0;
+	}
+
+	rc = read_permanent_flags((char *)&pf, sizeof(pf));
+	if (rc)
+		return rc;
+
+	if (pf.flags[PERM_FLAG_IDX_DISABLE]) {
+		if (verbose)
+			printf("TPM must first be enable.\n");
+		return 0;
+	}
+
+	rc = assert_physical_presence(verbose);
+	if (rc) {
+		dprintf("Asserting physical presence failed.\n");
+		return rc;
+	}
+
+	rc = build_and_send_cmd(TPM_ORD_SetOwnerInstall,
+				(allow) ? CommandFlag_TRUE :
+					  CommandFlag_FALSE,
+				sizeof(CommandFlag_TRUE),
+				NULL, 0, returnCode,
+				TPM_DURATION_TYPE_SHORT);
+
+	dprintf("Return code from TPM_SetOwnerInstall() = 0x%08x\n",
+		*returnCode);
+
+	if (rc || *returnCode)
+		goto err_exit;
+
+	if (verbose) {
+		if (allow)
+			printf("Installation of owner enabled.\n");
+		else
+			printf("Installation of owner disabled.\n");
+	}
+
+	return 0;
+
+err_exit:
+	dprintf("TPM malfunctioning (line %d).\n", __LINE__);
+	tpm_state.tpm_working = 0;
+	if (rc)
+		return rc;
+	return TCGBIOS_COMMAND_ERROR;
+}
+
+static uint32_t tpm_process_cfg(const tpm_bios_cfg *cfg, bool verbose,
+				uint32_t *returnCode)
+{
+	uint32_t rc = 0;
+
+	switch (cfg->op) {
+	case TPM_PPI_OP_NOOP: /* no-op */
+		break;
+
+	case TPM_PPI_OP_ENABLE:
+		rc = enable_tpm(true, returnCode, verbose);
+		break;
+
+	case TPM_PPI_OP_DISABLE:
+		rc = enable_tpm(false, returnCode, verbose);
+		break;
+
+	case TPM_PPI_OP_ACTIVATE:
+		rc = activate_tpm(true, true, returnCode, verbose);
+		break;
+
+	case TPM_PPI_OP_DEACTIVATE:
+		rc = activate_tpm(false, true, returnCode, verbose);
+		break;
+
+	case TPM_PPI_OP_CLEAR:
+		rc = force_clear(true, false, returnCode, verbose);
+		break;
+
+	case TPM_PPI_OP_SET_OWNERINSTALL_TRUE:
+		rc = set_owner_install(true, returnCode, verbose);
+		break;
+
+	case TPM_PPI_OP_SET_OWNERINSTALL_FALSE:
+		rc = set_owner_install(false, returnCode, verbose);
+		break;
+
+	default:
+		break;
+	}
+
+	if (rc)
+		printf("Op %d: An error occurred: 0x%x TPM return code: 0x%x\n",
+		       cfg->op, rc, *returnCode);
+
+	return rc;
+}
+
+uint32_t tpm_process_opcode(uint8_t op, bool verbose)
+{
+	uint32_t returnCode;
+	tpm_bios_cfg cfg = {
+		.op = op
+	};
+
+	return tpm_process_cfg(&cfg, verbose, &returnCode);
+}
diff --git a/lib/libtpm/tcgbios.h b/lib/libtpm/tcgbios.h
index 9b43ce3..e0a7045 100644
--- a/lib/libtpm/tcgbios.h
+++ b/lib/libtpm/tcgbios.h
@@ -14,6 +14,7 @@
 #define TCGBIOS_H
 
 #include <stdint.h>
+#include <stdbool.h>
 
 enum ipltype {
     IPL_BCV = 0,
@@ -28,5 +29,6 @@ uint32_t tpm_get_logsize(void);
 uint32_t tpm_ipl(enum ipltype bootcd, const uint8_t *addr, uint32_t length);
 uint32_t tpm_add_bcv(uint32_t bootdrv, const uint8_t *addr, uint32_t length);
 uint32_t tpm_add_event_separators(void);
+uint32_t tpm_process_opcode(uint8_t op, bool verbose);
 
 #endif /* TCGBIOS_H */
diff --git a/lib/libtpm/tcgbios_int.h b/lib/libtpm/tcgbios_int.h
index 888186c..420049f 100644
--- a/lib/libtpm/tcgbios_int.h
+++ b/lib/libtpm/tcgbios_int.h
@@ -14,6 +14,7 @@
 #define TCGBIOS_INT_H
 
 #include <stdint.h>
+#include <stdbool.h>
 
 #include "tpm_drivers.h"
 
@@ -138,6 +139,30 @@ struct tpm_res_getcap_perm_flags {
     struct tpm_permanent_flags perm_flags;
 } __attribute__((packed));
 
+struct tpm_req_getcap_stclear_flags {
+    TPM_REQ_HEADER
+    uint32_t  capArea;
+    uint32_t  subCapSize;
+    uint32_t  subCap;
+} __attribute__((packed));
+
+struct tpm_stclear_flags {
+    uint16_t tag;
+    uint8_t  flags[5];
+} __attribute__((packed));
+
+#define STCLEAR_FLAG_IDX_DEACTIVATED 0
+#define STCLEAR_FLAG_IDX_DISABLE_FORCE_CLEAR 1
+#define STCLEAR_FLAG_IDX_PHYSICAL_PRESENCE 2
+#define STCLEAR_FLAG_IDX_PHYSICAL_PRESENCE_LOCK 3
+#define STCLEAR_FLAG_IDX_GLOBAL_LOCK 4
+
+struct tpm_res_getcap_stclear_flags {
+    TPM_RSP_HEADER
+    uint32_t size;
+    struct tpm_stclear_flags stclear_flags;
+} __attribute__((packed));
+
 struct tpm_res_getcap_ownerauth {
     TPM_RSP_HEADER
     uint32_t    size;
@@ -160,4 +185,13 @@ struct tpm_res_sha1complete {
     uint8_t     hash[SHA1_BUFSIZE];
 } __attribute__((packed));
 
+#define TPM_PPI_OP_NOOP 0
+#define TPM_PPI_OP_ENABLE 1
+#define TPM_PPI_OP_DISABLE 2
+#define TPM_PPI_OP_ACTIVATE 3
+#define TPM_PPI_OP_DEACTIVATE 4
+#define TPM_PPI_OP_CLEAR 5
+#define TPM_PPI_OP_SET_OWNERINSTALL_TRUE 8
+#define TPM_PPI_OP_SET_OWNERINSTALL_FALSE 9
+
 #endif /* TCGBIOS_INT_H */
diff --git a/lib/libtpm/tpm.code b/lib/libtpm/tpm.code
index de90717..7728317 100644
--- a/lib/libtpm/tpm.code
+++ b/lib/libtpm/tpm.code
@@ -14,6 +14,7 @@
  */
 
 #include <tcgbios.h>
+#include <stdbool.h>
 
 
 /************************************************/
@@ -90,3 +91,14 @@ PRIM(tpm_X2d_add_X2d_bcv)
 	int bootdrv = TOS.u;
 	TOS.n = tpm_add_bcv(bootdrv, addr, length);
 MIRP
+
+/******************************************************/
+/* Process an opcode to change state of the TPM       */
+/* SLOF:   tpm-process-opcode  ( opcode verbose -- )  */
+/* LIBTPM: tpm_process_opcode(opcode, verbose)        */
+/******************************************************/
+PRIM(tpm_X2d_process_X2d_opcode)
+	int opcode = TOS.u; POP;
+	bool verbose = TOS.u;
+	TOS.n = tpm_process_opcode(opcode, verbose);
+MIRP
diff --git a/lib/libtpm/tpm.in b/lib/libtpm/tpm.in
index 06b0672..e5dbc25 100644
--- a/lib/libtpm/tpm.in
+++ b/lib/libtpm/tpm.in
@@ -20,3 +20,4 @@ cod(tpm-get-logsize)
 cod(tpm-add-event-separators)
 cod(tpm-ipl)
 cod(tpm-add-bcv)
+cod(tpm-process-opcode)
-- 
1.9.3
