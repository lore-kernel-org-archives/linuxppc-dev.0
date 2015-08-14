Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CA381A1D84
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 17:44:09 +1000 (AEST)
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 192FF140291
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 17:44:09 +1000 (AEST)
Received: by pdbfa8 with SMTP id fa8so28561477pdb.1
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:44:07 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v5 01/11] cxl: Convert MMIO read/write macros to inline
 functions
Date: Fri, 14 Aug 2015 17:41:17 +1000
Message-Id: <1439538087-32137-2-git-send-email-dja@axtens.net>
In-Reply-To: <1439538087-32137-1-git-send-email-dja@axtens.net>
References: <1439538087-32137-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We're about to make these more complex, so make them functions
first.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/cxl.h | 51 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 4fd66cabde1e..6a93bfbcd826 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -537,10 +537,15 @@ static inline void __iomem *_cxl_p1_addr(struct cxl *cxl, cxl_p1_reg_t reg)
 	return cxl->p1_mmio + cxl_reg_off(reg);
 }
 
-#define cxl_p1_write(cxl, reg, val) \
-	out_be64(_cxl_p1_addr(cxl, reg), val)
-#define cxl_p1_read(cxl, reg) \
-	in_be64(_cxl_p1_addr(cxl, reg))
+static inline void cxl_p1_write(struct cxl *cxl, cxl_p1_reg_t reg, u64 val)
+{
+	out_be64(_cxl_p1_addr(cxl, reg), val);
+}
+
+static inline u64 cxl_p1_read(struct cxl *cxl, cxl_p1_reg_t reg)
+{
+	return in_be64(_cxl_p1_addr(cxl, reg));
+}
 
 static inline void __iomem *_cxl_p1n_addr(struct cxl_afu *afu, cxl_p1n_reg_t reg)
 {
@@ -548,26 +553,40 @@ static inline void __iomem *_cxl_p1n_addr(struct cxl_afu *afu, cxl_p1n_reg_t reg
 	return afu->p1n_mmio + cxl_reg_off(reg);
 }
 
-#define cxl_p1n_write(afu, reg, val) \
-	out_be64(_cxl_p1n_addr(afu, reg), val)
-#define cxl_p1n_read(afu, reg) \
-	in_be64(_cxl_p1n_addr(afu, reg))
+static inline void cxl_p1n_write(struct cxl_afu *afu, cxl_p1n_reg_t reg, u64 val)
+{
+	out_be64(_cxl_p1n_addr(afu, reg), val);
+}
+
+static inline u64 cxl_p1n_read(struct cxl_afu *afu, cxl_p1n_reg_t reg)
+{
+	return in_be64(_cxl_p1n_addr(afu, reg));
+}
 
 static inline void __iomem *_cxl_p2n_addr(struct cxl_afu *afu, cxl_p2n_reg_t reg)
 {
 	return afu->p2n_mmio + cxl_reg_off(reg);
 }
 
-#define cxl_p2n_write(afu, reg, val) \
-	out_be64(_cxl_p2n_addr(afu, reg), val)
-#define cxl_p2n_read(afu, reg) \
-	in_be64(_cxl_p2n_addr(afu, reg))
+static inline void cxl_p2n_write(struct cxl_afu *afu, cxl_p2n_reg_t reg, u64 val)
+{
+	out_be64(_cxl_p2n_addr(afu, reg), val);
+}
 
+static inline u64 cxl_p2n_read(struct cxl_afu *afu, cxl_p2n_reg_t reg)
+{
+	return in_be64(_cxl_p2n_addr(afu, reg));
+}
 
-#define cxl_afu_cr_read64(afu, cr, off) \
-	in_le64((afu)->afu_desc_mmio + (afu)->crs_offset + ((cr) * (afu)->crs_len) + (off))
-#define cxl_afu_cr_read32(afu, cr, off) \
-	in_le32((afu)->afu_desc_mmio + (afu)->crs_offset + ((cr) * (afu)->crs_len) + (off))
+static inline u64 cxl_afu_cr_read64(struct cxl_afu *afu, int cr, u64 off)
+{
+	return in_le64((afu)->afu_desc_mmio + (afu)->crs_offset + ((cr) * (afu)->crs_len) + (off));
+}
+
+static inline u32 cxl_afu_cr_read32(struct cxl_afu *afu, int cr, u64 off)
+{
+	return in_le32((afu)->afu_desc_mmio + (afu)->crs_offset + ((cr) * (afu)->crs_len) + (off));
+}
 u16 cxl_afu_cr_read16(struct cxl_afu *afu, int cr, u64 off);
 u8 cxl_afu_cr_read8(struct cxl_afu *afu, int cr, u64 off);
 
-- 
2.1.4
