Return-Path: <skrishnakar@gmail.com>
MIME-Version: 1.0
Date: Tue, 19 May 2009 18:38:53 +0530
Message-ID: <6213bc560905190608j73f4191fxbd94158a2b1740c0@mail.gmail.com>
Subject: Initialize DBCR0 for PPC440 targets
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

kernel- 2.6.29
Debug technique: KGDB

The PowerPC kernel does not initialize the PPC440 DBCR0 register. This
prevents the use of software breakpoints in case of internal debug
mode. Looking into head_fsl_booke.S for initialization of DBCR0 is
used by boot-loaders.
It seems head_44x.S lacks this step of DBCR0 register initialization.
So fixing this with initializing the DBCR0 register as shown below :

Subject: [PATCH] powerpc: 44x: Initialize DBCR0 for targets not having
bootloader

The kernel does not initialize the PPC440 DBCR0 register.
This prevents (among other things) the use of software
breakpoints with GDB. The boot loaders probably do initialize
this but few targets run without a boot loader
---
 arch/powerpc/kernel/head_44x.S |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index a4a890a..b413bc4 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -240,6 +240,18 @@ skpinv:	addi	r4,r4,1				/* Increment */
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
 	mtspr	SPRN_IVPR,r4

+#if !defined(CONFIG_BDI_SWITCH)
+        /*
+         * The Abatron BDI JTAG debugger does not tolerate others
+         * mucking with the debug registers.
+         */
+        lis     r2,DBCR0_IDM@h
+        mtspr   SPRN_DBCR0,r2
+        isync
+        /* clear any residual debug events */
+        li      r2,-1
+        mtspr   SPRN_DBSR,r2
+#endif
 	/*
 	 * This is where the main kernel code starts.
 	 */

Any suggestions or comments on this ?

Thanks,
-Srikant
