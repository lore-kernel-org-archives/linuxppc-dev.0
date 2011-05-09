Return-Path: <anton@samba.org>
Date: Mon, 9 May 2011 17:36:44 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Improve scheduling of system call entry instructions
Message-ID: <20110509173644.33053672@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


After looking at our system call path, Mary Brown suggested that we
should put all mfspr SRR* instructions before any mtspr SRR*.

To test this I used a very simple null syscall (actually getppid)
testcase at http://ozlabs.org/~anton/junkcode/null_syscall.c

I tested with the following changes against the pseries_defconfig:

CONFIG_VIRT_CPU_ACCOUNTING=n
CONFIG_AUDIT=n

to remove the overhead of virtual CPU accounting and syscall
auditing.

POWER6:
baseline:       mean = 757.2 cycles       sd = 2.108
modified:       mean = 759.1 cycles       sd = 2.020

POWER7:
baseline:       mean = 411.4 cycles       sd = 0.138
modified:       mean = 404.1 cycles       sd = 0.109

So we have 1.77% improvement on POWER7 which looks significant. The
POWER6 suggest a 0.25% slowdown, but the results are within 1
standard deviation and may be in the noise.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/kernel/exceptions-64s.S
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/exceptions-64s.S	2011-05-07 10:56:04.000000000 +1000
+++ linux-powerpc/arch/powerpc/kernel/exceptions-64s.S	2011-05-09 11:20:23.872220052 +1000
@@ -211,11 +211,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	mr	r9,r13
 	GET_PACA(r13)
 	mfspr	r11,SPRN_SRR0
-	ld	r12,PACAKBASE(r13)
-	ld	r10,PACAKMSR(r13)
-	LOAD_HANDLER(r12, system_call_entry)
-	mtspr	SPRN_SRR0,r12
 	mfspr	r12,SPRN_SRR1
+	ld	r10,PACAKBASE(r13)
+	LOAD_HANDLER(r10, system_call_entry)
+	mtspr	SPRN_SRR0,r10
+	ld	r10,PACAKMSR(r13)
 	mtspr	SPRN_SRR1,r10
 	rfid
 	b	.	/* prevent speculative execution */
