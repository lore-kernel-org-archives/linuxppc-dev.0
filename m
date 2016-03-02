Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 566181A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 17:13:04 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>
Subject: [PATCH] powerpc/swsusp: Only use tlbie in POWER4 mode
Date: Wed,  2 Mar 2016 17:12:45 +1100
Message-Id: <1456899165-21624-1-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If CONFIG_HIBERNATION and CONFIG_PPC_BOOK3S_64 are set, code in
arch/powerpc/kernel/swsusp_amd64.S which uses the tlbia macro is enabled.
tlbia in turn uses tlbie, an instruction which takes more than one
operand in newer versions of POWER.  As such, the kernel fails to build
due to the assembler complaining about missing operands.

This can be worked around by assembling the instruction as in POWER4.
This fixes the build breakage caused by enabling CONFIG_HIBERNATION.
Hibernation is currently only tested on G5 PowerMacs, which should be
unaffected by this change.  For other platforms it may now build,
whether or not it works is a different story.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/include/asm/ppc_asm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 499d9f8..2b31632 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -427,7 +427,10 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	li	r4,1024;			\
 	mtctr	r4;				\
 	lis	r4,KERNELBASE@h;		\
+	.machine push;				\
+	.machine "power4";			\
 0:	tlbie	r4;				\
+	.machine pop;				\
 	addi	r4,r4,0x1000;			\
 	bdnz	0b
 #endif
-- 
2.7.2
