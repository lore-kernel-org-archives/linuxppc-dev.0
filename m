Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BC524B71F0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 15:17:49 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 19 Jun 2009 15:17:39 +1000
Subject: [PATCH] powerpc: Map more memory early on 601 processors
Message-Id: <20090619051749.AA410DDDA0@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 32-bit kernel relies on some memory being mapped covering
the kernel text,data and bss at least, early during boot before
the full MMU setup is done. On 32-bit "classic" processors, this
is done using BAT registers.

On 601, the size of BATs is limited to 8M and we use 2 of them
for that initial mapping. This can become quite tight when enabling
features like lockdep, so let's use a 3rd one to bump that mapping
from 16M to 24M. We keep the 4th BAT free as it can be useful for
debugging early boot code to map things like serial ports.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/head_32.S |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/head_32.S	2009-06-19 10:31:41.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_32.S	2009-06-19 10:32:13.000000000 +1000
@@ -1124,9 +1124,8 @@ mmu_off:
 	RFI
 
 /*
- * Use the first pair of BAT registers to map the 1st 16MB
- * of RAM to PAGE_OFFSET.  From this point on we can't safely
- * call OF any more.
+ * On 601, we use 3 BATs to map up to 24M of RAM at _PAGE_OFFSET
+ * (we keep one for debugging) and on others, we use one 256M BAT.
  */
 initial_bats:
 	lis	r11,PAGE_OFFSET@h
@@ -1136,12 +1135,16 @@ initial_bats:
 	bne	4f
 	ori	r11,r11,4		/* set up BAT registers for 601 */
 	li	r8,0x7f			/* valid, block length = 8MB */
-	oris	r9,r11,0x800000@h	/* set up BAT reg for 2nd 8M */
-	oris	r10,r8,0x800000@h	/* set up BAT reg for 2nd 8M */
 	mtspr	SPRN_IBAT0U,r11		/* N.B. 601 has valid bit in */
 	mtspr	SPRN_IBAT0L,r8		/* lower BAT register */
-	mtspr	SPRN_IBAT1U,r9
-	mtspr	SPRN_IBAT1L,r10
+	addis	r11,r11,0x800000@h
+	addis	r8,r8,0x800000@h
+	mtspr	SPRN_IBAT1U,r11
+	mtspr	SPRN_IBAT1L,r8
+	addis	r11,r11,0x800000@h
+	addis	r8,r8,0x800000@h
+	mtspr	SPRN_IBAT2U,r11
+	mtspr	SPRN_IBAT2L,r8
 	isync
 	blr
 
