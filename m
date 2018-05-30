Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wlTW4DXDzDrBy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 19:21:35 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id i5-v6so10723260plt.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 02:21:35 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v7 2/5] powerpc: add vcmpequd/vcmpequb ppc instruction macro
Date: Wed, 30 May 2018 17:21:00 +0800
Message-Id: <1527672063-6953-3-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1527672063-6953-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527672063-6953-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

Some old tool chains don't know about instructions like vcmpequd.

This patch adds .long macro for vcmpequd and vcmpequb, which is
a preparation to optimize ppc64 memcmp with VMX instructions.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/ppc-opcode.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 18883b8..1866a97 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -366,6 +366,8 @@
 #define PPC_INST_STFDX			0x7c0005ae
 #define PPC_INST_LVX			0x7c0000ce
 #define PPC_INST_STVX			0x7c0001ce
+#define PPC_INST_VCMPEQUD		0x100000c7
+#define PPC_INST_VCMPEQUB		0x10000006
 
 /* macros to insert fields into opcodes */
 #define ___PPC_RA(a)	(((a) & 0x1f) << 16)
@@ -396,6 +398,7 @@
 #define __PPC_BI(s)	(((s) & 0x1f) << 16)
 #define __PPC_CT(t)	(((t) & 0x0f) << 21)
 #define __PPC_SPR(r)	((((r) & 0x1f) << 16) | ((((r) >> 5) & 0x1f) << 11))
+#define __PPC_RC21	(0x1 << 10)
 
 /*
  * Only use the larx hint bit on 64bit CPUs. e500v1/v2 based CPUs will treat a
@@ -567,4 +570,12 @@
 				       ((IH & 0x7) << 21))
 #define PPC_INVALIDATE_ERAT	PPC_SLBIA(7)
 
+#define VCMPEQUD_RC(vrt, vra, vrb)	stringify_in_c(.long PPC_INST_VCMPEQUD | \
+			      ___PPC_RT(vrt) | ___PPC_RA(vra) | \
+			      ___PPC_RB(vrb) | __PPC_RC21)
+
+#define VCMPEQUB_RC(vrt, vra, vrb)	stringify_in_c(.long PPC_INST_VCMPEQUB | \
+			      ___PPC_RT(vrt) | ___PPC_RA(vra) | \
+			      ___PPC_RB(vrb) | __PPC_RC21)
+
 #endif /* _ASM_POWERPC_PPC_OPCODE_H */
-- 
1.8.3.1
