Return-Path: <tglx@linutronix.de>
Received: from tglx.tec.linutronix.de (pD953A911.dip.t-dialin.net
	[217.83.169.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B93E92BF13
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Dec 2004 02:23:13 +1100 (EST)
Date: Wed, 15 Dec 2004 15:21:43 +0100
From: tglx@linutronix.de
Message-ID: <20041215152142.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain
To: trini@kernel.crashing.org
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] Compile 6xx specific code only for 6xx machines
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The 6xx specific mmu functions in arch/boot/common/util.S break the compile for
other platforms. Compile them for 6xx only.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

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
