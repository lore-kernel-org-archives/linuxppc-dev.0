Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0CFC8B7C34
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:40 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 17/27] Make head_64.S aware of KVM real mode code
Date: Fri, 30 Oct 2009 16:47:17 +0100
Message-Id: <1256917647-6200-18-git-send-email-agraf@suse.de>
In-Reply-To: <1256917647-6200-1-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to run some KVM trampoline code in real mode. Unfortunately, real mode
only covers 8MB on Cell so we need to squeeze ourselves as low as possible.

Also, we need to trap interrupts to get us back from guest state to host state
without telling Linux about it.

This patch adds interrupt traps and includes the KVM code that requires real
mode in the real mode parts of Linux.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/exception-64s.h |    2 ++
 arch/powerpc/kernel/exceptions-64s.S     |    8 ++++++++
 arch/powerpc/kernel/head_64.S            |    7 +++++++
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index a98653b..57c4000 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -147,6 +147,7 @@
 	.globl label##_pSeries;				\
 label##_pSeries:					\
 	HMT_MEDIUM;					\
+	DO_KVM	n;					\
 	mtspr	SPRN_SPRG_SCRATCH0,r13;		/* save r13 */	\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common)
 
@@ -170,6 +171,7 @@ label##_pSeries:					\
 	.globl label##_pSeries;						\
 label##_pSeries:							\
 	HMT_MEDIUM;							\
+	DO_KVM	n;							\
 	mtspr	SPRN_SPRG_SCRATCH0,r13;	/* save r13 */			\
 	mfspr	r13,SPRN_SPRG_PACA;	/* get paca address into r13 */	\
 	std	r9,PACA_EXGEN+EX_R9(r13);	/* save r9, r10 */	\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 1808876..fc3ead0 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -41,6 +41,7 @@ __start_interrupts:
 	. = 0x200
 _machine_check_pSeries:
 	HMT_MEDIUM
+	DO_KVM	0x200
 	mtspr	SPRN_SPRG_SCRATCH0,r13		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common)
 
@@ -48,6 +49,7 @@ _machine_check_pSeries:
 	.globl data_access_pSeries
 data_access_pSeries:
 	HMT_MEDIUM
+	DO_KVM	0x300
 	mtspr	SPRN_SPRG_SCRATCH0,r13
 BEGIN_FTR_SECTION
 	mfspr	r13,SPRN_SPRG_PACA
@@ -77,6 +79,7 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_SLB)
 	.globl data_access_slb_pSeries
 data_access_slb_pSeries:
 	HMT_MEDIUM
+	DO_KVM	0x380
 	mtspr	SPRN_SPRG_SCRATCH0,r13
 	mfspr	r13,SPRN_SPRG_PACA		/* get paca address into r13 */
 	std	r3,PACA_EXSLB+EX_R3(r13)
@@ -115,6 +118,7 @@ data_access_slb_pSeries:
 	.globl instruction_access_slb_pSeries
 instruction_access_slb_pSeries:
 	HMT_MEDIUM
+	DO_KVM	0x480
 	mtspr	SPRN_SPRG_SCRATCH0,r13
 	mfspr	r13,SPRN_SPRG_PACA		/* get paca address into r13 */
 	std	r3,PACA_EXSLB+EX_R3(r13)
@@ -154,6 +158,7 @@ instruction_access_slb_pSeries:
 	.globl	system_call_pSeries
 system_call_pSeries:
 	HMT_MEDIUM
+	DO_KVM	0xc00
 BEGIN_FTR_SECTION
 	cmpdi	r0,0x1ebe
 	beq-	1f
@@ -186,12 +191,15 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	 * trickery is thus necessary
 	 */
 	. = 0xf00
+	DO_KVM	0xf00
 	b	performance_monitor_pSeries
 
 	. = 0xf20
+	DO_KVM	0xf20
 	b	altivec_unavailable_pSeries
 
 	. = 0xf40
+	DO_KVM	0xf40
 	b	vsx_unavailable_pSeries
 
 #ifdef CONFIG_CBE_RAS
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index c38afdb..9258074 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -37,6 +37,7 @@
 #include <asm/firmware.h>
 #include <asm/page_64.h>
 #include <asm/irqflags.h>
+#include <asm/kvm_book3s_64_asm.h>
 
 /* The physical memory is layed out such that the secondary processor
  * spin code sits at 0x0000...0x00ff. On server, the vectors follow
@@ -165,6 +166,12 @@ exception_marker:
 #include "exceptions-64s.S"
 #endif
 
+/* KVM trampoline code needs to be close to the interrupt handlers */
+
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+#include "../kvm/book3s_64_rmhandlers.S"
+#endif
+
 _GLOBAL(generic_secondary_thread_init)
 	mr	r24,r3
 
-- 
1.6.0.2
