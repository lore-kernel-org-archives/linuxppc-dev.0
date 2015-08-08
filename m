Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB1BD1A0509
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:13 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:11 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 6217DC90045
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:46:13 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781t73K64028674
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:07 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t7Gj012123
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:07 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 01/16] Add a TPM driver implementation
Date: Fri,  7 Aug 2015 21:54:50 -0400
Message-Id: <1438998905-4085665-2-git-send-email-stefanb@linux.vnet.ibm.com>
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

This patch adds a TPM driver for the CRQ interface as used by
the QEMU PAPR implementation.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/helpers.h        |   1 +
 lib/libtpm/Makefile      |  51 ++++++
 lib/libtpm/tpm_drivers.c | 456 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/libtpm/tpm_drivers.h |  93 ++++++++++
 slof/helpers.c           |   6 +
 5 files changed, 607 insertions(+)
 create mode 100644 lib/libtpm/Makefile
 create mode 100644 lib/libtpm/tpm_drivers.c
 create mode 100644 lib/libtpm/tpm_drivers.h

diff --git a/include/helpers.h b/include/helpers.h
index fb10534..9e6bdf8 100644
--- a/include/helpers.h
+++ b/include/helpers.h
@@ -33,6 +33,7 @@ extern long SLOF_pci_config_read16(long offset);
 extern void SLOF_pci_config_write32(long offset, long value);
 extern void SLOF_pci_config_write16(long offset, long value);
 extern void *SLOF_translate_my_address(void *addr);
+extern unsigned long SLOF_get_vtpm_unit(void);
 
 #define offset_of(type, member) ((long) &((type *)0)->member)
 #define container_of(ptr, type, member) ({                      \
