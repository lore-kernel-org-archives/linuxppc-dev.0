Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C328E1A0021
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:12 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:09 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9DED06E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:46:53 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781t8mF64028676
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:08 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t7W1012130
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:07 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 02/16] Add TPM initialization support
Date: Fri,  7 Aug 2015 21:54:51 -0400
Message-Id: <1438998905-4085665-3-git-send-email-stefanb@linux.vnet.ibm.com>
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

This patch implements the main part of the fimrmware extensions. It provides
the following functionality:

- initialization of the TPM by sending a sequence of commands to it
- proper setup of the TPM before the firmware hands over control to the bootloader

Structures that are needed in subsequent patches are also included in the
private header file tcgbios_int.h at this point.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 board-qemu/Makefile                 |   2 +-
 board-qemu/slof/Makefile            |  10 +-
 board-qemu/slof/OF.fs               |   6 +
 board-qemu/slof/tree.fs             |   3 +
 board-qemu/slof/vio-vtpm-cdriver.fs |  74 +++++++
 board-qemu/slof/vtpm-sml.fs         |  56 ++++++
 lib/Makefile                        |   2 +-
 lib/libtpm/Makefile                 |   2 +-
 lib/libtpm/tcgbios.c                | 371 ++++++++++++++++++++++++++++++++++++
 lib/libtpm/tcgbios.h                |  21 ++
 lib/libtpm/tcgbios_int.h            | 162 ++++++++++++++++
 lib/libtpm/tpm.code                 |  37 ++++
 lib/libtpm/tpm.in                   |  17 ++
 slof/fs/tpm/tpm-static.fs           |  34 ++++
 14 files changed, 791 insertions(+), 6 deletions(-)
 create mode 100644 board-qemu/slof/vio-vtpm-cdriver.fs
 create mode 100644 board-qemu/slof/vtpm-sml.fs
 create mode 100644 lib/libtpm/tcgbios.c
 create mode 100644 lib/libtpm/tcgbios.h
 create mode 100644 lib/libtpm/tcgbios_int.h
 create mode 100644 lib/libtpm/tpm.code
 create mode 100644 lib/libtpm/tpm.in
 create mode 100644 slof/fs/tpm/tpm-static.fs

diff --git a/board-qemu/Makefile b/board-qemu/Makefile
index 29ee016..0c03e54 100644
--- a/board-qemu/Makefile
+++ b/board-qemu/Makefile
@@ -15,7 +15,7 @@ BOARD_TARGETS = tools_build romfs_build clients_build stage1 subdirs
 SUBDIRS = slof
 
 COMMON_LIBS = libc libbootmsg libbases libnvram libelf libhvcall libvirtio libusb \
-              libveth libe1k
+              libveth libe1k libtpm
 
 all: $(BOARD_TARGETS)
 	$(MAKE) boot_rom.bin
diff --git a/board-qemu/slof/Makefile b/board-qemu/slof/Makefile
index 283f77d..be6eec1 100644
--- a/board-qemu/slof/Makefile
+++ b/board-qemu/slof/Makefile
@@ -21,7 +21,7 @@ all: version.o Makefile.dep OF.ffs paflof $(SLOFCMNDIR)/xvect.bin
 CPPFLAGS = -I$(LIBCMNDIR)/libbootmsg -I$(LIBCMNDIR)/libhvcall \
 	   -I$(LIBCMNDIR)/libvirtio -I$(LIBCMNDIR)/libnvram \
 	   -I$(LIBCMNDIR)/libusb -I$(LIBCMNDIR)/libveth \
-	   -I$(LIBCMNDIR)/libe1k
+	   -I$(LIBCMNDIR)/libe1k -I$(LIBCMNDIR)/libtpm
 SLOF_LIBS = \
 	$(LIBCMNDIR)/libbootmsg.a \
 	$(LIBCMNDIR)/libelf.a \
@@ -30,7 +30,8 @@ SLOF_LIBS = \
 	$(LIBCMNDIR)/libusb.a \
 	$(LIBCMNDIR)/libnvram.a \
 	$(LIBCMNDIR)/libveth.a \
-	$(LIBCMNDIR)/libe1k.a
+	$(LIBCMNDIR)/libe1k.a \
+	$(LIBCMNDIR)/libtpm.a
 BOARD_SLOF_IN = \
 	$(LIBCMNDIR)/libhvcall/hvcall.in \
 	$(LIBCMNDIR)/libvirtio/virtio.in \
