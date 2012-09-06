Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B87F2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 22:50:10 +1000 (EST)
Received: from mail70-db3 (localhost [127.0.0.1])	by mail70-db3-R.bigfish.com
 (Postfix) with ESMTP id 6BCE33E018A	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Sep 2012 12:50:04 +0000 (UTC)
Received: from DB3EHSMHS004.bigfish.com (unknown [10.3.81.238])	by
 mail70-db3.bigfish.com (Postfix) with ESMTP id E597F3C0086	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 12:50:00 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q86CnuOP028133	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Sep 2012 05:49:57 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc64: restore VDSO information on critical exception
Date: Thu, 6 Sep 2012 15:49:44 +0300
Message-ID: <1346935784-19521-1-git-send-email-mihai.caraman@freescale.com>
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

Critical exception on 64-bit booke uses user-visible SPRG3 as scratch.
Restore VDSO information in SPRG3 on exception prolog.
Use a common sprg3 field in PACA for all powerpc64 architectures.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/kvm_book3s_asm.h |    1 -
 arch/powerpc/include/asm/paca.h           |    1 +
 arch/powerpc/kernel/asm-offsets.c         |    2 +-
 arch/powerpc/kernel/exceptions-64e.S      |    4 +++-
 arch/powerpc/kernel/vdso.c                |    4 +---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index bfcd00c..88609b2 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -74,7 +74,6 @@ struct kvmppc_host_state {
 	ulong vmhandler;
 	ulong scratch0;
 	ulong scratch1;
-	ulong sprg3;
 	u8 in_guest;
 	u8 restore_hid5;
 	u8 napping;
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index daf813f..7796519 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -136,6 +136,7 @@ struct paca_struct {
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
 	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
+	u64 sprg3;			/* Saved user-visible sprg */
 
 #ifdef CONFIG_PPC_POWERNV
 	/* Pointer to OPAL machine check event structure set by the
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 85b05c4..72f2616 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -205,6 +205,7 @@ int main(void)
 	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
 	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
 	DEFINE(PACA_NAPSTATELOST, offsetof(struct paca_struct, nap_state_lost));
+	DEFINE(PACA_SPRG3, offsetof(struct paca_struct, sprg3));
 #endif /* CONFIG_PPC64 */
 
 	/* RTAS */
@@ -533,7 +534,6 @@ int main(void)
 	HSTATE_FIELD(HSTATE_VMHANDLER, vmhandler);
 	HSTATE_FIELD(HSTATE_SCRATCH0, scratch0);
 	HSTATE_FIELD(HSTATE_SCRATCH1, scratch1);
-	HSTATE_FIELD(HSTATE_SPRG3, sprg3);
 	HSTATE_FIELD(HSTATE_IN_GUEST, in_guest);
 	HSTATE_FIELD(HSTATE_RESTORE_HID5, restore_hid5);
 	HSTATE_FIELD(HSTATE_NAPPING, napping);
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 7476b0a..87a82fb 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -110,7 +110,9 @@
 
 #define PROLOG_STORE_RESTORE_SCRATCH_CRIT				    \
 	mfspr	r10,SPRN_SPRG_CRIT_SCRATCH;	/* get r13 */		    \
-	std	r10,PACA_EXCRIT+EX_R13(r13)
+	std	r10,PACA_EXCRIT+EX_R13(r13);				    \
+	ld	r11,PACA_SPRG3(r13);					    \
+	mtspr	SPRN_SPRG_CRIT_SCRATCH,r11;
 
 /* Variants of the "addition" argument for the prolog
  */
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index b67db22..1b2076f 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -723,9 +723,7 @@ int __cpuinit vdso_getcpu_init(void)
 
 	val = (cpu & 0xfff) | ((node & 0xffff) << 16);
 	mtspr(SPRN_SPRG3, val);
-#ifdef CONFIG_KVM_BOOK3S_HANDLER
-	get_paca()->kvm_hstate.sprg3 = val;
-#endif
+	get_paca()->sprg3 = val;
 
 	put_cpu();
 
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 5a84c8d..39a21bf 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1065,7 +1065,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 	mtspr	SPRN_DABRX,r6
 
 	/* Restore SPRG3 */
-	ld	r3,HSTATE_SPRG3(r13)
+	ld	r3,PACA_SPRG3(r13)
 	mtspr	SPRN_SPRG3,r3
 
 	/*
-- 
1.7.4.1
