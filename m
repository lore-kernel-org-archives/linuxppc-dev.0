Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 512C8B7CFC
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 16:39:11 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o2B5d756012413
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 23:39:08 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Make sure lwarx hint isn't set on ppc32
Date: Wed, 10 Mar 2010 23:39:07 -0600
Message-Id: <1268285947-6114-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

e500v1/v2 based chips will treat any reserved field being set in an
opcode as illegal.  Thus always setting the hint in the opcode is
a bad idea.

Anton should be kept away from the powerpc opcode map.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/ppc-opcode.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index aea7147..d553bbe 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -25,7 +25,7 @@
 #define PPC_INST_LDARX			0x7c0000a8
 #define PPC_INST_LSWI			0x7c0004aa
 #define PPC_INST_LSWX			0x7c00042a
-#define PPC_INST_LWARX			0x7c000029
+#define PPC_INST_LWARX			0x7c000028
 #define PPC_INST_LWSYNC			0x7c2004ac
 #define PPC_INST_LXVD2X			0x7c000698
 #define PPC_INST_MCRXR			0x7c000400
@@ -62,8 +62,8 @@
 #define __PPC_T_TLB(t)	(((t) & 0x3) << 21)
 #define __PPC_WC(w)	(((w) & 0x3) << 21)
 /*
- * Only use the larx hint bit on 64bit CPUs. Once we verify it doesn't have
- * any side effects on all 32bit processors, we can do this all the time.
+ * Only use the larx hint bit on 64bit CPUs. e500v1/v2 based CPUs will treat a
+ * larx with EH set as an illegal instruction.
  */
 #ifdef CONFIG_PPC64
 #define __PPC_EH(eh)	(((eh) & 0x1) << 0)
-- 
1.6.0.6