diff --git a/lib/libtpm/Makefile b/lib/libtpm/Makefile
new file mode 100644
index 0000000..a174815
--- /dev/null
+++ b/lib/libtpm/Makefile
@@ -0,0 +1,51 @@
+# *****************************************************************************
+# * Copyright (c) 2015 IBM Corporation
+# * All rights reserved.
+# * This program and the accompanying materials
+# * are made available under the terms of the BSD License
+# * which accompanies this distribution, and is available at
+# * http://www.opensource.org/licenses/bsd-license.php
+# *
+# * Contributors:
+# *     IBM Corporation - initial implementation
+# ****************************************************************************/
+
+TOPCMNDIR ?= ../..
+
+ASFLAGS = $(FLAG) $(RELEASE) $(CPUARCHDEF) -Wa,-mregnames
+CPPFLAGS = -I../libc/include $(CPUARCHDEF) -I$(INCLBRDDIR) \
+	   -I$(INCLCMNDIR) -I$(INCLCMNDIR)/$(CPUARCH) -I$(SLOFCMNDIR)
+CPPFLAGS += -I../libhvcall
+
+LDFLAGS = -nostdlib
+
+TARGET = ../libtpm.a
+
+
+all: $(TARGET)
+
+SRCS = tpm_drivers.c
+
+OBJS = $(SRCS:%.c=%.o)
+
+$(TARGET): $(OBJS)
+	$(AR) -rc $@ $(OBJS)
+	$(RANLIB) $@
+
+clean:
+	$(RM) $(TARGET) $(OBJS)
+
+distclean: clean
+	$(RM) Makefile.dep
+
+
+# Rules for creating the dependency file:
+depend:
+	$(RM) Makefile.dep
+	$(MAKE) Makefile.dep
+
+Makefile.dep: Makefile
+	$(CC) -M $(CPPFLAGS) $(CFLAGS) $(SRCS) $(SRCSS) > Makefile.dep
+
+# Include dependency file if available:
+-include Makefile.dep
diff --git a/lib/libtpm/tpm_drivers.c b/lib/libtpm/tpm_drivers.c
new file mode 100644
index 0000000..850da8c
--- /dev/null
+++ b/lib/libtpm/tpm_drivers.c
@@ -0,0 +1,456 @@
+/*****************************************************************************
+ * Copyright (c) 2015 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdbool.h>
+
+#include "string.h"
+#include "helpers.h"
+#include "byteorder.h"
+#include "tpm_drivers.h"
+#include "tcgbios.h"
+#include "libhvcall.h"
+#include "paflof.h"
+
+#define PAPR_VTPM_DEBUG   0
+
+#define dprintf(_x ...) \
+	if (PAPR_VTPM_DEBUG) { \
+		printf("VTPM CRQ: " _x); \
+	}
+
+#define MIN(a, b) ((a) > (b) ? (b) : (a))
+
+#define TPM_DEFAULT_DURATION_SHORT     (2000)
+#define TPM_DEFAULT_DURATION_MEDIUM    (20000)
+#define TPM_DEFAULT_DURATION_LONG      (60000)
+
+struct crq {
+	uint8_t valid;
+	uint8_t msg;
+	uint16_t len;
+	uint32_t data;
+	uint64_t reserved;
+} __attribute__((packed));
+
+#define PAPR_VTPM_INIT_CRQ_COMMAND      0xC0
+#define PAPR_VTPM_VALID_COMMAND         0x80
+#define PAPR_VTPM_MSG_RESULT            0x80
+
+/* msg types for valid = VALID_INIT_CRQ */
+#define PAPR_VTPM_INIT_CRQ_RESULT       0x1
+
+/* msg types for valid = IBMVTPM_VALID_CMD */
+#define PAPR_VTPM_GET_VERSION           0x1
+#define PAPR_VTPM_TPM_COMMAND           0x2
+#define PAPR_VTPM_GET_RTCE_BUFFER_SIZE  0x3
+
+static const uint32_t tpm_default_durations[TPM_NUM_DURATIONS] = {
+	TPM_DEFAULT_DURATION_SHORT,
+	TPM_DEFAULT_DURATION_MEDIUM,
+	TPM_DEFAULT_DURATION_LONG,
+};
+
+#define PAGE_SIZE 4096
+
+/* state of the PAPR CRQ VTPM driver */
+static struct spapr_vtpm_driver_state {
+        /* durations of short, medium, & long commands */
+	uint32_t durations[TPM_NUM_DURATIONS];
+	unsigned long vtpm_unit;
+	unsigned char *qaddr;
+	unsigned long qsize;
+	/* current q_entry */
+	unsigned int q_entry;
+	/* current response CRQ */
+	struct crq *response;
+	pfw_drv_state driver_state;
+	pfw_drv_error driver_error;
+	/* version of the TPM we talk to -- from CRQ message */
+	uint32_t tpm_version;
+	/* buffer offset in buffer for sending */
+	unsigned int buffer_offset;
+	/* actual size of the buffer being used */
+	unsigned int buffer_size;
+	/* the buffer; may be bigger than buffer_size */
+	unsigned char buffer[PAPR_VTPM_MAX_BUFFER_SIZE];
+} spapr_vtpm = {
+	.qsize = PAGE_SIZE,
+	.driver_state = PFW_DRV_STATE_INVALID,
+	.driver_error = PFW_DRV_ERROR_NO_FAILURE,
+	.buffer_size = sizeof(spapr_vtpm.buffer),
+};
+
+static void pfw_drv_state_set(pfw_drv_state s, pfw_drv_error e)
+{
+	spapr_vtpm.driver_state = s;
+	spapr_vtpm.driver_error = e;
+}
+
+static pfw_drv_state pfw_drv_state_get(void)
+{
+	return spapr_vtpm.driver_state;
+}
+
+static pfw_drv_state pfw_drv_error_get(void)
+{
+	return spapr_vtpm.driver_error;
+}
+
+static void spapr_vtpm_set_durations(
+                              const uint32_t durations[TPM_NUM_DURATIONS])
+{
+        memcpy(spapr_vtpm.durations, durations,
+               TPM_NUM_DURATIONS * sizeof(durations[0]));
+}
+
+/*
+ * Get the crq where the response will be found. This
+ * function will clear the CRQ's valid field and advance
+ * the entry counter to the next entry.
+ */
+static struct crq *get_response_crq(void)
+{
+	struct crq *crq;
+
+	dprintf("q_entry = %d\n", spapr_vtpm.q_entry);
+
+	crq = &((struct crq *)spapr_vtpm.qaddr)[spapr_vtpm.q_entry];
+	memset(crq, 0, sizeof(*crq));
+
+	spapr_vtpm.q_entry += 1;
+	if (spapr_vtpm.q_entry == spapr_vtpm.qsize / sizeof(struct crq))
+		spapr_vtpm.q_entry = 0;
+
+	return crq;
+}
+
+/*
+ * Send a message via CRQ and wait for the response
+ */
+static bool spapr_send_crq_and_wait(unsigned long unit,
+                                    struct crq *crq,
+                                    struct crq **resp,
+                                    unsigned timeout,
+                                    pfw_drv_state state1,
+                                    pfw_drv_state state2)
+{
+	long rc;
+	unsigned i;
+
+	*resp = get_response_crq();
+
+	pfw_drv_state_set(state1, PFW_DRV_ERROR_NO_FAILURE);
+
+	rc = hv_send_crq(unit, (uint64_t *)crq);
+	if (rc != H_SUCCESS) {
+		pfw_drv_state_set(PFW_DRV_STATE_WAIT_INIT,
+				  PFW_DRV_ERROR_TPM_CRQ_ERROR);
+		return false;
+	}
+
+	pfw_drv_state_set(state2,
+	                  PFW_DRV_ERROR_NO_FAILURE);
+
+	for (i = 0; i < timeout; i++) {
+		if (((*resp)->valid & PAPR_VTPM_MSG_RESULT))
+			return true;
+		SLOF_msleep(1);
+	}
+
+	pfw_drv_state_set(PFW_DRV_STATE_FAILURE,
+			  PFW_DRV_ERROR_WAIT_TIMEOUT);
+
+	dprintf("Received no response from CRQ\n");
+	return false;
+}
+
+/*
+ * Get parameters from the CRQ
+ */
+static bool spapr_vtpm_get_params(void)
+{
+	struct crq crq, *response;
+	static bool completed = false; /* only once */
+
+	if (completed)
+		return true;
+
+	/* get the TPM version */
+	crq.valid = PAPR_VTPM_VALID_COMMAND;
+	crq.msg = PAPR_VTPM_GET_VERSION;
+
+	if (!spapr_send_crq_and_wait(spapr_vtpm.vtpm_unit, &crq, &response, 10,
+	                             PFW_DRV_STATE_SEND_GET_VERSION,
+	                             PFW_DRV_STATE_WAIT_VERSION)) {
+		dprintf("Failure getting TPM version from CRQ\n");
+		return false;
+	}
+
+	pfw_drv_state_set(PFW_DRV_STATE_CHECK_VERSION,
+	                  PFW_DRV_ERROR_NO_FAILURE);
+
+	spapr_vtpm.tpm_version = be32_to_cpu(response->data);
+	dprintf("TPM backend version: %d\n", spapr_vtpm.tpm_version);
+
+	/* get the TPM's buffer size */
+	crq.valid = PAPR_VTPM_VALID_COMMAND;
+	crq.msg = PAPR_VTPM_GET_RTCE_BUFFER_SIZE;
+
+	if (!spapr_send_crq_and_wait(spapr_vtpm.vtpm_unit, &crq, &response, 10,
+	                             PFW_DRV_STATE_SEND_BUFSIZE_REQ,
+	                             PFW_DRV_STATE_WAIT_BUFSIZE)) {
+		dprintf("Failure getting RTCE buffer size from CRQ\n");
+		return false;
+	}
+
+	pfw_drv_state_set(PFW_DRV_STATE_ALLOC_RTCE_BUF,
+	                  PFW_DRV_ERROR_NO_FAILURE);
+
+	dprintf("RTCE buffer size: %u\n", be16_to_cpu(response->len));
+	spapr_vtpm.buffer_size = MIN(spapr_vtpm.buffer_size,
+				     be16_to_cpu(response->len));
+	if (spapr_vtpm.buffer_size < 1024) {
+		dprintf("RTCE buffer size of %u bytes is too small. "
+		        "Minimum is 1024 bytes.\n", spapr_vtpm.buffer_size);
+		pfw_drv_state_set(PFW_DRV_STATE_FAILURE,
+				  PFW_DRV_ERROR_BAD_RTCE_SIZE);
+		return false;
+	}
+
+	completed = true;
+
+	return true;
+}
+
+static bool spapr_vtpm_activate(uint8_t locty)
+{
+	long rc;
+	struct crq crq, *resp;
+	static bool initialized = false; /* only one init */
+
+	spapr_vtpm.buffer_offset = 0;
+
+	pfw_drv_state_set(PFW_DRV_STATE_REG_CRQ,
+			  PFW_DRV_ERROR_NO_FAILURE);
+
+	rc = hv_reg_crq(spapr_vtpm.vtpm_unit, (unsigned long)spapr_vtpm.qaddr,
+	                spapr_vtpm.qsize);
+	if (rc != H_SUCCESS) {
+		pfw_drv_state_set(PFW_DRV_STATE_WAIT_INIT,
+		                  PFW_DRV_ERROR_UNEXPECTED_REG_ERROR);
+		dprintf("CRQ registration failed\n");
+		return false;
+	}
+
+	/* we always start with q_entry 0 */
+	spapr_vtpm.q_entry = 0;
+
+	if (initialized)
+		goto skip_init;
+
+	crq.valid = PAPR_VTPM_INIT_CRQ_COMMAND;
+	crq.msg = PAPR_VTPM_INIT_CRQ_RESULT;
+
+	if (!spapr_send_crq_and_wait(spapr_vtpm.vtpm_unit,
+	                             &crq,
+	                             &resp,
+	                             10,
+	                             PFW_DRV_STATE_SEND_INIT,
+	                             PFW_DRV_STATE_WAIT_INIT_COMP)) {
+		dprintf("Initializing CRQ failed\n");
+		goto err_exit;
+	}
+	dprintf("Successfully initialized CRQ\n");
+
+	initialized = true;
+
+skip_init:
+	if (!spapr_vtpm_get_params())
+		goto err_exit;
+
+	return true;
+
+err_exit:
+	hv_free_crq(spapr_vtpm.vtpm_unit);
+
+	return false;
+}
+
+static bool spapr_vtpm_init(void)
+{
+        spapr_vtpm_set_durations(tpm_default_durations);
+
+	return true;
+}
+
+/*
+ * Check whether we have a CRQ underneath us
+ */
+static bool spapr_vtpm_probe(void)
+{
+	bool good = true;
+
+	spapr_vtpm_init();
+
+	if (!spapr_vtpm.qaddr) {
+		spapr_vtpm.qaddr = SLOF_alloc_mem(spapr_vtpm.qsize);
+		memset(spapr_vtpm.qaddr, 0, spapr_vtpm.qsize);
+
+		dprintf("getting FORTH vtpm-unit\n");
+		spapr_vtpm.vtpm_unit = SLOF_get_vtpm_unit();
+	}
+
+	dprintf("vtpm_unit = %lx, buffer = %p\n",
+	        spapr_vtpm.vtpm_unit, spapr_vtpm.qaddr);
+	if (!spapr_vtpm_activate(0)) {
+		good = false;
+	} else {
+		hv_free_crq(spapr_vtpm.vtpm_unit);
+	}
+
+	return good;
+}
+
+static bool spapr_vtpm_senddata(const uint8_t *const data, uint32_t len)
+{
+	/*
+	 * we have to collect all data to be sent in a buffer
+	 */
+
+	if (spapr_vtpm.buffer_offset + len > spapr_vtpm.buffer_size) {
+		spapr_vtpm.buffer_offset = 0;
+		return false;
+	}
+
+	memcpy(&spapr_vtpm.buffer[spapr_vtpm.buffer_offset], data, len);
+
+	spapr_vtpm.buffer_offset += len;
+
+	return true;
+}
+
+static bool spapr_vtpm_transfer(void)
+{
+	struct crq crq;
+	long rc;
+
+	spapr_vtpm.response = get_response_crq();
+	/* response CRQ has been set and valid field cleared */
+
+	crq.valid = PAPR_VTPM_VALID_COMMAND;
+	crq.msg = PAPR_VTPM_TPM_COMMAND;
+	crq.len = cpu_to_be16(spapr_vtpm.buffer_offset);
+	crq.data = cpu_to_be32((uint64_t)spapr_vtpm.buffer);
+
+	pfw_drv_state_set(PFW_DRV_STATE_SEND_TPM_CMD,
+	                  PFW_DRV_ERROR_NO_FAILURE);
+
+	rc = hv_send_crq(spapr_vtpm.vtpm_unit, (uint64_t *)&crq);
+
+	if (rc == H_SUCCESS) {
+		pfw_drv_state_set(PFW_DRV_STATE_WAIT_TPM_RSP,
+		                  PFW_DRV_ERROR_NO_FAILURE);
+	} else {
+		/* per pfw doc, move to wait_init state */
+		pfw_drv_state_set(PFW_DRV_STATE_WAIT_INIT,
+		                  PFW_DRV_ERROR_UNEXPECTED_SEND_ERROR);
+	}
+
+	spapr_vtpm.buffer_offset = 0;
+
+	return (rc == H_SUCCESS);
+}
+
+static bool spapr_vtpm_waitrespready(enum tpmDurationType to_t)
+{
+	uint32_t timeout = spapr_vtpm.durations[to_t];
+	int i;
+
+	/* response CRQ has been set */
+
+	for (i = 0; i < timeout; i++) {
+		if (spapr_vtpm.response->valid & PAPR_VTPM_MSG_RESULT) {
+			/* TPM responded: move to Send tpm-cmd state */
+			pfw_drv_state_set(PFW_DRV_STATE_SEND_TPM_CMD,
+					  PFW_DRV_ERROR_NO_FAILURE);
+			dprintf("Received response to TPM command\n");
+			return true;
+		}
+		SLOF_msleep(1);
+	}
+
+	pfw_drv_state_set(PFW_DRV_STATE_FAILURE,
+			  PFW_DRV_ERROR_WAIT_TIMEOUT);
+
+	dprintf("Received NO response to TPM command");
+
+	return false;
+}
+
+static bool spapr_vtpm_readresp(uint8_t *buffer, uint32_t *len)
+{
+	/* response CRQ has been set */
+
+	memcpy(buffer, (void *)(uint64_t)spapr_vtpm.response->data,
+	       MIN(*len, be32_to_cpu(spapr_vtpm.response->len)));
+
+	*len = be32_to_cpu(spapr_vtpm.response->len);
+	dprintf("Length of copied response: %d\n", *len);
+
+	return true;
+}
+
+static bool spapr_vtpm_endcycle(void)
+{
+	hv_free_crq(spapr_vtpm.vtpm_unit);
+
+	spapr_vtpm.response = NULL;
+
+	return true;
+}
+
+static uint32_t spapr_vtpm_get_buffersize(void)
+{
+	return spapr_vtpm.buffer_size;
+}
+
+static pfw_drv_state spapr_vtpm_get_state(void)
+{
+	return pfw_drv_state_get();
+}
+
+static pfw_drv_error spapr_vtpm_get_error(void)
+{
+	return pfw_drv_error_get();
+}
+
+/**** driver structures ****/
+
+struct tpm_driver tpm_drivers[TPM_NUM_DRIVERS] = {
+	[PAPR_DRIVER_IDX] = {
+		.setdurations  = spapr_vtpm_set_durations,
+		.probe         = spapr_vtpm_probe,
+		.init          = spapr_vtpm_init,
+		.activate      = spapr_vtpm_activate,
+		.ready         = spapr_vtpm_endcycle,
+		.senddata      = spapr_vtpm_senddata,
+		.transfer      = spapr_vtpm_transfer,
+		.waitrespready = spapr_vtpm_waitrespready,
+		.readresp      = spapr_vtpm_readresp,
+		.sha1threshold = 100 * 1024,
+		.getbuffersize = spapr_vtpm_get_buffersize,
+		.getstate      = spapr_vtpm_get_state,
+		.geterror      = spapr_vtpm_get_error,
+	},
+};
diff --git a/lib/libtpm/tpm_drivers.h b/lib/libtpm/tpm_drivers.h
new file mode 100644
index 0000000..2d74cc0
--- /dev/null
+++ b/lib/libtpm/tpm_drivers.h
@@ -0,0 +1,93 @@
+/*****************************************************************************
+ * Copyright (c) 2015 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#ifndef TPM_DRIVERS_H
+#define TPM_DRIVERS_H
+
+#include <stdint.h>
+#include <stdbool.h>
+
+enum tpmDurationType {
+	TPM_DURATION_TYPE_SHORT = 0,
+	TPM_DURATION_TYPE_MEDIUM,
+	TPM_DURATION_TYPE_LONG,
+};
+
+#define TPM_NUM_DURATIONS    3
+
+#define PAPR_DRIVER_IDX      0
+#define TPM_NUM_DRIVERS      1
+
+/* firmware driver states */
+typedef enum {
+	PFW_DRV_STATE_INVALID = 0,
+	PFW_DRV_STATE_INIT_CALLED = 1,
+	PFW_DRV_STATE_REG_CRQ = 2,
+	PFW_DRV_STATE_WAIT_INIT = 3,
+	PFW_DRV_STATE_SEND_INIT = 4,
+	PFW_DRV_STATE_FAILURE = 5,
+	PFW_DRV_STATE_WAIT_INIT_COMP = 6,
+	PFW_DRV_STATE_SEND_INIT_COMP = 7,
+	PFW_DRV_STATE_SEND_GET_VERSION = 8,
+	PFW_DRV_STATE_WAIT_VERSION = 9,
+	PFW_DRV_STATE_CHECK_VERSION = 10,
+	PFW_DRV_STATE_SEND_BUFSIZE_REQ = 11,
+	PFW_DRV_STATE_WAIT_BUFSIZE = 12,
+	PFW_DRV_STATE_ALLOC_RTCE_BUF = 13,
+	PFW_DRV_STATE_SEND_TPM_CMD = 14,
+	PFW_DRV_STATE_WAIT_TPM_RSP = 15,
+} pfw_drv_state;
+
+/* firmware driver errors */
+typedef enum {
+	PFW_DRV_ERROR_NO_FAILURE = -1,
+	PFW_DRV_ERROR_NOT_FOUND_TIMEOUT = 0,
+	PFW_DRV_ERROR_UNEXPECTED_REG_ERROR = 1,
+	PFW_DRV_ERROR_PARTNER_FAILED = 2,
+	PFW_DRV_ERROR_UNEXPECTED_TSP_ERROR = 3,
+	PFW_DRV_ERROR_TPM_PROTOCOL_ERROR = 4,
+	PFW_DRV_ERROR_WAIT_TIMEOUT = 5,
+	PFW_DRV_ERROR_UNEXPECTED_SEND_ERROR = 6,
+	PFW_DRV_ERROR_CRQ_OPEN_FAIL = 7,
+	PFW_DRV_ERROR_BAD_STATE = 8,
+	PFW_DRV_ERROR_TPM_FAIL = 9,
+	PFW_DRV_ERROR_TPM_CRQ_ERROR = 10,
+	PFW_DRV_ERROR_BAD_VERSION = 11,
+	PFW_DRV_ERROR_BAD_RTCE_SIZE = 12,
+	PFW_DRV_ERROR_SML_FAILURE = 13,
+	PFW_DRV_ERROR_SML_HANDED_OVER = 14,
+} pfw_drv_error;
+
+/* low level driver implementation */
+struct tpm_driver {
+	void (*setdurations)(const uint32_t durations[TPM_NUM_DURATIONS]);
+	bool (*probe)(void);
+	bool (*init)(void);
+	bool (*activate)(uint8_t locty);
+	bool (*ready)(void);
+	bool (*senddata)(const uint8_t *const data, uint32_t len);
+	bool (*transfer)(void);
+	bool (*waitrespready)(enum tpmDurationType to_t);
+	bool (*readresp)(uint8_t *buffer, uint32_t *len);
+	/* the TPM will be used for buffers of sizes below the sha1threshold
+	   for calculating the hash */
+	uint32_t sha1threshold;
+	void (*get_vers_data)(uint16_t *did, uint16_t *vid, uint16_t *rid);
+	uint32_t (*getbuffersize)(void);
+	pfw_drv_state (*getstate)(void);
+	pfw_drv_error (*geterror)(void);
+};
+
+/* the max. buffer size by the external TPM is 4k */
+#define PAPR_VTPM_MAX_BUFFER_SIZE       4096
+
+#endif /* TPM_DRIVERS_H */
diff --git a/slof/helpers.c b/slof/helpers.c
index d7c1888..dc7f08c 100644
--- a/slof/helpers.c
+++ b/slof/helpers.c
@@ -134,3 +134,9 @@ void *SLOF_translate_my_address(void *addr)
 	forth_eval("translate-my-address");
 	return (void *)forth_pop();
 }
+
+unsigned long SLOF_get_vtpm_unit(void)
+{
+	forth_eval("vtpm-unit");
+	return forth_pop();
+}
-- 
1.9.3
