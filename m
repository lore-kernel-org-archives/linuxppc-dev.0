Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6vsN40rHzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 05:12:40 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id o123so347256pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 12:12:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/4] powerpc/64s: Revert setting LPCR LPES0 on POWER9
Date: Wed, 19 Apr 2017 05:12:16 +1000
Message-Id: <20170418191220.3166-2-npiggin@gmail.com>
In-Reply-To: <20170418191220.3166-1-npiggin@gmail.com>
References: <20170418191220.3166-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The XIVE enablement patches set LPES0 on POWER9 host. This bit sets
external interrupts to guest delivery mode that uses SRR[01]. The host's
EE interrupt handler expects HSRR[01] (for earlier CPUs). which is fine
because XIVE is configured not to deliver EE to the host (HVI is used
instead) so this should never be executed.

However a bug in interrupt controller code or odd configuration of
mambo/systemsim could result in the host getting EE. Keeping EE delivery
mode matching the host handler prevents strange crashes due to using
the wrong exception registers.

When running in guest mode and getting EE, the guest LPCR will be
loaded by KVM which contains the LPES0 bit.

Fixes: 08a1e650cc ("powerpc: Fixup LPCR:PECE and HEIC setting on POWER9")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/cpu_setup_power.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 7013ae3d1675..1fce4ddd2e6c 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -107,7 +107,7 @@ _GLOBAL(__setup_cpu_power9)
 	or	r3, r3, r4
 	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT | LPCR_HR)
 	andc	r3, r3, r4
-	li	r4,(LPCR_LPES0 >> LPCR_LPES_SH)
+	li	r4,0 /* LPES = 0 */
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
@@ -131,7 +131,7 @@ _GLOBAL(__restore_cpu_power9)
 	or	r3, r3, r4
 	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT | LPCR_HR)
 	andc	r3, r3, r4
-	li	r4,(LPCR_LPES0 >> LPCR_LPES_SH)
+	li	r4,0 /* LPES = 0 */
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
-- 
2.11.0
