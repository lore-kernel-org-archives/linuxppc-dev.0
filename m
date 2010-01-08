Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 98B8FB7BF3
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jan 2010 03:53:24 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
Subject: [PATCH] 8xx: fix user space TLB walk in dcbX fixup
Date: Fri, 8 Jan 2010 17:46:26 +0100
Message-Id: <1262969186-18462-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The newly added fixup for buggy dcbX insn's has
a bug that always trigger a kernel TLB walk so a user space
dcbX insn will cause a Kernel Machine Check if it hits DTLB error.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---

I found this problem in 2.4 and forward ported it to 2.6. I
cannot test it so I cannot be 100% sure I got it right.

 arch/powerpc/kernel/head_8xx.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index ce327c5..91bef6e 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -542,11 +542,11 @@ DARFixed:/* Return from dcbx instruction bug workaround, r10 holds value of DAR
 FixupDAR:/* Entry point for dcbx workaround. */
 	/* fetch instruction from memory. */
 	mfspr	r10, SPRN_SRR0
+	andis.	r11, r10, 0x8000	/* Address >= 0x80000000 */
 	DO_8xx_CPU6(0x3780, r3)
 	mtspr	SPRN_MD_EPN, r10
 	mfspr	r11, SPRN_M_TWB	/* Get level 1 table entry address */
-	cmplwi	cr0, r11, 0x0800
-	blt-	3f		/* Branch if user space */
+	beq-	3f		/* Branch if user space */
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@h
 	ori	r11, r11, (swapper_pg_dir-PAGE_OFFSET)@l
 	rlwimi	r11, r10, 32-20, 0xffc /* r11 = r11&~0xffc|(r10>>20)&0xffc */
-- 
1.6.4.4
