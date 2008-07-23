Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF02BDE825
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 04:29:06 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6NIT2MW006598
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:29:02 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6NIT3WC205074
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:29:03 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6NIT2I2032649
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:29:02 -0400
Date: Wed, 23 Jul 2008 13:29:03 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 05/16 v4] powerpc: Enable CMO feature during platform setup
Message-ID: <20080723182902.GH12905@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080723181932.GC12905@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Robert Jennings <rcj@linux.vnet.ibm.com>

For Cooperative Memory Overcommitment (CMO), set the FW_FEATURE_CMO
flag in powerpc_firmware_features from the rtas ibm,get-system-parameters
table prior to calling iommu_init_early_pSeries.

With this, any CMO specific functionality can be controlled by checking:
 firmware_has_feature(FW_FEATURE_CMO)

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
Correct string conversion for rtas value being read for CMO configuration.
A value of -1 in the string indicates that CMO is not enabled and we
had used simple_strtoul rather than simple_strtol.

---
 arch/powerpc/platforms/pseries/setup.c |   71 ++++++++++++++++++++++++++++=
+++++
 include/asm-powerpc/firmware.h         |    3 +
 2 files changed, 73 insertions(+), 1 deletion(-)

Index: b/arch/powerpc/platforms/pseries/setup.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -314,6 +314,76 @@ static int pseries_set_xdabr(unsigned lo
 			H_DABRX_KERNEL | H_DABRX_USER);
 }
=20
+#define CMO_CHARACTERISTICS_TOKEN 44
+#define CMO_MAXLENGTH 1026
+
+/**
+ * fw_cmo_feature_init - FW_FEATURE_CMO is not stored in ibm,hypertas-func=
tions,
+ * handle that here. (Stolen from parse_system_parameter_string)
+ */
+void pSeries_cmo_feature_init(void)
+{
+	char *ptr, *key, *value, *end;
+	int call_status;
+	int PrPSP =3D -1;
+	int SecPSP =3D -1;
+
+	pr_debug(" -> fw_cmo_feature_init()\n");
+	spin_lock(&rtas_data_buf_lock);
+	memset(rtas_data_buf, 0, RTAS_DATA_BUF_SIZE);
+	call_status =3D rtas_call(rtas_token("ibm,get-system-parameter"), 3, 1,
+				NULL,
+				CMO_CHARACTERISTICS_TOKEN,
+				__pa(rtas_data_buf),
+				RTAS_DATA_BUF_SIZE);
+
+	if (call_status !=3D 0) {
+		spin_unlock(&rtas_data_buf_lock);
+		pr_debug("CMO not available\n");
+		pr_debug(" <- fw_cmo_feature_init()\n");
+		return;
+	}
+
+	end =3D rtas_data_buf + CMO_MAXLENGTH - 2;
+	ptr =3D rtas_data_buf + 2;	/* step over strlen value */
+	key =3D value =3D ptr;
+
+	while (*ptr && (ptr <=3D end)) {
+		/* Separate the key and value by replacing '=3D' with '\0' and
+		 * point the value at the string after the '=3D'
+		 */
+		if (ptr[0] =3D=3D '=3D') {
+			ptr[0] =3D '\0';
+			value =3D ptr + 1;
+		} else if (ptr[0] =3D=3D '\0' || ptr[0] =3D=3D ',') {
+			/* Terminate the string containing the key/value pair */
+			ptr[0] =3D '\0';
+
+			if (key =3D=3D value) {
+				pr_debug("Malformed key/value pair\n");
+				/* Never found a '=3D', end processing */
+				break;
+			}
+
+			if (0 =3D=3D strcmp(key, "PrPSP"))
+				PrPSP =3D simple_strtol(value, NULL, 10);
+			else if (0 =3D=3D strcmp(key, "SecPSP"))
+				SecPSP =3D simple_strtol(value, NULL, 10);
+			value =3D key =3D ptr + 1;
+		}
+		ptr++;
+	}
+
+	if (PrPSP !=3D -1 || SecPSP !=3D -1) {
+		pr_info("CMO enabled\n");
+		pr_debug("CMO enabled, PrPSP=3D%d, SecPSP=3D%d\n", PrPSP, SecPSP);
+		powerpc_firmware_features |=3D FW_FEATURE_CMO;
+	} else
+		pr_debug("CMO not enabled, PrPSP=3D%d, SecPSP=3D%d\n", PrPSP, SecPSP);
+	spin_unlock(&rtas_data_buf_lock);
+	pr_debug(" <- fw_cmo_feature_init()\n");
+}
+
 /*
  * Early initialization.  Relocation is on but do not reference unbolted p=
ages
  */
@@ -329,6 +399,7 @@ static void __init pSeries_init_early(vo
 	else if (firmware_has_feature(FW_FEATURE_XDABR))
 		ppc_md.set_dabr =3D pseries_set_xdabr;
=20
+	pSeries_cmo_feature_init();
 	iommu_init_early_pSeries();
=20
 	pr_debug(" <- pSeries_init_early()\n");
Index: b/include/asm-powerpc/firmware.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-powerpc/firmware.h
+++ b/include/asm-powerpc/firmware.h
@@ -46,6 +46,7 @@
 #define FW_FEATURE_PS3_LV1	ASM_CONST(0x0000000000800000)
 #define FW_FEATURE_BEAT		ASM_CONST(0x0000000001000000)
 #define FW_FEATURE_BULK_REMOVE	ASM_CONST(0x0000000002000000)
+#define FW_FEATURE_CMO		ASM_CONST(0x0000000004000000)
=20
 #ifndef __ASSEMBLY__
=20
@@ -58,7 +59,7 @@ enum {
 		FW_FEATURE_MIGRATE | FW_FEATURE_PERFMON | FW_FEATURE_CRQ |
 		FW_FEATURE_VIO | FW_FEATURE_RDMA | FW_FEATURE_LLAN |
 		FW_FEATURE_BULK | FW_FEATURE_XDABR | FW_FEATURE_MULTITCE |
-		FW_FEATURE_SPLPAR | FW_FEATURE_LPAR,
+		FW_FEATURE_SPLPAR | FW_FEATURE_LPAR | FW_FEATURE_CMO,
 	FW_FEATURE_PSERIES_ALWAYS =3D 0,
 	FW_FEATURE_ISERIES_POSSIBLE =3D FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
 	FW_FEATURE_ISERIES_ALWAYS =3D FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
