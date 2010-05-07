Return-Path: <paulus@ozlabs.org>
Date: Fri, 7 May 2010 15:46:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Avoid bad relocations in iSeries code
Message-ID: <20100507054650.GC25173@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Subrata Modak <subrata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Subrata Modak reported that building a CONFIG_RELOCATABLE kernel with
CONFIG_ISERIES enabled gives the following warnings:

WARNING: 4 bad relocations
c00000000007216e R_PPC64_ADDR16_HIGHEST  __ksymtab+0x00000000009dcec8
c000000000072172 R_PPC64_ADDR16_HIGHER  __ksymtab+0x00000000009dcec8
c00000000007217a R_PPC64_ADDR16_HI  __ksymtab+0x00000000009dcec8
c00000000007217e R_PPC64_ADDR16_LO  __ksymtab+0x00000000009dcec8

The reason is that decrementer_iSeries_masked is using
LOAD_REG_IMMEDIATE to get the address of a kernel symbol, which
creates relocations that aren't handled by the kernel relocator code.

Instead of reading the tb_ticks_per_jiffy variable, we can just set
the decrementer to its maximum value (0x7fffffff) and that will work
just as well.  In fact timer_interrupt sets the decrementer to that
value initially anyway, and we are sure to get into timer_interrupt
once interrupts are reenabled because we store 1 to the decrementer
interrupt flag in the lppaca (LPPACADECRINT(r12) here).

Reported-by: Subrata Modak <subrata@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/platforms/iseries/exception.S |    4 ++--

 1 file changed, 2 insertions(+), 2 deletions(-)
diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
index fba5bf9..32a56c6 100644
--- a/arch/powerpc/platforms/iseries/exception.S
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -252,8 +252,8 @@ decrementer_iSeries_masked:
 	li	r11,1
 	ld	r12,PACALPPACAPTR(r13)
 	stb	r11,LPPACADECRINT(r12)
-	LOAD_REG_IMMEDIATE(r12, tb_ticks_per_jiffy)
-	lwz	r12,0(r12)
+	li	r12,-1
+	clrldi	r12,r12,33	/* set DEC to 0x7fffffff */
 	mtspr	SPRN_DEC,r12
 	/* fall through */
 
