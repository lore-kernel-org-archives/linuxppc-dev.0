Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyypD6F1wzDr7s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 21:57:40 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u62so11683750pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 04:57:40 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Subject: [PATCH v2] powerpc/kexec: Fix radix to hash kexec
Date: Thu, 29 Jun 2017 21:57:26 +1000
Message-Id: <20170629115726.11060-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes a crash seen while doing a kexec from
radix mode to hash mode. Key 0 is special in hash and
used in the RPN by default, we set the key values to 0
today. In radix mode key 0 is used to control
supervisor<->user access. In hash key 0 is used by default,
so the first instruction after the switch causes a crash on
kexec.

This patch fixes
(3b10d00 powerpc/mm/radix: Prevent kernel execution of user space)
The commit above introduced setting of IAMR and AMOR values to
prevent execution of user mode instructions from supervisor mode.
We need to clean up these SPR's on kexec.

Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---

 Changelog v2:
 - Put the code in a feature section for CPU_FTR_ARCH_300

 arch/powerpc/kernel/misc_64.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index c119044..8ac0bd2 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -614,6 +614,18 @@ _GLOBAL(kexec_sequence)
 	li	r0,0
 	std	r0,16(r1)
 
+BEGIN_FTR_SECTION
+	/*
+	 * This is the best time to turn AMR/IAMR off.
+	 * key 0 is used in radix for supervisor<->user
+	 * protection, but on hash key 0 is reserved
+	 * ideally we want to enter with a clean state.
+	 * NOTE, we rely on r0 being 0 from above.
+	 */
+	mtspr	SPRN_IAMR,r0
+	mtspr	SPRN_AMOR,r0
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+
 	/* save regs for local vars on new stack.
 	 * yes, we won't go back, but ...
 	 */
-- 
2.9.4
