Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E755EDE044
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 01:16:28 +1000 (EST)
Date: Tue, 1 Jul 2008 10:16:16 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 1/2] powerpc: Fix building of feature-fixup tests on ppc32
Message-ID: <Pine.LNX.4.64.0807011015390.20129@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to use PPC_LCMPI otherwise we get compile errors like:

arch/powerpc/lib/feature-fixups-test.S: Assembler messages:
arch/powerpc/lib/feature-fixups-test.S:142: Error: Unrecognized opcode: `cmpdi'
arch/powerpc/lib/feature-fixups-test.S:149: Error: Unrecognized opcode: `cmpdi'
arch/powerpc/lib/feature-fixups-test.S:164: Error: Unrecognized opcode: `cmpdi'

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/lib/feature-fixups-test.S |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/lib/feature-fixups-test.S b/arch/powerpc/lib/feature-fixups-test.S
index 10d038b..0549be0 100644
--- a/arch/powerpc/lib/feature-fixups-test.S
+++ b/arch/powerpc/lib/feature-fixups-test.S
@@ -139,14 +139,14 @@ globl(ftr_fixup_test6)
 1:	or	1,1,1
 BEGIN_FTR_SECTION
 	or	5,5,5
-2:	cmpdi	r3,0
+2:	PPC_LCMPI	r3,0
 	beq	4f
 	blt	2b
 	b	1b
 	b	4f
 FTR_SECTION_ELSE
 2:	or	2,2,2
-	cmpdi	r3,1
+	PPC_LCMPI	r3,1
 	beq	3f
 	blt	2b
 	b	3f
@@ -161,7 +161,7 @@ globl(end_ftr_fixup_test6)
 globl(ftr_fixup_test6_expected)
 1:	or	1,1,1
 2:	or	2,2,2
-	cmpdi	r3,1
+	PPC_LCMPI	r3,1
 	beq	3f
 	blt	2b
 	b	3f
-- 
1.5.5.1
