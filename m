Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 2D3B92BE83
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Dec 2004 02:06:05 +1100 (EST)
Date: Wed, 15 Dec 2004 08:06:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Message-ID: <20041215150603.GD22316@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2.6.10-rc3] ppc32: Compile classic PPC specific ASM only on
	CONFIG_6xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[ I hope this can go in prior to 2.6.10 ]

Newer binutils (2.15) when they know they aren't assembling for a
classic target (say e500 instead of 750) disallow certain opcodes,
causing the compile to fail.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

---
 util.S |    2 ++
 1 files changed, 2 insertions(+)
---
Index: 2.6.10-rc3/arch/ppc/boot/common/util.S
===================================================================
--- 2.6.10-rc3/arch/ppc/boot/common/util.S	(revision 11)
+++ 2.6.10-rc3/arch/ppc/boot/common/util.S	(working copy)
@@ -27,6 +27,7 @@
 
 	.text
 
+#ifdef CONFIG_6xx
 	.globl	disable_6xx_mmu
 disable_6xx_mmu:
 	/* Establish default MSR value, exception prefix 0xFFF.
@@ -94,6 +95,7 @@
 	sync
 	isync
 	blr
+#endif
 
 	.globl	_setup_L2CR
 _setup_L2CR:

-- 
Tom Rini
http://gate.crashing.org/~trini/
