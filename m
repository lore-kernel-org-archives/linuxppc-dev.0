Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8N6M2Ks9zDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 17:28:11 +1000 (AEST)
Message-ID: <1470814054.3015.98.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix crash during static key init on ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Christian Kujau
 <lists@nerdbynature.de>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 10 Aug 2016 17:27:34 +1000
In-Reply-To: <874m6tt8d0.fsf@concordia.ellerman.id.au>
References: <alpine.DEB.2.20.14.1608082213450.8131@trent.utfs.org>
 <alpine.DEB.2.20.14.1608090157090.8131@trent.utfs.org>
 <1470743530.3015.38.camel@kernel.crashing.org>
 <87inv9te2n.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.14.1608092224220.8131@trent.utfs.org>
 <874m6tt8d0.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We cannot do those initializations from apply_feature_fixups() as
this function runs in a very restricted environment in 32-bit where
the kernel isn't running at its linked address and the PTRRELOC()
macro must be used for any global accesss.

Instead, split them into a separtate steup_feature_keys() function
which is called in a more suitable spot on ppc32.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 57fec8a..ddf54f5 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -186,6 +186,7 @@ label##3:					       	\
 
 #ifndef __ASSEMBLY__
 void apply_feature_fixups(void);
+void setup_feature_keys(void);
 #endif
 
 #endif /* __ASM_POWERPC_FEATURE_FIXUPS_H */
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index c3e861d..9a2ae96 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -102,6 +102,9 @@ extern unsigned int memset_nocache_branch; /* Insn to be replaced by NOP */
 
 notrace void __init machine_init(u64 dt_ptr)
 {
+	/* Configure static keys first */
+	setup_feature_keys();
+
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index eafb9a7..7ac8e6e 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -300,6 +300,7 @@ void __init early_setup(unsigned long dt_ptr)
 
 	/* Apply all the dynamic patching */
 	apply_feature_fixups();
+	setup_feature_keys();
 
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu();
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 74145f0..043415f 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -188,7 +188,10 @@ void __init apply_feature_fixups(void)
 			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
 #endif
 	do_final_fixups();
+}
 
+void __init setup_feature_keys(void)
+{
 	/*
 	 * Initialise jump label. This causes all the cpu/mmu_has_feature()
 	 * checks to take on their correct polarity based on the current set of
