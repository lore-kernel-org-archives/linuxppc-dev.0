Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 944622C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 23:27:28 +1000 (EST)
Received: from mail257-tx2 (localhost [127.0.0.1])	by
 mail257-tx2-R.bigfish.com (Postfix) with ESMTP id 3CD8814005D	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 13:27:24 +0000 (UTC)
Received: from TX2EHSMHS029.bigfish.com (unknown [10.9.14.247])	by
 mail257-tx2.bigfish.com (Postfix) with ESMTP id 3A4CECC0045	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 13:27:21 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q76DRJMS012089	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2012 06:27:20 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 6/6] powerpc/booke64: restore VDSO information on critical
 exception
Date: Mon, 6 Aug 2012 16:27:08 +0300
Message-ID: <1344259628-31161-7-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1344259628-31161-1-git-send-email-mihai.caraman@freescale.com>
References: <1344259628-31161-1-git-send-email-mihai.caraman@freescale.com>
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

Critical exception handler on 64-bit booke uses user-visible SPRG3 as scratch.
Restore VDSO information in SPRG3 on exception prolog.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/paca.h      |    3 +++
 arch/powerpc/kernel/asm-offsets.c    |    1 +
 arch/powerpc/kernel/exceptions-64e.S |    4 +++-
 arch/powerpc/kernel/vdso.c           |    2 ++
 4 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index daf813f..6b98ad4 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -118,6 +118,9 @@ struct paca_struct {
 	void *mc_kstack;
 	void *crit_kstack;
 	void *dbg_kstack;
+
+	/* User-visible sprg information */
+	ulong sprg3;
 #endif /* CONFIG_PPC_BOOK3E */
 
 	mm_context_t context;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 85b05c4..8ca338d 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -168,6 +168,7 @@ int main(void)
 	DEFINE(PACA_MC_STACK, offsetof(struct paca_struct, mc_kstack));
 	DEFINE(PACA_CRIT_STACK, offsetof(struct paca_struct, crit_kstack));
 	DEFINE(PACA_DBG_STACK, offsetof(struct paca_struct, dbg_kstack));
+	DEFINE(PACA_SPRG3, offsetof(struct paca_struct, sprg3));
 #endif /* CONFIG_PPC_BOOK3E */
 
 #ifdef CONFIG_PPC_STD_MMU_64
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
index b67db22..a0b0d08 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -725,6 +725,8 @@ int __cpuinit vdso_getcpu_init(void)
 	mtspr(SPRN_SPRG3, val);
 #ifdef CONFIG_KVM_BOOK3S_HANDLER
 	get_paca()->kvm_hstate.sprg3 = val;
+#elif CONFIG_PPC_BOOK3E
+	get_paca()->sprg3 = val;
 #endif
 
 	put_cpu();
-- 
1.7.4.1
