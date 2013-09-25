Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc: Add real mode cache inhibited IO accessors
Date: Wed, 25 Sep 2013 15:38:52 +1000
Message-Id: <1380087532-20219-2-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1380087532-20219-1-git-send-email-michael@ellerman.id.au>
References: <1380087532-20219-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These accessors allow us to do cache inhibited accesses when in real
mode. They should only be used in real mode.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/io.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 8b3bd66..1cac8d3 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -178,10 +178,24 @@ DEF_MMIO_OUT_DFORM(out_be32, 32, stw);
 DEF_MMIO_OUT_XFORM(out_le16, 16, sthbrx);
 DEF_MMIO_OUT_XFORM(out_le32, 32, stwbrx);
 
+/*
+ * Cache inhibitied accessors for use in real mode, you don't want to use these
+ * unless you know what you're doing.
+ */
+DEF_MMIO_OUT_XFORM(out_rm8,   8, stbcix);
+DEF_MMIO_OUT_XFORM(out_rm16, 16, sthcix);
+DEF_MMIO_OUT_XFORM(out_rm32, 32, stwcix);
+DEF_MMIO_IN_XFORM(in_rm8,   8, lbzcix);
+DEF_MMIO_IN_XFORM(in_rm16, 16, lhzcix);
+DEF_MMIO_IN_XFORM(in_rm32, 32, lwzcix);
+
 #ifdef __powerpc64__
 DEF_MMIO_OUT_DFORM(out_be64, 64, std);
 DEF_MMIO_IN_DFORM(in_be64, 64, ld);
 
+DEF_MMIO_OUT_XFORM(out_rm64, 64, stdcix);
+DEF_MMIO_IN_XFORM(in_rm64, 64, ldcix);
+
 /* There is no asm instructions for 64 bits reverse loads and stores */
 static inline u64 in_le64(const volatile u64 __iomem *addr)
 {
-- 
1.8.1.2
