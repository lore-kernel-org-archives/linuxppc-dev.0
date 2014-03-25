Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 18/33] powerpc/tm: Fix GOT save offset for ABIv2
Date: Tue, 25 Mar 2014 22:44:24 +1100
Message-Id: <1395747879-5948-19-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The r2 TOC/GOT save offset is 40 on ABIv1 and 24 on ABIv2.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/ppc_asm.h | 2 ++
 arch/powerpc/kernel/tm.S           | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 3185d11..2cc2511 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -190,8 +190,10 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #define STK_REG(i)     __STK_REG(__REG_##i)
 
 #if defined(_CALL_ELF) && _CALL_ELF == 2
+#define STK_GOT		24
 #define __STK_PARAM(i)	(32 + ((i)-3)*8)
 #else
+#define STK_GOT		40
 #define __STK_PARAM(i)	(48 + ((i)-3)*8)
 #endif
 #define STK_PARAM(i)	__STK_PARAM(__REG_##i)
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index db02e84..988565b 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -107,7 +107,7 @@ _GLOBAL(tm_reclaim)
 	mflr	r0
 	stw	r6, 8(r1)
 	std	r0, 16(r1)
-	std	r2, 40(r1)
+	std	r2, STK_GOT(r1)
 	stdu	r1, -TM_FRAME_SIZE(r1)
 
 	/* We've a struct pt_regs at [r1+STACK_FRAME_OVERHEAD]. */
@@ -288,7 +288,7 @@ dont_backup_fp:
 	ld	r0, 16(r1)
 	mtcr	r4
 	mtlr	r0
-	ld	r2, 40(r1)
+	ld	r2, STK_GOT(r1)
 
 	/* Load system default DSCR */
 	ld	r4, DSCR_DEFAULT@toc(r2)
@@ -311,7 +311,7 @@ _GLOBAL(tm_recheckpoint)
 	mflr	r0
 	stw	r5, 8(r1)
 	std	r0, 16(r1)
-	std	r2, 40(r1)
+	std	r2, STK_GOT(r1)
 	stdu	r1, -TM_FRAME_SIZE(r1)
 
 	/* We've a struct pt_regs at [r1+STACK_FRAME_OVERHEAD].
@@ -447,7 +447,7 @@ restore_gprs:
 	ld	r0, 16(r1)
 	mtcr	r4
 	mtlr	r0
-	ld	r2, 40(r1)
+	ld	r2, STK_GOT(r1)
 
 	/* Load system default DSCR */
 	ld	r4, DSCR_DEFAULT@toc(r2)
-- 
1.8.3.2
