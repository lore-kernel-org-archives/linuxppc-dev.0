Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Add real mode cache inhibited IO accessors
Date: Fri, 29 Nov 2013 13:27:18 +1100
Message-Id: <1385692038-1342-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

These accessors allow us to do cache inhibited accesses when in real
mode. They should only be used in real mode.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/io.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 575fbf8..97d3869 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -191,8 +191,24 @@ DEF_MMIO_OUT_D(out_le32, 32, stw);
 
 #endif /* __BIG_ENDIAN */
 
+/*
+ * Cache inhibitied accessors for use in real mode, you don't want to use these
+ * unless you know what you're doing.
+ *
+ * NB. These use the cpu byte ordering.
+ */
+DEF_MMIO_OUT_X(out_rm8,   8, stbcix);
+DEF_MMIO_OUT_X(out_rm16, 16, sthcix);
+DEF_MMIO_OUT_X(out_rm32, 32, stwcix);
+DEF_MMIO_IN_X(in_rm8,   8, lbzcix);
+DEF_MMIO_IN_X(in_rm16, 16, lhzcix);
+DEF_MMIO_IN_X(in_rm32, 32, lwzcix);
+
 #ifdef __powerpc64__
 
+DEF_MMIO_OUT_X(out_rm64, 64, stdcix);
+DEF_MMIO_IN_X(in_rm64, 64, ldcix);
+
 #ifdef __BIG_ENDIAN__
 DEF_MMIO_OUT_D(out_be64, 64, std);
 DEF_MMIO_IN_D(in_be64, 64, ld);
-- 
1.8.3.2
