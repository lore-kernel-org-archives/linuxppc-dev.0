Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFF2C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:20:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054BF2075E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054BF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ycv24XXzzDqR0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 05:19:58 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Ycnl1yMTzDqMW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 05:15:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Ycnl0Bgfz8x89
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 05:15:23 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Ycnk6XjHz9sDB; Wed,  3 Apr 2019 05:15:22 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=cclaudio@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Ycnk3g9gz9s9y
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Apr 2019 05:15:22 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x32I9Zod142187
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Apr 2019 14:15:21 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rmbn4kw9g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 02 Apr 2019 14:15:20 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cclaudio@linux.ibm.com>;
 Tue, 2 Apr 2019 19:15:19 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 2 Apr 2019 19:15:15 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x32IFEYX10158236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Apr 2019 18:15:14 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41C18112061;
 Tue,  2 Apr 2019 18:15:14 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53553112063;
 Tue,  2 Apr 2019 18:15:12 +0000 (GMT)
Received: from rino.br.ibm.com (unknown [9.18.235.111])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  2 Apr 2019 18:15:12 +0000 (GMT)
From: Claudio Carvalho <cclaudio@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] powerpc/powernv: Add support for OPAL secure variables
Date: Tue,  2 Apr 2019 15:15:03 -0300
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402181505.25037-1-cclaudio@linux.ibm.com>
References: <20190402181505.25037-1-cclaudio@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040218-0072-0000-0000-000004148535
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010862; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183360; UDB=6.00619523; IPR=6.00964108; 
 MB=3.00026263; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 18:15:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040218-0073-0000-0000-00004BB0048F
Message-Id: <20190402181505.25037-3-cclaudio@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-02_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020121
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Nayna Jain <nayna@linux.ibm.com>, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The X.509 certificates trusted by the platform and other information
required to secure boot the host OS kernel are wrapped in secure
variables, which are controlled by OPAL.

The OPAL secure variables can be handled through the following OPAL
calls.

OPAL_SECVAR_GET:
Returns the data for a given secure variable name and vendor GUID.

OPAL_SECVAR_GET_NEXT:
For a given secure variable, it returns the name and vendor GUID
of the next variable.

OPAL_SECVAR_ENQUEUE:
Enqueue the supplied secure variable update so that it can be processed
by OPAL in the next boot. Variable updates cannot be be processed right
away because the variable storage is write locked at runtime.

OPAL_SECVAR_INFO:
Returns size information about the variable.

This patch adds support for OPAL secure variables by setting up the EFI
runtime variable services to make OPAL calls.

This patch also introduces CONFIG_OPAL_SECVAR for enabling the OPAL
secure variables support in the kernel. Since CONFIG_OPAL_SECVAR selects
CONFIG_EFI, it also allow us to manage the OPAL secure variables from
userspace via efivarfs.

Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
---
This patch depends on new OPAL calls that are being added to skiboot.
The patch set that implements the new calls has been posted to
https://patchwork.ozlabs.org/project/skiboot/list/?series=99805
---
 arch/powerpc/include/asm/opal-api.h          |   6 +-
 arch/powerpc/include/asm/opal.h              |  10 ++
 arch/powerpc/platforms/Kconfig               |   3 +
 arch/powerpc/platforms/powernv/Kconfig       |   9 +
 arch/powerpc/platforms/powernv/Makefile      |   1 +
 arch/powerpc/platforms/powernv/opal-call.c   |   4 +
 arch/powerpc/platforms/powernv/opal-secvar.c | 179 +++++++++++++++++++
 7 files changed, 211 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-secvar.c

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 870fb7b239ea..d3066f29cb7a 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -210,7 +210,11 @@
 #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
 #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
 #define	OPAL_NX_COPROC_INIT			167
-#define OPAL_LAST				167
+#define OPAL_SECVAR_GET				170
+#define OPAL_SECVAR_GET_NEXT			171
+#define OPAL_SECVAR_ENQUEUE			172
+#define OPAL_SECVAR_INFO			173
+#define OPAL_LAST				173
 
 #define QUIESCE_HOLD			1 /* Spin all calls at entry */
 #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index a55b01c90bb1..fdfd8dd7b326 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -385,6 +385,16 @@ void opal_powercap_init(void);
 void opal_psr_init(void);
 void opal_sensor_groups_init(void);
 
