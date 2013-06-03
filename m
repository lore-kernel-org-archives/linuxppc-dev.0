Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9861B2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2013 06:54:40 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [RFC PATCH 1/6] KVM: PPC: Book3E: Fix AltiVec interrupt numbers and
 build breakage
Date: Mon, 3 Jun 2013 23:54:23 +0300
Message-ID: <1370292868-2697-2-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
References: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Interrupt numbers defined for Book3E follows IVORs definition. Align
BOOKE_INTERRUPT_ALTIVEC_UNAVAIL and BOOKE_INTERRUPT_ALTIVEC_ASSIST to this
rule which also fixes the build breakage.
IVORs 32 and 33 are shared so reflect this in the interrupts naming.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/kvm_asm.h |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index b9dd382..851bac7 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -54,8 +54,16 @@
 #define BOOKE_INTERRUPT_DEBUG 15
 
 /* E500 */
-#define BOOKE_INTERRUPT_SPE_UNAVAIL 32
-#define BOOKE_INTERRUPT_SPE_FP_DATA 33
+#define BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL 32
+#define BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST 33
+/*
+ * TODO: Unify 32-bit and 64-bit kernel exception handlers to use same defines
+ */
+#define BOOKE_INTERRUPT_SPE_UNAVAIL BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
+#define BOOKE_INTERRUPT_SPE_FP_DATA BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
+#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
+#define BOOKE_INTERRUPT_ALTIVEC_ASSIST \
+				BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
 #define BOOKE_INTERRUPT_SPE_FP_ROUND 34
 #define BOOKE_INTERRUPT_PERFORMANCE_MONITOR 35
 #define BOOKE_INTERRUPT_DOORBELL 36
@@ -67,10 +75,6 @@
 #define BOOKE_INTERRUPT_HV_SYSCALL 40
 #define BOOKE_INTERRUPT_HV_PRIV 41
 
-/* altivec */
-#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL 42
-#define BOOKE_INTERRUPT_ALTIVEC_ASSIST 43
-
 /* book3s */
 
 #define BOOK3S_INTERRUPT_SYSTEM_RESET	0x100
-- 
1.7.4.1