@@ -40,7 +41,8 @@ BOARD_SLOF_IN = \
 	$(LIBCMNDIR)/libnvram/libnvram.in \
 	$(LIBCMNDIR)/libbases/libbases.in \
 	$(LIBCMNDIR)/libveth/veth.in \
-	$(LIBCMNDIR)/libe1k/e1k.in
+	$(LIBCMNDIR)/libe1k/e1k.in \
+	$(LIBCMNDIR)/libtpm/tpm.in
 BOARD_SLOF_CODE = $(BOARD_SLOF_IN:%.in=%.code)
 
 include $(SLOFCMNDIR)/Makefile.inc
@@ -71,6 +73,7 @@ VIO_FFS_FILES = \
 	$(SLOFBRDDIR)/pci-device_1af4_1009.fs \
 	$(SLOFBRDDIR)/vio-hvterm.fs \
 	$(SLOFBRDDIR)/vio-vscsi.fs \
+	$(SLOFBRDDIR)/vio-vtpm-cdriver.fs \
 	$(SLOFBRDDIR)/vio-veth.fs \
 	$(SLOFBRDDIR)/rtas-nvram.fs \
 	$(SLOFBRDDIR)/virtio-net.fs \
@@ -99,6 +102,7 @@ OF_FFS_FILES = \
 	$(SLOFBRDDIR)/default-font.bin \
 	$(SLOFBRDDIR)/pci-phb.fs \
 	$(SLOFBRDDIR)/rtas.fs \
+	$(SLOFBRDDIR)/vtpm-sml.fs \
 	$(SLOFBRDDIR)/pci-device_1234_1111.fs \
 	$(SLOFBRDDIR)/pci-device_1013_00b8.fs \
 	$(SLOFBRDDIR)/pci-device_8086_100e.fs \
diff --git a/board-qemu/slof/OF.fs b/board-qemu/slof/OF.fs
index 561d892..bd9495e 100644
--- a/board-qemu/slof/OF.fs
+++ b/board-qemu/slof/OF.fs
@@ -113,6 +113,10 @@ d# 512000000 VALUE tb-frequency   \ default value - needed for "ms" to work
 
 #include "fdt.fs"
 
+350 cp
+
+#include <tpm/tpm-static.fs>
+
 360 cp
 
 #include <root.fs>
@@ -300,6 +304,8 @@ cr
 #include "copyright-oss.fs"
 cr cr
 
+vtpm-unassert-pp
+
 \ this CATCH is to ensure the code bellow always executes:  boot may ABORT!
 ' start-it CATCH drop
 
diff --git a/board-qemu/slof/tree.fs b/board-qemu/slof/tree.fs
index 4aba4c5..b71009d 100644
--- a/board-qemu/slof/tree.fs
+++ b/board-qemu/slof/tree.fs
@@ -83,6 +83,9 @@ include fbuffer.fs
 	    2dup " qemu,spapr-nvram" strequal IF
 	    	" rtas-nvram.fs" included
 	    THEN
+	    2dup " IBM,vtpm" strequal IF
+                " vio-vtpm-cdriver.fs" included
+	    THEN
             2drop
        THEN
        peer
