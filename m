Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhsYF4ZFYzDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 14:12:49 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xhsYF35h3z9sPt
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2017 14:12:49 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 01/17] powerpc: Correct instruction code for xxlor
 instruction
Date: Wed, 30 Aug 2017 14:12:24 +1000
Message-Id: <1504066360-30128-2-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
References: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The instruction code for xxlor that commit 0016a4cf5582 ("powerpc:
Emulate most Book I instructions in emulate_step()", 2010-06-15)
added is actually the code for xxlnor.  It is used in get_vsr()
and put_vsr() and the effect of the error is that if emulate_step
is used to emulate a VSX load or store from any register other
than vsr0, the bitwise complement of the correct value will be
loaded or stored.  This corrects the error.

Fixes: 0016a4cf5582 ("powerpc: Emulate most Book I instructions in emulate_step()")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/ppc-opcode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 041ba15..8861289 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -262,7 +262,7 @@
 #define PPC_INST_TLBSRX_DOT		0x7c0006a5
 #define PPC_INST_VPMSUMW		0x10000488
 #define PPC_INST_VPMSUMD		0x100004c8
-#define PPC_INST_XXLOR			0xf0000510
+#define PPC_INST_XXLOR			0xf0000490
 #define PPC_INST_XXSWAPD		0xf0000250
 #define PPC_INST_XVCPSGNDP		0xf0000780
 #define PPC_INST_TRECHKPT		0x7c0007dd
-- 
2.7.4