+extern int opal_secvar_get(uint64_t name, uint64_t vendor, uint64_t attr,
+			   uint64_t data_size, uint64_t data);
+extern int opal_secvar_get_next(uint64_t name_size, uint64_t name,
+				uint64_t vendor);
+extern int opal_secvar_enqueue(uint64_t name, uint64_t vendor, uint64_t attr,
+			       uint64_t data_size, uint64_t data);
+extern int opal_secvar_info(uint64_t attr, uint64_t storage_space,
+			    uint64_t remaining_space,
+			    uint64_t max_variable_size);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_OPAL_H */
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index f3fb79fccc72..8e30510bc0c1 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -326,4 +326,7 @@ config XILINX_PCI
 	bool "Xilinx PCI host bridge support"
 	depends on PCI && XILINX_VIRTEX
 
+config EFI
+	bool
+
 endmenu
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 850eee860cf2..879f8e766098 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -47,3 +47,12 @@ config PPC_VAS
 	  VAS adapters are found in POWER9 based systems.
 
 	  If unsure, say N.
+
+config OPAL_SECVAR
+	bool "OPAL Secure Variables"
+	depends on PPC_POWERNV && !CPU_BIG_ENDIAN
+	select UCS2_STRING
+	select EFI
+	help
+	  This enables the kernel to access OPAL secure variables via EFI
+	  runtime variable services.
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index da2e99efbd04..1511d836fd19 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_PERF_EVENTS) += opal-imc.o
 obj-$(CONFIG_PPC_MEMTRACE)	+= memtrace.o
 obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o
 obj-$(CONFIG_OCXL_BASE)	+= ocxl.o
+obj-$(CONFIG_OPAL_SECVAR)	+= opal-secvar.o
diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
index daad8c45c8e7..8c791c4c187b 100644
--- a/arch/powerpc/platforms/powernv/opal-call.c
+++ b/arch/powerpc/platforms/powernv/opal-call.c
@@ -282,3 +282,7 @@ OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
 OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
 OPAL_CALL(opal_nx_coproc_init,			OPAL_NX_COPROC_INIT);
