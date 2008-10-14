Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 14 Oct 2008 15:38:48 +1100
Subject: [PATCH] powerpc: Fix 32-bit SMP boot on CHRP
Message-Id: <20081014043924.A950DDDDFD@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

prom_init was changed to take a new argument, the address
where the kernel is loaded, which is now used to copy the
SMP spin loop down before use.

However, only head_64.S was adapted to pass this new value,
not head_32.S, thus breaking SMP boot on 32-bit SMP CHRP
machines.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/head_32.S |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-work.orig/arch/powerpc/kernel/head_32.S	2008-10-14 15:22:33.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_32.S	2008-10-14 15:23:58.000000000 +1100
@@ -110,6 +110,12 @@ __start:
 #ifdef CONFIG_PPC_MULTIPLATFORM
 	cmpwi	0,r5,0
 	beq	1f
+
+	/* find out where we are now */
+	bcl	20,31,$+4
+0:	mflr	r8			/* r8 = runtime addr here */
+	addis	r8,r8,(_stext - 0b)@ha
+	addi	r8,r8,(_stext - 0b)@l	/* current runtime base addr */
 	bl	prom_init
 	trap
 #endif