diff --git a/board-qemu/slof/vio-vtpm-cdriver.fs b/board-qemu/slof/vio-vtpm-cdriver.fs
new file mode 100644
index 0000000..2fc1657
--- /dev/null
+++ b/board-qemu/slof/vio-vtpm-cdriver.fs
@@ -0,0 +1,74 @@
+\ *****************************************************************************
+\ * Copyright (c) 2015 IBM Corporation
+\ * All rights reserved.
+\ * This program and the accompanying materials
+\ * are made available under the terms of the BSD License
+\ * which accompanies this distribution, and is available at
+\ * http://www.opensource.org/licenses/bsd-license.php
+\ *
+\ * Contributors:
+\ *     IBM Corporation - initial implementation
+\ ****************************************************************************/
+
+." Populating " pwd
+
+false VALUE vtpm-debug?
+0 VALUE vtpm-unit
+
+: setup-alias
+    " ibm,vtpm" find-alias 0= IF
+        " ibm,vtpm" get-node node>path set-alias
+    ELSE
+        drop
+    THEN
+;
+
+: vtpm-cleanup ( )
+    vtpm-debug? IF ." VTPM: Disabling RTAS bypass" cr THEN
+    vtpm-unit 0 rtas-set-tce-bypass
+;
+
+: vtpm-init ( -- true | false )
+    0 0 get-node open-node ?dup 0= IF EXIT THEN
+    my-self >r
+    dup to my-self
+
+    vtpm-debug? IF ." VTPM: Initializing for c-driver" cr THEN
+
+    my-unit to vtpm-unit
+
+    \ Enable TCE bypass special qemu feature
+    vtpm-unit 1 rtas-set-tce-bypass
+
+    \ Have TCE bypass cleaned up
+    ['] vtpm-cleanup add-quiesce-xt
+
+    tpm-start                              ( -- errcode )
+    vtpm-debug? IF
+        ." VTPM: Error code from tpm-start: " dup . cr
+    THEN
+
+    \ check errorcode
+    0= IF
+        \ tpm-start had no error: Setup an alias
+        setup-alias
+    THEN
+
+    close-node
+    r> to my-self
+;
+
+: open ( )
+    vtpm-debug? IF ." VTPM: vTPM open()" cr THEN
+    true
+;
+
+: close ( )
+    vtpm-debug? IF ." VTPM: vTPM close()" cr THEN
+;
+
+\ setup alias and the RTAS bypass
+vtpm-init
+
+\ setup the log
+include vtpm-sml.fs
diff --git a/board-qemu/slof/vtpm-sml.fs b/board-qemu/slof/vtpm-sml.fs
new file mode 100644
index 0000000..72edac0
--- /dev/null
+++ b/board-qemu/slof/vtpm-sml.fs
@@ -0,0 +1,56 @@
+\ *****************************************************************************
+\ * Copyright (c) 2015 IBM Corporation
+\ * All rights reserved.
+\ * This program and the accompanying materials
+\ * are made available under the terms of the BSD License
+\ * which accompanies this distribution, and is available at
+\ * http://www.opensource.org/licenses/bsd-license.php
+\ *
+\ * Contributors:
+\ *     IBM Corporation - initial implementation
+\ ****************************************************************************/
+
+\ KVM/qemu TPM SML entries in /ibm,vtpm
+
+" /" find-device
+
+new-device
+
+false VALUE    vtpm-debug?
+0     VALUE    log-base
+40000 CONSTANT LOG-SIZE   \ 256k per VTPM FW spec.
+
+LOG-SIZE alloc-mem to log-base
+
+\ create /ibm,vtpm
+s" ibm,vtpm" 2dup device-name device-type
+
+: sml-get-allocated-size ( -- buffer-size)
+    vtpm-debug? IF
+        ." Call to sml-get-allocated-size; size = " LOG-SIZE . cr
+    THEN
+    LOG-SIZE
+;
+
+: sml-get-handover-size ( -- size )
+    vtpm-debug? IF
+        ." Call to sml-get-handover-size; size = " LOG-SIZE . cr
+    THEN
+    LOG-SIZE
+;
+
+: sml-handover ( dest size -- )
+    vtpm-debug? IF
+        2dup
+        ." Call to sml-handover; size = " . ." dest = " . cr
+    THEN
+    log-base        ( dest size src )
+    -rot            ( src dest size )
+    move
+;
+
+: open  true ;
+: close ;
+
+finish-device
+device-end
diff --git a/lib/Makefile b/lib/Makefile
index ed8a359..9c802e2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -11,7 +11,7 @@
 # ****************************************************************************/
 
 SUBDIRS = libc libipmi libbootmsg libbases libnvram libelf libhvcall libvirtio \
-          libusb libveth libe1k libbcm
+          libusb libveth libe1k libbcm libtpm
 
 all:  subdirs
 
diff --git a/lib/libtpm/Makefile b/lib/libtpm/Makefile
index a174815..53d3abb 100644
--- a/lib/libtpm/Makefile
+++ b/lib/libtpm/Makefile
@@ -24,7 +24,7 @@ TARGET = ../libtpm.a
 
 all: $(TARGET)
 
-SRCS = tpm_drivers.c
+SRCS = tpm_drivers.c tcgbios.c
 
 OBJS = $(SRCS:%.c=%.o)
 
diff --git a/lib/libtpm/tcgbios.c b/lib/libtpm/tcgbios.c
new file mode 100644
index 0000000..efa4cdf
--- /dev/null
+++ b/lib/libtpm/tcgbios.c
@@ -0,0 +1,371 @@
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
+/*
+ *  Implementation of the TPM BIOS extension according to the specification
+ *  described in the IBM VTPM Firmware document and the TCG Specification
+ *  that can be found here under the following link:
+ *  http://www.trustedcomputinggroup.org/resources/pc_client_work_group_specific_implementation_specification_for_conventional_bios
+ */
+
+#include "types.h"
+#include "byteorder.h"
+#include "tpm_drivers.h"
+#include "string.h"
+#include "tcgbios.h"
+#include "tcgbios_int.h"
+#include "stdio.h"
+
+#define DEBUG 0
+#define dprintf(_x ...) do { \
+	if (DEBUG) { \
+		printf("TCGBIOS: " _x); \
+	} \
+} while (0);
+
+static const uint8_t Startup_ST_CLEAR[] = { 0x00, TPM_ST_CLEAR };
+static const uint8_t Startup_ST_STATE[] = { 0x00, TPM_ST_STATE };
+
+static const uint8_t PhysicalPresence_CMD_ENABLE[]  = { 0x00, 0x20 };
+static const uint8_t PhysicalPresence_CMD_DISABLE[] = { 0x01, 0x00 };
+static const uint8_t PhysicalPresence_PRESENT[]     = { 0x00, 0x08 };
+static const uint8_t PhysicalPresence_NOT_PRESENT_LOCK[] = { 0x00, 0x14 };
+
+static const uint8_t CommandFlag_FALSE[] = { 0x00 };
+static const uint8_t CommandFlag_TRUE[]  = { 0x01 };
+
+static const uint8_t GetCapability_Permanent_Flags[] = {
+	0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x04,
+	0x00, 0x00, 0x01, 0x08
+};
+
+static const uint8_t GetCapability_OwnerAuth[] = {
+	0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x04,
+	0x00, 0x00, 0x01, 0x11
+};
+
+static const uint8_t GetCapability_Timeouts[] = {
+	0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x04,
+	0x00, 0x00, 0x01, 0x15
+};
+
+static const uint8_t GetCapability_Durations[] = {
+	0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x04,
+	0x00, 0x00, 0x01, 0x20
+};
+
+struct tpm_state {
+	uint8_t	  tpm_probed:1;
+	uint8_t   tpm_found:1;
+	uint8_t   tpm_working:1;
+	uint8_t   if_shutdown:1;
+	struct tpm_driver *tpm_driver_to_use;
+};
+
+static struct tpm_state tpm_state = {
+	.tpm_driver_to_use = NULL,
+};
+
+extern struct tpm_driver tpm_drivers[];
+
+/********************************************************
+  Extensions for TCG-enabled BIOS
+ *******************************************************/
+
+static bool is_tpm_present(void)
+{
+	bool rc = false;
+	unsigned int i;
+
+	for (i = 0; i < TPM_NUM_DRIVERS; i++) {
+		struct tpm_driver *td = &tpm_drivers[i];
+		if (td->probe()) {
+			td->init();
+			tpm_state.tpm_driver_to_use = td;
+			rc = true;
+			break;
+		}
+	}
+
+	return rc;
+}
+
+static void probe_tpm(void)
+{
+	if (!tpm_state.tpm_probed) {
+		tpm_state.tpm_probed = 1;
+		tpm_state.tpm_found = (is_tpm_present() != 0);
+		tpm_state.tpm_working = tpm_state.tpm_found;
+	}
+}
+
+static bool has_working_tpm(void)
+{
+	probe_tpm();
+
+	return tpm_state.tpm_working;
+}
+
+static uint32_t transmit(uint8_t locty, const struct iovec iovec[],
+			 uint8_t *respbuffer, uint32_t *respbufferlen,
+			 enum tpmDurationType to_t)
+{
+	struct tpm_driver *td;
+	unsigned int i;
+
+	if (tpm_state.tpm_driver_to_use == NULL)
+		return TCGBIOS_FATAL_COM_ERROR;
+
+	td = tpm_state.tpm_driver_to_use;
+
+	if (!td->activate(locty))
+		return TCGBIOS_FATAL_COM_ERROR;
+
+	for (i = 0; iovec[i].length; i++) {
+		if (!td->senddata(iovec[i].data,
+				  iovec[i].length))
+			return TCGBIOS_FATAL_COM_ERROR;
+	}
+
+	if (!td->transfer())
+		return TCGBIOS_FATAL_COM_ERROR;
+
+	if (!td->waitrespready(to_t))
+		return TCGBIOS_FATAL_COM_ERROR;
+
+	if (!td->readresp(respbuffer, respbufferlen))
+		return TCGBIOS_FATAL_COM_ERROR;
+
+	td->ready();
+
+	return 0;
+}
+
+/*
+ * Send a TPM command with the given ordinal. Append the given buffer
+ * containing all data in network byte order to the command (this is
+ * the custom part per command) and expect a response of the given size.
+ * If a buffer is provided, the response will be copied into it.
+ */
+static uint32_t build_and_send_cmd_od(uint32_t ordinal,
+				      const uint8_t *append,
+				      uint32_t append_size,
+				      uint8_t *resbuffer,
+				      uint32_t return_size,
+				      uint32_t *returnCode,
+				      const uint8_t *otherdata,
+				      uint32_t otherdata_size,
+				      enum tpmDurationType to_t)
+{
+#define MAX_APPEND_SIZE   sizeof(GetCapability_Timeouts)
+#define MAX_RESPONSE_SIZE sizeof(struct tpm_res_getcap_perm_flags)
+	uint32_t rc;
+	uint8_t ibuffer[TPM_REQ_HEADER_SIZE + MAX_APPEND_SIZE];
+	uint8_t obuffer[MAX_RESPONSE_SIZE];
+	struct tpm_req_header *trqh = (struct tpm_req_header *)ibuffer;
+	struct tpm_rsp_header *trsh = (struct tpm_rsp_header *)obuffer;
+	uint8_t locty = 0;
+	struct iovec iovec[3] = {{ 0 }};
+	uint32_t obuffer_len = sizeof(obuffer);
+
+	if (append_size > MAX_APPEND_SIZE || return_size > MAX_RESPONSE_SIZE) {
+		dprintf("size of requested buffers too big.");
+		return TCGBIOS_FIRMWARE_ERROR;
+	}
+
+	iovec[0].data = trqh;
+	iovec[0].length = TPM_REQ_HEADER_SIZE + append_size;
+
+	if (otherdata) {
+		iovec[1].data = (void *)otherdata;
+		iovec[1].length = otherdata_size;
+	}
+
+	memset(ibuffer, 0, sizeof(ibuffer));
+	memset(obuffer, 0, sizeof(obuffer));
+
+	trqh->tag = cpu_to_be16(TPM_TAG_RQU_CMD);
+	trqh->totlen = cpu_to_be32(TPM_REQ_HEADER_SIZE +
+				   append_size + otherdata_size);
+	trqh->ordinal = cpu_to_be32(ordinal);
+
+	if (append_size)
+		memcpy((char *)trqh + sizeof(*trqh),
+		       append, append_size);
+
+	rc = transmit(locty, iovec, obuffer, &obuffer_len, to_t);
+	if (rc)
+		return rc;
+
+	*returnCode = be32_to_cpu(trsh->errcode);
+
+	if (resbuffer)
+		memcpy(resbuffer, trsh, return_size);
+
+	return 0;
+}
+
+static uint32_t build_and_send_cmd(uint32_t ordinal, const uint8_t *append,
+				   uint32_t append_size, uint8_t *resbuffer,
+				   uint32_t return_size, uint32_t *returnCode,
+				   enum tpmDurationType to_t)
+{
+	return build_and_send_cmd_od(ordinal, append, append_size,
+				     resbuffer, return_size, returnCode,
+				     NULL, 0, to_t);
+}
+
+static uint32_t determine_timeouts(void)
+{
+	uint32_t rc;
+	uint32_t returnCode;
+	struct tpm_res_getcap_durations durations;
+	struct tpm_driver *td = tpm_state.tpm_driver_to_use;
+	unsigned int i;
+
+	rc = build_and_send_cmd(TPM_ORD_GetCapability,
+				GetCapability_Durations,
+				sizeof(GetCapability_Durations),
+				(uint8_t *)&durations, sizeof(durations),
+				&returnCode, TPM_DURATION_TYPE_SHORT);
+
+	dprintf("Return code from TPM_GetCapability(Durations) = 0x%08x\n",
+		returnCode);
+
+	if (rc || returnCode)
+		goto err_exit;
+
+	for (i = 0; i < TPM_NUM_DURATIONS; i++)
+		durations.durations[i] = be32_to_cpu(durations.durations[i]);
+
+	dprintf("durations: %u %u %u\n",
+		durations.durations[0],
+		durations.durations[1],
+		durations.durations[2]);
+
+	td->setdurations(durations.durations);
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
+static uint32_t tpm_startup(void)
+{
+	uint32_t rc;
+	uint32_t returnCode;
+
+	if (!has_working_tpm())
+		return TCGBIOS_GENERAL_ERROR;
+
+	dprintf("Starting with TPM_Startup(ST_CLEAR)\n");
+	rc = build_and_send_cmd(TPM_ORD_Startup,
+				Startup_ST_CLEAR, sizeof(Startup_ST_CLEAR),
+				NULL, 0, &returnCode,
+				TPM_DURATION_TYPE_SHORT);
+
+	dprintf("Return code from TPM_Startup = 0x%08x\n",
+		returnCode);
+
+	if (rc || returnCode)
+		goto err_exit;
+
+	rc = build_and_send_cmd(TPM_ORD_SelfTestFull, NULL, 0,
+				NULL, 0, &returnCode,
+				TPM_DURATION_TYPE_LONG);
+
+	dprintf("Return code from TPM_SelfTestFull = 0x%08x\n",
+		returnCode);
+
+	if (rc || returnCode)
+		goto err_exit;
+
+	rc = determine_timeouts();
+	if (rc)
+		goto err_exit;
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
+uint32_t tpm_start(void)
+{
+	tpm_state.if_shutdown = 0;
+	tpm_state.tpm_probed = 0;
+	tpm_state.tpm_found = 0;
+	tpm_state.tpm_working = 0;
+
+	if (!has_working_tpm()) {
+		dprintf("%s: Machine does not have a working TPM\n",
+			__func__);
+		tpm_state.if_shutdown = 1;
+		return TCGBIOS_FATAL_COM_ERROR;
+	}
+
+	return tpm_startup();
+}
+
+uint32_t tpm_unassert_pp(void)
+{
+	uint32_t rc;
+	uint32_t returnCode;
+
+	if (!has_working_tpm())
+		return TCGBIOS_GENERAL_ERROR;
+
+	rc = build_and_send_cmd(TPM_ORD_PhysicalPresence,
+				PhysicalPresence_CMD_ENABLE,
+				sizeof(PhysicalPresence_CMD_ENABLE),
+				NULL, 0, &returnCode,
+				TPM_DURATION_TYPE_SHORT);
+
+	dprintf("Return code from TPM_PhysicalPresence(CMD_ENABLE) = 0x%08x\n",
+		returnCode);
+
+	if (rc || returnCode)
+		goto err_exit;
+
+	rc = build_and_send_cmd(TPM_ORD_PhysicalPresence,
+				PhysicalPresence_NOT_PRESENT_LOCK,
+				sizeof(PhysicalPresence_NOT_PRESENT_LOCK),
+				NULL, 0, &returnCode,
+				TPM_DURATION_TYPE_SHORT);
+
+	dprintf("Return code from TPM_PhysicalPresence(NOT_PRESENT_LOCK) = 0x%08x\n",
+		returnCode);
+
+	if (rc || returnCode)
+		goto err_exit;
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
diff --git a/lib/libtpm/tcgbios.h b/lib/libtpm/tcgbios.h
new file mode 100644
index 0000000..c4c462e
--- /dev/null
+++ b/lib/libtpm/tcgbios.h
@@ -0,0 +1,21 @@
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
+#ifndef TCGBIOS_H
+#define TCGBIOS_H
+
+#include <stdint.h>
+
+uint32_t tpm_start(void);
+uint32_t tpm_unassert_pp(void);
+
+#endif /* TCGBIOS_H */
diff --git a/lib/libtpm/tcgbios_int.h b/lib/libtpm/tcgbios_int.h
new file mode 100644
index 0000000..c8caf3b
--- /dev/null
+++ b/lib/libtpm/tcgbios_int.h
@@ -0,0 +1,162 @@
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
+#ifndef TCGBIOS_INT_H
+#define TCGBIOS_INT_H
+
+#include <stdint.h>
+
+#include "tpm_drivers.h"
+
+/* internal error codes */
+#define TCGBIOS_OK                       0x0
+#define TCGBIOS_LOGOVERFLOW              0x1
+#define TCGBIOS_GENERAL_ERROR            0x2
+#define TCGBIOS_FIRMWARE_ERROR           0x3
+#define TCGBIOS_FATAL_COM_ERROR          0x4
+#define TCGBIOS_INVALID_INPUT_PARA       0x5
+#define TCGBIOS_COMMAND_ERROR            0x6
+#define TCGBIOS_INTERFACE_SHUTDOWN       0x7
+
+#define TPM_ORD_SelfTestFull             0x00000050
+#define TPM_ORD_ForceClear               0x0000005d
+#define TPM_ORD_GetCapability            0x00000065
+#define TPM_ORD_PhysicalEnable           0x0000006f
+#define TPM_ORD_PhysicalDisable          0x00000070
+#define TPM_ORD_SetOwnerInstall          0x00000071
+#define TPM_ORD_PhysicalSetDeactivated   0x00000072
+#define TPM_ORD_Startup                  0x00000099
+#define TPM_ORD_PhysicalPresence         0x4000000a
+#define TPM_ORD_Extend                   0x00000014
+#define TPM_ORD_SHA1Start                0x000000a0
+#define TPM_ORD_SHA1Update               0x000000a1
+#define TPM_ORD_SHA1Complete             0x000000a2
+
+#define TPM_ST_CLEAR                     0x1
+#define TPM_ST_STATE                     0x2
+#define TPM_ST_DEACTIVATED               0x3
+
+#define TPM_TAG_RQU_CMD                  0x00c1
+
+/* TPM command error codes */
+#define TPM_INVALID_POSTINIT             0x26
+
+/* event types */
+#define EV_POST_CODE             1
+#define EV_SEPARATOR             4
+#define EV_ACTION                5
+#define EV_EVENT_TAG             6
+#define EV_COMPACT_HASH         12
+#define EV_IPL                  13
+#define EV_IPL_PARTITION_DATA   14
+
+#define STATUS_FLAG_SHUTDOWN        (1 << 0)
+
+#define SHA1_BUFSIZE                20
+
+struct iovec {
+    size_t length;
+    void   *data;
+};
+
+/* Input and Output blocks for the TCG BIOS commands */
+
+/* PCClient_PCREventStruct -- format of log entries; compatible with x86 */
+struct pcpes {
+    uint32_t pcrindex;
+    uint32_t eventtype;
+    uint8_t digest[SHA1_BUFSIZE];
+    uint32_t eventdatasize;
+    uint32_t event;
+} __attribute__((packed));
+
+#define TPM_REQ_HEADER \
+    uint16_t tag; \
+    uint32_t totlen; \
+    uint32_t ordinal;
+
+#define TPM_REQ_HEADER_SIZE  (sizeof(uint16_t) + sizeof(uint32_t) + sizeof(uint32_t))
+
+#define TPM_RSP_HEADER \
+    uint16_t tag; \
+    uint32_t totlen; \
+    uint32_t errcode;
+
+#define TPM_RSP_HEADER_SIZE  (sizeof(uint16_t) + sizeof(uint32_t) + sizeof(uint32_t))
+
+struct tpm_req_header {
+    TPM_REQ_HEADER;
+} __attribute__((packed));
+
+struct tpm_rsp_header {
+    TPM_RSP_HEADER;
+} __attribute__((packed));
+
+struct tpm_req_extend {
+    TPM_REQ_HEADER
+    uint32_t pcrindex;
+    uint8_t digest[SHA1_BUFSIZE];
+} __attribute__((packed));
+
+struct tpm_rsp_extend {
+    TPM_RSP_HEADER
+    uint8_t digest[SHA1_BUFSIZE];
+} __attribute__((packed));
+
+struct tpm_req_getcap_perm_flags {
+    TPM_REQ_HEADER
+    uint32_t capArea;
+    uint32_t subCapSize;
+    uint32_t subCap;
+} __attribute__((packed));
+
+struct tpm_permanent_flags {
+    uint16_t tag;
+    uint8_t flags[20];
+} __attribute__((packed));
+
+#define PERM_FLAG_IDX_DISABLE 0
+#define PERM_FLAG_IDX_OWNERSHIP 1
+#define PERM_FLAG_IDX_DEACTIVATED 2
+#define PERM_FLAG_IDX_DISABLEOWNERCLEAR 4
+#define PERM_FLAG_IDX_PHYSICAL_PRESENCE_LIFETIME_LOCK 6
+#define PERM_FLAG_IDX_PHYSICAL_PRESENCE_HW_ENABLE 7
+
+struct tpm_res_getcap_perm_flags {
+    TPM_RSP_HEADER
+    uint32_t    size;
+    struct tpm_permanent_flags perm_flags;
+} __attribute__((packed));
+
+struct tpm_res_getcap_ownerauth {
+    TPM_RSP_HEADER
+    uint32_t    size;
+    uint8_t     flag;
+} __attribute__((packed));
+
+struct tpm_res_getcap_durations {
+    TPM_RSP_HEADER
+    uint32_t    size;
+    uint32_t    durations[TPM_NUM_DURATIONS];
+} __attribute__((packed));
+
+struct tpm_res_sha1start {
+    TPM_RSP_HEADER
+    uint32_t    max_num_bytes;
+} __attribute__((packed));
+
+struct tpm_res_sha1complete {
+    TPM_RSP_HEADER
+    uint8_t     hash[SHA1_BUFSIZE];
+} __attribute__((packed));
+
+#endif /* TCGBIOS_INT_H */
diff --git a/lib/libtpm/tpm.code b/lib/libtpm/tpm.code
new file mode 100644
index 0000000..567b384
--- /dev/null
+++ b/lib/libtpm/tpm.code
@@ -0,0 +1,37 @@
+/******************************************************************************
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
+/*
+ * libtpm bindings for SLOF - implementation
+ */
+
+#include <tcgbios.h>
+
+
+/************************************************/
+/* Startup TPM code                             */
+/* SLOF:   tpm-start  ( -- errcode )            */
+/* LIBNEWUSB: tpm_start(void)                   */
+/************************************************/
+PRIM(tpm_X2d_start)
+	PUSH;
+	TOS.n = tpm_start();
+MIRP
+
+/************************************************/
+/* Prepare TPM state for bootloader             */
+/* SLOF:   tpm-unassert-pp ( -- errcode )       */
+/* LIBNEWUSB: tpm_unassert_pp(void)             */
+/************************************************/
+PRIM(tpm_X2d_unassert_X2d_pp)
+	PUSH;
+	TOS.n = tpm_unassert_pp();
+MIRP
diff --git a/lib/libtpm/tpm.in b/lib/libtpm/tpm.in
new file mode 100644
index 0000000..266439e
--- /dev/null
+++ b/lib/libtpm/tpm.in
@@ -0,0 +1,17 @@
+/******************************************************************************
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
+/*
+ * libtpm bindings for SLOF - definitions
+ */
+
+cod(tpm-start)
+cod(tpm-unassert-pp)
diff --git a/slof/fs/tpm/tpm-static.fs b/slof/fs/tpm/tpm-static.fs
new file mode 100644
index 0000000..11e4ad5
--- /dev/null
+++ b/slof/fs/tpm/tpm-static.fs
@@ -0,0 +1,34 @@
+\ *****************************************************************************
+\ * Copyright (c) 2015 IBM Corporation
+\ * All rights reserved.
+\ * This program and the accompanying materials
+\ * are made available under the terms of the BSD License
+\ * which accompanies this distribution, and is available at
+\ * http://www.opensource.org/licenses/bsd-license.php
+\ *
+\ * Contributors:
+\ *     IBM Corporation - initial implementation
+\ ****************************************************************************/
+
+false VALUE vtpm-debug?
+
+\ none of the vTPM functions may be called if the alias is not there
+: vtpm-available?
+    " ibm,vtpm" find-alias 0 <> IF
+        drop
+        true
+    ELSE
+        false
+    THEN
+;
+
+: vtpm-unassert-pp
+    vtpm-available? IF
+        tpm-unassert-pp                                    ( -- errcode )
+        vtpm-debug? IF
+            ." VTPM: Error code from tpm-unassert-pp: " . cr
+        ELSE
+            drop
+        THEN
+    THEN
+;
-- 
1.9.3
