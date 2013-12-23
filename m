Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DBD632C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 12:24:54 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc: Add global exports for all interrupt vectors
Date: Mon, 23 Dec 2013 02:24:42 +0100
Message-Id: <1387761885-39599-2-git-send-email-agraf@suse.de>
In-Reply-To: <1387761885-39599-1-git-send-email-agraf@suse.de>
References: <1387761885-39599-1-git-send-email-agraf@suse.de>
Cc: Dinar Valeev <dvaleev@suse.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to access every interrupt vector we can find soon, so let's
make them all visible through names to outside code.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/exceptions-64s.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9f905e4..fcd039f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -148,6 +148,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 				 NOTEST, 0x100)
 
 	. = 0x200
+	.globl machine_check_pSeries_1
 machine_check_pSeries_1:
 	/* This is moved out of line as it can be patched by FW, but
 	 * some code path might still want to branch into the original
@@ -328,24 +329,28 @@ hv_doorbell_trampoline:
 	 * trickery is thus necessary
 	 */
 	. = 0xf00
+	.global performance_monitor_pseries_trampoline
 performance_monitor_pseries_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	performance_monitor_pSeries
 
 	. = 0xf20
+	.global altivec_unavailable_pseries_trampoline
 altivec_unavailable_pseries_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	altivec_unavailable_pSeries
 
 	. = 0xf40
+	.global vsx_unavailable_pseries_trampoline
 vsx_unavailable_pseries_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	vsx_unavailable_pSeries
 
 	. = 0xf60
+	.global facility_unavailable_trampoline
 facility_unavailable_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
-- 
1.8.1.4
