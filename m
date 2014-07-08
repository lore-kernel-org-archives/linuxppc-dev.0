Return-Path: <joel@jms.id.au>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 105EA1A0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 16:38:41 +1000 (EST)
Received: by mail-pa0-f51.google.com with SMTP id hz1so6826400pad.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jul 2014 23:38:38 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Alexander Graf <agraf@suse.de>
Subject: [PATCH v2 1/3] powerpc/kvm: Remove redundant save of SIER AND MMCR2
Date: Tue,  8 Jul 2014 16:08:20 +0930
Message-Id: <1404801502-4663-2-git-send-email-joel@jms.id.au>
In-Reply-To: <1404801502-4663-1-git-send-email-joel@jms.id.au>
References: <1404801502-4663-1-git-send-email-joel@jms.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These two registers are already saved in the block above. Aside from
being unnecessary, by the time we get down to the second save location
r8 no longer contains MMCR2, so we are clobbering the saved value with
PMC5.

MMCR2 primarily consists of counter freeze bits. So restoring the value
of PMC5 into MMCR2 will most likely have the effect of freezing
counters.

Fixes: 72cde5a88d37 ("KVM: PPC: Book3S HV: Save/restore host PMU registers that are new in POWER8")
Cc: stable@vger.kernel.org
Signed-off-by: Joel Stanley <joel@jms.id.au>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Paul Mackerras <paulus@samba.org>
Reviewed-by: Alexander Graf <agraf@suse.de>
---
V2:
 - Add comments from mpe

 arch/powerpc/kvm/book3s_hv_interrupts.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
index 8c86422..731be74 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupts.S
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -127,11 +127,6 @@ BEGIN_FTR_SECTION
 	stw	r10, HSTATE_PMC + 24(r13)
 	stw	r11, HSTATE_PMC + 28(r13)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
-BEGIN_FTR_SECTION
-	mfspr	r9, SPRN_SIER
-	std	r8, HSTATE_MMCR + 40(r13)
-	std	r9, HSTATE_MMCR + 48(r13)
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 31:
 
 	/*
-- 
2.0.0
