Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/power8: Update denorm exeception
Date: Thu, 30 May 2013 17:33:19 +1000
Message-Id: <1369899199-3973-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1369899199-3973-1-git-send-email-mikey@neuling.org>
References: <1369899199-3973-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER8 can take a denormalisation exception on any VSX registers.

This does the extra 32 VSX registers we don't currently handle.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/exceptions-64s.S |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3c9296b..e783453 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -480,6 +480,16 @@ FTR_SECTION_ELSE
 	XVCPSGNDP32(0)
 
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
+
+BEGIN_FTR_SECTION
+	b	denorm_done
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
+/*
+ * To denormalise we need to move a copy of the register to itself.
+ * For POWER8 we need to do that for all 64 VSX registers
+ */
+	XVCPSGNDP32(32)
+denorm_done:
 	mtspr	SPRN_HSRR0,r11
 	mtcrf	0x80,r9
 	ld	r9,PACA_EXGEN+EX_R9(r13)
-- 
1.7.10.4
