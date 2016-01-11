Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FBB41A0202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 13:59:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: tuliom@linux.vnet.ibm.com, adhemerval.zanella@linaro.org,
 cseo@linux.vnet.ibm.com, bergner@vnet.ibm.com, sjmunroe@us.ibm.com
Subject: [PATCH] powerpc: Add HWCAP bits for Power9
Date: Mon, 11 Jan 2016 13:59:04 +1100
Message-Id: <1452481144-26173-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to support Power9 we need two new HWCAP bits. We are merging
these ahead of the cputable entry so that glibc can start referring to
them.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/uapi/asm/cputable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
index 43686043e297..8dde19962a5b 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -43,5 +43,7 @@
 #define PPC_FEATURE2_TAR		0x04000000
 #define PPC_FEATURE2_VEC_CRYPTO		0x02000000
 #define PPC_FEATURE2_HTM_NOSC		0x01000000
+#define PPC_FEATURE2_ARCH_3_00		0x00800000 /* ISA 3.00 */
+#define PPC_FEATURE2_HAS_IEEE128	0x00400000 /* VSX IEEE Binary Float 128-bit */
 
 #endif /* _UAPI__ASM_POWERPC_CPUTABLE_H */
-- 
2.5.0
