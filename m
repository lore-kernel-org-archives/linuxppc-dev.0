Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyt861yyxzDr46
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 18:27:50 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id j186so11083547pge.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 01:27:50 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kexec: Fix radix to hash kexec
Date: Thu, 29 Jun 2017 18:27:34 +1000
Message-Id: <20170629082734.4195-1-bsingharora@gmail.com>
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

NOTES:
 This patch can be made power9 specific, but I've chosen not
 to do so, I could add it in a feature section if recommended.
 Since this is only for kexec resetting them might be helpful
 when we fully implement keys as well.

 arch/powerpc/kernel/misc_64.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index c119044..39d2b58 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -614,6 +614,16 @@ _GLOBAL(kexec_sequence)
 	li	r0,0
 	std	r0,16(r1)
 
+	/*
+	 * This is the best time to turn AMR/IAMR off.
+	 * key 0 is used in radix for supervisor<->user
+	 * protection, but on hash key 0 is reserved
+	 * ideally we want to enter with a clean state.
+	 * NOTE, we rely on r0 being 0 from above.
+	 */
+	mtspr	SPRN_IAMR,r0
+	mtspr	SPRN_AMOR,r0
+
 	/* save regs for local vars on new stack.
 	 * yes, we won't go back, but ...
 	 */
-- 
2.9.4
