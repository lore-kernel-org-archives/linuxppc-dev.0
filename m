Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sY8ln1zyXzDsRL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 13:09:09 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id x24so8934377pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 20:09:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/8] powerpc/pseries: syscall remove trampoline
Date: Tue, 13 Sep 2016 13:08:40 +1000
Message-Id: <20160913030846.29790-3-npiggin@gmail.com>
In-Reply-To: <20160913030846.29790-1-npiggin@gmail.com>
References: <20160913030846.29790-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The syscall trampoline is not required, remove it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4015f71..ea57a2c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -42,7 +42,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 #define SYSCALL_PSERIES_2_RFID 					\
 	mfspr	r12,SPRN_SRR1 ;					\
 	ld	r10,PACAKBASE(r13) ; 				\
-	LOAD_HANDLER(r10, system_call_entry) ; 			\
+	LOAD_HANDLER(r10, system_call_common) ; 		\
 	mtspr	SPRN_SRR0,r10 ; 				\
 	ld	r10,PACAKMSR(r13) ;				\
 	mtspr	SPRN_SRR1,r10 ; 				\
@@ -65,7 +65,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 #define SYSCALL_PSERIES_2_DIRECT				\
 	mflr	r10 ;						\
 	ld	r12,PACAKBASE(r13) ; 				\
-	LOAD_HANDLER(r12, system_call_entry) ;			\
+	LOAD_HANDLER(r12, system_call_common) ;			\
 	mtctr	r12 ;						\
 	mfspr	r12,SPRN_SRR1 ;					\
 	/* Re-use of r13... No spare regs to do this */	\
@@ -910,10 +910,6 @@ hv_facility_unavailable_relon_trampoline:
 #endif
 	STD_RELON_EXCEPTION_PSERIES(0x5700, 0x1700, altivec_assist)
 
-	.align	7
-system_call_entry:
-	b	system_call_common
-
 ppc64_runlatch_on_trampoline:
 	b	__ppc64_runlatch_on
 
-- 
2.9.3
