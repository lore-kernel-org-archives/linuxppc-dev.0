Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9FCB02C029E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 01:35:55 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/booke64: Use common defines for AltiVec
 interrupts numbers
Date: Mon, 1 Jul 2013 18:35:30 +0300
Message-ID: <1372692931-16324-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Book3E some SPE/FP/AltiVec interrupts share the same number. Use
common defines to indentify these numbers.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kernel/exceptions-64e.S |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 645170a..0c379e9 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -399,7 +399,7 @@ interrupt_end_book3e:
 
 /* Altivec Unavailable Interrupt */
 	START_EXCEPTION(altivec_unavailable);
-	NORMAL_EXCEPTION_PROLOG(0x200, BOOKE_INTERRUPT_ALTIVEC_UNAVAIL,
+	NORMAL_EXCEPTION_PROLOG(0x200, BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL,
 				PROLOG_ADDITION_NONE)
 	/* we can probably do a shorter exception entry for that one... */
 	EXCEPTION_COMMON(0x200, PACA_EXGEN, INTS_KEEP)
@@ -421,7 +421,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 
 /* AltiVec Assist */
 	START_EXCEPTION(altivec_assist);
-	NORMAL_EXCEPTION_PROLOG(0x220, BOOKE_INTERRUPT_ALTIVEC_ASSIST,
+	NORMAL_EXCEPTION_PROLOG(0x220,
+				BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST,
 				PROLOG_ADDITION_NONE)
 	EXCEPTION_COMMON(0x220, PACA_EXGEN, INTS_DISABLE)
 	bl	.save_nvgprs
-- 
1.7.3.4
