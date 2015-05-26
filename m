Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC7501A1174
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 10:22:05 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v2 09/21] cxl: Dump debug info on the AFU configuration record
Date: Tue, 26 May 2015 10:20:06 +1000
Message-Id: <1432599618-26844-10-git-send-email-mikey@neuling.org>
In-Reply-To: <1432599618-26844-1-git-send-email-mikey@neuling.org>
References: <1432599618-26844-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we parse the AFU Configuration record, dump some info on it when in
debug mode.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/pci.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 1ac2ecf..9066a7a 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -90,6 +90,7 @@
 /* This works a little different than the p1/p2 register accesses to make it
  * easier to pull out individual fields */
 #define AFUD_READ(afu, off)		in_be64(afu->afu_desc_mmio + off)
+#define AFUD_READ_LE(afu, off)		in_le64(afu->afu_desc_mmio + off)
 #define EXTRACT_PPC_BIT(val, bit)	(!!(val & PPC_BIT(bit)))
 #define EXTRACT_PPC_BITS(val, bs, be)	((val & PPC_BITMASK(bs, be)) >> PPC_BITLSHIFT(be))
 
@@ -286,7 +287,8 @@ static void dump_cxl_config_space(struct pci_dev *dev)
 
 static void dump_afu_descriptor(struct cxl_afu *afu)
 {
-	u64 val;
+	u64 val, afu_cr_num, afu_cr_off, afu_cr_len;
+	int i;
 
 #define show_reg(name, what) \
 	dev_info(&afu->dev, "afu desc: %30s: %#llx\n", name, what)
@@ -296,6 +298,7 @@ static void dump_afu_descriptor(struct cxl_afu *afu)
 	show_reg("num_of_processes", AFUD_NUM_PROCS(val));
 	show_reg("num_of_afu_CRs", AFUD_NUM_CRS(val));
 	show_reg("req_prog_mode", val & 0xffffULL);
+	afu_cr_num = AFUD_NUM_CRS(val);
 
 	val = AFUD_READ(afu, 0x8);
 	show_reg("Reserved", val);
@@ -307,8 +310,10 @@ static void dump_afu_descriptor(struct cxl_afu *afu)
 	val = AFUD_READ_CR(afu);
 	show_reg("Reserved", (val >> (63-7)) & 0xff);
 	show_reg("AFU_CR_len", AFUD_CR_LEN(val));
+	afu_cr_len = AFUD_CR_LEN(val) * 256;
 
 	val = AFUD_READ_CR_OFF(afu);
+	afu_cr_off = val;
 	show_reg("AFU_CR_offset", val);
 
 	val = AFUD_READ_PPPSA(afu);
@@ -325,6 +330,11 @@ static void dump_afu_descriptor(struct cxl_afu *afu)
 	val = AFUD_READ_EB_OFF(afu);
 	show_reg("AFU_EB_offset", val);
 
+	for (i = 0; i < afu_cr_num; i++) {
+		val = AFUD_READ_LE(afu, afu_cr_off + i * afu_cr_len);
+		show_reg("CR Vendor", val & 0xffff);
+		show_reg("CR Device", (val >> 16) & 0xffff);
+	}
 #undef show_reg
 }
 
-- 
2.1.0