+OPAL_CALL(opal_secvar_get,			OPAL_SECVAR_GET);
+OPAL_CALL(opal_secvar_get_next,			OPAL_SECVAR_GET_NEXT);
+OPAL_CALL(opal_secvar_enqueue,			OPAL_SECVAR_ENQUEUE);
+OPAL_CALL(opal_secvar_info,			OPAL_SECVAR_INFO)
diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
new file mode 100644
index 000000000000..e333828bd0bc
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-secvar.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PowerNV code for secure variables
+ *
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Claudio Carvalho <cclaudio@linux.ibm.com>
+ *
+ */
+#define pr_fmt(fmt) "secvar: "fmt
+
+#include <linux/efi.h>
+#include <asm/machdep.h>
+#include <asm/opal.h>
+
+static bool opal_secvar_supported;
+
+static efi_status_t opal_to_efi_status_log(int rc, const char *func_name)
+{
+	efi_status_t status;
+
+	switch (rc) {
+	case OPAL_EMPTY:
+		status = EFI_NOT_FOUND;
+		break;
+	case OPAL_HARDWARE:
+		status = EFI_DEVICE_ERROR;
+		break;
+	case OPAL_NO_MEM:
+		pr_err("%s: No space in the volatile storage\n", func_name);
+		status = EFI_OUT_OF_RESOURCES;
+		break;
+	case OPAL_PARAMETER:
+		status = EFI_INVALID_PARAMETER;
+		break;
+	case OPAL_PARTIAL:
+		status = EFI_BUFFER_TOO_SMALL;
+		break;
+	case OPAL_PERMISSION:
+		status = EFI_WRITE_PROTECTED;
+		break;
+	case OPAL_RESOURCE:
+		pr_err("%s: No space in the non-volatile storage\n", func_name);
+		status = EFI_OUT_OF_RESOURCES;
+		break;
+	case OPAL_SUCCESS:
+		status = EFI_SUCCESS;
+		break;
+	default:
+		pr_err("%s: Unknown OPAL error %d\n", func_name, rc);
+		status = EFI_DEVICE_ERROR;
+		break;
+	}
+
+	return status;
+}
+
+#define opal_to_efi_status(rc) opal_to_efi_status_log(rc, __func__)
+
+static efi_status_t
+opal_get_variable(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
+		  unsigned long *data_size, void *data)
+{
+	int rc;
+
+	if (!opal_secvar_supported)
+		return EFI_UNSUPPORTED;
+
+	*data_size = cpu_to_be64(*data_size);
+
+	rc = opal_secvar_get(__pa(name), __pa(vendor), __pa(attr),
+			     __pa(data_size), __pa(data));
+	/*
+	 * The @attr is an optional output parameter. It is returned in
+	 * big-endian.
+	 */
+	if (attr)
+		*attr = be32_to_cpup(attr);
+	*data_size = be64_to_cpu(*data_size);
+
+	return opal_to_efi_status(rc);
+}
+
+static efi_status_t
+opal_get_next_variable(unsigned long *name_size, efi_char16_t *name,
+		       efi_guid_t *vendor)
+{
+	int rc;
+
+	if (!opal_secvar_supported)
+		return EFI_UNSUPPORTED;
+
+	*name_size = cpu_to_be64(*name_size);
+
+	rc = opal_secvar_get_next(__pa(name_size), __pa(name),
+				  __pa(vendor));
+
+	*name_size = be64_to_cpu(*name_size);
+
+	return opal_to_efi_status(rc);
+}
+
+static efi_status_t
+opal_set_variable(efi_char16_t *name, efi_guid_t *vendor, u32 attr,
+		  unsigned long data_size, void *data)
+{
+	int rc;
+
+	if (!opal_secvar_supported)
+		return EFI_UNSUPPORTED;
+	/*
+	 * The secure variable update must be enqueued in order to be processed
+	 * in the next boot by firmware. The secure variable storage is write
+	 * locked at runtime.
+	 */
+	rc = opal_secvar_enqueue(__pa(name), __pa(vendor), attr,
+				 data_size, __pa(data));
+	return opal_to_efi_status(rc);
+}
+
+static efi_status_t
+opal_query_variable_info(u32 attr, u64 *storage_space, u64 *remaining_space,
+			 u64 *max_variable_size)
+{
+	int rc;
+
+	if (!opal_secvar_supported)
+		return EFI_UNSUPPORTED;
+
+	*storage_space = cpu_to_be64p(storage_space);
+	*remaining_space = cpu_to_be64p(remaining_space);
+	*max_variable_size = cpu_to_be64p(max_variable_size);
+
+	rc = opal_secvar_info(attr, __pa(storage_space), __pa(remaining_space),
+			      __pa(max_variable_size));
+
+	*storage_space = be64_to_cpup(storage_space);
+	*remaining_space = be64_to_cpup(remaining_space);
+	*max_variable_size = be64_to_cpup(max_variable_size);
+
+	return opal_to_efi_status(rc);
+}
+
+static void pnv_efi_runtime_setup(void)
+{
+	/*
+	 * The opal wrappers below treat the @name, @vendor, and @data
+	 * parameters as little endian blobs.
+	 * @name is a ucs2 string
+	 * @vendor is the vendor GUID. It is converted to LE in the kernel
+	 * @data variable data, which layout may be different for each variable
+	 */
+	efi.get_variable = opal_get_variable;
+	efi.get_next_variable = opal_get_next_variable;
+	efi.set_variable = opal_set_variable;
+	efi.query_variable_info = opal_query_variable_info;
+
+	if (!opal_check_token(OPAL_SECVAR_GET) ||
+	    !opal_check_token(OPAL_SECVAR_GET_NEXT) ||
+	    !opal_check_token(OPAL_SECVAR_ENQUEUE) ||
+	    !opal_check_token(OPAL_SECVAR_INFO)) {
+		pr_err("OPAL doesn't support secure variables\n");
+		opal_secvar_supported = false;
+	} else {
+		opal_secvar_supported = true;
+	}
+}
+
+static int __init pnv_efi_init(void)
+{
+	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+	set_bit(EFI_BOOT, &efi.flags);
+
+	if (IS_ENABLED(CONFIG_64BIT))
+		set_bit(EFI_64BIT, &efi.flags);
+
+	pnv_efi_runtime_setup();
+	return 0;
+}
+machine_arch_initcall(powernv, pnv_efi_init);
-- 
2.20.1

