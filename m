Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C02AFB7CBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Feb 2010 18:30:21 +1100 (EST)
Subject: [PATCH] powerpc: Fix lwsync feature fixup vs. modules on 64-bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 26 Feb 2010 18:30:07 +1100
Message-ID: <1267169407.23523.1798.camel@pasglop>
Mime-Version: 1.0
Cc: Anton Blanchard <anton@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton's commit enabling the use of the lwsync fixup mechanism on 64-bit
breaks modules. The lwsync fixup section uses .long instead of the
FTR_ENTRY_OFFSET macro used by other fixups sections, and thus will
generate 32-bit relocations that our module loader cannot resolve.

This changes it to use the same type as other feature sections.

Note however that we might want to consider using 32-bit for all the
feature fixup offsets and add support for R_PPC_REL32 to module_64.c
instead as that would reduce the size of the kernel image. I'll leave
that as an exercise for the reader for now...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/feature-fixups.h |    2 +-
 arch/powerpc/lib/feature-fixups.c         |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index cbd4dfa..96a7d06 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -165,7 +165,7 @@ label##2:						\
 	.pushsection sect,"a";				\
 	.align 2;					\
 label##3:					       	\
-	.long label##1b-label##3b;			\
+	FTR_ENTRY_OFFSET label##1b-label##3b;		\
 	.popsection;
 
 #endif /* __ASM_POWERPC_FEATURE_FIXUPS_H */
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 4dee652..e640175 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -112,7 +112,8 @@ void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 {
-	int *start, *end, *dest;
+	long *start, *end;
+	unsigned int *dest;
 
 	if (!(value & CPU_FTR_LWSYNC))
 		return ;
